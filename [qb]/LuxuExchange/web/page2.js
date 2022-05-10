$(".changeaddrBTN").click(function () {
	var changeaddrInput =$(".changeaddrInput").val()
	if (changeaddrInput != "") {
		$.post("https://LuxuExchange/action", JSON.stringify({
            action: "changeAddr",
			newAddr :  "0x" +  changeaddrInput
        }));
	}
	else {
		let addressinfo = document.getElementById("addressinfo")
		addressinfo.innerHTML = "Error, empty field!"
	}
})

window.addEventListener('message', function(event) {
	var addrInUse = event.data.addrInUse
	var currentAddress = event.data.currentAddr
	var newAddress = event.data._newAddr
	let addressinfo = document.getElementById("addressinfo")
	addressinfo.innerHTML = "Your current address: "+ currentAddress
	if (addrInUse == true) {
		addressinfo.innerHTML = "That address is already being used!"

	}
	else if (addrInUse == false)  {
		addressinfo.innerHTML = "Sucess, your new address is: " + newAddress
	}


})

