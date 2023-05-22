const fs = require('fs');
const oracledb = require('oracledb');
const express = require('express');
const app = express();
const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var loggedUserID = null;

const dbConfig = {
  user: 'LIBRARYFCM',
  password: 'condenado',
  connectString: '192.168.56.1:1521/xepdb1'
};

const templateFile = './WWW/result.html';

function generateUserID() {
  const numbers = '0123456789';
  const length = 6;
  let userID = '';

  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * numbers.length);
    userID += numbers.charAt(randomIndex);
  }

  return userID;
}



function generateLoanId() {
  const numbers = '0123456789';
  const length = 10;
  let LoanID = '';

  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * numbers.length);
    LoanID += numbers.charAt(randomIndex);
  }

  return LoanID;
}






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
    <div class="category${row[6]}">
      <div class="card-wrapper"">
        <div class="card hoverable card-element">
          <div class="card-image valign-wrapper card-index-image">
            <img src="https://covers.openlibrary.org/b/isbn/${row[0]}-L.jpg ">
            <a href="bookPage.html?isbn=${row[0]}" class="btn-floating halfway-fab left waves-effect waves-light orange" style="left: 40%;"><i class="material-icons">add</i></a>
          </div>
          <div class="card-content center" id="card-title">
            <h6>${decodeURIComponent((row[1]))}</h6>                    
          </div>
        </div>
      </div>
    </div>
  </div>
    `
    )
    .join('');
}



app.get('/data/genre/:id', async (req, res) => {
  try {
    const genreId = req.params.id;
    const connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute(
      'SELECT generonombre FROM genero WHERE generoid = :id',
      [genreId]
    );
    await connection.close();

    const genreName = decodeURIComponent((result.rows[0][0]));  //genreName utilizado con .genreName
    res.json({ genreName });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error retrieving genre name from database.' });
  }
});



app.get('/data/publisher/:id', async (req, res) => {
  try {
    const publisherId = req.params.id;
    const connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute(
      'SELECT editorialnombre FROM editorial WHERE editorialid = :id',
      [publisherId]
    );
    await connection.close();

    const publisherName = result.rows[0][0];
    res.json({ publisherName });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error retrieving publisher name from database.' });
  }
});



app.get('/data/:isbn', async (req, res) => {
  try {
    const isbn = req.params.isbn;

    // Obtener la información del libro desde la base de datos según el ISBN
    const connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute('SELECT * FROM libro WHERE LibroID = :LibroID', [isbn]);
    const book = result.rows[0];

    const authorResult = await connection.execute('SELECT * FROM autor WHERE autorid IN (SELECT autorid FROM autor_libro WHERE LibroID = :LibroID)', [isbn]);
    const author = authorResult.rows[0];
    

    await connection.close();

    // Enviar la información del libro como respuesta
    res.json({
      isbn: book[0],
      pages: book[3],
      language: book[5],
      genre: book[6],
      publisher: book[7],
      stock: book[4],
      title: book[1],
      year: book[2],
      authorName: author[1],
      authorLastName: author[2]
      
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al obtener la información del libro' });
  }
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




app.post('/reg', async (req, res) => {

  try {
    let usuarioid = generateUserID();

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
      `INSERT INTO usuario (usuarioid, usuarionombre, usuarioapellido,  usuariodireccion, usuariotelefono, usuariocorreo, usuariocontrasena)
       VALUES (:usuarioid, :usuarionombre, :usuarioapellido,  :usuariodireccion, :usuariotelefono, :usuariocorreo, :usuariocontrasena)`,
      [usuarioid, usuarionombre, usuarioapellido, usuariodireccion, usuariotelefono, usuariocorreo, usuariocontrasena]
    );

    await connection.commit();
    await connection.close();

    const alertHTML = `
    <script>
      alert('Usuario registrado exitosamente, por favor inicie sesión');
      window.location.href = '/index.html'; // Redirige a otra página después de mostrar el alert
    </script>
  `;
  res.send(alertHTML);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: 'Error al registrar el usuario' });

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

    console.log(result.rows);

    const sucessAlert = `
    <script>
      alert('Usuario logeado exitosamente');
      window.location.href = '/books.html'; // Redirige a otra página después de mostrar el alert
    </script>
  `;

    await connection.close();

    if (result.rows.length > 0) {
      // Se encontró una coincidencia en la base de datos
      loggedUserID = result.rows[0][0];
      res.send(sucessAlert);

    } else {
      // No se encontraron coincidencias en la base de datos
      res.status(401).json({ message: 'Credenciales inválidas' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al comparar los datos con la base de datos' });
  }
});




app.post('/order', async (req, res) => {
  prestamoID = generateLoanId();
  const { isbn } = req.body;
  const userID = loggedUserID;
  console.log(userID,isbn);
  const sucessAlert = `
    <script>
      alert('Usuario logeado exitosamente');// Redirige a otra página después de mostrar el alert
    </script>
  `;
  try {
    const connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute(
      `SELECT a.ArticuloID
      FROM Articulo a
      LEFT JOIN Prestamo p ON a.ArticuloID = p.ArticuloID
      WHERE a.LibroID = :isbn AND p.ArticuloID IS NULL AND ROWNUM = 1
      `,
      [isbn]
    );
    await connection.close();

    if(result.rows[0] == undefined){
      console.log("Ya no hay stock  disponible")
    }
    else{
      articuloID = result.rows[0][0];
      const connection = await oracledb.getConnection(dbConfig);
      const loan = await connection.execute(
        `INSERT INTO Prestamo (PrestamoID, PrestamoFecha, PrestamoCaducidad, PrestamoEstatus, UsuarioID, ArticuloID)
          VALUES (:prestamoid, SYSDATE, SYSDATE+7, 'Activo', :userID, :articuloID)`,
        [prestamoID, userID, articuloID]
      );
      const minusStock = await connection.execute(
        `UPDATE Libro SET Cantidad = Cantidad - 1 WHERE LibroID = :isbn`,
        [isbn]
      );
      await connection.commit();
      await connection.close();
      console.log("Prestamo registrado exitosamente");
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al registrar el prestamo' });
  }
});


  


    

app.get('/loggedUserID', (req, res) => {
  res.json({ loggedUserID });
});

app.get('/logout', (req, res) => {
  loggedUserID = null;
  res.redirect('/index.html');
});

//proteger mis rutas books.html userOrders.html bookPage.html si el loggedUserID es null, es decir, si no hay un usuario logeado en el sistema entonces redirigir a index.html



app.use(express.static('WWW'));

app.use((req, res) => {
  res.status(404).sendFile('./WWW/404error.html', { root: __dirname });
});


app.listen(8888, () => {
  console.log('Servidor escuchando en el puerto 8888');
});

