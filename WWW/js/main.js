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

