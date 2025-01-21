
let handle1 _ =
  Templates.Base.render "noword"
  |> Dream.html

let handle2 request =
  Dream.param request "word"
  |> Templates.Base.render
  |> Dream.html

