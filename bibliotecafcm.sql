-- Eliminar todas las restricciones en la base de datos 
ALTER TABLE Libro
   DROP CONSTRAINT R_16 CASCADE;
   
ALTER TABLE Libro
   DROP CONSTRAINT R_21 CASCADE;
   
ALTER TABLE Articulo
   DROP CONSTRAINT R_23 CASCADE;

ALTER TABLE Autor_Libro
   DROP CONSTRAINT R_19 CASCADE;

ALTER TABLE Autor_Libro
   DROP CONSTRAINT R_20 CASCADE;

ALTER TABLE GeneroDesc
   DROP CONSTRAINT R_27 CASCADE;

ALTER TABLE Editorial_Sede
   DROP CONSTRAINT R_29 CASCADE;

ALTER TABLE Editorial_Sede
   DROP CONSTRAINT R_30 CASCADE;

ALTER TABLE Multa
   DROP CONSTRAINT R_17 CASCADE;

ALTER TABLE Prestamo
   DROP CONSTRAINT R_32 CASCADE;

ALTER TABLE Prestamo
   DROP CONSTRAINT R_33 CASCADE;

-- Eliminar las restricciones de clave primaria en cada tabla
ALTER TABLE Libro
   DROP CONSTRAINT XPKLibro CASCADE;

ALTER TABLE Articulo
   DROP CONSTRAINT XPKArticulo CASCADE;

ALTER TABLE Autor
   DROP CONSTRAINT XPKAutor CASCADE;

ALTER TABLE Autor_Libro
   DROP CONSTRAINT XPKAutor_Libro CASCADE;

ALTER TABLE Editorial
   DROP CONSTRAINT XPKEditorial CASCADE;

ALTER TABLE Genero
   DROP CONSTRAINT XPKGenero CASCADE;

ALTER TABLE GeneroDesc
   DROP CONSTRAINT XPKGeneroDesc CASCADE;

ALTER TABLE Sede
   DROP CONSTRAINT XPKSede CASCADE;

ALTER TABLE Editorial_Sede
   DROP CONSTRAINT XPKEditorial_Sede CASCADE;

ALTER TABLE Usuario
   DROP CONSTRAINT XPKUsuario CASCADE;

ALTER TABLE Multa
   DROP CONSTRAINT XPKMulta CASCADE;

ALTER TABLE Prestamo
   DROP CONSTRAINT XPKPrestamo CASCADE;
   
ALTER TABLE Usuario
   DROP CONSTRAINT UQ_UsuarioCorreo;

-- Eliminar las tablas
DROP TABLE Autor;
DROP TABLE Genero;
DROP TABLE Editorial;
DROP TABLE Libro;
DROP TABLE Autor_Libro;
DROP TABLE Articulo;
DROP TABLE Prestamo;
DROP TABLE Usuario;
DROP TABLE Multa;
DROP TABLE GeneroDesc;
DROP TABLE Sede;
Drop TABLE Editorial_Sede;
Drop TABLE Autor_Libro;

CREATE TABLE Libro
(
	LibroID              INT  NOT NULL ,
	LibroTitulo          VARCHAR2(100)  NOT NULL ,
	LibroFecha           DATE  NOT NULL ,
	LibroPaginas         INT  NOT NULL ,
	Cantidad             INT  NOT NULL ,
	Idioma               VARCHAR2(50)  NOT NULL ,
	GeneroID             INT  NULL ,
	EditorialID          INT  NULL 
);

ALTER TABLE Libro
	ADD CONSTRAINT  XPKLibro PRIMARY KEY (LibroID);

CREATE TABLE Articulo
(
	ArticuloID           INT  NOT NULL ,
	ArticuloEstatus      VARCHAR2(20)  NOT NULL ,
	LibroID              INT  NULL 
);

ALTER TABLE Articulo
	ADD CONSTRAINT  XPKArticulo PRIMARY KEY (ArticuloID);

CREATE TABLE Autor
(
	AutorID              INT  NOT NULL ,
	AutorNombre          VARCHAR2(100)  NOT NULL ,
	AutorApellido        VARCHAR2(100)  NOT NULL ,
	AutorNacionalidad    VARCHAR2(50)  NOT NULL 
);

ALTER TABLE Autor
	ADD CONSTRAINT  XPKAutor PRIMARY KEY (AutorID);

CREATE TABLE Autor_Libro
(
	AutorID              INT  NOT NULL ,
	LibroID              INT  NOT NULL 
);

ALTER TABLE Autor_Libro
	ADD CONSTRAINT  XPKAutor_Libro PRIMARY KEY (AutorID,LibroID);

CREATE TABLE Editorial
(
	EditorialID          INT  NOT NULL ,
	EditorialNombre      VARCHAR(100)  NOT NULL 
);

ALTER TABLE Editorial
	ADD CONSTRAINT  XPKEditorial PRIMARY KEY (EditorialID);

CREATE TABLE Genero
(
	GeneroID             INT  NOT NULL ,
	GeneroNombre         VARCHAR2(30)  NOT NULL 
);

ALTER TABLE Genero
	ADD CONSTRAINT  XPKGenero PRIMARY KEY (GeneroID);

