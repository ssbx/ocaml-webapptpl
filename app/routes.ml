let lst = 
  []
  (* fail test, count fail/success *)
  @ [ Dream.get "/fail" Controllers.Count.fail_fun
    ; Dream.get "/count" Controllers.Count.get_count]

  (* hello and hello param *)
  @ [ Dream.get "/"            Controllers.Hello.handle_hello
    ; Dream.get "/hello"       Controllers.Hello.handle_hello
    ; Dream.get "/hello/:word" Controllers.Hello.handle_hello2 ]

  (* print request sync/async *)
  @ [ Dream.post "/print_request" Controllers.Echo.handle_sync
    ; Dream.post "/print_request2" Controllers.Echo.handle_async ]

  @ [ Dream.get "/templates" Controllers.Templates.handle1 
    ; Dream.get "/templates/:word" Controllers.Templates.handle2 ]

  @ [ Dream.get "/static/**" Controllers.Static.handle 
    ; Dream.get "/favicon.ico" Controllers.Static.handle ]
