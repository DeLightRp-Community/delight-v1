// [ SIDEBAR ] \\

AdminMenu.LoadCategory = function(Category) {
    if (Category == 'Actions') {
        AdminMenu.LoadItems();
    } else if (Category == 'PlayerList') {
        AdminMenu.LoadPlayerList();
    } else if (Category == 'RecentBans') {

    } else if (Category == 'PlayerLogs') {

    } else if (Category == 'Options') {

    }
}

AdminMenu.SidebarAction = function(Action, Element) {
    if (Action == 'DevMode') {
        if ($(Element).hasClass('enabled')) {
            $(Element).removeClass('enabled')
            $.post(`https://${GetParentResourceName()}/Admin/DevMode`, JSON.stringify({
                Toggle: false,
            }));
        } else {
            $(Element).addClass('enabled')
            $.post(`https://${GetParentResourceName()}/Admin/DevMode`, JSON.stringify({
                Toggle: true,
            }));
        }
    } else if (Action == 'PinnedTargets') {
        if ($('.menu-pinned-players').is(':visible')) {
            $('.menu-pinned-players').fadeOut(150);
        } else {
            $('.menu-pinned-players').fadeIn(150);
        }
    } else if (Action == 'ToggleMenu') {
        AdminMenu.Close();
    }
}

// [ CLICKS ] \\
let Timeout = false;
$(document).on('click', ".menu-sidebar-action", function (e) {
    e.preventDefault();

    let NewSidebarCat = $(this);
    let OldSidebarCat = $(this).attr('data-Action');
    if (AdminMenu.Sidebar.Selected != OldSidebarCat && !Timeout) {
        Timeout = true;
        setTimeout(() => {
            Timeout = false;
        }, 300);
        if (NewSidebarCat.hasClass('lower')) {
            AdminMenu.SidebarAction(OldSidebarCat, NewSidebarCat)
        } else {
            let PreviousSidebarCat = $(`[data-Action="${AdminMenu.Sidebar.Selected}"]`);

            AdminMenu.LoadCategory(OldSidebarCat);
            // DebugMessage(`Changing Sidebar Category: ${AdminMenu.Sidebar.Selected} -> ${OldSidebarCat}`)
            
            $(PreviousSidebarCat).removeClass('selected');
            $(NewSidebarCat).addClass('selected');
    
            $(`[data-Page="${AdminMenu.Sidebar.Selected}"`).fadeOut(150);
            $(`[data-Page="${OldSidebarCat}"`).fadeIn(150);
    
            setTimeout(function(){ AdminMenu.Sidebar.Selected = OldSidebarCat; }, 200);
        }
    }
});