CREATE TABLE GeneroDesc
(
	GeneroID             INT  NOT NULL ,
	GeneroDescripcion    VARCHAR2(500)  NOT NULL 
);

ALTER TABLE GeneroDesc
	ADD CONSTRAINT  XPKGeneroDesc PRIMARY KEY (GeneroID);

CREATE TABLE Sede
(
	SedeID               INT  NOT NULL ,
	Localizacion         VARCHAR2(100)  NOT NULL 
);

ALTER TABLE Sede
	ADD CONSTRAINT  XPKSede PRIMARY KEY (SedeID);

CREATE TABLE Editorial_Sede
(
	EditorialID          INT  NOT NULL ,
	SedeID               INT  NOT NULL 
);

ALTER TABLE Editorial_Sede
	ADD CONSTRAINT  XPKEditorial_Sede PRIMARY KEY (EditorialID,SedeID);

CREATE TABLE Usuario
(
	UsuarioID            INT  NOT NULL ,
	UsuarioNombre        VARCHAR2(50)  NOT NULL ,
	UsuarioApellido      VARCHAR2(50)  NOT NULL ,
	UsuarioDireccion     VARCHAR2(150)  NOT NULL ,
	UsuarioTelefono      VARCHAR2(50)  NOT NULL ,
	UsuarioCorreo        VARCHAR2(100)  NOT NULL ,
	UsuarioContrasena    VARCHAR2(100)  NOT NULL 
);

ALTER TABLE Usuario
	ADD CONSTRAINT  XPKUsuario PRIMARY KEY (UsuarioID);

CREATE TABLE Multa
(
	MultaID               INT  NOT NULL ,
	Monto                DECIMAL(10,2)  NOT NULL ,
	MultaFecha           DATE  NOT NULL ,
	Estatus              VARCHAR2(30)  NOT NULL ,
	UsuarioID            INT  NULL 
);

ALTER TABLE Multa
	ADD CONSTRAINT  XPKMulta PRIMARY KEY (MultaID);

CREATE TABLE Prestamo
(
	PrestamoID           INT  NOT NULL ,
	PrestamoFecha        DATE  NOT NULL ,
	PrestamoCaducidad    DATE  NOT NULL ,
	PrestamoEstatus      VARCHAR2(20)  NOT NULL ,
	UsuarioID            INT  NULL ,
	ArticuloID           INT  NULL 
);

ALTER TABLE Prestamo
	ADD CONSTRAINT  XPKPrestamo PRIMARY KEY (PrestamoID);

ALTER TABLE Libro
	ADD (
CONSTRAINT R_16 FOREIGN KEY (GeneroID) REFERENCES Genero (GeneroID) ON DELETE SET NULL);

ALTER TABLE Libro
	ADD (
CONSTRAINT R_21 FOREIGN KEY (EditorialID) REFERENCES Editorial (EditorialID) ON DELETE SET NULL);

ALTER TABLE Articulo
	ADD (
CONSTRAINT R_23 FOREIGN KEY (LibroID) REFERENCES Libro (LibroID) ON DELETE SET NULL);

ALTER TABLE Autor_Libro
	ADD (
CONSTRAINT R_19 FOREIGN KEY (AutorID) REFERENCES Autor (AutorID));

ALTER TABLE Autor_Libro
	ADD (
CONSTRAINT R_20 FOREIGN KEY (LibroID) REFERENCES Libro (LibroID));

ALTER TABLE GeneroDesc
	ADD (
CONSTRAINT R_27 FOREIGN KEY (GeneroID) REFERENCES Genero (GeneroID));

ALTER TABLE Editorial_Sede
	ADD (
CONSTRAINT R_29 FOREIGN KEY (EditorialID) REFERENCES Editorial (EditorialID));

ALTER TABLE Editorial_Sede
	ADD (
CONSTRAINT R_30 FOREIGN KEY (SedeID) REFERENCES Sede (SedeID));

ALTER TABLE Multa
	ADD (
CONSTRAINT R_17 FOREIGN KEY (UsuarioID) REFERENCES Usuario (UsuarioID) ON DELETE SET NULL);

ALTER TABLE Prestamo
	ADD (
CONSTRAINT R_32 FOREIGN KEY (UsuarioID) REFERENCES Usuario (UsuarioID) ON DELETE SET NULL);

ALTER TABLE Prestamo
	ADD (
CONSTRAINT R_33 FOREIGN KEY (ArticuloID) REFERENCES Articulo (ArticuloID) ON DELETE SET NULL);

ALTER TABLE Usuario
    ADD CONSTRAINT UQ_UsuarioCorreo UNIQUE (UsuarioCorreo);

--Genero
INSERT INTO Genero (GeneroID, GeneroNombre)
VALUES (1, 'Arte');

INSERT INTO Genero (GeneroID, GeneroNombre)
VALUES (2, 'Aventura');

INSERT INTO Genero (GeneroID, GeneroNombre)
VALUES (3, 'Ciencia ficciÃ³n');

INSERT INTO Genero (GeneroID, GeneroNombre)
VALUES (4, 'FantasÃ­a');

INSERT INTO Genero (GeneroID, GeneroNombre)
VALUES (5, 'FilosofÃ­a');

