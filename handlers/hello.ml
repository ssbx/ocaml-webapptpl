
let handle_hello _ = Dream.html "hello dream!"

let handle_hello2 request =
  Dream.html (Dream.param request "word")
