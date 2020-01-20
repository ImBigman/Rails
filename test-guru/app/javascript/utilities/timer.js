document.addEventListener('turbolinks:load', function () {

    let progressTimer = document.getElementById('clockdiv');
    let deadLine = new Date(Date.parse(gon.timer) );
    if (progressTimer) {createClock('clockdiv', deadLine)}

    function getTimeRemaining(endTime) {
        var t = Date.parse(endTime) - Date.parse(new Date());
        var seconds = Math.floor((t / 1000) % 60);
        var minutes = Math.floor((t / 1000 / 60) % 60);
        return {
            'total': t,
            'minutes': minutes,
            'seconds': seconds
        };
    }

    function createClock(id, endTime) {
        let minutesSpan = document.querySelector('.minutes');
        let secondsSpan = document.querySelector('.seconds');

        function updateClock() {
            let t = getTimeRemaining(endTime);
            minutesSpan.innerHTML = ('0' + t.minutes).slice(-2);
            secondsSpan.innerHTML = ('0' + t.seconds).slice(-2);

            if (t.total <= 0) {
                document.querySelector(".hidden-message").classList.remove('hide');
                setInterval("window.location.href = gon.result", 7000);
                clearInterval(timeInterval);
                return 0;
            }
        }

        updateClock();
        let timeInterval = setInterval(updateClock, 1000);
    }

// setInterval("window.location.href = gon.result", 4000);
});

