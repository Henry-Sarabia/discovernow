import './anim.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

// Main.embed(document.getElementById('root'));
var elm = Main.embed(document.getElementById('root'));

elm.ports.scrollIdIntoView.subscribe(function(domId) {
    document.getElementById(domId).scrollIntoView({behavior: "smooth", block: "start", inline: "start"});
});

var timeoutLimit = 150;

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

registerServiceWorker();
