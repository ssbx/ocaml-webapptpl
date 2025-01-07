let lst = 
  []
  (* fail test, count fail/success *)
  @ [ Dream.get "/fail" Handlers.Count.fail_fun
    ; Dream.get "/count" Handlers.Count.get_count]

  (* hello and hello param *)
  @ [ Dream.get "/"            Handlers.Hello.handle_hello
    ; Dream.get "/hello"       Handlers.Hello.handle_hello
    ; Dream.get "/hello/:word" Handlers.Hello.handle_hello2 ]

  (* print request sync/async *)
  @ [ Dream.post "/print_request" Handlers.Echo.handle_sync
    ; Dream.post "/print_request2" Handlers.Echo.handle_async ]

  @ [ Dream.get "/templates" Handlers.With_templates.handle1 
    ; Dream.get "/templates/:word" Handlers.With_templates.handle2 ]

  @ [ Dream.get "/**" Handlers.Static.handle ]
