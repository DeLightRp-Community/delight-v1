var language;
var lang = {
    en : {
        settings : 'Settings',
        delete : 'Delete',
        spawn: 'Spawn',
        modal : {
            addTitle : 'Add Coord',
            desc : 'Description',
            locationName : 'locationName',
            vector : 'Vector3 Coords',
            close : 'close',
            save : 'Save changes',
            vectorHelper : 'Vector Insert Helper',
            placeholder : {
                create_cord_description : 'Enter Location Description',
                helper: 'Help to insert your Coords',
                create_cord_name: 'Enter Location Name',
            },
        },
        tooltips: {
            devMode : 'Enable Dev Mode',
            addCords : 'Add Coord',
            settings : 'Settings',
        }
    },
    de: {
        settings : 'Einstellungen',
        delete : 'Löschen',
        spawn: 'Spawn',
        modal : {
            addTitle : 'Koordinaten hinzufügen',
            desc : 'Beschreibung',
            locationName : 'locationName',
            vector : 'Vector3  Koordinaten',
            close : 'schließen',
            save : 'speichern',
            vectorHelper : 'Vektor-Einfügehilfe',
            placeholder : {
                create_cord_description : 'Standortbeschreibung eingeben',
                helper: 'Hilfe zum Einfügen Ihrer Koordinaten',
                create_cord_name: 'Standortname eingeben',
            },

        },
        tooltips: {
            devMode : 'Dev-Modus aktivieren',
            addCords : 'Koordinaten hinzufügen',
            settings : 'Einstellungen',
        }
    },
    pl: {
        settings : 'Ustawienia',
        delete : 'Usuń',
        spawn: 'Spawn',
        modal : {
            desc : 'Opis',
            locationName : 'locationName',
            vector : 'Vector3 Współrzędne',
            close : 'zamknij',
            save : 'Zapisz zmiany',
            vectorHelper : 'Pomocnik wstawiania wektorów'

        },
        tooltips: {
            devMode : 'Włącz tryb Dev',
            addCords : 'Dodaj Współrzędne',
            settings : 'Ustawienia',
        }
    }
}


window.addEventListener('message', (event) => {
    let data = event.data
    if (data.action === 'open') {
        $(document).ready(function(){
            $('.spawn_box').show();
            $('#enterHouse').hide();
            $('#chooseApartment').hide()
            $('#lastLocation').show()
        });
        init(data)
    }else if(data.action === 'close') {
        showSpawn(false)
    }else if(data.action === 'message') {
        $.post('https://jerzys_spawn/notifySound');
        showMessage(data.messageText, data.messageType,data.messageTitle)
    }else if(data.action === 'update') {
        deleteAllNodes()
        setTimeout(() => {
            updateNodes(data.getCoords)
        },1000)
    }else if(data.action === 'isAdmin') {
        $('#devMode').fadeIn()
    }
    if (data.action == "setupApp") {
        $(document).ready(function(){
            $('.spawn_box').addClass('showInactive')
        });
        setupApps(data.locations)
    }
});

function init(data) {
    console.log(data)
    deleteAllNodes()
    showApartment(data.apartments)
    showHouses(data.houses)
    showSpawn(true)
    language = data.language
    $('.spawn_header').html(data.title)
    $('.spawn_body').html(data.description)
    document.documentElement.style.setProperty('--accent-color', data.accentColor);
    document.documentElement.style.setProperty('--success-color', data.succesColor);
    document.documentElement.style.setProperty('--error-color', data.errorColor);
    createNodes(data.getCoords)
    setLanguage()
}

// Show Houses
function showHouses(data) { 
    if(data) {

    }
}

// Show Apartements
function showApartment(data) {
    let insertApartments = $('#apartmentAccount');
    insertApartments.html("")
    if(data) {
        console.log(data)
        Object.keys(data).map(function(value,i){
            let html = `
            <option value="${data[i].name}" data-type="${data[i].type}">${data[i].label}</option>
            `
            insertApartments.append(html)
        })
    }
}

