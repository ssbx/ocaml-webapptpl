[%%client
(* This file was generated by Ocsigen Start.
   Feel free to use it, modify it, and redistribute it as you wish. *)
(* Notification demo *)
open Js_of_ocaml_lwt]

[%%shared open Eliom_content]
[%%shared open Html.D]

(* Instantiate function Os_notif.Simple for each kind of notification
   you need.
   The key is the resource ID. For example, if you are implementing a
   messaging application, it can be the chatroom ID
   (for example type key = int64).
*)
module Notif = Os_notif.Make_Simple (struct
    type key = unit

    (* The resources identifiers.
                       Here unit because we have only one resource. *)

    type notification = string
  end)

(* Broadcast message [v] *)
let%rpc notify (v : string) : unit Lwt.t =
  (* Notify all client processes listening on this resource
     (identified by its key, given as first parameter)
     by sending them message v. *)
  Notif.notify (* ~notfor:`Me *) (() : Notif.key) v;
  (* Use ~notfor:`Me to avoid receiving the message in this tab,
     or ~notfor:(`User myid) to avoid sending to the current user.
     (Where myid is Os_current_user.get_current_userid ())
  *)
  Lwt.return_unit

let%rpc listen () : unit Lwt.t = Notif.listen (); Lwt.return_unit

(* Display a message every time the React event [e = Notif.client_ev ()]
   happens. *)
let%server () =
  Os_session.on_start_process (fun _ ->
    let e : (unit * string) Eliom_react.Down.t = Notif.client_ev () in
    ignore
      [%client
        (Eliom_lib.Dom_reference.retain Js_of_ocaml.Dom_html.window
           ~keep:
             (React.E.map
                (fun (_, msg) ->
                   (* Eliom_lib.alert "%s" msg *)
                   Os_msg.msg ~level:`Msg (Printf.sprintf "%s" msg))
                ~%e)
         : unit)];
    Lwt.return_unit)

(* Make a text input field that calls [f s] for each [s] submitted *)
let%shared make_form msg f =
  let inp = Eliom_content.Html.D.Raw.input ()
  and btn =
    Eliom_content.Html.(D.button ~a:[D.a_class ["button"]] [D.txt msg])
  in
  ignore
    [%client
      (Lwt.async @@ fun () ->
       let btn = Eliom_content.Html.To_dom.of_element ~%btn
       and inp = Eliom_content.Html.To_dom.of_input ~%inp in
       Lwt_js_events.clicks btn @@ fun _ _ ->
       let v = Js_of_ocaml.Js.to_string inp##.value in
       let%lwt () = ~%f v in
       inp##.value := Js_of_ocaml.Js.string "";
       Lwt.return_unit
       : unit)];
  Eliom_content.Html.D.div [inp; btn]

let%rpc unlisten () : unit Lwt.t = Notif.unlisten (); Lwt.return_unit

(* Page for this demo *)
let%shared page () =
  (* Subscribe to notifications when entering this page: *)
  let%lwt () = listen () in
  (* Unsubscribe from notifications when user leaves this page *)
  let (_ : unit Eliom_client_value.t) =
    [%client Eliom_client.Page_status.ondead (fun () -> Lwt.async unlisten)]
  in
  Lwt.return
    Eliom_content.Html.F.
      [ h1 [%i18n Demo.notification]
      ; p
          ([%i18n
             Demo.exchange_msg_between_users ~os_notif:[code [txt "Os_notif"]]]
          @ [ br ()
            ; txt [%i18n Demo.S.open_multiple_tabs_browsers]
            ; br ()
            ; txt [%i18n Demo.S.fill_input_form_send_message] ])
      ; make_form [%i18n Demo.S.send_message]
          [%client (notify : string -> unit Lwt.t)] ]

(* Service registration is done on both sides (shared section),
   so that pages can be generated from the server
   (first request, crawling, search engines ...)
   or the client (subsequent link clicks, or mobile app ...). *)
let%shared () =
  Webapptpl_base.App.register ~service:Demo_services.demo_notif
    ( Webapptpl_page.Opt.connected_page @@ fun myid_o () () ->
      let%lwt p = page () in
      Webapptpl_container.page ~a:[a_class ["os-page-demo-notif"]] myid_o p )
