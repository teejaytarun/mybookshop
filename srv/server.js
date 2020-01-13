/*eslint no-console: 0*/
"use strict";

var http = require("http");
var port = process.env.PORT || 3000;

http.createServer(function (req, res) {
  res.writeHead(200, {"Content-Type": "text/plain"});
  res.end("Hello World\n");
}).listen(port);

console.log("Server listening on port %d", port);

// const odatav2proxy = require("@sap/cds-odata-v2-adapter-proxy")
// const express = require("express")
// const cds = require("@sap/cds")

// const { PORT=3000 } = process.env
// const app = express()

// cds.serve("all").in(app)

// app.use(odatav2proxy({ port: PORT }))

// app.listen (PORT, ()=> console.info(`server listening on http:\/\/localhost:${PORT}`))