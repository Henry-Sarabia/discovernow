import './anim.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

// Main.embed(document.getElementById('root'));
var elm = Main.embed(document.getElementById('root'));

var wow = new WOW(
    {
      boxClass:     'wow',      // animated element css class (default is wow)
      animateClass: 'animated', // animation css class (default is animated)
      offset:       0,          // distance to the element when triggering the animation (default is 0)
      mobile:       true,       // trigger animations on mobile devices (default is true)
      live:         true,       // act on asynchronously loaded content (default is true)
      callback:     function(box) {
        // the callback is fired every time an animation is started
        // the argument that is passed in is the DOM node being animated
      },
      scrollContainer: null // optional scroll container selector, otherwise use window
    }
  );
  wow.init();

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
