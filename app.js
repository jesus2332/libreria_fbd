const fs = require('fs');
const oracledb = require('oracledb');
const express = require('express');
const app = express();
const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

const dbConfig = {
  user: 'LIBRARYFCM',
  password: 'condenado',
  connectString: 'localhost:1521/xepdb1'
};

const templateFile = './WWW/result.html';

function generateUserID() {
  const numbers = '0123456789';
  const length = 4;
  let userID = '';

  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * numbers.length);
    userID += numbers.charAt(randomIndex);
  }

  return userID;
}

function generateUsernp() {
  const numbers = '0123456789';
  const length = 6;
  let userNP = '';

  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * numbers.length);
    userNP += numbers.charAt(randomIndex);
  }

  return userNP;
}


app.post('/reg', async (req, res) => {

  try {
    let usuarioid = generateUserID();
    let numeroprestamos = generateUsernp();
    const {
      usuarionombre,
      usuarioapellido,
      usuariodireccion,
      usuariotelefono,
      usuariocorreo,
      usuariocontrasena
    } = req.body;

    const connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute(
      `INSERT INTO usuario (usuarioid, usuarionombre, usuarioapellido, numeroprestamos, usuariodireccion, usuariotelefono, usuariocorreo, usuariocontrasena)
       VALUES (:usuarioid, :usuarionombre, :usuarioapellido, :numeroprestamos, :usuariodireccion, :usuariotelefono, :usuariocorreo, :usuariocontrasena)`,
      [usuarioid, usuarionombre, usuarioapellido, numeroprestamos, usuariodireccion, usuariotelefono, usuariocorreo, usuariocontrasena]
    );

    await connection.commit();
    await connection.close();

    const alertHTML = `
    <script>
      alert('Usuario registrado exitosamente');
      window.location.href = '/login.html'; // Redirige a otra página después de mostrar el alert
    </script>
  `;
  res.send(alertHTML);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: 'Error al registrar el usuario' });

  }
});



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
    <div class="col s3 data-category-id="${row[6]}">
      <div class="card-wrapper">
        <div class="card hoverable card-element">
          <div class="card-image valign-wrapper card-index-image">
            <img src="https://covers.openlibrary.org/b/isbn/${row[0]}-L.jpg ">
            <a href="bookPage.html" class="btn-floating halfway-fab left waves-effect waves-light orange" style="left: 40%;"><i class="material-icons">add</i></a>
          </div>
          <div class="card-content center" id="card-title">
            <h6>${decodeURIComponent(row[1])}</h6>                    
          </div>
        </div>
      </div>
    </div>
    `
    )
    .join('');
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


app.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    const connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute(
     `SELECT * FROM usuario WHERE usuariocorreo = :email AND usuariocontrasena = :password`,
      [email, password]
    );

    await connection.close();

    if (result.rows.length > 0) {
      // Se encontró una coincidencia en la base de datos
      res.redirect('./userOrders.html');
    } else {
      // No se encontraron coincidencias en la base de datos
      res.status(401).json({ message: 'Credenciales inválidas' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al comparar los datos con la base de datos' });
  }
});

app.use(express.static('WWW'));

app.use((req, res) => {
  res.status(404).sendFile('./WWW/404error.html', { root: __dirname });
});


app.listen(8888, () => {
  console.log('Servidor escuchando en el puerto 8888');
});

