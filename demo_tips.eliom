[%%shared
(* This file was generated by Ocsigen Start.
   Feel free to use it, modify it, and redistribute it as you wish. *)
(* Os_tips demo *)
open Eliom_content.Html.F]

(* Here is an example of tip. Call this function while generating the
   widget concerned by the explanation it contains. *)
let%shared example_tip () =
  (* Have a look at the API documentation of module Os_tips for
     more options. *)
  Os_tips.bubble () ~top:[%client 40] ~right:[%client 0] ~width:[%client 300]
    ~height:[%client 180] ~arrow:[%client `top 250] ~name:"example"
    ~content:
      [%client
        fun _ ->
          Lwt.return
            Eliom_content.Html.F.
              [p [%i18n Demo.example_tip]; p [%i18n Demo.look_module_tip]]]

(* Page for this demo *)
let%shared page () =
  (* Call the function defining the tip from the server or the client: *)
  let%lwt () = example_tip () in
  Lwt.return
    [ h1 [%i18n Demo.tips1]
    ; p [%i18n Demo.tips2 ~os_tips:[code [txt "Os_tips"]]]
    ; p [%i18n Demo.tips3]
    ; p
        [%i18n
          Demo.tips4
            ~set_page:
              [a ~service:Webapptpl_services.settings_service [%i18n Demo.tips5] ()]]
    ]

(* Service registration is done on both sides (shared section),
   so that pages can be generated from the server
   (first request, crawling, search engines ...)
   or the client (subsequent link clicks, or mobile app ...). *)
let%shared () =
  Webapptpl_base.App.register ~service:Demo_services.demo_tips
    ( Webapptpl_page.Opt.connected_page @@ fun myid_o () () ->
      let%lwt p = page () in
      Webapptpl_container.page ~a:[a_class ["os-page-demo-tips"]] myid_o p )
