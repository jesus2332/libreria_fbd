var loggedUserID;

fetch('/loggedUserId')
  .then(response => response.json())
  .then(data => {
    loggedUserID = data.loggedUserID;
    console.log(loggedUserID);
    // En la parte superior de books.html
    if(loggedUserID ==null&& !localStorage.getItem('redirected')) {
      localStorage.setItem('redirected', true);
      window.location.replace("http://localhost:8888/index.html");

    }
    
    
  })
  .catch(error => console.error(error));



const orderButton = document.getElementById('order-button');

orderButton.addEventListener('click', () => {
  order = {isbn: isbn};
  fetch('/order', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(order)
  })
  
  .then(response => {
    location.reload();
    if (response.ok) {
      alert("Prestamo registrado exitosamente"); // Mostrar alerta de éxito
      
    } else {
     
      alert("Error al registrar el préstamo"); // Mostrar alerta de error

    }
  })
  .catch(error => {
    console.error(error);
  });
});



