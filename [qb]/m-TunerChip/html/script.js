QBTuner = {}

$(document).ready(function(){
    $('.container').hide();

    window.addEventListener('message', function(event){
        var eventData = event.data;

        if (eventData.action == "ui") {
            if (eventData.toggle) {
                QBTuner.Open()
            }
        }
    });
});

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27:
            QBTuner.Close();
            break;
    }
});

$(document).on('click', '#save', function(){
    $.post('https://m-TunerChip/save', JSON.stringify({
        boost: $("#boost-slider").val(),
        acceleration: $("#acceleration-slider").val(),
        gearchange: $("#gear-slider").val(),
        breaking: $("#breaking-slider").val(),
        drivetrain: $("#drivetrain-slider").val()
    }));
});

$(document).on('click', '#reset', function(){
    $.post('https://m-TunerChip/reset');
});

$(document).on('click', '#cancel', function(){
    QBTuner.Close();
});

$(document).on('click', "#tuning", function(){
    $(".headlights-block").css("display", "none");
    $(".neon-block").css("display", "none");
    $(".stancer-block").css("display", "none");
    $(".tunerchip-block").css("display", "block");
});

QBTuner.Open = function() {
    $.post('https://m-TunerChip/checkItem', JSON.stringify({item: "tunerlaptop"}), function(hasItem){
        if (hasItem) {
            $('.container').fadeIn(250);
        }
    })
}

QBTuner.Close = function() {
    $('.container').fadeOut(250);
    $.post('https://m-TunerChip/exit');
}