// Set Language
function setLanguage() {
    $('#devMode').attr("data-bs-original-title",lang[language].tooltips.devMode)
    $('#addCord').attr("data-bs-original-title",lang[language].tooltips.addCords)
    $('#settings').attr("data-bs-original-title",lang[language].tooltips.settings)
    // Add Language
    $('#addTitle').html(lang[language].modal.addTitle)
    $('#add_desc').html(lang[language].modal.desc)
    $('#vector_coords').html(lang[language].modal.vector)
    $('#vector_name').html(lang[language].modal.vectorHelper)
    $('#add_close').html(lang[language].modal.close)
    $('#add_create').html(lang[language].modal.save)
    // Add Placeholder
    $('#create_cord_name').attr('placeholder',lang[language].modal.placeholder.create_cord_name)
    $('#create_cord_description').attr('placeholder',lang[language].modal.placeholder.create_cord_description)
    $('#helper').html('placeholder',lang[language].modal.placeholder.helper)
    $('#add_close').html(lang[language].modal.close)
    $('#add_create').html(lang[language].modal.save)

}

// Generate Notifications
function showMessage(messageText, messageType, messageTitle) {
    let notiContainer = $('.notification');
    let notifyCreate = 
    `
    <div class="noti ${messageType}">
        <div class="top">
          ${messageTitle}
        </div>
        <div class="bottom">
          ${messageText}
        </div>
      </div>
    `
    notiContainer.append("<span>"+notifyCreate+"</span>")
    setTimeout(() => {
        $('.notification > span:last-child').remove()
    }, 5000)
}

// Reset all Nodes
function deleteAllNodes() {
    $('.spawn_point').each(function(index,element){
        $(this).remove();
    })
}

// Updating Nodes
function updateNodes(data) { 
    let nodeValues = JSON.parse(data)
        Object.keys(nodeValues).map(function(i,element){
            let createNode = `
            <div class="spawn_point" id="${nodeValues[i].cord_id}" 
            data-spawn-name="${nodeValues[i].cord_name}"
            data-spawn-description="${nodeValues[i].cord_desc}" 
            data-spawn-x-cord="${nodeValues[i].x_cord}" 
            data-spawn-y-cord="${nodeValues[i].y_cord}" 
            data-spawn-z-cord="${nodeValues[i].z_cord}" 
            data-id="${nodeValues[i].cord_id}"
            style="left:${nodeValues[i].left_value}px;top:${nodeValues[i].top_value}px;position:absolute;z-index:10">
            <div class="spawn_point_box">
                <span class="material-icons">add</span>
            </div>
            <div class="spawn_point_text">
                <div class="spawn_point_text_header">
                    ${nodeValues[i].cord_name}
                </div>
                <div class="spawn_point_text_desc">
                    ${nodeValues[i].cord_desc}
                </div>
                <div class="spawn_point_option displayGrid">
                    <div class="spawn_point_option_left" data-bs-toggle="modal" data-bs-target="#editCord"  
                    data-edit-id="${nodeValues[i].cord_id}" data-spawn-x-cord="${nodeValues[i].x_cord}"  data-spawn-y-cord="${nodeValues[i].y_cord}" data-spawn-z-cord="${nodeValues[i].z_cord}" 
                    ">
                       ${lang[language].settings}
                    </div>
                    <div class="spawn_point_option_right" data-delete-id="${nodeValues[i].cord_id}">
                        ${lang[language].delete}
                    </div>
                </div>
            </div>
        </div>
        `
        $('.jerzys_spawn_background').append(createNode)
        })
        initAnimation()
        initDrag(true)
 
}

