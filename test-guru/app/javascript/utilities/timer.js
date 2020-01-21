document.addEventListener('turbolinks:load', function () {

    let progressTimer = document.getElementById('clockdiv');
    let timerData = document.getElementById('timer-label');

    if (progressTimer && timerData) {
        let endDate = timerData.getAttribute('data-progress-timer');
        let deadLine = new Date(Date.parse(endDate) );
        createClock('clockdiv', deadLine)
    }

    function getTimeRemaining(endTime) {
        let t = Date.parse(endTime) - Date.parse(new Date());
        let seconds = Math.floor((t / 1000) % 60);
        let minutes = Math.floor((t / 1000 / 60) % 60);
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
                setInterval("window.location.href =  document.location + '/result'", 3000);
                clearInterval(timeInterval);
                return 0;
            }
        }

        updateClock();
        let timeInterval = setInterval(updateClock, 1000);
    }

});
