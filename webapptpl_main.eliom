(** This is the main file if you are using static linking without config file.
 *)

module%shared Webapptpl = Webapptpl

let%server _ =
  Ocsigen_server.start
    ~ports:[`All, 8080]
    ~veryverbose:()
    ~debugmode:true
    ~logdir:"local/var/log/webapptpl"
    ~datadir:"local/var/data/webapptpl"
    ~uploaddir:(Some "/tmp")
    ~usedefaulthostname:true
    ~command_pipe:"local/var/run/webapptpl-cmd"
    ~default_charset:(Some "utf-8")
    [ Ocsigen_server.host
      [Staticmod.run ~dir:"local/var/www/webapptpl" (); Eliom.run ()] ]
