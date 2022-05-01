[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/N4N05X1G8)

># **QBCore | aj-camera**

This is a fork of the ESX Resource [kim-camera](https://github.com/quimalborch/kim-camera/) all rights go to them. I only took the resource, made it work out of the box with QBCore. Along with some other changes such as some keys are different, different animations and the ability to destroy cameras so people can no longer look through them. Along with some UI I *borrowed* from qb-houses

>## **Features**

* Add the cameras where ever.
* Maximum signal distance from the camera
* Switch from camera to camera easily
* Move the camera 360 degrees horizontally and 50 degrees vertically
* Place the cameras quickly
* Low resmon (0.00ms), (0.02ms in use)
* If you focus somewhere, the prop will focus to the spot, so players not on camera can see where the player on the camera is looking
* Synchronize the movement of the camera when you turn the direction with other users
* Being able to zoom and unzoom in the camera
* Ability to shoot and destroy cameras so players cannot use them anymore

>## **Installation**
#### Add this so your `qb-core/shared/items.lua`
```lua
['camera'] = {
        ['name'] = 'camera',
        ['label'] = 'CCTV Camera',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'camera.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A CCTV Camera... wonder what you can do with this'
    },
```
#### After placing cameras down, look through them with the `/cameras` command
