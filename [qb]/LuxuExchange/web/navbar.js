const navBar = document.querySelector(".navbar")
            allLi = document.querySelectorAll("#navli");
            var canSelect = true
allLi.forEach((li, index) => {
    li.addEventListener("click", e => {
        if (canSelect == true) {
            e.preventDefault()
            
            navBar.querySelector(".active").classList.remove("active")
            
            li.classList.add("active")

            const indicator = document.querySelector(".indicator")
            indicator.style.transform = `translateX(calc(${index * 70}px))`
            if (index == 0) {
                canSelect = false
                $.post("https://LuxuExchange/action", JSON.stringify({
                    action: "getbalancesAndaddress"
                }))

                $(document).ready(function() {
                    $(".page2").fadeOut(1)
                    $(".page3").fadeOut(1)
                    $(".page4").fadeOut(1)
                    $(".page5").fadeOut(1)
                    $(".container").fadeIn(650, function () { canSelect = true})
                });
            }
            else if (index == 1 ) {
                canSelect = false
                $.post("https://LuxuExchange/action", JSON.stringify({
                    action: "getbalancesAndaddress"
                }))
                $(document).ready(function() {
                    $(".container").fadeOut(1)
                    $(".page3").fadeOut(1)
                    $(".page4").fadeOut(1)
                    $(".page5").fadeOut(1)
                    $(".page2").fadeIn(650,function () { canSelect = true  })
                });
            }
            else if (index == 2 ) {
                canSelect = false
                $.post("https://LuxuExchange/action", JSON.stringify({
                    action: "fetchsecondtable"
                }))
                $(document).ready(function() {
                    $(".container").fadeOut(1)
                    $(".page2").fadeOut(1)
                    $(".page4").fadeOut(1)
                    $(".page5").fadeOut(1)
                    $(".page3").fadeIn(650,function () { canSelect = true  })
                });
            }
            else if (index == 3 )  {
                canSelect = false
                $.post("https://LuxuExchange/action", JSON.stringify({
                    action: "refreshBalances"
                }))
                $(document).ready(function() {
                    $(".container").fadeOut(1);
                    $(".page2").fadeOut(1);
                    $(".page3").fadeOut(1);
                    $(".page5").fadeOut(1);
                    $(".page4").fadeIn(650,function () { canSelect = true  });
                });
            }
            else if (index == 4 ) {
                canSelect = false
                $(document).ready(function() {
                    $(".container").fadeOut(1)
                    $(".page2").fadeOut(1)
                    $(".page3").fadeOut(1)
                    $(".page4").fadeOut(1)
                    $(".page5").fadeIn(650,function () { canSelect = true  })
                });
            }
        }
    })
})



//CHANGE CHART
function createWidget(stock){
    var stock_selected = stock
    var fxWidget = new TradingView.widget({
        "autosize":"true",
        "symbol": stock_selected,
        "interval": "D",
        "timezone": "Etc/UTC",
        "theme": "dark",
        "style": "1",
        "locale": "en",
        "toolbar_bg": "#f1f3f6",
        "enable_publishing": false,
        "allow_symbol_change": true,
        "container_id": "tradingview_3418f"
    }); 
}
$(".asset-list>ul>li").on('click', function(e) {
    var stock_selected = $(this).attr('stock')
    createWidget(stock_selected)
    setTimeout(function() {
        $.post("https://LuxuExchange/action", JSON.stringify({
            action: "getbalancesAndaddress"
        }))   
    }, 2000 )



});

// END CHANGE CHART






