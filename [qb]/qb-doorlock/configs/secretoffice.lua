

-- garage created by Mosayeb
Config.DoorList['secretoffice-garage'] = {
    objCoords = vec3(577.874390, -2804.135986, 7.084586),
    fixText = false,
    doorType = 'garage',
    doorLabel = 'garage',
    distance = 5,
    objYaw = 59.000011444092,
    objName = 531616259,
    locked = true,
    hideLabel = true,
    authorizedGangs = { ['mof'] = 0 }, -- Gang access (checks for a minimum grade of 0)
    doorRate = 1.0,
}

-- doubledoor created by Mosayeb
Config.DoorList['secretoffice-doubledoor'] = {
    hideLabel = true,
    doors = {
        {objName = 2059796542, objYaw = 239.0, objCoords = vec3(563.549012, -2792.628418, 6.437998)},
        {objName = -1854394974, objYaw = 239.0, objCoords = vec3(562.660828, -2794.104736, 6.440020)}
    },
    authorizedGangs = { ['mof'] = 0 }, -- Gang access (checks for a minimum grade of 0)
    locked = true,
    doorType = 'double',
    doorLabel = 'double door',
    doorRate = 1.0,
    distance = 2,
}

-- singledoor created by Mosayeb
Config.DoorList['secretoffice-singledoor'] = {
    doorLabel = 'singledoor',
    authorizedGangs = { ['mof'] = 0 }, -- Gang access (checks for a minimum grade of 0)
    locked = true,
    doorRate = 1.0,
    hideLabel = true,
    objYaw = 239.0,
    objCoords = vec3(552.021362, -2787.322998, 6.248070),
    doorType = 'door',
    objName = -88942360,
    fixText = false,
    distance = 2,
}

-- guninventory created by Mosayeb
Config.DoorList['secretoffice-guninventory'] = {
    doorLabel = 'guninventory',
    authorizedGangs = { ['mof'] = 0 }, -- Gang access (checks for a minimum grade of 0)
    locked = true,
    doorRate = 1.0,
    hideLabel = true,
    objYaw = 224.0001373291,
    objCoords = vec3(541.615418, -2783.608642, 6.129850),
    doorType = 'door',
    objName = -992144277,
    fixText = false,
    distance = 2,
}