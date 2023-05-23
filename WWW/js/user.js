var loggedUserID;

fetch('/loggedUserId')
.then(response => response.json())
.then(data => {
  loggedUserID = data.loggedUserID;
  console.log(loggedUserID);
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
    if (response.ok) {
      alert("Prestamo registrado exitosamente"); // Mostrar alerta de éxito
    } else {
      throw new Error("Error al registrar el préstamo");
    }
  })
  .catch(error => {
    console.error(error);
  });
});

const redirectButton = document.getElementById('orders-button');
redirectButton.addEventListener('click', () => {
  window.location.href = "otro.html";
});