INSERT INTO Genero (GeneroID, GeneroNombre)
VALUES (6, 'Historia');

INSERT INTO Genero (GeneroID, GeneroNombre)
VALUES (7, 'Terror');

-- GeneroDesc
INSERT INTO GeneroDesc (GeneroID, GeneroDescripcion)
VALUES (1, 'Son publicaciones que presentan y exploran obras de arte visual, ya sea de artistas, movimientos artÃ­sticos o periodos histÃ³ricos del arte');

INSERT INTO GeneroDesc (GeneroID, GeneroDescripcion)
VALUES (2, 'Son aquellos libros que se centran en contar emocionantes historias de viajes, descubrimientos y desafÃ­os');

INSERT INTO GeneroDesc (GeneroID, GeneroDescripcion)
VALUES (3, 'Los libros de ciencia ficciÃ³n son obras literarias que exploran conceptos, escenarios y tecnologÃ­as imaginarias basadas en la ciencia y la especulaciÃ³n cientÃ­fica.');

INSERT INTO GeneroDesc (GeneroID, GeneroDescripcion)
VALUES (4, 'Son obras literarias que se desarrollan en mundo imaginarios, llenos de elementos mÃ¡gicos, seres fantÃ¡sticos y aventuras extraordinarias.');

INSERT INTO GeneroDesc (GeneroID, GeneroDescripcion)
VALUES (5, 'Es un campo de estudio que se ocupa de explorar preguntas fundamentales sobre la existencia, el conocimiento, la Ã©tica, la realidad y la naturaleza humana.');

INSERT INTO GeneroDesc (GeneroID, GeneroDescripcion)
VALUES (6, 'Los libros de historia son publicaciones que ofrecen una visiÃ³n general de los eventos, personas y perÃ­odos clave de la historia humana. ');

INSERT INTO GeneroDesc (GeneroID, GeneroDescripcion)
VALUES (7, 'Son obras literarias que buscan generar emociones intensas de miedo, suspenso y angustia en los lectores.');


--Editorial
INSERT INTO Editorial (EditorialID, EditorialNombre)
VALUES (1, 'Phaidon');

INSERT INTO Editorial (EditorialID, EditorialNombre)
VALUES (2, 'Blume');

INSERT INTO Editorial (EditorialID, EditorialNombre)
VALUES (3, 'Oxford University Press');

INSERT INTO Editorial (EditorialID, EditorialNombre)
VALUES (4, 'Taschen');

INSERT INTO Editorial (EditorialID, EditorialNombre)
VALUES (5, 'Penguin Random House');

INSERT INTO Editorial (EditorialID, EditorialNombre)
VALUES (6, 'Austral');

INSERT INTO Editorial (EditorialID, EditorialNombre)
VALUES (7, 'Selector');

INSERT INTO Editorial (EditorialID, EditorialNombre)
VALUES (8, 'Editores Mexicanos');

INSERT INTO Editorial (EditorialID, EditorialNombre)
VALUES (9, 'Alma');

INSERT INTO Editorial (EditorialID, EditorialNombre)
VALUES (10, 'Booket MÃ©xico');

INSERT INTO Editorial (EditorialID, EditorialNombre)
VALUES (11, 'OcÃ©ano de MÃ©xico');

INSERT INTO Editorial (EditorialID, EditorialNombre)
VALUES (12, 'Editorial independiente');

INSERT INTO Editorial (EditorialID, EditorialNombre)
VALUES (13, 'Alianza');

INSERT INTO Editorial (EditorialID, EditorialNombre)
VALUES (14, 'Dante');

--Sede
INSERT INTO Sede (SedeID, Localizacion)
VALUES (1, 'New York');

INSERT INTO Sede (SedeID, Localizacion)
VALUES (2, 'MÃ©xico');

INSERT INTO Sede (SedeID, Localizacion)
VALUES (3, 'Inglaterra');

INSERT INTO Sede (SedeID, Localizacion)
VALUES (4, 'EspaÃ±a');

INSERT INTO Sede (SedeID, Localizacion)
VALUES (5, 'Barcelona, EspaÃ±a');

INSERT INTO Sede (SedeID, Localizacion)
VALUES (6, 'CataluÃ±a, EspaÃ±a');

INSERT INTO Sede (SedeID, Localizacion)
VALUES (7, 'MÃ©xico');

INSERT INTO Sede (SedeID, Localizacion)
VALUES (8, 'MÃ©xico');

INSERT INTO Sede (SedeID, Localizacion)
VALUES (9, 'Barcelona, EspaÃ±a');

INSERT INTO Sede (SedeID, Localizacion)
VALUES (10, 'MÃ©xico');

INSERT INTO Sede (SedeID, Localizacion)
VALUES (11, 'MÃ©xico');

INSERT INTO Sede (SedeID, Localizacion)
VALUES (12, 'Desconocida');

INSERT INTO Sede (SedeID, Localizacion)
VALUES (13, 'Madrid, EspaÃ±a');

INSERT INTO Sede (SedeID, Localizacion)
VALUES (14, 'MÃ©xico');

--Editorial_Sede
INSERT INTO Editorial_Sede (EditorialID, SedeID)
VALUES (1, 1);

