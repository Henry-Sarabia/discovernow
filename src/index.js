import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

var elm = Main.embed(document.getElementById('root'));

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
