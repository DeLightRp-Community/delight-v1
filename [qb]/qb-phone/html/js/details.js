function LoadPlayerMoneys(){
    var PlayerPhoneNumber = QB.Phone.Data.PlayerData.charinfo.phone;
    var PlayerBankAcc = QB.Phone.Data.PlayerData.charinfo.account;
    var PlayerBankMoney = QB.Phone.Data.PlayerData.money.bank;
    var PlayerPayCheckMoney = QB.Phone.Data.PlayerData.money.paycheck;
    var PlayerCasinoMoney = QB.Phone.Data.PlayerData.money.chip;

    $(".details-phone").html(PlayerPhoneNumber)
    $(".details-bankserial").html(PlayerBankAcc)
    $(".details-bankmoney").html("$"+PlayerBankMoney)
    $(".details-paycheck").html("$"+PlayerPayCheckMoney)
    $(".details-casinomoney").html(PlayerCasinoMoney)

    var PlayerLicenses = QB.Phone.Data.PlayerData.metadata.licences;

    $(".details-list").html("");
    var AddOption0 = '<div class="details-text-license">Licenses</div>'
    $('.details-list').append(AddOption0);
    for (const [k, v] of Object.entries(PlayerLicenses)) {
        if (v){
            var firstLetter = k.substring(0, 1);  
            var Fulltext = firstLetter.toUpperCase()+k.replace(firstLetter,'')+" License"

            var AddOption = '<div class="details-license-body-main">'+
                                '<div class="details-license-text-class">'+Fulltext+'</div>'+
                                '<div class="details-license-icon-class"><i style="color: #b1d18e;" class="fas fa-check-circle"></i></div>'+
                            '</div>'
            $('.details-list').append(AddOption);
        }
    }
}

/* <div class="details-license-body-main">
    <div class="details-license-text-class">driver</div>
    <div class="details-license-icon-class"><i style="color: #b1d18e;" class="fas fa-check-circle"></i></div>
</div> */