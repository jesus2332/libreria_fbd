# Sistema de Gestión bibliotecario Web

## Nota importante

> La Documentacion completa la puedes encontrar en el archivo manualUsuario.pdf y en el archivo manualTecnico.pdf en este mismo repositorio

## Descripción

El Sistema de Gestión bibliotecario Web es un sistema encargado de la administración y gestión de información relacionada con los libros, revistas, artículos y otros materiales de la biblioteca, así como información sobre los usuarios, préstamos, reservas y otros aspectos de la gestión de la biblioteca.

## Objetivo

El objetivo principal de este sistema es permitir la búsqueda y recuperación eficiente de información de la biblioteca, así como la gestión de préstamos, reservas y devoluciones de libros.

## Objetivos específicos

- Permitir a los usuarios buscar y filtrar los libros ofrecidos por el sistema por género.
- Facilitar el proceso de renta de libros.
- Mantener un inventario actualizado de los libros disponibles para renta.
- Llevar un control de las multas por retardo al momento de entregar los libros.

## Tipos de usuarios

El sistema cuenta con los siguientes tipos de usuarios:

- Público General Registrado
- Público General No Registrado

## Requerimientos

El sistema cumple con los siguientes requerimientos funcionales:

- Permite el registro de nuevos libros con todos los datos correspondientes.
- Valida que el libro registrado no exista previamente en la base de datos.
- Permite a los usuarios registrarse en la página web proporcionando su nombre, apellido, dirección, número de teléfono, correo electrónico y contraseña.
- Valida que el correo electrónico del usuario sea único.
- Almacena la información del usuario en la base de datos.
- Permite a los usuarios buscar libros por título o género.
- Permite ver los resultados de búsqueda y seleccionar un libro para obtener más información.
- Permite a los usuarios alquilar libros disponibles.
- Verifica la disponibilidad del libro y registra el alquiler en la base de datos.
- Mantiene un registro de los libros alquilados por cada usuario.
- Verifica que el libro se devuelva dentro del tiempo correspondiente y sin daños.
- Genera multas y las registra en la base de datos en caso de retraso en la devolución.
- Permite a los usuarios consultar el estado de sus alquileres y multas asociadas.
- Permite ver una lista de los libros que tienen actualmente y cualquier multa pendiente.

# Sistema de Gestión bibliotecario Web

## Descripción

El Sistema de Gestión bibliotecario Web es un sistema encargado de la administración y gestión de información relacionada con los libros, revistas, artículos y otros materiales de la biblioteca, así como información sobre los usuarios, préstamos, reservas y otros aspectos de la gestión de la biblioteca.

## Objetivo

El objetivo principal de este sistema es permitir la búsqueda y recuperación eficiente de información de la biblioteca, así como la gestión de préstamos, reservas y devoluciones de libros.

## Objetivos específicos

- Permitir a los usuarios buscar y filtrar los libros ofrecidos por el sistema por género.
- Facilitar el proceso de renta de libros.
- Mantener un inventario actualizado de los libros disponibles para renta.
- Llevar un control de las multas por retardo al momento de entregar los libros.

## Tipos de usuarios

El sistema cuenta con los siguientes tipos de usuarios:

- Público General Registrado
- Público General No Registrado

## Requerimientos no funcionales

El sistema debe cumplir con los siguientes requerimientos no funcionales:

- Capacidad de manejar grandes volúmenes de datos de forma eficiente y con tiempos de respuesta rápidos.
- Tiempo de respuesta aceptable para consultas y operaciones en la base de datos, garantizando una experiencia de usuario fluida.
- Garantizar la seguridad de los datos almacenados en la base de datos, evitando el acceso no autorizado, la modificación o eliminación indebida de información.
- Implementación de un mecanismo de copias de seguridad y recuperación de la base de datos para garantizar la disponibilidad de los datos en caso de fallas.
- Disponibilidad del sistema las 24 horas del día, los 7 días de la semana, para que los usuarios puedan acceder en cualquier momento.
- Medidas para minimizar el tiempo de inactividad planificado o no planificado, como mantenimiento programado y redundancia de servidores.
- Confiabilidad y disponibilidad del sistema, evitando interrupciones o fallas frecuentes.
- Gestión adecuada de errores y excepciones para minimizar las interrupciones en el funcionamiento normal.

## Arquitectura del Sistema/Aplicación

### Layer/Tier's

El sistema se divide en las siguientes capas o tiers:

- Capa de Presentación (Frontend): Esta capa se encarga de la interfaz de usuario y la interacción con el usuario. Está compuesta por tecnologías web como HTML, CSS y JavaScript, utilizando el framework Materialize CSS para el diseño visual y la interfaz responsiva. Aquí se encuentra la página de inicio, la búsqueda de libros, los detalles del libro, las órdenes y las multas.

