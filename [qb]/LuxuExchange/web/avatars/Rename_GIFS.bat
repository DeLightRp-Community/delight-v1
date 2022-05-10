set /a Index=1

setlocal enabledelayedexpansion

for /r %%i in (*.gif) do ( 
    rename "%%i" "!Index!.gif"
    set /a Index+=1
)