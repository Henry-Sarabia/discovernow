(function(body) {

    let usingMouse;

    let preFocus = function(event) {
        usingMouse = (event.type === 'mousedown');
    };

    let addFocus = function(event) {
        if (usingMouse)
            event.target.classList.add('focus--mouse');
    };

    let removeFocus = function(event) {
        event.target.classList.remove('focus--mouse');
    };

    let bindEvents = function() {
        body.addEventListener('keydown', preFocus);
        body.addEventListener('mousedown', preFocus);
        body.addEventListener('focusin', addFocus);
        body.addEventListener('focusout', removeFocus);
    };

    bindEvents();

})(document.body);