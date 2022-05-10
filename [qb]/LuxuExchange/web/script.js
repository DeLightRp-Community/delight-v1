
//display imgs
const numberofimages = 7 // Change this to the number of images you have on the avatars folder
var imgs = [];
for (var i = 1; i <=numberofimages; i++) {  
    imgs.push('avatars/' + i + '.png')
}

for(i = 0; i < imgs.length; i++)
{
    document.getElementById("avatar-container").innerHTML += "<img class='avatars' src='"+ imgs[i] + "' class='images'></img>";
}

function refreshTables() {
	$.post("https://LuxuExchange/action", JSON.stringify({
                    action: "fetchtransactions"
	}))
}




function changeColor() {
    var choosenColor = $("#coloroptions").val()
    if (choosenColor == 'red') {
        document.documentElement.style.setProperty('--customcolor', '#eb0e0e');
    }
    if (choosenColor == 'green') {
        document.documentElement.style.setProperty('--customcolor', '#04AA6D');
    }
    if (choosenColor == 'blue') {
        document.documentElement.style.setProperty('--customcolor', '#1477FF');
    }
    if (choosenColor == 'orange') {
        document.documentElement.style.setProperty('--customcolor', '#F6610A');
    }
    if (choosenColor == 'purple') {
        document.documentElement.style.setProperty('--customcolor', '#642CA9');
    }
    if (choosenColor == 'pink') {
        document.documentElement.style.setProperty('--customcolor', '#FF36AB');
    }
    if (choosenColor == 'ruby') {
        document.documentElement.style.setProperty('--customcolor', '#8B2635');
    }
}



var max_chars = 17;

$('.cryptoinput').keydown( function(e){
    if ($(this).val().length >= max_chars) { 
        $(this).val($(this).val().substr(0, max_chars));
    }
});

$('.cryptoinput').keyup( function(e){
    if ($(this).val().length >= max_chars) { 
        $(this).val($(this).val().substr(0, max_chars));
    }
});

