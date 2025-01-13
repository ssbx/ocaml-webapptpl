(* This file was generated by Ocsigen-start.
   Feel free to use it, modify it, and redistribute it as you wish. *)

let%server best_matched_language () =
  (* lang contains a list of (language_as_string, quality_value) *)
  let lang = Eliom_request_info.get_accept_language () in
  (* If no quality is given, we suppose it's 1 *)
  let lang =
    List.map (fun (s, q) -> s, match q with Some q -> q | None -> 1.) lang
  in
  (* Increasingly sort based on the quality *)
  let lang = List.sort (fun (_, q1) (_, q2) -> compare q2 q1) lang in
  Lwt.return
  @@
  (* The first language of the list is returned. If the list is empty,
     the default language is returned. *)
  let rec aux = function
    | (l, _) :: tl -> (
      try Webapptpl_i18n.guess_language_of_string l
      with Webapptpl_i18n.Unknown_language _ -> aux tl)
    | [] -> Webapptpl_i18n.default_language
  in
  aux lang

let%server update_language lang =
  let language = Webapptpl_i18n.string_of_language lang in
  let myid_o = Os_current_user.Opt.get_current_userid () in
  (* Update the server and client values *)
  Webapptpl_i18n.set_language lang;
  ignore [%client (Webapptpl_i18n.set_language ~%lang : unit)];
  (* Update in the database if a user is connected *)
  match myid_o with
  | None -> Lwt.return_unit
  | Some userid -> Os_user.update_language ~userid ~language

let%server _ =
  Os_session.on_start_process (fun _ ->
    (* Guess a default language. *)
    let%lwt lang = best_matched_language () in
    ignore (update_language lang);
    Lwt.return_unit);
  Os_session.on_start_connected_process (fun userid ->
    (* Set language according to user preferences. *)
    let%lwt language =
      match%lwt Os_user.get_language userid with
      | Some lang -> Lwt.return (Webapptpl_i18n.guess_language_of_string lang)
      | None ->
          let%lwt best_language = best_matched_language () in
          ignore
            (Os_user.update_language ~userid
               ~language:(Webapptpl_i18n.string_of_language best_language));
          Lwt.return best_language
    in
    Webapptpl_i18n.set_language language;
    ignore [%client (Webapptpl_i18n.set_language ~%language : unit)];
    Lwt.return_unit)
