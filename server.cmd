@echo off
REM 阿里云服务器快速管理脚本
REM 使用方法: server.cmd [命令]

set SERVER=47.77.180.76
set USER=root

if "%1"=="" (
    echo === 阿里云服务器快速管理 ===
    echo.
    echo 可用命令:
    echo   status  - 检查服务器状态
    echo   web     - 启动 Web 服务器
    echo   stop    - 停止 Web 服务器
    echo   ls      - 列出 Web 目录
    echo   logs    - 查看 Web 日志
    echo   shell   - 打开 SSH Shell
    echo.
    goto :end
)

if "%1"=="status" (
    echo === 服务器进程状态 ===
    ssh %USER%@%SERVER% "ps aux | grep http.server | grep -v grep"
    echo.
    echo === 端口 80 监听状态 ===
    ssh %USER%@%SERVER% "netstat -tlnp | grep :80"
    goto :end
)

if "%1"=="web" (
    echo === 启动 Web 服务器 ===
    ssh %USER%@%SERVER% "pkill -f http.server 2^>/dev/null"
    ssh %USER%@%SERVER% "cd /var/www/html ^&^& nohup python3 -m http.server 80 ^>^> /tmp/web.log 2^>^&1 ^&"
    echo Web 服务器已启动
    echo 访问地址: http://%SERVER%/
    goto :end
)

if "%1"=="stop" (
    echo === 停止 Web 服务器 ===
    ssh %USER%@%SERVER% "pkill -f http.server"
    echo Web 服务器已停止
    goto :end
)

if "%1"=="ls" (
    echo === Web 目录内容 ===
    ssh %USER%@%SERVER% "ls -la /var/www/html/"
    goto :end
)

if "%1"=="logs" (
    echo === Web 服务器日志 ===
    ssh %USER%@%SERVER% "tail -20 /tmp/web.log"
    goto :end
)

if "%1"=="shell" (
    ssh %USER%@%SERVER%
    goto :end
)

echo 执行命令: %*
ssh %USER%@%SERVER% "%*"

:end
