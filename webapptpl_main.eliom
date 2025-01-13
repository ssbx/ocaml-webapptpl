(** This is the main file if you are using static linking without config file.
    It is not used if you are using a config file and ocsigenserver *)

module%shared Webapptpl = Webapptpl

let%server _ =
  Ocsigen_server.start
    [ Ocsigen_server.host
        [Staticmod.run ~dir:"local/var/www/webapptpl" (); Eliom.run ()] ]
