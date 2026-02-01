# 阿里云服务器管理脚本
# 使用方法：.\ssh-server.ps1 [命令]

$Server = "47.77.180.76"
$User = "root"

function Run-SSH {
    param([string]$Command)
    ssh $User@$Server $Command
}

if ($args.Count -eq 0) {
    Write-Host "=== 阿里云服务器管理脚本 ===" -ForegroundColor Green
    Write-Host ""
    Write-Host "可用命令:" -ForegroundColor Cyan
    Write-Host "  status  - 检查服务器状态"
    Write-Host "  web     - 启动 Web 服务器"
    Write-Host "  stop    - 停止 Web 服务器"
    Write-Host "  ls      - 列出 Web 目录"
    Write-Host "  shell   - 打开 SSH Shell"
    Write-Host ""
} elseif ($args[0] -eq "status") {
    Write-Host "=== 服务器状态 ===" -ForegroundColor Green
    Run-SSH "ps aux | grep -E 'http.server|python' | grep -v grep"
    Write-Host ""
    Write-Host "=== 端口 80 监听状态 ===" -ForegroundColor Green
    Run-SSH "netstat -tlnp 2>/dev/null | grep ':80'"
} elseif ($args[0] -eq "web") {
    Write-Host "=== 启动 Web 服务器 ===" -ForegroundColor Green
    Run-SSH "pkill -f http.server 2>/dev/null"
    Run-SSH "cd /var/www/html && nohup python3 -m http.server 80 >> /tmp/web.log 2>&1 &"
    Start-Sleep -Seconds 2
    Write-Host "Web 服务器已启动" -ForegroundColor Yellow
    Write-Host "访问地址: http://47.77.180.76/" -ForegroundColor Cyan
} elseif ($args[0] -eq "stop") {
    Write-Host "=== 停止 Web 服务器 ===" -ForegroundColor Green
    Run-SSH "pkill -f http.server"
    Write-Host "Web 服务器已停止" -ForegroundColor Yellow
} elseif ($args[0] -eq "ls") {
    Write-Host "=== Web 目录内容 ===" -ForegroundColor Green
    Run-SSH "ls -la /var/www/html/"
} elseif ($args[0] -eq "shell") {
    ssh root@47.77.180.76
} else {
    Write-Host "执行命令: $args" -ForegroundColor Green
    Run-SSH ($args -join ' ')
}
