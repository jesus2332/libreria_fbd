const fs = require('fs');
const oracledb = require('oracledb');
const express = require('express');
const bodyParser = require('body-parser');
const app = express();

function generateUserID() {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  const length = 4;
  let userID = '';

  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    userID += characters.charAt(randomIndex);
  }

  return userID;
}

function generateUsernp() {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  const length = 6;
  let userID = '';

  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    userID += characters.charAt(randomIndex);
  }

  return userID;
}

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
    const result = await connection.execute('SELECT * FROM autor');
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
        <tr>
          <td>${row[0]}</td>
          <td>${row[1]}</td>
          <td>${row[2]}</td>
          <td>${row[3]}</td>
          <!-- Agrega aquí las columnas adicionales -->
        </tr>
      `
    )
    .join('');
}

app.use(express.static('WWW'));
app.use(bodyParser.urlencoded({ extended: true }));


app.use((req, res) => {
  res.status(404).sendFile('./WWW/404error.html', { root: __dirname });
});

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
console.log("punto");

app.post('/login', async (req, res) => {
  console.log("puntooo");
  let usuarioid = generateUserID();
  let numeroprestamos = generateUsernp();
  console.log(req.body);
  const { usuarionombre, usuarioapellido, usuariodireccion, usuariotelefono, usuariocorreo, usuariocontraseña } = req.body;

  try {
    const connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute(
      `INSERT INTO usuario (usuarioid, usuarionombre, usuarioapellido, numeroprestamos, usuariodireccion, usuariotelefono, usuariocorreo, usuariocontraseña) 
      VALUES (:usuarioid, :usuarionombre, :usuarioapellido, :numeroprestamos, :usuariodireccion, :usuariotelefono, :usuariocorreo, :usuariocontraseña)`,
      [usuarioid, usuarionombre, usuarioapellido, numeroprestamos, usuariodireccion, usuariotelefono, usuariocorreo, usuariocontraseña]
    );

    console.log('Registro insertado correctamente');
    res.status(200).send('Registro insertado correctamente');
  } catch (error) {
    console.error('Error al insertar el registro', error);
    res.status(500).send('Error al insertar el registro');
  }
});

console.log("puntito");

app.listen(8888, () => {
  console.log('Servidor escuchando en el puerto 8888');
});