// Creating Nodes
function createNodes(data) { 
    let nodeValues = JSON.parse(data)
        Object.keys(nodeValues).map(function(i,element){
            let createNode = `
            <div class="spawn_point" id="${nodeValues[i].cord_id}" 
            data-spawn-name="${nodeValues[i].cord_name}"
            data-spawn-description="${nodeValues[i].cord_desc}" 
            data-spawn-x-cord="${nodeValues[i].x_cord}" 
            data-spawn-y-cord="${nodeValues[i].y_cord}" 
            data-spawn-z-cord="${nodeValues[i].z_cord}" 
            data-id="${nodeValues[i].cord_id}"
            style="left:${nodeValues[i].left_value}px;top:${nodeValues[i].top_value}px;position:absolute;z-index:10">
            <div class="spawn_point_box">
                <span class="material-icons">add</span>
            </div>
            <div class="spawn_point_text">
                <div class="spawn_point_text_header">
                    ${nodeValues[i].cord_name}
                </div>
                <div class="spawn_point_text_desc">
                    ${nodeValues[i].cord_desc}
                </div>
                <div class="spawn_point_option">
                    <div class="spawn_point_option_left" data-bs-toggle="modal" data-bs-target="#editCord"  
                    data-edit-id="${nodeValues[i].cord_id}" 
                    data-spawn-x-cord="${nodeValues[i].x_cord}"
                    data-spawn-y-cord="${nodeValues[i].y_cord}"  
                    data-spawn-z-cord="${nodeValues[i].z_cord}">
                        ${lang[language].settings}
                    </div>
                    <div class="spawn_point_option_right" data-delete-id="${nodeValues[i].cord_id}">
                        ${lang[language].delete}
                    </div>
                </div>
            </div>
        </div>
        `
        $('.jerzys_spawn_background').append(createNode)
        })
        initAnimation()
        initDrag(false)
}

// Show Spawn
function showSpawn(bool) {
    if(bool) {
        $('#spawnBody').removeClass("hide")
    } else {
        $('#spawnBody').addClass("hide")
    }
}

$(document).on("click",".spawn_point_box", function() {
    removeActive('.spawn_point')
    $(this).parent().addClass('active')
    let spawnName = $(this).parent().data('spawn-name');
    let spawnBox = $('.spawn_box');
    let spawnDescription = $(this).parent().data('spawn-description');
    let xCoords = $(this).parent().data('spawn-x-cord');
    let yCoords = $(this).parent().data('spawn-y-cord');
    let zCoords = $(this).parent().data('spawn-z-cord');
    removeBox(spawnBox)
    setTimeout(() => {
        let html = `
        <div class="spawn_header">
            ${spawnName}
        </div>
        <div class="spawn_body">
           ${spawnDescription}
        </div>
        <div class="spawn_footer">
            <div class="btn_enter btn_enter_spawn" data-cord-x="${xCoords}" data-cord-y="${yCoords}" data-cord-z="${zCoords}">
                ${lang[language].spawn}
            </div>
        </div>
    `
    addIn(spawnBox)
    $('.spawn_box').html(html)
    }, 1000)
})

// Mouseover Sounds
$(document).on("mouseover", ".spawn_point_box, .btn-enter, #lastLocation, #enterHouse", function(){
    $.post('https://jerzys_spawn/hoverDotSound');
})

// On click Sound
$(document).on("click", "#addCord, #devMode, #settings, .jerzy-modal-close, .btn-jerzy", function(){
    $.post('https://jerzys_spawn/hoverDotSound');
})

// Trigger Spawn
$(document).one("click",".btn_enter_spawn", function() {
    let cordX = $(this).data('cord-x');
    let cordY = $(this).data('cord-y');
    let cordZ = $(this).data('cord-z');
    $('#enterAnimation').addClass('closeAnimation');
    setTimeout(() => {
        $.ajax({
            url:'https://jerzys_spawn/enterSpawn',
            method: 'POST',
            data: JSON.stringify({
                cordX : cordX,
                cordY : cordY,
                cordZ : cordZ,
            }),
            success: function(response) {
    
            }
        })
    },3000)
    setTimeout(() => { 
        $('#enterAnimation').removeClass('closeAnimation')
     }, 6000)
})

$(document).on("click", function(e) {
    if(e.target.classList[0] == "spawn_point" || e.target.parentElement.parentElement.classList[0] == "spawn_point" || e.target.classList[0] == "spawn_point_option_left" || e.target.classList[0] == "spawn_point_option_right" || e.target.parentElement.classList[0] == "modal-content" || e.target.parentElement.parentElement.classList[0] == "modal-content") {
    } else {
        $('.spawn_point').removeClass('active')
    }
})

