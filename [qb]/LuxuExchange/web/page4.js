$("#sendbtn").click(function (e) { 
    e.preventDefault();
    var Receiver = $("#target-userid").val()
    var sendammount = $("#sendammount").val()
    var chosenasset = $("#chosenassetsend").val()
    alert("You sent id:" + Receiver +" "+ sendammount + chosenasset)
    $.post("https://LuxuExchange/action", JSON.stringify({
        action: "sendcrypto",
        selectedCrypto: chosenasset,
        sentammount: sendammount,
        Receiver: Receiver
    }))
    $.post("https://LuxuExchange/action", JSON.stringify({
        action: "refreshBalances"
    }))

});


$("#refreshBalances-btn").click(function (e) {
    $.post("https://LuxuExchange/action", JSON.stringify({
        action: "refreshBalances"
    }))
    e.preventDefault(); 
});


