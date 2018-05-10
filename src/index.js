import './anim.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

// Main.embed(document.getElementById('root'));
var elm = Main.embed(document.getElementById('root'));

var timeoutLimit = 150;

// TODO: add requestAnimationFrame
elm.ports.scrollNextSibling.subscribe(function(domId) {
    setTimeout(function() {
        var next = document.getElementById(domId).nextElementSibling;
    if (next == null) {
        return
    } else {
        next.scrollIntoView({behavior: "smooth", block: "start", inline: "nearest"});
    }
     }, timeoutLimit);
    
});


elm.ports.scrollPrevSibling.subscribe(function(domId) {
    setTimeout(function() {
        var prev = document.getElementById(domId).previousElementSibling;
    if (prev == null) {
        return
    } else {
        prev.scrollIntoView({behavior: "smooth", block: "start", inline: "nearest"});
    }
     }, timeoutLimit);
});

elm.ports.toggleModal.subscribe(function(domId) {
    requestAnimationFrame(function() {
        document.getElementById(domId).classList.toggle("is-active");
    })
});

registerServiceWorker();