function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode != 46 && charCode > 31 
    && (charCode < 48 || charCode > 57))
        return false;

    return true;
}
function isValidURL(string) {
    var res = string.match(/(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g);
    return (res !== null)
};
//AVATARS
var newavatar =  $("#currentavatar").prop('src')
//choose from list
$(".avatars").on("click", function() {
    newavatar = $(this).prop('src')
    $('#currentavatar').attr('src', newavatar);
})

//upload avatar
$("#avatarlinkbtn").on("click", function() {
    if (isValidURL($("#avatarlinkinput").val())) {
        newavatar = $("#avatarlinkinput").val()
        $('#currentavatar').attr('src', newavatar);
        $('#avatar').attr('src', newavatar);
        $('#avatarprofile').attr('src', newavatar);
        $('#currentavatar').attr('src', newavatar);
    }
})

function changeAvatar() {
    $('#avatar').attr('src', newavatar);
    $('#avatarprofile').attr('src', newavatar);
    $('#currentavatar').attr('src', newavatar);
}
document.addEventListener('DOMContentLoaded', function () {

    
    if (localStorage['avatar']) {
        newavatar =  localStorage['avatar'];
        changeAvatar()
    }
    $("#avatarcontainerbutton").on("click", function() {
        localStorage['avatar'] = newavatar; 
        changeAvatar()
    })




    var input = document.getElementById('coloroptions');
    if (localStorage['color']) { 
        input.value = localStorage['color']; 
        changeColor()

    }
    input.onchange = function () {
         localStorage['color'] = this.value; 
         changeColor()
     }
 });

 $('#bs-asset').on('change', function() {
    var newchosencrypto = $("#bsinput").val()
    convertAmmount(newchosencrypto)
})

function convertAmmount(valNum){
    var buyasset = $("#bs-asset").val()
    if (buyasset == "btc"){
        var cryptoV = Number(btc.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
                 
    }
    if (buyasset == "eth"){
        var cryptoV = Number(eth.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
                 
                 
    }
    if (buyasset == "hex"){
        var cryptoV = Number(hex.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
                 
    }
    if (buyasset == "doge"){
        var cryptoV = Number(doge.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
                 
    }
    if (buyasset == "sol"){
        var cryptoV = Number(sol.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
                 
    }
    if (buyasset == "ada"){
        var cryptoV = Number(ada.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
                 
                 
    }
    if (buyasset == "shib"){
        var cryptoV = Number(shib.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
                 
    }
    if (buyasset == "bnb"){
        var cryptoV = Number(bnb.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
                 
                 
    }
    if (buyasset == "tron"){
        var cryptoV = Number(tron.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
                 
                 
    }
    if (buyasset == "xrp"){
         var cryptoV = Number(xrp.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
    }
    if (buyasset == "avax"){
        var cryptoV = Number(avax.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
                 
                 
    }
    if (buyasset == "matic"){
        var cryptoV = Number(matic.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
                 
    }
    if (buyasset == "xmr"){
        var cryptoV = Number(xmr.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
                 
                 
    }
    if (buyasset == "luna"){
        var cryptoV = Number(luna.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
                 
                 
    }
    if (buyasset == "aurora"){
        var cryptoV = Number(aurora.innerText.replace('$' , ''))
        $(".convertedammount").text("Estimative ≈ " + Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( valNum*cryptoV))
                 
    }
    if ($("#bsinput").val() == ""){
        $(".convertedammount").text("")
                 
    }
}


var max_chars = 16;

$('.changeaddrInput').keydown( function(e){
    if ($(this).val().length >= max_chars) { 
        $(this).val($(this).val().substr(0, max_chars));
    }
});

$('.changeaddrInput').keyup( function(e){
    if ($(this).val().length >= max_chars) { 
        $(this).val($(this).val().substr(0, max_chars));
    }
});




function interval(func, wait, times){
    var interv = function(w, t){
        return function(){
            if(typeof t === "undefined" || t-- > 0){
                setTimeout(interv, w);
                try{
                    func.call(null);
                }
                catch(e){
                    t = 0;
                    throw e.toString();
                }
            }
        };
    }(wait, times);

    setTimeout(interv, wait);
};

var btcwallet = document.getElementById("btcwallet");
var ethwallet = document.getElementById("ethwallet");
var hexwallet = document.getElementById("hexwallet");
var solwallet = document.getElementById("solwallet");
var dogewallet = document.getElementById("dogewallet");
var adawallet = document.getElementById("adawallet");
var shibwallet = document.getElementById("shibwallet");
var bnbwallet = document.getElementById("bnbwallet");
var tronwallet = document.getElementById("tronwallet");
var xrpwallet = document.getElementById("xrpwallet");
var avaxwallet = document.getElementById("avaxwallet");
var maticwallet = document.getElementById("maticwallet");
var xmrwallet = document.getElementById("xmrwallet");
var lunawallet = document.getElementById("lunawallet");
var aurorawallet = document.getElementById("aurorawallet");

//get crypto prices
var btc = document.getElementById("btcprice");
var eth = document.getElementById("ethprice");
var hex = document.getElementById("hexprice");
var sol = document.getElementById("solprice");
var doge = document.getElementById("dogeprice");
var ada = document.getElementById("adaprice");
var shib = document.getElementById("shibprice");
var bnb = document.getElementById("bnbprice");
var tron = document.getElementById("tronprice");
var xrp = document.getElementById("xrpprice");
var avax = document.getElementById("avaxprice");
var matic = document.getElementById("maticprice");
var xmr = document.getElementById("xmrprice");
var luna = document.getElementById("lunaprice");
var aurora = document.getElementById("auroraprice");


function apiGET(){
    return $.ajax({
        "async": true,
        "scroosDomain": true,
        "url": "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin%2Cethereum%2Chex%2Csolana%2Cdogecoin%2Cshiba-inu%2Ccardano%2Cbinancecoin%2Ctron%2Cripple%2Cavalanche-2%2Cmatic-network%2Cmonero%2Cterra-luna%2Caurora-near&vs_currencies=usd",
    
        "method": "GET",
        "headers": {}
    });
};

async function cryptoQuotes(){

    try{
        const response = await apiGET()
        btc.innerHTML = "$" + response.bitcoin.usd;
        eth.innerHTML = "$" + response.ethereum.usd;
        hex.innerHTML = "$" + response.hex.usd;
        sol.innerHTML = "$" + response.solana.usd;
        doge.innerHTML = "$" + response.dogecoin.usd;
        bnb.innerHTML = "$" + response.binancecoin.usd;
        tron.innerHTML = "$" + response.tron.usd;
        xrp.innerHTML = "$" + response.ripple.usd;
        matic.innerHTML = "$" + response["matic-network"].usd;
        xmr.innerHTML = "$" + response.monero.usd;
        luna.innerHTML = "$" + response["terra-luna"].usd;
        aurora.innerHTML = "$" + response["aurora-near"].usd;
        avax.innerHTML = "$" + response['avalanche-2'].usd;
        shib.innerHTML = "$" + response['shiba-inu'].usd;
        ada.innerHTML = "$" + response.cardano.usd;
    }
    catch(err){}
}

 //refresh crypto prices every 45seconds
setInterval(cryptoQuotes ,45000);
$("#exit-btn").click(function() {
    $.post("https://LuxuExchange/action", JSON.stringify({
        action: "fechar"
    }))
    $(".main").hide("slow")
    location.reload()
})


//exit with esc button
var KEYCODE_ESC = 27;

$(document).keyup(function(e) {
  if (e.keyCode == KEYCODE_ESC) {
    $.post("https://LuxuExchange/action", JSON.stringify({
        action: "fechar"
    }))
    $(".main").hide("slow")
    location.reload()
  };
});

//datatables
var tablepage3 = $("#page3table").DataTable({
    "autoWidth": false,
    "searching": true,
    "paging":true,
    "order": [[ 5, "desc" ]],
    "info":true,
    "lengthChange":false,});
var tablepage1 = $('#page1th').DataTable({
    "autoWidth": true,
    "searching": false,
    "paging":false,
    "lengthChange":false,
    "info":false,
    "ordering":false});


function fillTable1(transactions) {
    try{
        tablepage1.clear()
        for (var i = 0; i < 4; i++) {
            tablepage1.row.add([
                transactions[i]["type"],
                transactions[i]["asset"],
                transactions[i]["value"],
                transactions[i]["price"],
                transactions[i]["receiver_address"],
                transactions[i]["date"]
            ]).draw( false );
        }
    }catch(e){}
}
function fillTable2(transactions) {
    try{
        tablepage3.clear()
        for (var i = 0; i < transactions.length; i++) {
            tablepage3.row.add([
                transactions[i]["type"],
                transactions[i]["asset"],
                transactions[i]["value"],
                transactions[i]["price"],
                transactions[i]["receiver_address"],
                transactions[i]["date"]
            ]).draw( false );
        }
    }catch(e){} 
}

var successSound = new Audio('sounds/success.mp3');
var errorSound = new Audio('sounds/error2.mp3');
var warningSound = new Audio('sounds/warning.mp3');
var receivedSound = new Audio('sounds/received.mp3');
var sendSound = new Audio('sounds/sent.mp3');

window.addEventListener('message', function(event) { 
    switch (event.data.action) {  
        case 'abrir':
            cryptoQuotes()
            $(".main").fadeIn("slow");
        break
        case 'filltables':
            var transactions  = event.data.transactions
            fillTable1(transactions)
            fillTable2(transactions)
        break
        case 'fillfirsttable':
            var transactions  = event.data.transactions
            fillTable1(transactions)
        case 'fillsecondtable':
            var transactions  = event.data.transactions
            fillTable2(transactions)
        break
    }
    switch (event.data.notify){
        case 'success':
            successSound.play();
            var msg = $("<div id='successMSG'></div>").html("<div class='card_o' > <div class='card__icon'> <img src='images/check.svg' style='width: 50px;'> </div> <div class='card__message'> <h2>Success!</h2> <p id='successmsg'>"+event.data.notifymsg+"</p> </div></div>")
            $(".notifyall").append(msg); 
            $("#successMSG").fadeIn("slow").delay(2000).fadeOut();
            setTimeout(function() {$("#successMSG").remove()},2500)
        break
        case 'warning':
            warningSound.play();
            var msg = $("<div id='warningMSG'></div>").html("<div class='card_o' > <div class='card__icon'> <img src='images/warning.svg' style='width: 50px;'> </div> <div class='card__message'> <h2>Warning!</h2> <p id='warningmsg'>"+event.data.notifymsg+"</p> </div></div>")
            $(".notifyall").append(msg); 
            $("#warningMSG").fadeIn("slow").delay(2000).fadeOut();
            setTimeout(function() {$("#warningMSG").remove()},2500)
        break
        case 'error':
            errorSound.play();
            var msg = $("<div id='errorMSG'></div>").html("<div class='card_o' > <div class='card__icon'> <img src='images/error.svg' style='width: 30px;'> </div> <div class='card__message'> <h2>Error!</h2> <p id='errormsg'>"+event.data.notifymsg+"</p> </div></div>")
            $(".notifyall").append(msg); 
            $("#errorMSG").fadeIn("slow").delay(2000).fadeOut();
            setTimeout(function() {$("#errorMSG").remove()},2500)
        break
        case 'received':
            receivedSound.play();
            $("#notifymsg").text(event.data.notifymsg)
        break
        case 'send':
            sendSound.play();
            $("#notifymsg").text(event.data.notifymsg)
            $("#successMSG").fadeIn("slow").delay(2000).fadeOut();
        break
    }

    var bankmoney = event.data.bankbalance
    var balance = document.getElementById("balance")
    $("#balance-page2").text(Intl.NumberFormat('en-US', {style: 'currency', notation: "compact",  currency: 'USD'}).format( bankmoney))
    balance.textContent = Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact", currency: 'USD'}).format( bankmoney)
    var username = event.data.username
    $(".username").text(username)


    var btcbalance = document.getElementById("btcbalance");
    var ethbalance = document.getElementById("ethbalance");
    var hexbalance = document.getElementById("hexbalance");
    var solbalance = document.getElementById("solbalance");
    var dogebalance = document.getElementById("dogebalance");
    var adabalance = document.getElementById("adabalance");
    var shibbalance = document.getElementById("shibbalance");
    var bnbbalance = document.getElementById("bnbbalance");
    var tronbalance = document.getElementById("tronbalance");
    var xrpbalance = document.getElementById("xrpbalance");
    var avaxbalance = document.getElementById("avaxbalance");
    var maticbalance = document.getElementById("maticbalance");
    var xmrbalance = document.getElementById("xmrbalance");
    var lunabalance = document.getElementById("lunabalance");
    var aurorabalance = document.getElementById("aurorabalance");

    btcbalance.innerHTML =  event.data.btcBalance + " btc"
    ethbalance.innerHTML = event.data.ethBalance + " eth"
    hexbalance.innerHTML = event.data.hexBalance + " hex"
    solbalance.innerHTML = event.data.solBalance + " sol"
    dogebalance.innerHTML =  event.data.dogeBalance + " doge"
    adabalance.innerHTML = event.data.adaBalance + " ada"
    shibbalance.innerHTML = event.data.shibBalance + " shib"
    bnbbalance.innerHTML = event.data.bnbBalance + " bnb"
    tronbalance.innerHTML =  event.data.tronBalance + " tron"
    xrpbalance.innerHTML = event.data.xrpBalance + " xrp"
    avaxbalance.innerHTML = event.data.avaxBalance + " avax"
    maticbalance.innerHTML = event.data.maticBalance + " matic"
    xmrbalance.innerHTML =  event.data.xmrBalance + " xmr"
    lunabalance.innerHTML = event.data.lunaBalance + " luna"
    aurorabalance.innerHTML = event.data.auroraBalance + " aurora"
    

    
    //page2 total balances
    var usernamepage2 = document.getElementById("username-page2")
    usernamepage2.textContent = event.data.username
    var totalcryptovalue = document.getElementById("totalcryptovalue")
    var totalBalance = document.getElementById("totalbalance")
    async function total(){
        try{
            const response = await apiGET()
            
            var totalCryptocurrencyValue = 
            event.data.btcBalance * response.bitcoin.usd+
            event.data.ethBalance * response.ethereum.usd+
            event.data.hexBalance * response.hex.usd+
            event.data.solBalance * response.solana.usd+
            event.data.dogeBalance * response.dogecoin.usd+
            event.data.bnbBalance * response.binancecoin.usd+
            event.data.tronBalance * response.tron.usd+
            event.data.xrpBalance * response.ripple.usd+
            event.data.maticBalance *response["matic-network"].usd+
            event.data.xmrBalance * response.monero.usd+
            event.data.lunaBalance * response["terra-luna"].usd+
            event.data.auroraBalance * response["aurora-near"].usd+
            event.data.avaxBalance * response['avalanche-2'].usd+
            event.data.shibBalance * response['shiba-inu'].usd+
            event.data.adaBalance * response.cardano.usd;
    
            var bankCryptoSum = totalCryptocurrencyValue + event.data.bankbalance
            totalcryptovalue.textContent = Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( totalCryptocurrencyValue) ;
            totalBalance.textContent =   Intl.NumberFormat('en-US', {style: 'currency',   notation: "compact", currency: 'USD'}).format( bankCryptoSum) ;
    
    
            btcwallet.innerHTML =  "Wallet: "+ event.data.btcBalance+ " btc ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.btcBalance* response.bitcoin.usd ) 
            ethwallet.innerHTML = "Wallet: "+ event.data.ethBalance+ " eth ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.ethBalance* response.ethereum.usd ) 
            hexwallet.innerHTML = "Wallet: "+ event.data.hexBalance+ " hex ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.hexBalance* response.hex.usd ) 
            solwallet.innerHTML = "Wallet: "+ event.data.solBalance+ " sol ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.solBalance*  response.solana.usd) 
            dogewallet.innerHTML =  "Wallet: "+ event.data.dogeBalance+ " doge ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.dogeBalance*  response.dogecoin.usd) 
            adawallet.innerHTML = "Wallet: "+ event.data.adaBalance+ " ada ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.adaBalance* response.cardano.usd ) 
            shibwallet.innerHTML = "Wallet: "+ event.data.shibBalance+ " shib ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.shibBalance* response['shiba-inu'].usd ) 
            bnbwallet.innerHTML = "Wallet: "+ event.data.bnbBalance+ " bnb ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.bnbBalance* response.binancecoin.usd ) 
            tronwallet.innerHTML =  "Wallet: "+ event.data.tronBalance+ " tron ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.tronBalance* response.tron.usd ) 
            xrpwallet.innerHTML = "Wallet: "+ event.data.xrpBalance+ " xrp ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.xrpBalance* response.ripple.usd ) 
            avaxwallet.innerHTML = "Wallet: "+ event.data.avaxBalance+ " avax ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.avaxBalance*response['avalanche-2'].usd  ) 
            maticwallet.innerHTML = "Wallet: "+ event.data.maticBalance+ " matic ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.maticBalance* response["matic-network"].usd ) 
            xmrwallet.innerHTML =  "Wallet: "+ event.data.xmrBalance+ " xmr ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.xmrBalance* response.monero.usd ) 
            lunawallet.innerHTML = "Wallet: "+ event.data.lunaBalance+ " luna ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.lunaBalance*  response["terra-luna"].usd) 
            aurorawallet.innerHTML = "Wallet: "+ event.data.auroraBalance+ " aurora ~ "+  Intl.NumberFormat('en-US', {style: 'currency',  notation: "compact",  currency: 'USD'}).format( event.data.auroraBalance* response["aurora-near"].usd ) 
    
    
    
        }
        catch(err){}
    }
    total()


});



$("#exit-btn").hover(
    function() {
        $(".bx.bx-exit").hide()
        $(".bx.bxs-exit").show()
    } , function() {
        $(".bx.bx-exit").show()
        $(".bx.bxs-exit").hide()
    }
)


//buy function

$("#buy-btn").click(async function() {
    $("#successMSG").fadeIn("slow").delay(2000).fadeOut();
    var buyasset = $("#bs-asset").val()
    var buyammount = $("#bsinput").val()
    var BuyorSell = "buy"
    //get Prices
    try{
        const response = await apiGET()
        if (buyasset == "btc"){
            result = response.bitcoin.usd;
            getPrice(result);           
        }
        if (buyasset == "eth"){
            result = response.ethereum.usd;
            getPrice(result);           
        }
        if (buyasset == "hex"){
            result = response.hex.usd;
            getPrice(result);           
        }
        if (buyasset == "sol"){
            result = response.solana.usd;
            getPrice(result);           
        }
        if (buyasset == "doge"){
            result = response.dogecoin.usd;
            getPrice(result);           
        }
        if (buyasset == "ada"){
            result = response.cardano.usd;
            getPrice(result);           
        }
        if (buyasset == "shib"){
            result = response['shiba-inu'].usd;
            getPrice(result);           
        }
        if (buyasset == "bnb"){
            result = response.binancecoin.usd;
            getPrice(result);           
        }
        if (buyasset == "tron"){
            result = response.tron.usd;
            getPrice(result);           
        }
        if (buyasset == "xrp"){
            result = response.ripple.usd;
            getPrice(result);           
        }
        if (buyasset == "avax"){
            result = response['avalanche-2'].usd;
            getPrice(result);           
        }
        if (buyasset == "matic"){
            result = response["matic-network"].usd;
            getPrice(result);           
        }
        if (buyasset == "xmr"){
            result = response.monero.usd;
            getPrice(result);           
        }
        if (buyasset == "luna"){
            result = response["terra-luna"].usd;
            getPrice(result);           
        }
        if (buyasset == "aurora"){
            result = response["aurora-near"].usd;
            getPrice(result);           
        }

    }
    catch(err){}

    function getPrice(assetPrice) {
        var assetPrice = assetPrice
        var totalCryptoValue = buyammount * assetPrice
        if (buyammount <= 0){
            return false
        }
        else {
            $.post("https://LuxuExchange/action", JSON.stringify({
                action:"buycrypto",
                buyammount: buyammount,
                assetname: buyasset,
                assetPrice: assetPrice,
                totalCryptoValue: totalCryptoValue,
                BuyorSell: BuyorSell
            }));

        }
    }
})

//sell function
$("#sell-btn").click(async function() {

    var buyasset = $("#bs-asset").val()
    var buyammount = $("#bsinput").val()
    var BuyorSell = "sell"
    //get Prices
    try{
        const response = await apiGET()
        if (buyasset == "btc"){
            result = response.bitcoin.usd;
            getPrice(result);           
        }
        if (buyasset == "eth"){
            result = response.ethereum.usd;
            getPrice(result);           
        }
        if (buyasset == "hex"){
            result = response.hex.usd;
            getPrice(result);           
        }
        if (buyasset == "sol"){
            result = response.solana.usd;
            getPrice(result);           
        }
        if (buyasset == "doge"){
            result = response.dogecoin.usd;
            getPrice(result);           
        }
        if (buyasset == "ada"){
            result = response.cardano.usd;
            getPrice(result);           
        }
        if (buyasset == "shib"){
            result = response['shiba-inu'].usd;
            getPrice(result);           
        }
        if (buyasset == "bnb"){
            result = response.binancecoin.usd;
            getPrice(result);           
        }
        if (buyasset == "tron"){
            result = response.tron.usd;
            getPrice(result);           
        }
        if (buyasset == "xrp"){
            result = response.ripple.usd;
            getPrice(result);           
        }
        if (buyasset == "avax"){
            result = response['avalanche-2'].usd;
            getPrice(result);           
        }
        if (buyasset == "matic"){
            result = response["matic-network"].usd;
            getPrice(result);           
        }
        if (buyasset == "xmr"){
            result = response.monero.usd;
            getPrice(result);           
        }
        if (buyasset == "luna"){
            result = response["terra-luna"].usd;
            getPrice(result);           
        }
        if (buyasset == "aurora"){
            result = response["aurora-near"].usd;
            getPrice(result);           
        }

    }
    catch(err){}

    function getPrice(assetPrice) {
        var assetPrice = assetPrice
        var totalCryptoValue = buyammount * assetPrice
        if (buyammount <= 0){
            return false
        }
        else {
            $.post("https://LuxuExchange/action", JSON.stringify({
                action:"buycrypto",
                buyammount: buyammount,
                assetname: buyasset,
                assetPrice: assetPrice,
                totalCryptoValue: totalCryptoValue,
                BuyorSell: BuyorSell
            }));

        }
    }
})

