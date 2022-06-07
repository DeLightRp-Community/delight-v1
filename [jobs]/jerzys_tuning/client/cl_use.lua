-- Function Sending Mail
RegisterNetEvent('jerzys_tuning:client:sendMail', function (price, title, name, cid, locationName, vehiclePlate,tuner, percentage)
    local data = {}
    data = {ammount = price, citizenid = cid, location = locationName, plate = vehiclePlate, tuner = tuner, percentage = percentage}
    TriggerServerEvent('qb-phone:server:sendNewMail', {
    sender = name,
    subject = title,
    message = string.format([[
        %s Amount: %s $ <br>You can accept and decline by using the buttons on the bottom <br>
        ]],title,price),
    button = {
        enabled = true,
        buttonEvent = 'jerzys_tuning:client:confirm',
        buttonData = data
        }
    })
end)