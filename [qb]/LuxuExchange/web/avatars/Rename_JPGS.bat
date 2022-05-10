set /a Index=1

setlocal enabledelayedexpansion

for /r %%i in (*.jpg) do ( 
    rename "%%i" "!Index!.jpg"
    set /a Index+=1
)