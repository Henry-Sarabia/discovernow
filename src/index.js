import { Main } from './Main.elm';
import './main.css';
import './icons.css';
import cassette from './images/cassette.jpg';
import greenTop from './images/greenTopography.svg';
import roseTop from './images/roseTopography.svg';
import { dom, library } from '../node_modules/@fortawesome/fontawesome-svg-core';
import { faAngleDown, faAngleRight, faHeart, faSpinner } from '../node_modules/@fortawesome/free-solid-svg-icons';
import { faSpotify, faGithub } from '../node_modules/@fortawesome/free-brands-svg-icons';
import { faPlayCircle } from '../node_modules/@fortawesome/free-regular-svg-icons';
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

library.add(faAngleDown, faAngleRight, faHeart, faSpinner, faSpotify, faGithub, faPlayCircle);
dom.watch();

registerServiceWorker();
