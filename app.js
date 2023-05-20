const fs = require('fs');
const oracledb = require('oracledb');
const express = require('express');
const app = express();

const dbConfig = {
  user: 'PROYECTOFINAL',
  password: 'HOLA',
  connectString: 'localhost:1521/xepdb1'
};

const templateFile = './WWW/result.html';

async function getData() {
  let connection;

  try {
    connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute('SELECT * FROM libro');
    return result.rows;
  } catch (error) {
    console.error(error);
    throw error;
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (error) {
        console.error(error);
      }
    }
  }
}

function generateRowsHTML(data) {
  return data
    .map(
      row => `
    <div class="col s3">
          <div class="card-wrapper">
              <div class="card hoverable card-element">
                  <div class="card-image valign-wrapper card-index-image">
                    <img src="https://covers.openlibrary.org/b/isbn/${row[0]}-L.jpg ">
                    <a href="bookPage.html" class="btn-floating halfway-fab left waves-effect waves-light orange" style="left: 40%;"><i class="material-icons">add</i></a>
                  </div>
                  <div class="card-content center" id="card-title">
                    <h6>${decodeURIComponent(escape(row[1]))}</h6>
                  </div>
              </div>
         </div>

  </div>
    `
    ).join('');
}

app.get('/data', async (req, res) => {
  try {
    const data = await getData();
    fs.readFile(templateFile, 'utf8', (err, template) => {
      if (err) {
        res.status(500).send('Error reading template file.');
        return;
      }

      const renderedHTML = template.replace(
        '<!-- Aquí se generarán las filas de la tabla con los datos -->',
        generateRowsHTML(data)
      );

      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.write(renderedHTML);
      res.end();
    });
  } catch (error) {
    console.error(error);
    res.status(500).send('Error retrieving data from Oracle DB.');
  }
});

app.use(express.static('WWW'));

app.use((req, res) => {
  res.status(404).sendFile('./WWW/404error.html', { root: __dirname });
});


app.listen(8888, () => {
  console.log('Servidor escuchando en el puerto 8888');
});
