AdminMenu = {}
Coords = {}

AdminMenu.Action = {}
AdminMenu.Category = {}
AdminMenu.Sidebar = {}
AdminMenu.PlayerList = {}

AdminMenu.DebugEnabled = true
AdminMenu.Opened = false;
AdminMenu.IsGeneratingDropdown = false;

AdminMenu.Action.SelectedCat = null;
AdminMenu.Action.Selected = "All";
AdminMenu.Sidebar.Selected = "Actions";
AdminMenu.Sidebar.Size = "Small";

AdminMenu.FavoritedItems = {};
AdminMenu.PinnedTargets = {};
AdminMenu.EnabledItems = {};
AdminMenu.Settings = {};

AdminMenu.Players = null;
AdminMenu.Items = null;
AdminMenu.CurrentTarget = null;

AdminMenu.Update = function(Data) {
    DebugMessage(`Menu Updating`);
    AdminMenu.FavoritedItems = Data.Favorited;
    AdminMenu.PinnedTargets = Data.PinnedPlayers;
    AdminMenu.Settings = Data.MenuSettings;
    AdminMenu.Players = Data.AllPlayers
    AdminMenu.Items = Data.AdminItems
    AdminMenu.LoadItems();
}
 
AdminMenu.Open = function(Data) {
    DebugMessage(`Menu Opening`);
    AdminMenu.DebugEnabled = Data.Debug;
    AdminMenu.FavoritedItems = Data.Favorited;
    AdminMenu.PinnedTargets = Data.PinnedPlayers;
    AdminMenu.Settings = Data.MenuSettings;
    $('.menu-main-container').css('pointer-events', 'auto');
    $('.menu-main-container').fadeIn(450, function() {
        $('.menu-page-actions-search input').focus();
        if (AdminMenu.Items == null && AdminMenu.Players == null) {
            AdminMenu.Players = Data.AllPlayers
            AdminMenu.Items = Data.AdminItems
            if (AdminMenu.Sidebar.Selected == 'Actions') {
                $('.menu-pages').find(`[data-Page="${AdminMenu.Sidebar.Selected}"`).fadeIn(150);
                AdminMenu.LoadItems();
            }
        };
        AdminMenu.Players = Data.AllPlayers
        AdminMenu.Opened = true;
    });
}


AdminMenu.Close = function() {
    DebugMessage(`Menu Closing`);
    AdminMenu.ClearDropdown();
    $.post(`https://${GetParentResourceName()}/Admin/Close`);
    $('.menu-main-container').css('pointer-events', 'none');
    $('.menu-main-container').fadeOut(150, function() {
        AdminMenu.Opened = false; 
    });
}

AdminMenu.ChangeSize = function() {
    if (AdminMenu.Sidebar.Size == 'Small') {
        $('.menu-size-change').html('<i class="fas fa-chevron-right"></i>');
        AdminMenu.Sidebar.Size = 'Large';
        $('.menu-main-container').css({
            width: 50+"%",
            right: 25+"%",
        });
    } else {
        $('.menu-size-change').html('<i class="fas fa-chevron-left"></i>');
        AdminMenu.Sidebar.Size = 'Small';
        $('.menu-main-container').css({
            width: 24.24+"%",
            right: 3+"%",
        });
    }
}

Coords.Copy = function(Data) {
    let TextArea = document.createElement('textarea');
    let Selection = document.getSelection();
    TextArea.textContent = Data.Coords;
    document.body.appendChild(TextArea);
    Selection.removeAllRanges();
    TextArea.select();
    document.execCommand('copy');
    Selection.removeAllRanges();
    document.body.removeChild(TextArea);
}

// [ CLICKS ] \\

$(document).on('click', '.menu-size-change', function(e) {
    e.preventDefault();
    AdminMenu.ChangeSize()
});

$(document).on('click', '.menu-current-target', function(e){
    $(this).parent().find('.ui-styles-input').each(function(Elem, Obj){
        if ($(this).find('input').data("PlayerId")) {
            if (AdminMenu.CurrentTarget != null) {
                if ($('.admin-menu-item').find('.admin-menu-items-option-input').first().find('.ui-input-label').text() == 'Player') {
                    $(this).find('input').data("PlayerId", null)
                    $(this).find('input').val(" ");
                }
            }
        }
    });
    $('.admin-menu-items').animate({
        'max-height': 72.6+'vh',
    }, 100);
    $('.menu-current-target').fadeOut(150);
    AdminMenu.CurrentTarget = null;
});

// [ FUNCTIONS ] \\

DebugMessage = function(Message) {
    if (AdminMenu.DebugEnabled) {
        console.log(`[DEBUG]: ${Message}`);
    }
}

// [ LISTENER ] \\

document.addEventListener('DOMContentLoaded', (event) => {
    DebugMessage(`Menu Initialised`)
    AdminMenu.Action.SelectedCat = $('.menu-page-action-header-categories').find('.active');
    window.addEventListener('message', function(event){
        let Action = event.data.Action;
        let Data = event.data
        switch(Action) {
            case "Open":
                AdminMenu.Open(Data);
                break;
            case "Close":
                if (!AdminMenu.Opened) return;
                AdminMenu.Close();
                break;
            case "Update":
                if (!AdminMenu.Opened) return;
                AdminMenu.Update(Data);
                break;
            case "SetItemEnabled":
                AdminMenu.EnabledItems[Data.Name] = Data.State;
                Data.State ? $(`#admin-option-${Data.Name}`).addClass('enabled') : $(`#admin-option-${Data.Name}`).removeClass('enabled');
                break;
            case 'copyCoords':
                Coords.Copy(event.data);
                break;
        }
    });
});

$(document).on({
    keydown: function(e) {
        if (e.keyCode == 27 && AdminMenu.Opened) {
            AdminMenu.Close();
        }
    },
});