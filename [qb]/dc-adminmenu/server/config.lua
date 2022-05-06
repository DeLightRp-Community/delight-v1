--- If this is somehow something else besides interact-sound. Please so change the name of the event that
--- is triggered when using the play sound option in the menu.
SoundScriptName = 'interact-sound' -- Name of the sound script that you are using
SoundPath = '/client/html/sounds' -- Where the sounds are located
Linux = false -- Wheter or not if you use linux. Very important!

--- Who should be able to trigger each NetEvent on the server side?
events = {
    ['kill'] = 'adminmenu.god',
    ['revive'] = 'adminmenu.god',
    ['freeze'] = 'adminmenu.admin',
    ['spectate'] = 'adminmenu.admin',
    ['goto'] = 'adminmenu.admin',
    ['bring'] = 'adminmenu.admin',
    ['intovehicle'] = 'adminmenu.admin',
    ['kick'] = 'adminmenu.admin',
    ['ban'] = 'adminmenu.god',
    ['setPermissions'] = 'adminmenu.god',
    ['cloth'] = 'adminmenu.admin',
    ['spawnVehicle'] = 'adminmenu.admin',
    ['savecar'] = 'adminmenu.god',
    ['playsound'] = 'adminmenu.admin',
    ['usemenu'] = 'adminmenu.admin',
    ['routingbucket'] = 'adminmenu.admin',
    ['getradiolist'] = 'adminmenu.admin',
}

--- Permission hierarchy order from top to bottom. Important for the PermOrder function.
PermissionOrder = {
    'adminmenu.god',
    'adminmenu.admin',
}

--- Changes the behaviour of the PermOrder function. If set to true it means you still use the database permission system.
OldPermissionSystem = false