INSERT INTO Editorial_Sede (EditorialID, SedeID)
VALUES (2, 2);

INSERT INTO Editorial_Sede (EditorialID, SedeID)
VALUES (3, 3);

INSERT INTO Editorial_Sede (EditorialID, SedeID)
VALUES (4, 4);

INSERT INTO Editorial_Sede (EditorialID, SedeID)
VALUES (5, 5);

INSERT INTO Editorial_Sede (EditorialID, SedeID)
VALUES (6, 6);


--Arte
INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9780134401997, 'The Story Art', TO_DATE('1998-11-01', 'YYYY-MM-DD'), 688, 20, 'InglÃ©s',1,1);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788489693630, 'Historia del Arte', TO_DATE('2018-09-01', 'YYYY-MM-DD'), 224, 15, 'EspaÃ±ol',1,2);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9780714836256, 'The Art Book', TO_DATE('1997-04-17', 'YYYY-MM-DD'), 503, 20, 'InglÃ©s',1,1);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9780192842374, 'Classical Art: From Greece to Rome', TO_DATE('2001-07-19', 'YYYY-MM-DD'), 304, 5, 'InglÃ©s',1,3);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9783836553568, 'Los secretos de las obras de artes', TO_DATE('2013-03-16', 'YYYY-MM-DD'), 294, 4, 'EspaÃ±ol',1,4);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788498452136, 'La isla del tesoro', TO_DATE('2014-04-1', 'YYYY-MM-DD'), 288, 24, 'EspaÃ±ol',2,5);

--Aventura
INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9781095898826, 'Robinson Crusoe', TO_DATE('2019-01-18', 'YYYY-MM-DD'), 215, 14, 'EspaÃ±ol',2,6);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9789706434111, 'Las Aventuras de Tom Sawyer', TO_DATE('2002-02-15', 'YYYY-MM-DD'), 80, 17, 'EspaÃ±ol',2,7);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788467721874, 'La Isla Misteriosa', TO_DATE('2019-01-01', 'YYYY-MM-DD'), 576, 35, 'EspaÃ±ol',2,8);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788415618829, 'Las Aventuras de Sherlock Holmes', TO_DATE('2019-07-01', 'YYYY-MM-DD'), 368, 40, 'EspaÃ±ol',2,9);

--Ciencia ficciÃ³n
INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9780553382570, 'FundaciÃ³n', TO_DATE('2015-04-01', 'YYYY-MM-DD'), 264, 34, 'EspaÃ±ol',3,5);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9782724215908, 'Dune', TO_DATE('2020-08-01', 'YYYY-MM-DD'), 784, 17, 'EspaÃ±ol',3,5);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788491425755, 'El fin de la eternidad', TO_DATE('2019-11-01', 'YYYY-MM-DD'), 288, 10, 'EspaÃ±ol',3,5);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788435015745, 'Yo, robot', TO_DATE('2016-07-01', 'YYYY-MM-DD'), 376, 8, 'EspaÃ±ol',3,5);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788432013881, '1984', TO_DATE('2020-09-01', 'YYYY-MM-DD'), 352, 26, 'EspaÃ±ol',3,5);


--FantasÃ­a
INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788401022524, 'El nombre del Viento', TO_DATE('2012-09-01', 'YYYY-MM-DD'),  880, 20, 'EspaÃ±ol',4,5);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9786070724145, 'El hobbit', TO_DATE('2014-10-31', 'YYYY-MM-DD'), 288, 10, 'EspaÃ±ol',4,10);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9786073128834, 'Juego de tronos', TO_DATE('2015-03-01', 'YYYY-MM-DD'), 800, 17, 'EspaÃ±ol',4,5);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9786073193894, 'Harry Potter y la piedra filosofal', TO_DATE('2020-12-30', 'YYYY-MM-DD'), 264, 45, 'EspaÃ±ol',4,5);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788498387940, 'Animales fantÃ¡sticos y dÃ³nde encontrarlos', TO_DATE('2017-05-15', 'YYYY-MM-DD'), 128, 20, 'EspaÃ±ol',4,11);

--FilosofÃ­a
INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9786071122254, 'Meditaciones', TO_DATE('2019-07-20', 'YYYY-MM-DD'), 264, 10, 'EspaÃ±ol',5,12);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788420650913, 'AsÃ­ Hablo Zaratustra', TO_DATE('2011-07-14', 'YYYY-MM-DD'), 556, 15, 'EspaÃ±ol',5,13);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788417430825, 'El prÃ­ncipe', TO_DATE('2019-01-01', 'YYYY-MM-DD'), 160, 13, 'EspaÃ±ol',5,9);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788417079956, 'La Republica', TO_DATE('2018-03-09', 'YYYY-MM-DD'), 228, 13, 'EspaÃ±ol',5,12);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788441431935, 'El Contrato Social', TO_DATE('2017-11-10', 'YYYY-MM-DD'), 96, 8, 'EspaÃ±ol',5,12);


