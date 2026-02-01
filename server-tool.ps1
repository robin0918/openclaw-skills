# 阿里云服务器管理工具
# 需要 Posh-SSH 模块

param(
    [Parameter(Position=0)]
    [string]$Command = ""
)

$Server = "47.77.180.76"
$User = "root"
$Password = ConvertTo-SecureString "Xigua918" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($User, $Password)

# 检查 Posh-SSH 模块
if (-not (Get-Module -ListAvailable -Name Posh-SSH)) {
    Write-Host "正在安装 Posh-SSH 模块..." -ForegroundColor Yellow
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope CurrentUser
    Install-Module -Name Posh-SSH -Force -Scope CurrentUser
}

# 连接到服务器
$Session = New-SSHSession -ComputerName $Server -Credential $Credential -AcceptKey

if ($Command -eq "") {
    Write-Host "=== 阿里云服务器管理工具 ===" -ForegroundColor Green
    Write-Host ""
    Write-Host "可用命令:" -ForegroundColor Cyan
    Write-Host "  status  - 检查服务器状态"
    Write-Host "  web     - 启动 Web 服务器"
    Write-Host "  stop    - 停止 Web 服务器"
    Write-Host "  ls      - 列出 Web 目录"
    Write-Host "  logs    - 查看 Web 日志"
    Write-Host "  upload  - 上传文件到服务器"
    Write-Host ""
} elseif ($Command -eq "status") {
    Write-Host "=== 服务器进程状态 ===" -ForegroundColor Green
    Invoke-SSHCommand -SessionId $Session.SessionId -Command "ps aux | grep http.server | grep -v grep"
    Write-Host ""
    Write-Host "=== 端口 80 监听状态 ===" -ForegroundColor Green
    Invoke-SSHCommand -SessionId $Session.SessionId -Command "netstat -tlnp | grep :80"
} elseif ($Command -eq "web") {
    Write-Host "=== 启动 Web 服务器 ===" -ForegroundColor Green
    Invoke-SSHCommand -SessionId $Session.SessionId -Command "pkill -f http.server 2>/dev/null"
    Invoke-SSHCommand -SessionId $Session.SessionId -Command "cd /var/www/html && nohup python3 -m http.server 80 >> /tmp/web.log 2>&1 &"
    Write-Host "Web 服务器已启动" -ForegroundColor Yellow
    Write-Host "访问地址: http://$Server/" -ForegroundColor Cyan
} elseif ($Command -eq "stop") {
    Write-Host "=== 停止 Web 服务器 ===" -ForegroundColor Green
    Invoke-SSHCommand -SessionId $Session.SessionId -Command "pkill -f http.server"
    Write-Host "Web 服务器已停止" -ForegroundColor Yellow
} elseif ($Command -eq "ls") {
    Write-Host "=== Web 目录内容 ===" -ForegroundColor Green
    Invoke-SSHCommand -SessionId $Session.SessionId -Command "ls -la /var/www/html/"
} elseif ($Command -eq "logs") {
    Write-Host "=== Web 服务器日志 ===" -ForegroundColor Green
    Invoke-SSHCommand -SessionId $Session.SessionId -Command "tail -20 /tmp/web.log"
} elseif ($Command -eq "upload") {
    Write-Host "=== 上传文件 ===" -ForegroundColor Green
    $localFile = Read-Host "输入本地文件路径"
    $remotePath = Read-Host "输入远程路径 (默认: /var/www/html/)"
    if ([string]::IsNullOrWhiteSpace($remotePath)) { $remotePath = "/var/www/html/" }
    Set-SCPFile -LocalFile $localFile -RemotePath $remotePath -ComputerName $Server -Credential $Credential -AcceptKey
    Write-Host "文件上传完成" -ForegroundColor Green
} else {
    Write-Host "执行命令: $Command" -ForegroundColor Green
    Invoke-SSHCommand -SessionId $Session.SessionId -Command $Command
}

Remove-SSHSession -SessionId $Session.SessionId
