$(function () {
    window.addEventListener('message', (evt) => {
        let ele = document.getElementById('cross');
        if (evt.data === 'Show') {
            ele.style.display = 'block';
        } else {
            ele.style.display = 'none';
        }
    });
});