--Historia
INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9786073101400, 'La caÃ­da de los gigantes', TO_DATE('2017-06-01', 'YYYY-MM-DD'), 1024, 19, 'EspaÃ±ol',6,5);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788466342285, 'De animales a dioses: Breve historia de la humanidad', TO_DATE('2020-09-01', 'YYYY-MM-DD'), 496, 5, 'EspaÃ±ol',6,5);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9789807716093, 'Diario de Ana Frank', TO_DATE('2018-01-01', 'YYYY-MM-DD'), 224, 23, 'EspaÃ±ol',6,14);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9789700518152, 'El nombre de la rosa', TO_DATE('2010-11-01', 'YYYY-MM-DD'), 512, 15, 'EspaÃ±ol',6,5);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9786073120319, 'La ladrona de libros', TO_DATE('2013-12-01', 'YYYY-MM-DD'), 544, 15, 'EspaÃ±ol',6,5);


--Terror
INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9789176370728, 'Frankenstein O El Moderno Prometeo', TO_DATE('2016-10-01', 'YYYY-MM-DD'), 328, 25, 'EspaÃ±ol',7,5);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9788415618836, 'DrÃ¡cula', TO_DATE('2019-07-01', 'YYYY-MM-DD'), 496, 25, 'EspaÃ±ol',7,9);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9786073118392, 'El resplandor', TO_DATE('2013-10-01', 'YYYY-MM-DD'), 688, 30, 'EspaÃ±ol',7,5);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9780451169518, 'It', TO_DATE('2022-04-01', 'YYYY-MM-DD'), 1504, 30, 'EspaÃ±ol',7,5);

INSERT INTO libro (LibroID, librotitulo, librofecha, libropaginas, cantidad, idioma, generoid, editorialid)
VALUES (9780307743671, 'El misterio de Salems Lot', TO_DATE('2022-08-01', 'YYYY-MM-DD'), 528, 15, 'EspaÃ±ol',7,5);



INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (1, 'Ernst', 'Gombrich', 'AustrÃ­aca y britÃ¡nica');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (2, 'Jose', 'Rafols', 'EspaÃ±ol');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (3, 'Pahidon', 'Press', 'Estadounidense');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (4, 'Mary', 'Beard', 'BritÃ¡nica');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (5, 'Lupina', 'Lara', 'Mexicana');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (6, 'Robert', 'Stevenson', 'BritÃ¡nico');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (7, 'Daniel', 'Defoe', 'BritÃ¡nico');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (8, 'Mark', 'Twain', 'Estadounidense');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (9, 'Julio', 'Verne', 'FrancÃ©s');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (10, 'Arthur', 'Conan', 'BritÃ¡nica');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (11, 'Isaac', 'Asimov', 'Estadounidense');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (12, 'Frank ', 'Herbert', 'Estadounidense');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (13, 'George', 'Orwell', 'BritÃ¡nico');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (14, 'Patrick', 'Rothfuss', 'Estadounidense');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (15, 'J. R. R.', 'Tolkien', 'BritÃ¡nico');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (16, 'George', 'R. R.', 'Estadounidense');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (17, 'J. K.', 'Rowling', 'BritÃ¡nica');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (18, 'Marco', 'Aurelio', 'Italiano');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (19, 'Friedrich', 'Nietzsche', 'Aleman');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (20, 'Nicolas', 'Maquiavelo', 'Italiano');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (21, 'Platon', '-', 'Griego');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (22, 'Jean-Jacques', 'Rousseau', 'Suizo');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (23, 'Ken', 'Follett', 'BritÃ¡nico');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (24, 'Yuval', 'Noah', 'IsraelÃ­');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (25, 'Ana', 'Frank', 'Alemana');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (26, 'Umberto', 'Eco', 'Italiano');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (27, 'Markus', 'Zusak', 'Australiano');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (28, 'Mary', 'Shelley', 'Inglesa');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (29, 'Bram', 'Stoker', 'IrlandÃ©s');

INSERT INTO autor (autorid, autornombre, autorapellido, autornacionalidad)
VALUES (30, 'Stephen', 'King', 'Estadounidense');





--AUTOR_LIBRO:
INSERT INTO autor_libro (autorid, LibroID)
values  (1,9780134401997);

INSERT INTO autor_libro (autorid, LibroID)
values  (2,9788489693630);

INSERT INTO autor_libro (autorid, LibroID)
values  (3,9780714836256);

INSERT INTO autor_libro (autorid, LibroID)
values  (4,9780192842374);

INSERT INTO autor_libro (autorid, LibroID)
values  (5,9783836553568);

INSERT INTO autor_libro (autorid, LibroID)
values  (6,9788498452136);

INSERT INTO autor_libro (autorid, LibroID)
values  (7,9781095898826);

INSERT INTO autor_libro (autorid, LibroID)
values  (8,9789706434111);

INSERT INTO autor_libro (autorid, LibroID)
values  (9,9788467721874);

INSERT INTO autor_libro (autorid, LibroID)
values  (10,9788415618829);

INSERT INTO autor_libro (autorid, LibroID)
values  (11,9780553382570);

INSERT INTO autor_libro (autorid, LibroID)
values  (12,9782724215908);

INSERT INTO autor_libro (autorid, LibroID)
values  (11,9788491425755);

INSERT INTO autor_libro (autorid, LibroID)
values  (11,9788435015745);

INSERT INTO autor_libro (autorid, LibroID)
values  (13,9788432013881);

