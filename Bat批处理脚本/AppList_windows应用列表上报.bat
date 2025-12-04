@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

echo 右键 管理员身份运行次bat文件;
echo 如有多台设备,输入姓名时后面加上数字,标识第几台;
echo 如: 张三3,表示张三的第三台设备;

:: 获取用户姓名
set /p "userName=请输入您的真实姓名: "
if "!userName!"=="" (
    echo 姓名不能为空！
    pause
    exit /b 1
)

echo 正在获取已安装的软件列表（这可能需要一点时间）...
echo 软件信息已经获取 正在构建json（内存中构建）...

:: 构建 APP_LIST（内存 JSON 数组）
set "APP_LIST=["
set "firstEntry=true"
set "currentName="
set "currentVersion="

:: 处理 64 位注册表的输出
for /f "tokens=1,2,*" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s 2^>nul ^| findstr /i /c:"DisplayName" /c:"DisplayVersion"') do (
    if "%%A"=="DisplayName" (
        set "currentName=%%C"
    ) else if "%%A"=="DisplayVersion" (
        set "currentVersion=%%C"
        if defined currentName (
            if not "!currentName!"=="" (
                if "!firstEntry!"=="true" (
                    set "firstEntry=false"
                ) else (
                    set "APP_LIST=!APP_LIST!,"
                )
                set "APP_LIST=!APP_LIST!{\"name\":\"!currentName!\",\"version\":\"!currentVersion!\"}"
            )
            set "currentName="
            set "currentVersion="
        )
    )
)

:: 处理 32 位注册表（WOW6432Node）
if exist "%SystemRoot%\SysWOW64" (
    for /f "tokens=1,2,*" %%A in ('reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s 2^>nul ^| findstr /i /c:"DisplayName" /c:"DisplayVersion"') do (
        if "%%A"=="DisplayName" (
            set "currentName=%%C"
        ) else if "%%A"=="DisplayVersion" (
            set "currentVersion=%%C"
            if defined currentName (
                if not "!currentName!"=="" (
                    if "!firstEntry!"=="true" (
                        set "firstEntry=false"
                    ) else (
                        set "APP_LIST=!APP_LIST!,"
                    )
                    set "APP_LIST=!APP_LIST!{\"name\":\"!currentName!\",\"version\":\"!currentVersion!\"}"
                )
                set "currentName="
                set "currentVersion="
            )
        )
    )
)

:: 处理空列表
if "!firstEntry!"=="true" (
    set "APP_LIST=[]"
) else (
    set "APP_LIST=!APP_LIST!]"
)

echo 数据准备完毕
echo.

:: 构建接口请求数据
set "API_URL=http://172.24.24.101:8000/app_list/upload"
set "API_DATA={\"name\":\"!userName!\",\"list\":!APP_LIST!}"

:: 使用 curl 提交数据（直接用内存数据，不用临时文件）
where curl >nul 2>nul
if %errorlevel% equ 0 (
    
    REM 创建临时批处理来执行 curl，避免特殊字符问题
    set "TMP_CMD=%TEMP%\curl_cmd_%RANDOM%.bat"
    (
        echo @echo off
        echo setlocal enabledelayedexpansion
        echo curl -i -X POST ^
        echo   -H "Content-Type: application/json" ^
        echo   -d "!API_DATA!" ^
        echo   "!API_URL!"
    ) > "!TMP_CMD!"
    
    call "!TMP_CMD!"
    
    del /f /q "!TMP_CMD!"
    
    echo.
    echo 提交完成！
) else (
    echo 检测到系统没有 curl，正在使用 PowerShell 提交...
    echo.
    
    powershell -NoProfile -Command ^
        "$API_URL = '!API_URL!'; $API_DATA = '!API_DATA!'; Write-Host '提交数据:'; Write-Host $API_DATA; Write-Host ''; try { $r = Invoke-WebRequest -Uri $API_URL -Method Post -Body $API_DATA -ContentType 'application/json' -UseBasicParsing; Write-Host '状态码:' $r.StatusCode; Write-Host '响应体:'; Write-Host $r.Content } catch { Write-Host '提交失败:' $_.Exception.Message }"
)

:: 删除临时文件（如果存在）
if exist "%TEMP%\softlist_*.json" del /f /q "%TEMP%\softlist_*.json" >nul 2>nul

echo.
pause