// Addin Animation for Spawn
function addIn(element) {
    element.removeClass(['fadeOut','floatY'])
    element.addClass(['fadeIn','floatY'])
    setTimeout(() => {
        element.removeClass('fadeIn')
    },1500)
}

// Remove Element for Spawn
function removeBox(element) {
    element.addClass(['fadeOut','floatY'])
}

// Loop through every element, remove the active class
function removeActive(element) {
    $(element).each(function(){
        $(this).removeClass('active')
    })
}

// Settings 
$('#devMode').on("click", function() {
    if($(this).hasClass('activeSettings')) {
        $(this).removeClass('activeSettings')
        $(this).css('right','20px')
        $('.spawn_point').removeClass('point_drag')
        showSettings(true)
        initDrag(false)
    } else {
        $(this).addClass('activeSettings')
        $(this).css('right','100px')
        $('.spawn_point').addClass('point_drag')
        showSettings(false)
        initDrag(true)
    }
})

function disableDev() {
    $('#devMode').removeClass('activeSettings')
    $('#devMode').css('right','20px')
    $('.spawn_point').removeClass('point_drag')
    showSettings(true)
    initDrag(false)
}

// initDrag
function initDrag(bool) {
    $( ".spawn_point" ).draggable({ disabled: true });
    $('.jerzys_spawn_background').droppable({
        drop: function (event,ui) {
           let updateId = ui.draggable[0].getAttribute("data-id")
           let left_value = ui.offset.left;
           let top_value = ui.offset.top;
           $.ajax({
               url: 'https://jerzys_spawn/updateCords',
               type: 'POST',
               dataType: "json",
               data: JSON.stringify({
                   id : updateId,
                   left_value : left_value,
                   top_value: top_value,
                }),
               success: function(response) {
            }
           })
        }
    })
    if(bool) {
        $( ".spawn_point" ).draggable({ disabled: false });
    } else {
        $( ".spawn_point" ).draggable({ disabled: true });
    }
}

// Settings Show Functions
function showSettings(bool) {
    if(bool) {
        $('#addCord').removeClass('displayShow')
        $('#settings').removeClass('displayShow')
        $('.spawn_point_option').removeClass('displayGrid')
    } else {
        $('#addCord').addClass('displayShow')
        $('#settings').addClass('displayShow')
        $('.spawn_point_option').addClass('displayGrid')
    }
}

// GSAP Animation for Spawn Boxes
function initAnimation() {
    let spawn  = gsap.timeline({scrollTrigger: '#jerzys_spawn'})
    spawn.from(".spawn_point", {
        ease: Power1.easeInOut,
        y: 40,
        opacity:0, 
        duration: 0.3,
        stagger: {
            each: 0.3,
        }
    })
    spawn.from(".logo",{
        ease: Power1.easeInOut,
        y: 500,
        opacity:0,
        duration:1.1,
    }, "=-1")
}
// Create new Coord
$(document).on("click",".createAdd", function() {
    let cordName = $('#create_cord_name').val();
    let cordDesc = $('#create_cord_description').val();
    let left = 1747
    let top = 22
    let x_cord = $('#x_cord').val();
    let y_cord = $('#y_cord').val();
    let z_cord = $('#z_cord').val();
    $.ajax({
        url: 'https://jerzys_spawn/generateNode',
        type: 'POST',
        dataType: "json",
        data: 
            JSON.stringify({
                cordName : cordName,
                cordDesc : cordDesc,
                left_value: left,
                top_value: top,
                x_cord: x_cord,
                y_cord: y_cord,
                z_cord: z_cord
            })
        ,
        success: function(response) {
        },
    })
})

