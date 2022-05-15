let timer_start, timer_game, timer_finish, timer_time, answer, wrong, right, speed, numbers, timerStart, positions,checktime;
let game_started = false;
let streak = 0;
let max_streak = 0;
let best_time = 99.999;

// Get max streak from cookie
const regex = /max-streak_vaultcodes=([\d]+)/g;
let cookie = document.cookie;
if((cookie = regex.exec(cookie)) !== null){
    max_streak = cookie[1];
}
// Get max streak from cookie
const regex_time = /best-time_vaultcodes=([\d.]+)/g;
cookie = document.cookie;
if((cookie = regex_time.exec(cookie)) !== null){
    best_time = parseFloat(cookie[1]);
}

const sleep = (ms, fn) => {return setTimeout(fn, ms)};

const rangeNumbers = (length = 1) => {
    return Array.from({length}, _ => Math.floor(Math.random() * 10))
}


document.querySelector('.minigame .numbers').addEventListener('keydown', function(e) {
    if (e.ctrlKey === true && e.key === 'c'){
        alert('Low tier cheater WeirdChamp');
        e.preventDefault();
        return false;
    }
});
document.querySelector('#answer').addEventListener('keydown', function(e) {
    if (e.ctrlKey === true && e.key === 'v'){
        alert('Low tier cheater WeirdChamp');
        e.preventDefault();
        return false;
    }
    if (e.key === 'Enter' && document.querySelector('.solution').offsetHeight === 0) {
        clearTimeout(timer_finish);
        check();
    }
});
document.querySelector('#answer').addEventListener('drop', function(e) {
    alert('Low tier cheater WeirdChamp');
    e.preventDefault();
    return false;
});

function check(){
    stopTimer();

    let response = document.querySelector('#answer').value.toLowerCase().trim();
    if(game_started && response === answer.join('')){
        $.post("https://vaultcodes/success");
        reset();
        setTimeout(function(){
            $('.minigame').addClass('hide_disp');
        },3000)
    }else{
        answer.forEach( (number, pos) => {
            let span = document.createElement('span');
            span.innerText = number;
            span.classList.add('bad');
            document.querySelector('.solution').append(span);
        });
        $.post("https://vaultcodes/fail");
        setTimeout(function(){
            document.querySelector('.splash').classList.remove('hidden');
            document.querySelector('.minigame .input').classList.add('hidden');
            document.querySelector('.minigame .numbers').classList.add('hidden');
            $('.minigame').addClass('hide_disp');
            
        },3000)
    }
}

function reset(){
    game_started = false;

    resetTimer();
    clearTimeout(timer_start);
    clearTimeout(timer_game);
    clearTimeout(timer_finish);

    document.querySelector('.splash').classList.remove('hidden');
    document.querySelector('.minigame .numbers').classList.add('hidden');
    document.querySelector('.minigame .input').classList.add('hidden');

    document.querySelector('#answer').value = '';
    document.querySelector('.solution').innerHTML = '';
    // start();
}

function start(){

    numbers = document.querySelector('#numbers').value;
    console.log(numbers)
    answer = rangeNumbers(numbers);
    document.querySelector('.minigame .numbers').innerHTML = answer.join('');

    timer_start = sleep(2000, function(){
        document.querySelector('.splash').classList.add('hidden');
        document.querySelector('.minigame .input').classList.add('hidden');
        document.querySelector('.minigame .numbers').classList.remove('hidden');

        timer_game = sleep(3000, function(){
            document.querySelector('.minigame .numbers').classList.add('hidden');
            document.querySelector('.minigame .input').classList.remove('hidden');

            game_started = true;
            startTimer();

            document.querySelector('#answer').focus({preventScroll: true});

            speed = document.querySelector('#speed').value;
            console.log(speed)
            timer_finish = sleep((speed * 1000), function(){
                game_started = false;
                streak = 0;
                check();
            });
        });
    });

}

function startTimer(){
    timerStart = new Date();
    timer_time = setInterval(timer,1);
}
function timer(){
    let timerNow = new Date();
    let timerDiff = new Date();
    timerDiff.setTime(timerNow - timerStart);
    let ms = timerDiff.getMilliseconds();
    let sec = timerDiff.getSeconds();
    if (ms < 10) {ms = "00"+ms;}else if (ms < 100) {ms = "0"+ms;}
    document.querySelector('.streaks .time').innerHTML = sec+"."+ms;
}
function stopTimer(){
    clearInterval(timer_time);
}
function resetTimer(){
    clearInterval(timer_time);
}


window.addEventListener("message", function (event) {
    console.log(event)
    let data = event.data;
    console.log(data)
    if (data.action === "start") {
        var n=data.numbers;
        var s=data.timer
        console.log(s)
        document.querySelector('#numbers').value=n
        document.querySelector('#speed').value=s
        $('.minigame').removeClass('hide_disp')
        start();
    }
});