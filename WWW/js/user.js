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
  

});


