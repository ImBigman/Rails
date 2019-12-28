document.addEventListener('turbolinks:load', function () {

    let startPoint =  document.querySelector('.progress-bar');
    let progressValue = document.getElementById('progress');
    if(startPoint)  {
        startPoint.style.width = progressValue.getAttribute('data-test-progress');
        startPoint.setAttribute('aria-valuenow',(startPoint.style.width.slice(0, -1)));
    }
});
