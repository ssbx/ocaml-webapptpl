open Lwt.Infix
type 'a io = 'a Lwt.t
let return = Lwt.return
let run t = Unix_os.Main.run t ; exit
0

let mirage_runtime_delay__key = Mirage_runtime.register_arg @@
# 33 "lib/devices/runtime_arg.ml"
  Mirage_runtime.delay
;;

let mirage_runtime_network_v4_network_ipaddr_v4_prefix_of_string_exn_0_0_0_00__key = Mirage_runtime.register_arg @@
# 64 "lib/devices/runtime_arg.ml"
  Mirage_runtime_network.V4.network (Ipaddr.V4.Prefix.of_string_exn "0.0.0.0/0")
;;

let mirage_runtime_network_v6_network_none__key = Mirage_runtime.register_arg @@
# 81 "lib/devices/runtime_arg.ml"
  Mirage_runtime_network.V6.network None
;;

let mirage_runtime_network_ipv4_only___key = Mirage_runtime.register_arg @@
# 94 "lib/devices/runtime_arg.ml"
  Mirage_runtime_network.ipv4_only ()
;;

let mirage_runtime_network_ipv6_only___key = Mirage_runtime.register_arg @@
# 98 "lib/devices/runtime_arg.ml"
  Mirage_runtime_network.ipv6_only ()
;;

let mirage_runtime_logs__key = Mirage_runtime.register_arg @@
# 204 "lib/devices/runtime_arg.ml"
  Mirage_runtime.logs
;;

let cmdliner_stdlib_setup_backtracesome_true_randomize_hashtablessome_true___key = Mirage_runtime.register_arg @@
# 404 "lib/mirage.ml"
  Cmdliner_stdlib.setup ~backtrace:(Some true) ~randomize_hashtables:(Some true) ()
;;

# 43 "mirage/main.ml"

module Mirage_logs_make__6 = Mirage_logs.Make(Pclock)

# 47 "mirage/main.ml"

module Unikernel_hello_world__11 = Unikernel.Hello_world(Pclock)(Unix_os.Time)(Tcpip_stack_socket.V4V6)

let mirage_bootvar__1 = lazy (
# 15 "lib/devices/argv.ml"
  return (Mirage_bootvar.argv ())
);;
# 55 "mirage/main.ml"

let struct_end__2 = lazy (
  let __mirage_bootvar__1 = Lazy.force mirage_bootvar__1 in
  __mirage_bootvar__1 >>= fun _mirage_bootvar__1 ->
# 47 "lib/functoria/job.ml"
  return Mirage_runtime.(with_argv (runtime_args ()) "hello" _mirage_bootvar__1)
);;
# 63 "mirage/main.ml"

let cmdliner_stdlib__3 = lazy (
  let _cmdliner_stdlib_setup_backtracesome_true_randomize_hashtablessome_true_ = (cmdliner_stdlib_setup_backtracesome_true_randomize_hashtablessome_true___key ()) in
  return (_cmdliner_stdlib_setup_backtracesome_true_randomize_hashtablessome_true_)
);;
# 69 "mirage/main.ml"

let mirage_runtime__4 = lazy (
  let _mirage_runtime_delay = (mirage_runtime_delay__key ()) in
# 302 "lib/mirage.ml"
  Unix_os.Time.sleep_ns (Duration.of_sec _mirage_runtime_delay)
);;
# 76 "mirage/main.ml"

let pclock__5 = lazy (
  return ()
);;
# 81 "mirage/main.ml"

let mirage_logs_make__6 = lazy (
  let __pclock__5 = Lazy.force pclock__5 in
  __pclock__5 >>= fun _pclock__5 ->
  let _mirage_runtime_logs = (mirage_runtime_logs__key ()) in
# 22 "lib/devices/reporter.ml"
  let reporter = Mirage_logs_make__6.create () in
  Mirage_runtime.set_level ~default:(Some Logs.Info) _mirage_runtime_logs;
  Logs.set_reporter reporter;
  Lwt.return reporter
);;
# 93 "mirage/main.ml"

let unix_os_time__7 = lazy (
  return ()
);;
# 98 "mirage/main.ml"

