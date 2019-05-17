function toggleModal(id) {
    requestAnimationFrame(function() {
        document.getElementById(id).classList.toggle("is-active");
    })
}