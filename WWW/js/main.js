fetch(document.getElementById('card-gallery').dataset.apiUrl)
          .then(response => response.text())
          .then(data => {
            const cardGallery = document.getElementById('card-gallery');
            cardGallery.innerHTML = data;
          })
.catch(error => console.error(error));





function searchBooks() {
    const searchInput = document.getElementById('search-input');
    const searchTerm = searchInput.value.toLowerCase();
    const cardGallery = document.getElementById('card-gallery');
    const cards = cardGallery.getElementsByClassName('card-wrapper');



    for (let i = 0; i < cards.length; i++) {
      const card = cards[i];
      const title = card.querySelector('.card-content h6').textContent.toLowerCase();

      if (title.includes(searchTerm)) {
        card.style.display = 'block';
      } else {
        card.style.display = 'none';
      }
    }
}



function filterBooksByCategory() {
  const selectedCategory = document.querySelector('input[name="category"]:checked').value;

  // Obtener todos los elementos de libros
  const bookElements = document.querySelectorAll('.card-element');

  // Recorrer los elementos y mostrar u ocultar según la categoría seleccionada
  bookElements.forEach(element => {
      if (selectedCategory === 'all') {
          // Mostrar todos los libros
          element.style.display = 'block';
      } else {
          // Obtener la categoría del libro actual
          const category = element.parentElement.parentElement.classList[0].slice(8); // Se obtiene el número de categoría a partir de la clase

          // Comparar la categoría del libro con la categoría seleccionada
          if (category === selectedCategory) {
              // Mostrar el libro si pertenece a la categoría seleccionada
              element.style.display = 'block';
          } else {
              // Ocultar el libro si no pertenece a la categoría seleccionada
              element.style.display = 'none';
          }
      }
      
  });
}





document.getElementById('logout-icon').addEventListener('click', () => {
  fetch('/logout')
    .then(response => {
      if (response.ok) {
        window.location.href = '/index.html';
      } else {
        console.error('Error al cerrar sesión');
      }
    })
    .catch(error => {
      console.error(error);
    });
});