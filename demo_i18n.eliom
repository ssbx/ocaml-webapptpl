[%%shared
(* This file was generated by Ocsigen Start.
   Feel free to use it, modify it, and redistribute it as you wish. *)
(* Ocsigen_i18n demo *)
open Eliom_content.Html.F]

(* Page for this demo *)
let%shared page () =
  (* Syntax [%i18n key] or [%i18n Module.key] inserts
     the text corresponding to the key, in the language chosen by the user,
     as a list of HTML elements.
     Syntax [%i18n S.key] or [%i18n Module.S.key] inserts the text as a string.
     It is possible to give parameters (here a boolean ~capitalize, or
     a piece of HTML text ~f1 or ~f2). Have a look at file
     assets/webapptpl_Demo_i18n.tsv
     to see how to write the corresponding translations.
  *)
  Lwt.return
    [ h1 [%i18n Demo.internationalization ~capitalize:true]
    ; p [%i18n Demo.internationalization_1]
    ; p
        [%i18n
          Demo.internationalization_2
            ~f1:[code [txt "assets/webapptpl_i18n.tsv"]]
            ~f2:[code [txt "webapptpl_i18n.eliom"]]]
    ; p [txt [%i18n Demo.S.internationalization_3]]
    ; p
        [%i18n
          Demo.internationalization_4
            ~f:[code [txt "assets/webapptpl_Demo_i18n.tsv"]]
            ~demo_prefix:[code [txt "demo_"]]] ]

(* Service registration is done on both sides (shared section),
   so that pages can be generated from the server
   (first request, crawling, search engines ...)
   or the client (subsequent link clicks, or mobile app ...). *)
let%shared () =
  Webapptpl_base.App.register ~service:Demo_services.demo_i18n
    ( Webapptpl_page.Opt.connected_page @@ fun myid_o () () ->
      let%lwt p = page () in
      Webapptpl_container.page ~a:[a_class ["os-page-demo-i18n"]] myid_o p )
