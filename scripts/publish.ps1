# 把随笔推送到线上
#
# 由仓库根目录的「发布上线.bat」调用。
# 只提交 src/content/posts（也就是你的文章），不会误提交别的东西。

$ErrorActionPreference = 'Continue'
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
[Console]::InputEncoding  = [System.Text.UTF8Encoding]::new($false)

$repo = Split-Path $PSScriptRoot -Parent
Set-Location $repo

Write-Host ""
Write-Host "==========  发布上线  ==========" -ForegroundColor Cyan
Write-Host ""

$changed = git status --porcelain -- src/content/posts
if ([string]::IsNullOrWhiteSpace($changed)) {
	Write-Host "没有发现文章的改动。" -ForegroundColor Yellow
	Write-Host "（要先双击「写新随笔.bat」建文章，或者手动改过 src\content\posts 里的文件）"
	exit 0
}

Write-Host "将要发布的改动：" -ForegroundColor Cyan
git status --short -- src/content/posts | ForEach-Object { "    $_" }
Write-Host ""

$msg = Read-Host "提交说明（直接回车 = 用默认说明）"
if ([string]::IsNullOrWhiteSpace($msg)) {
	$msg = "content: 更新随笔 " + (Get-Date -Format 'yyyy-MM-dd HH:mm')
}

git add src/content/posts
git commit -m $msg
if ($LASTEXITCODE -ne 0) {
	Write-Host ""
	Write-Host "提交失败，改动还在本地，没有丢。" -ForegroundColor Red
	exit 1
}

Write-Host ""
Write-Host "正在推送到 GitHub..." -ForegroundColor Cyan
git push origin master
if ($LASTEXITCODE -ne 0) {
	Write-Host ""
	Write-Host "推送失败。改动已经提交在本地，网络恢复后再运行一次这个脚本即可。" -ForegroundColor Red
	Write-Host "如果提示要登录，按提示完成一次即可（之后会记住）。"
	exit 1
}

Write-Host ""
Write-Host "已推送！GitHub 会自动构建部署，大约 2 分钟后上线。" -ForegroundColor Green
Write-Host "   首页：https://luoxue007.com/" -ForegroundColor Green
Write-Host "   归档：https://luoxue007.com/archive/" -ForegroundColor Green
Write-Host "   （浏览器里按 Ctrl+F5 强制刷新，避免看到旧的缓存页面）"
Write-Host ""
