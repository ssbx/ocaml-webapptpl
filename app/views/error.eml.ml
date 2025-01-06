
let render code reason debug_info =
  <html>
  <body>
    <h1><%i code %> <%s reason %></h1>
    <pre><%s debug_info %></pre>
  </body>
  </html>
