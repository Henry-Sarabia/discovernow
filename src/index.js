import { Main } from './Main.elm';
import './main.css';
import './icons.css';
import './fontawesome-all.js';
import cassette from './images/cassette.jpg';
import greenTop from './images/greenTopography.svg'
import roseTop from './images/roseTopography.svg'
import registerServiceWorker from './registerServiceWorker';

var elm = Main.embed(document.getElementById('root'), {
    splashBG: cassette,
    bodyBG: greenTop,
    errorBG: roseTop
});

elm.ports.scrollIdIntoView.subscribe(function(domId) {
    requestAnimationFrame(function() {
        document.getElementById(domId).scrollIntoView({behavior: "smooth", block: "start", inline: "start"});
    })
});

elm.ports.toggleModal.subscribe(function(domId) {
    requestAnimationFrame(function() {
        document.getElementById(domId).classList.toggle("is-active");
    })
});

registerServiceWorker();
