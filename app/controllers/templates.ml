
let handle1 _ =
  Views.Base.render "noword"
  |> Dream.html

let handle2 request =
  Dream.param request "word"
  |> Views.Base.render
  |> Dream.html

