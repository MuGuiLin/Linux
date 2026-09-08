@echo off
chcp 65001 >nul
echo 正在检测当前 Python 架构（32[x86]、64）...

python -c "import struct; print(struct.calcsize('P') * 8)"

pause