INSERT INTO autor_libro (autorid, LibroID)
values  (14,9788401022524);

INSERT INTO autor_libro (autorid, LibroID)
values  (15, 9786070724145);

INSERT INTO autor_libro (autorid, LibroID)
values  (16,9786073128834);

INSERT INTO autor_libro (autorid, LibroID)
values  (17,9786073193894);

INSERT INTO autor_libro (autorid, LibroID)
values  (17, 9788498387940);

INSERT INTO autor_libro (autorid, LibroID)
values  (18,9786071122254);

INSERT INTO autor_libro (autorid, LibroID)
values  (19,9788420650913);

INSERT INTO autor_libro (autorid, LibroID)
values  (20, 9788417430825);

INSERT INTO autor_libro (autorid, LibroID)
values  (21,9788417079956);

INSERT INTO autor_libro (autorid, LibroID)
values  (22,9788441431935);

INSERT INTO autor_libro (autorid, LibroID)
values  (23, 9786073101400);

INSERT INTO autor_libro (autorid, LibroID)
values  (24,9788466342285);

INSERT INTO autor_libro (autorid, LibroID)
values  (25,9789807716093);

INSERT INTO autor_libro (autorid, LibroID)
values  (26, 9789700518152);

INSERT INTO autor_libro (autorid, LibroID)
values  (27,9786073120319);

INSERT INTO autor_libro (autorid, LibroID)
values  (28,9789176370728);

INSERT INTO autor_libro (autorid, LibroID)
values  (29,9788415618836);

INSERT INTO autor_libro (autorid, LibroID)
values  (30,9786073118392);

INSERT INTO autor_libro (autorid, LibroID)
values  (30,9780451169518);

INSERT INTO autor_libro (autorid, LibroID)
values  (30,9780307743671);


