document.addEventListener('turbolinks:load', function () {

    let startPoint =  document.querySelector('.progress-bar');
    let progressValue = document.getElementById('progress');
    let progressLabel = document.getElementById('progress-bar-title');

    if(startPoint && progressValue)  {
        startPoint.style.width = progressValue.getAttribute('data-test-progress');
        startPoint.setAttribute('aria-valuenow',(startPoint.style.width.slice(0, -1)));
    }
    if(startPoint && startPoint.getAttribute('aria-valuenow') === '100') {
        progressLabel.classList.add('hide')
    }
});
