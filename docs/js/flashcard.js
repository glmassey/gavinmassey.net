function loadFlashcards() {
    fetch('/data/flashcards.json')
        .then(response => response.json())
        .then(flashcards => {
            // JavaScript to display the flashcards
            // Implement the logic to create and handle flashcards here
        })
        .catch(error => console.error('Error loading flashcards:', error));
}

// Call the function to load flashcards
loadFlashcards();