$(document).on("click", ".spawn_point_option_left", function() {
    let getData = $(this).data('edit-id');
    let cordName =  $('#'+getData).data('spawn-name');
    let cordDesc = $('#'+getData).data('spawn-description')
    let xCoords =  $('#'+getData).data('spawn-x-cord');
    let yCoords =  $('#'+getData).data('spawn-y-cord');
    let zCoords =  $('#'+getData).data('spawn-z-cord');
    $('#editCordTitle').html(cordName)
    $('#edit_cord_desc').val(cordDesc);
    $('#edit_cord_name').val(cordName)
    $('#x_cord_edit').val(xCoords)
    $('#y_cord_edit').val(yCoords )
    $('#z_cord_edit').val(zCoords)
    $('.saveBtn').data('save-id', getData)
})

$(document).on("click", ".spawn_point_option_right", function(){
    let deleteId = $(this).data('delete-id');
    $.ajax({
        url: 'https://jerzys_spawn/deleteNode',
        type: 'POST',
        data: JSON.stringify({
            id : deleteId
        }),
        success: function(response) {
        }
    })
})

$(document).one("click", ".saveBtn", function() {
    let getData = $(this).data('save-id')
    let cordName =  $('#edit_cord_name').val()
    let cordDesc = $('#edit_cord_desc').val()
    let x_cord = $('#x_cord_edit').val();
    let y_cord = $('#y_cord_edit').val();
    let z_cord = $('#z_cord_edit').val();
    $.ajax({
        url:'https://jerzys_spawn/saveEdit',
        type: 'POST',
        data: JSON.stringify({
            id : getData,
            cordName : cordName,
            cordDesc : cordDesc,
            x_cord: x_cord,
            y_cord: y_cord,
            z_cord: z_cord
        }),
        beforeSend: function () {

        },
        success: function(response) {
        }
    })
})

$('#addCord').on("click", function(){
    clearCreate()
})

function clearCreate() {
    $('#create_cord_name').val("");
    $('#create_cord_description').val("");
    $('#v3_cord').val("")
}

function reloadDots() {
    $('.spawn_point').each(function() {
        $(this).addClass('point_drag')
    })     
    $( ".spawn_point" ).draggable({ disabled: false });
}
$(document).one("click", "#closeUi", function(){
    disableDev()
    $.post('https://jerzys_spawn/closeUi', JSON.stringify({}))
})
// BOOTSTRAP
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl)
})

$(document).one('click', '.setupApps', function(evt){
    evt.preventDefault();
    var location = $('#apartment').val();
    var spawnType = "appartment"
    if (spawnType == "appartment") {
        $.post('https://jerzys_spawn/getApartment', JSON.stringify({
            appType: location,
        }));
    }
});

$(document).one('click', '#enterLastLocation', function(evt){
    $('#enterAnimation').addClass('closeAnimation');
    setTimeout(() => { 
        $.post('https://jerzys_spawn/lastLocation', JSON.stringify({}))
    }, 3000)
    setTimeout(() => { 
       $('#enterAnimation').removeClass('closeAnimation')
    }, 6000)
});


$(document).on("click", ".spawn_aparments", function(){
    $('#enterAnimation').addClass('closeAnimation');
    let apartment = $('#apartmentAccount').val()
    let apartmentType = $('#apartmentAccount').find(':selected').attr('data-type')
    setTimeout(() => { 
        $.post('https://jerzys_spawn/spawnApartment', JSON.stringify({apartment,apartmentType}))
    }, 3000)
    setTimeout(() => { 
       $('#enterAnimation').removeClass('closeAnimation')
    }, 6000)
})


// Setup Appartements
function setupApps(apps) {
    showChooseApp(true)
    $('.spawn_box').addClass('showInactive')
    $('.lastLocation').addClass('showInactive')
    $('#chooseApartmentAccount').addClass('showInactive')
    $('.spawn_point').each(function(){
        $(this).addClass('showInactive')
    })
    var parent = $('#apartment')
    $.each(apps, function(index, app){
        $(parent).append(`<option value="${app.name}">${app.label}</option>`)
    });
    $('#enterHouse').addClass('setupApps')
    $('#lastLocation').addClass('showInactive')
}

function showChooseApp(bool){
    if(bool) {
        $('#chooseApartment').addClass('displayShow')
        $('#enterHouse').addClass('showActive')
    } else {
        $('#chooseApartment').hide()
        $('#enterHouse').hide()
    }
}