- Capa de Aplicación (Backend): Esta capa maneja la lógica de negocio y la funcionalidad de la aplicación. Utiliza Node.js como entorno de ejecución de JavaScript y Express como framework web para el enrutamiento y la gestión de las solicitudes HTTP. Se encarga de manejar las solicitudes del usuario, procesar la lógica de la aplicación y realizar operaciones en la base de datos.

- Capa de Datos (Backend): Esta capa se conecta a la base de datos Oracle utilizando el paquete `oracledb` de Node.js. Se encarga de realizar consultas y actualizaciones en la base de datos, recuperar y almacenar la información relacionada con los usuarios, los libros, las órdenes y las multas.

### Frontend/Backend

El frontend de la aplicación utiliza tecnologías web como HTML, CSS y JavaScript para la interfaz de usuario y la interacción con el usuario. Se emplea el framework Materialize CSS para un diseño visual atractivo y una interfaz responsiva.

El backend de la aplicación utiliza Node.js y Express para manejar las solicitudes del usuario, procesar la lógica de la aplicación y realizar operaciones en la base de datos Oracle. También se utiliza el paquete `oracledb` para interactuar con la base de datos y realizar consultas y actualizaciones.

### Estructura modular del sistema

La estructura modular del sistema sigue un enfoque MVC (Modelo-Vista-Controlador) o similar, donde los componentes del sistema están organizados en módulos y siguen un patrón de separación de responsabilidades. Algunos módulos son los siguientes:

- Módulo de Autenticación: Maneja el registro de usuarios, el inicio de sesión y la gestión de sesiones.
- Módulo de Búsqueda y Filtrado: Permite a los usuarios buscar libros por nombre y filtrar por categorías.
- Módulo de Gestión de Libros: Maneja las operaciones relacionadas con los libros, como obtener detalles, actualizar el stock, etc.
- Módulo de Órdenes de Préstamo: Gestiona la generación de órdenes de préstamo, verificación de stock, fechas de préstamo y caducidad, etc.
- Módulo de Seguimiento de Órdenes: Permite a los usuarios ver el estado de sus préstamos y actualizar el estado de las órdenes (entregado, multa pendiente, etc.).
- Módulo de Multas: Maneja la generación y visualización de multas, así como su estado y pagos.

## Lógica/Reglas del Negocio

Las reglas de negocio y la lógica de la aplicación de Biblioteca Online se centran en el manejo de los siguientes aspectos:

### Registro de Usuarios:

- Los usuarios deben proporcionar información válida y completa al registrarse en la aplicación.
- Se verifica que la dirección de correo electrónico sea única y no esté registrada previamente.
- Las contraseñas se almacenan de forma segura utilizando técnicas de hash y sal para proteger la información del usuario.

### Inicio de Sesión:

- Los usuarios deben proporcionar credenciales válidas (correo electrónico y contraseña) para iniciar sesión en la aplicación.
- Se verifica la validez de las credenciales ingresadas y se autentica al usuario mediante una comparación con los datos almacenados en la base de datos.

### Búsqueda y Filtrado de Libros:

- Los usuarios pueden buscar libros por su nombre utilizando la barra de búsqueda.
- Los libros se filtran por categorías seleccionadas, mostrando solo aquellos que correspondan a la categoría elegida.
- Los resultados de búsqueda y filtrado se presentan al usuario de manera dinámica y actualizada en la interfaz.

### Detalles del Libro:

- Al hacer clic en el botón "+" de un libro, se accede a los detalles específicos de ese libro.
- Se muestra al usuario información detallada sobre el libro, como portada, título, ISBN, autor, género, editorial y stock disponible.

### Órdenes de Préstamo:

- Los usuarios pueden realizar órdenes de préstamo de libros disponibles.
- Se verifica la disponibilidad de stock del libro antes de generar una orden de préstamo.
- Se registra la información de la orden, incluyendo la fecha de préstamo y la fecha de caducidad.
- Se proporciona al usuario una notificación de confirmación o error dependiendo del resultado de la generación de la orden.

### Seguimiento de Órdenes y Multas:

- Los usuarios pueden acceder a la página de órdenes para ver el estado de sus préstamos.
- Se muestra al usuario una lista de sus órdenes de préstamo, incluyendo detalles como la imagen del libro, el ISBN, la fecha de préstamo y la fecha de caducidad.
- Se permite al usuario actualizar el estado de una orden, marcándola como "entregada" cuando el libro se devuelve o indicando una "multa pendiente" si el libro no se devuelve a tiempo.
- Las multas se generan automáticamente si un libro no se devuelve antes de la fecha de caducidad.
- Los usuarios pueden acceder a la página de multas para ver las multas pendientes, incluyendo detalles como la fecha de creación, el monto a pagar y el estado de la multa.

