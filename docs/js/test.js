(function() {
    var currentColor = 'black';
    setInterval(function() {
        document.body.style.backgroundColor = currentColor;
        currentColor = (currentColor === 'black') ? 'red' : 'black';
    }, 3000); // Change the color every 3 seconds
})();
