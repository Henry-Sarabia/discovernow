function waypointInit() {
    requestAnimationFrame(function() {
        if (document.getElementById("heroPhases")) {
            var waypoint = new Waypoint({
                element: document.getElementById('heroPhases'),
                handler: function() {
                    console.log('Basic waypoint triggered');
                    document.getElementById("heroPhases").classList.add("animated");
                    // this.destroy();
                }
            });
        } else {
            waypointInit();
        }
    })
};

waypointInit();