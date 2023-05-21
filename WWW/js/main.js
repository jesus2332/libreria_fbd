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