@echo off

setlocal

set "CCUBE_PATH=D:\aig-ccube-ipad\aig-ccube-ipad"

@REM set "CCUBE_PATH=D:\Gitlab\Test\aig-ccube-ipad"

endlocal

cd /d "D:\aig-ccube-ipad\aig-ccube-ipad"

@REM cd /d "D:\Gitlab\Test\aig-ccube-ipad"

npm run dev

@REM start node.js

IF EXIST "%CCUBE_PATH%" (

    @REM start "%CCUBE_PATH%"

    @REM npm run dev

    echo Successfully started!

    explorer.exe "http://localhost:666/ipad/"

) ELSE (

    echo Dir does not exist!
)

pause