Estas reglas de negocio y lógica de la aplicación garantizan que los usuarios puedan registrarse, buscar, ordenar y realizar un seguimiento de sus préstamos de libros de manera eficiente y precisa, siguiendo las normas y restricciones establecidas en el sistema de biblioteca.

## Descripción Interfaz de la aplicación

La aplicación de Biblioteca FCM presenta una interfaz intuitiva y fácil de usar para los usuarios. A continuación, se proporciona una descripción detallada de los componentes y características clave de la interfaz desde una perspectiva técnica.

### Página de Inicio:

La página de inicio muestra un formulario de registro para que los usuarios se registren en la aplicación. Está diseñada utilizando HTML y CSS (Materialize CSS) para lograr una apariencia atractiva y receptiva. El formulario de registro utiliza campos como nombre, dirección de correo electrónico, contraseña, etc., para recopilar la información del usuario. El registro se realiza a través de una solicitud POST a través de Node.js y Express.

### Inicio de Sesión:

Después de registrarse, los usuarios pueden iniciar sesión en la aplicación utilizando su dirección de correo electrónico y contraseña. El inicio de sesión se realiza a través de un formulario de inicio de sesión en el panel izquierdo de la interfaz. Los datos ingresados por el usuario se validan y se realiza una verificación con la base de datos de Oracle utilizando el módulo oracledb en Node.js.

### Página Principal:

La página principal muestra una lista de libros registrados en la biblioteca. Cada libro se presenta con su imagen, título y un botón "+" para ordenar el libro. La lista de libros se obtiene de la base de datos de Oracle y se muestra dinámicamente en la interfaz utilizando plantillas HTML que nosotros diseñamos.

### Barra Lateral:

La barra lateral ubicada en el lado izquierdo de la interfaz contiene tres botones: "Salir", "Multas" y "Órdenes". Estos botones están implementados como elementos HTML interactivos y se comunican con el servidor a través de solicitudes HTTP para realizar acciones correspondientes, como cerrar la sesión, acceder a la página de multas o acceder a la página de órdenes.

### Barra de Búsqueda y Filtrado:

En la parte superior de la página principal, hay una barra de búsqueda que permite a los usuarios buscar libros por su nombre. Justo debajo de la barra de búsqueda, se encuentran los botones de filtrado por categorías. Al hacer clic en estos botones, se envían solicitudes al servidor para obtener libros de la categoría seleccionada y se actualiza la lista de libros en la interfaz utilizando técnicas de renderizado dinámico.

### Detalles del Libro:

Cuando un usuario hace clic en el botón "+" de un libro, se le redirige a la página de detalles del libro. Aquí se muestran detalles más específicos sobre el libro, como la portada, título, ISBN, autor, género, editorial y stock disponible. Los detalles se obtienen de la base de datos de Oracle y se muestran en la interfaz.

### Órdenes

La página de órdenes muestra todas las órdenes de préstamo realizadas por el usuario. Para cada orden, se muestra la imagen del libro prestado, el ISBN, la fecha de préstamo y la fecha de caducidad. Además, se muestra un botón de estado que permite al usuario actualizar el estado de la orden. Los datos de las órdenes se obtienen de la base de datos de Oracle, específicamente de la tabla "prestamos".

### Multas

En la página de multas, se muestran todas las multas pendientes del usuario. Cada multa incluye detalles como la fecha de creación, el monto a pagar y el estado de la multa. Los datos de las multas se obtienen de la base de datos de Oracle, específicamente de la tabla "multas".

### Descripción de reglas de seguridad (acceso/operación)

- Autenticación y Autorización: Se verifica la identidad del usuario utilizando credenciales únicas (correo electrónico y contraseña). Solo los usuarios autenticados tienen acceso a sus datos personales, así como a las multas y órdenes.

- Protección de Contraseñas: Las contraseñas se transmiten de manera segura a través de conexiones cifradas para prevenir el acceso no autorizado durante la transmisión.

- Gestión de Sesiones: Se utiliza un mecanismo de gestión de sesiones para mantener el estado del usuario.

## Conclusión

En resumen, este proyecto realizado para la clase de Introducción a las bases de datos ha logrado cumplir con los objetivos establecidos. Hemos desarrollado un sitio web de una biblioteca que permite prestar libros a usuarios registrados y generar multas para préstamos con retraso.

Durante el proceso de desarrollo, se ha puesto un énfasis en la experiencia del usuario, creando una interfaz sencilla y amigable. La integración con la base de datos ha permitido un almacenamiento eficiente de la información, asegurando la capacidad de consulta en el futuro.

En conclusión, el proyecto ha logrado satisfacer las necesidades y requerimientos establecidos. Además, hemos adquirido conocimientos sobre el desarrollo de sitios web y su relación con la materia. Presentamos así el proyecto desarrollado para esta asignatura.






