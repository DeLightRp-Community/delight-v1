set /a Index=1

setlocal enabledelayedexpansion

for /r %%i in (*.png) do ( 
    rename "%%i" "!Index!.png"
    set /a Index+=1
)