let udpv4v6_socket__8 = lazy (
  let _mirage_runtime_network_ipv4_only_ = (mirage_runtime_network_ipv4_only___key ()) in
  let _mirage_runtime_network_ipv6_only_ = (mirage_runtime_network_ipv6_only___key ()) in
  let _mirage_runtime_network_v4_network_ipaddr_v4_prefix_of_string_exn_0_0_0_00 = (mirage_runtime_network_v4_network_ipaddr_v4_prefix_of_string_exn_0_0_0_00__key ()) in
  let _mirage_runtime_network_v6_network_none = (mirage_runtime_network_v6_network_none__key ()) in
# 35 "lib/devices/udp.ml"
  Udpv4v6_socket.connect ~ipv4_only:_mirage_runtime_network_ipv4_only_ ~ipv6_only:_mirage_runtime_network_ipv6_only_ _mirage_runtime_network_v4_network_ipaddr_v4_prefix_of_string_exn_0_0_0_00 _mirage_runtime_network_v6_network_none
);;
# 108 "mirage/main.ml"

let tcpv4v6_socket__9 = lazy (
  let _mirage_runtime_network_ipv4_only_ = (mirage_runtime_network_ipv4_only___key ()) in
  let _mirage_runtime_network_ipv6_only_ = (mirage_runtime_network_ipv6_only___key ()) in
  let _mirage_runtime_network_v4_network_ipaddr_v4_prefix_of_string_exn_0_0_0_00 = (mirage_runtime_network_v4_network_ipaddr_v4_prefix_of_string_exn_0_0_0_00__key ()) in
  let _mirage_runtime_network_v6_network_none = (mirage_runtime_network_v6_network_none__key ()) in
# 41 "lib/devices/tcp.ml"
  Tcpv4v6_socket.connect ~ipv4_only:_mirage_runtime_network_ipv4_only_ ~ipv6_only:_mirage_runtime_network_ipv6_only_ _mirage_runtime_network_v4_network_ipaddr_v4_prefix_of_string_exn_0_0_0_00 _mirage_runtime_network_v6_network_none
);;
# 118 "mirage/main.ml"

let tcpip_stack_socket_v4v6__10 = lazy (
  let __udpv4v6_socket__8 = Lazy.force udpv4v6_socket__8 in
  let __tcpv4v6_socket__9 = Lazy.force tcpv4v6_socket__9 in
  __udpv4v6_socket__8 >>= fun _udpv4v6_socket__8 ->
  __tcpv4v6_socket__9 >>= fun _tcpv4v6_socket__9 ->
# 121 "lib/devices/stack.ml"
  Tcpip_stack_socket.V4V6.connect _udpv4v6_socket__8 _tcpv4v6_socket__9
);;
# 128 "mirage/main.ml"

let unikernel_hello_world__11 = lazy (
  let __pclock__5 = Lazy.force pclock__5 in
  let __unix_os_time__7 = Lazy.force unix_os_time__7 in
  let __tcpip_stack_socket_v4v6__10 = Lazy.force tcpip_stack_socket_v4v6__10 in
  __pclock__5 >>= fun _pclock__5 ->
  __unix_os_time__7 >>= fun _unix_os_time__7 ->
  __tcpip_stack_socket_v4v6__10 >>= fun _tcpip_stack_socket_v4v6__10 ->
  (Unikernel_hello_world__11.start _pclock__5 _unix_os_time__7
_tcpip_stack_socket_v4v6__10 : unit io)
);;
# 140 "mirage/main.ml"

let mirage_runtime__12 = lazy (
  let __struct_end__2 = Lazy.force struct_end__2 in
  let __cmdliner_stdlib__3 = Lazy.force cmdliner_stdlib__3 in
  let __mirage_runtime__4 = Lazy.force mirage_runtime__4 in
  let __mirage_logs_make__6 = Lazy.force mirage_logs_make__6 in
  let __unikernel_hello_world__11 = Lazy.force unikernel_hello_world__11 in
  __struct_end__2 >>= fun _struct_end__2 ->
  __cmdliner_stdlib__3 >>= fun _cmdliner_stdlib__3 ->
  __mirage_runtime__4 >>= fun _mirage_runtime__4 ->
  __mirage_logs_make__6 >>= fun _mirage_logs_make__6 ->
  __unikernel_hello_world__11 >>= fun _unikernel_hello_world__11 ->
# 385 "lib/mirage.ml"
  return ()
);;
# 156 "mirage/main.ml"

let () =
  let t = Lazy.force struct_end__2 >>= fun _ ->
  Lazy.force cmdliner_stdlib__3 >>= fun _ ->
  Lazy.force mirage_runtime__4 >>= fun _ ->
  Lazy.force mirage_logs_make__6 >>= fun _ ->
  Lazy.force mirage_runtime__12 in
  run t
;;