--Articulos:
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (1, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (2, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (3, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (4, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (5, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (6, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (7, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (8, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (9, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (10, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (11, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (12, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (13, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (14, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (15, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (16, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (17, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (18, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (19, 'Bien', 9780134401997);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (20, 'Bien', 9780134401997);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (21, 'Bien', 9788489693630);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (22, 'Bien', 9788489693630);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (23, 'Bien', 9788489693630);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (24, 'Bien', 9788489693630);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (25, 'Bien', 9788489693630);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (26, 'Bien', 9788489693630);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (27, 'Bien', 9788489693630);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (28, 'Bien', 9788489693630);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (29, 'Bien', 9788489693630);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (30, 'Bien', 9788489693630);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (31, 'Bien', 9788489693630);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (32, 'Bien', 9788489693630);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (33, 'Bien', 9788489693630);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (34, 'Bien', 9788489693630);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (35, 'Bien', 9788489693630);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (36, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (37, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (38, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (39, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (40, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (41, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (42, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (43, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (44, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (45, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (46, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (47, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (48, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (49, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (50, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (51, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (52, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (53, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (54, 'Bien', 9780714836256);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (55, 'Bien', 9780714836256);

INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (56, 'Bien', 9780192842374);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (57, 'Bien', 9780192842374);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (58, 'Bien', 9780192842374);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (59, 'Bien', 9780192842374);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (60, 'Bien', 9780192842374);

INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (61, 'Bien', 9783836553568);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (62, 'Bien', 9783836553568);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (63, 'Bien', 9783836553568);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (64, 'Bien', 9783836553568);

INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (65, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (66, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (67, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (68, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (69, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (70, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (71, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (72, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (73, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (74, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (75, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (76, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (77, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (78, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (79, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (80, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (81, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (82, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (83, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (84, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (85, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (86, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (87, 'Bien', 9788498452136);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (88, 'Bien', 9788498452136);

INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (89, 'Bien', 9781095898826);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (90, 'Bien', 9781095898826);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (91, 'Bien', 9781095898826);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (92, 'Bien', 9781095898826);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (93, 'Bien', 9781095898826);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (94, 'Bien', 9781095898826);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (95, 'Bien', 9781095898826);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (96, 'Bien', 9781095898826);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (97, 'Bien', 9781095898826);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (98, 'Bien', 9781095898826);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (99, 'Bien', 9781095898826);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (100, 'Bien', 9781095898826);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (101, 'Bien', 9781095898826);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (102, 'Bien', 9781095898826);

INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (103, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (104, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (105, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (106, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (107, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (108, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (109, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (110, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (111, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (112, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (113, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (114, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (115, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (116, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (117, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (118, 'Bien', 9789706434111);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (119, 'Bien', 9789706434111);

INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (120, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (121, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (122, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (123, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (124, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (125, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (126, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (127, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (128, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (129, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (130, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (131, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (132, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (133, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (134, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (135, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (136, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (137, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (138, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (139, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (140, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (141, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (142, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (143, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (144, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (145, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (146, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (147, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (148, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (149, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (150, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (151, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (152, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (153, 'Bien', 9788467721874);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (154, 'Bien', 9788467721874);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (155, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (156, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (157, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (158, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (159, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (160, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (161, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (162, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (163, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (164, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (165, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (166, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (167, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (168, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (169, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (170, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (171, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (172, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (173, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (174, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (175, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (176, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (177, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (178, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (179, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (180, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (181, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (182, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (183, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (184, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (185, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (186, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (187, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (188, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (189, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (190, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (191, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (192, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (193, 'Bien', 9788415618829);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (194, 'Bien', 9788415618829);

INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (195, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (196, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (197, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (198, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (199, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (200, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (201, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (202, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (203, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (204, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (205, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (206, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (207, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (208, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (209, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (210, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (211, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (212, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (213, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (214, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (215, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (216, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (217, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (218, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (219, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (220, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (221, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (222, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (223, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (224, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (225, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (226, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (227, 'Bien', 9780553382570);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (228, 'Bien', 9780553382570);

INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (229, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (230, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (231, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (232, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (233, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (234, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (235, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (236, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (237, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (238, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (239, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (240, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (241, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (242, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (243, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (244, 'Bien', 9782724215908);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (245, 'Bien', 9782724215908);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (246, 'Bien', 9788491425755);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (247, 'Bien', 9788491425755);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (248, 'Bien', 9788491425755);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (249, 'Bien', 9788491425755);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (250, 'Bien', 9788491425755);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (251, 'Bien', 9788491425755);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (252, 'Bien', 9788491425755);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (253, 'Bien', 9788491425755);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (254, 'Bien', 9788491425755);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (255, 'Bien', 9788491425755);

INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (256, 'Bien', 9788435015745);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (257, 'Bien', 9788435015745);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (258, 'Bien', 9788435015745);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (259, 'Bien', 9788435015745);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (260, 'Bien', 9788435015745);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (261, 'Bien', 9788435015745);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (262, 'Bien', 9788435015745);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (263, 'Bien', 9788435015745);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (264, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (265, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (266, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (267, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (268, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (269, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (270, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (271, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (272, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (273, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (274, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (275, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (276, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (277, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (278, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (279, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (280, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (281, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (282, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (283, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (284, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (285, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (286, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (287, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (288, 'Bien', 9788432013881);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (289, 'Bien', 9788432013881);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (290, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (291, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (292, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (293, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (294, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (295, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (296, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (297, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (298, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (299, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (300, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (301, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (302, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (303, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (304, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (305, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (306, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (307, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (308, 'Bien', 9788401022524);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (309, 'Bien', 9788401022524);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (310, 'Bien', 9786070724145);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (311, 'Bien', 9786070724145);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (312, 'Bien', 9786070724145);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (313, 'Bien', 9786070724145);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (314, 'Bien', 9786070724145);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (315, 'Bien', 9786070724145);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (316, 'Bien', 9786070724145);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (317, 'Bien', 9786070724145);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (318, 'Bien', 9786070724145);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (319, 'Bien', 9786070724145);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (320, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (321, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (322, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (323, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (324, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (325, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (326, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (327, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (328, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (329, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (330, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (331, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (332, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (333, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (334, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (335, 'Bien', 9786073128834);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (336, 'Bien', 9786073128834);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (337, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (338, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (339, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (340, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (341, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (342, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (343, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (344, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (345, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (346, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (347, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (348, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (349, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (350, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (351, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (352, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (353, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (354, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (355, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (356, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (357, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (358, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (359, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (360, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (361, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (362, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (363, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (364, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (365, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (366, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (367, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (368, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (369, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (370, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (371, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (372, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (373, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (374, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (375, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (376, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (377, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (378, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (379, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (380, 'Bien', 9786073193894);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (381, 'Bien', 9786073193894);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (382, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (383, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (384, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (385, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (386, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (387, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (388, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (389, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (390, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (391, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (392, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (393, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (394, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (395, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (396, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (397, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (398, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (399, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (400, 'Bien', 9788498387940);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (401, 'Bien', 9788498387940);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (402, 'Bien', 9786071122254);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (403, 'Bien', 9786071122254);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (404, 'Bien', 9786071122254);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (405, 'Bien', 9786071122254);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (406, 'Bien', 9786071122254);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (407, 'Bien', 9786071122254);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (408, 'Bien', 9786071122254);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (409, 'Bien', 9786071122254);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (410, 'Bien', 9786071122254);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (411, 'Bien', 9786071122254);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (412, 'Bien', 9788420650913);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (413, 'Bien', 9788420650913);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (414, 'Bien', 9788420650913);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (415, 'Bien', 9788420650913);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (416, 'Bien', 9788420650913);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (417, 'Bien', 9788420650913);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (418, 'Bien', 9788420650913);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (419, 'Bien', 9788420650913);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (420, 'Bien', 9788420650913);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (421, 'Bien', 9788420650913);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (422, 'Bien', 9788420650913);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (423, 'Bien', 9788420650913);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (424, 'Bien', 9788420650913);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (425, 'Bien', 9788420650913);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (426, 'Bien', 9788420650913);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (427, 'Bien', 9788417430825);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (428, 'Bien', 9788417430825);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (429, 'Bien', 9788417430825);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (430, 'Bien', 9788417430825);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (431, 'Bien', 9788417430825);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (432, 'Bien', 9788417430825);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (433, 'Bien', 9788417430825);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (434, 'Bien', 9788417430825);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (435, 'Bien', 9788417430825);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (436, 'Bien', 9788417430825);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (437, 'Bien', 9788417430825);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (438, 'Bien', 9788417430825);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (439, 'Bien', 9788417430825);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (440, 'Bien', 9788417079956);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (441, 'Bien', 9788417079956);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (442, 'Bien', 9788417079956);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (443, 'Bien', 9788417079956);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (444, 'Bien', 9788417079956);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (445, 'Bien', 9788417079956);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (446, 'Bien', 9788417079956);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (447, 'Bien', 9788417079956);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (448, 'Bien', 9788417079956);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (449, 'Bien', 9788417079956);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (450, 'Bien', 9788417079956);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (451, 'Bien', 9788417079956);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (452, 'Bien', 9788417079956);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (453, 'Bien', 9788441431935);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (454, 'Bien', 9788441431935);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (455, 'Bien', 9788441431935);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (456, 'Bien', 9788441431935);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (457, 'Bien', 9788441431935);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (458, 'Bien', 9788441431935);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (459, 'Bien', 9788441431935);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (460, 'Bien', 9788441431935);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (461, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (462, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (463, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (464, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (465, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (466, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (467, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (468, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (469, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (470, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (471, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (472, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (473, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (474, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (475, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (476, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (477, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (478, 'Bien', 9786073101400);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (479, 'Bien', 9786073101400);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (480, 'Bien', 9788466342285);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (481, 'Bien', 9788466342285);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (482, 'Bien', 9788466342285);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (483, 'Bien', 9788466342285);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (484, 'Bien', 9788466342285);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (485, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (486, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (487, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (488, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (489, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (490, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (491, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (492, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (493, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (494, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (495, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (496, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (497, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (498, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (499, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (500, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (501, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (502, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (503, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (504, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (505, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (506, 'Bien', 9789807716093);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (507, 'Bien', 9789807716093);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (508, 'Bien', 9789700518152);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (509, 'Bien', 9789700518152);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (510, 'Bien', 9789700518152);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (511, 'Bien', 9789700518152);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (512, 'Bien', 9789700518152);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (513, 'Bien', 9789700518152);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (514, 'Bien', 9789700518152);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (515, 'Bien', 9789700518152);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (516, 'Bien', 9789700518152);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (517, 'Bien', 9789700518152);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (518, 'Bien', 9789700518152);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (519, 'Bien', 9789700518152);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (520, 'Bien', 9789700518152);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (521, 'Bien', 9789700518152);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (522, 'Bien', 9789700518152);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (523, 'Bien', 9786073120319);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (524, 'Bien', 9786073120319);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (525, 'Bien', 9786073120319);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (526, 'Bien', 9786073120319);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (527, 'Bien', 9786073120319);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (528, 'Bien', 9786073120319);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (529, 'Bien', 9786073120319);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (530, 'Bien', 9786073120319);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (531, 'Bien', 9786073120319);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (532, 'Bien', 9786073120319);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (533, 'Bien', 9786073120319);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (534, 'Bien', 9786073120319);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (535, 'Bien', 9786073120319);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (536, 'Bien', 9786073120319);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (537, 'Bien', 9786073120319);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (538, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (539, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (540, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (541, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (542, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (543, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (544, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (545, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (546, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (547, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (548, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (549, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (550, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (551, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (552, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (553, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (554, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (555, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (556, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (557, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (558, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (559, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (560, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (561, 'Bien', 9789176370728);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (562, 'Bien', 9789176370728);



INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (563, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (564, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (565, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (566, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (567, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (568, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (569, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (570, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (571, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (572, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (573, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (574, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (575, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (576, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (577, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (578, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (579, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (580, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (581, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (582, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (583, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (584, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (585, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (586, 'Bien', 9788415618836);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (587, 'Bien', 9788415618836);



INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (588, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (589, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (590, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (591, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (592, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (593, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (594, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (595, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (596, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (597, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (598, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (599, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (600, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (601, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (602, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (603, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (604, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (605, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (606, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (607, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (608, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (609, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (610, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (611, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (612, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (613, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (614, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (615, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (616, 'Bien', 9786073118392);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (617, 'Bien', 9786073118392);


INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (618, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (619, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (620, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (621, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (622, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (623, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (624, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (625, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (626, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (627, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (628, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (629, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (630, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (631, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (632, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (633, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (634, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (635, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (636, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (637, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (638, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (639, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (640, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (641, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (642, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (643, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (644, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (645, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (646, 'Bien', 9780451169518);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (647, 'Bien', 9780451169518);

INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (648, 'Bien', 9780307743671);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (649, 'Bien', 9780307743671);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (650, 'Bien', 9780307743671);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (651, 'Bien', 9780307743671);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (652, 'Bien', 9780307743671);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (653, 'Bien', 9780307743671);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (654, 'Bien', 9780307743671);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (655, 'Bien', 9780307743671);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (656, 'Bien', 9780307743671);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (657, 'Bien', 9780307743671);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (658, 'Bien', 9780307743671);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (659, 'Bien', 9780307743671);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (660, 'Bien', 9780307743671);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (661, 'Bien', 9780307743671);
INSERT INTO articulo (articuloid, articuloestatus, LibroID)
VALUES (662, 'Bien', 9780307743671);
