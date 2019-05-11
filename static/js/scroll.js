function smoothScroll(id) {
    requestAnimationFrame(function() {
        document.getElementById(id).scrollIntoView({behavior: "smooth", block: "start", inline: "start"});
    })
}