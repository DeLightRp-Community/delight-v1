$(document).on('click', '.cancelmenu-button', function(e) {
    e.preventDefault();
    $.post('http://qb-TriadRecords/Click', JSON.stringify({}))
    $.post('http://qb-TriadRecords/CloseNui', JSON.stringify({}))
    $(".mainmenu-container").animate({"top": "-30vh"}, 250, function() {
      $('.mainmenu-container').css("display", "none");
   }) 
});

OpenMenu = function() {
  $('.mainmenu-container').css("display", "block");
  $('.mainmenu-container').animate({"top": "30vh"}, 350)
}

$(document).on('click', '.close-button', function(e) {
    e.preventDefault();
    $.post('http://qb-TriadRecords/Click', JSON.stringify({}))
    $.post('http://qb-TriadRecords/CloseNui', JSON.stringify({}))
    $(".mainmenu-container").animate({"top": "-30vh"}, 250, function() {
      $('.mainmenu-container').css("display", "none");
   }) 
});

window.addEventListener('message', function(event) {
    switch(event.data.action) {
        case "OpenMenu":
          OpenMenu();
          break;
    }
});