const http = require('http');
const fs = require('fs');

http.createServer((request, response) => {
  const file = request.url === '/' ? './WWW/index.html' : `./WWW${request.url}`;

  console.log("Conexión");

  if (request.url === "/login") {
    let data = [];
    request.on("data", value => {
      data.push(value);
    }).on("end", () => {    
      let params = Buffer.concat(data).toString();
      console.log(params);
      response.end();
    });
  } else {
    fs.readFile(file, (err, data) => {
      if (err) {
        response.writeHead(404, {"Content-Type": "text/plain"});
        response.write("404 Not Found");
        response.end();
      } else {
        let contentType = "text/html";

        const extension = file.split('.').pop();
        switch (extension) {
          case "txt":
            contentType = "text/plain";
            break;
          case "html":
            contentType = "text/html";
            break;
          case "css":
            contentType = "text/css";
            break;
          case "ico":
            contentType = "image/x-icon";
            break;
          case "js":
            contentType = "text/javascript";
            break;
          case "jpeg":
            contentType = "image/jpeg";
            break;
        }

        response.writeHead(200, {"Content-Type": contentType});
        response.write(data);
        response.end();
      }
    });
  }
}).listen(4444);
