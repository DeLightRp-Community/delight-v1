

-- records created by AmirTech
Config.DoorList['records-records'] = {
    doorRate = 1.0,
    doorType = 'door',
    distance = 2,
    doorLabel = 'recordsroom',
    fixText = false,
    objCoords = vec3(-822.034485, -715.693359, 32.486649),
    authorizedJobs = { ['records'] = 0 },
    objName = 693644064,
    objYaw = 0.0,
    locked = true,
}

-- staircase created by AmirTech
Config.DoorList['records-staircase'] = {
    doorRate = 1.0,
    doorType = 'door',
    distance = 2,
    doorLabel = 'staircase',
    fixText = false,
    objCoords = vec3(-819.499084, -711.912415, 28.205597),
    authorizedJobs = { ['records'] = 0 },
    objName = 693644064,
    objYaw = 270.00003051758,
    locked = true,
}

-- elevatior created by AmirTech
Config.DoorList['records-elevatior'] = {
    doorRate = 1.0,
    doorType = 'doublesliding',
    distance = 2,
    doors = {
        {objName = 1396002225, objYaw = 269.99932861328, objCoords = vec3(-819.527710, -704.463623, 27.064535)},
        {objName = 1396002225, objYaw = 90.015060424805, objCoords = vec3(-819.548401, -706.487793, 27.052980)}
    },
    doorLabel = 'elevator',
    locked = true,
    authorizedJobs = { ['records'] = 0 },
}