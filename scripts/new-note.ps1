# 新建一篇随笔
#
# 由仓库根目录的「写新随笔.bat」调用，也可以直接右键用 PowerShell 运行。
# 做的事：问标题 -> 用拼音生成文件名 -> 写好头部信息 -> 打开记事本让你写正文。

$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
[Console]::InputEncoding  = [System.Text.UTF8Encoding]::new($false)

$repo = Split-Path $PSScriptRoot -Parent
Set-Location $repo

Write-Host ""
Write-Host "==========  写新随笔  ==========" -ForegroundColor Cyan
Write-Host ""

$title = Read-Host "标题（直接回车 = 用今天日期当标题）"
if ([string]::IsNullOrWhiteSpace($title)) {
	$title = "随笔 " + (Get-Date -Format 'yyyy-MM-dd')
}

Write-Host "正在生成文件名..."
$slug = (& node "$PSScriptRoot\pinyin-slug.mjs" $title 2>$null | Out-String).Trim()
if ([string]::IsNullOrWhiteSpace($slug)) {
	$slug = "note-" + (Get-Date -Format 'yyyyMMdd-HHmmss')
}

$file = Join-Path $repo "src\content\posts\$slug.md"
$relPath = "src\content\posts\$slug.md"

if (Test-Path $file) {
	Write-Host ""
	Write-Host "这篇已经存在了：$relPath" -ForegroundColor Yellow
	$ans = Read-Host "直接打开它继续写吗？(Y/N)"
	if ($ans -notmatch '^[Yy]') {
		Write-Host "已取消，什么都没改。"
		exit 0
	}
} else {
	$date = Get-Date -Format 'yyyy-MM-dd'
	$head = "---`ntitle: $title`npublished: $date`ntags: [随笔]`ncategory: 随笔`n---`n`n"
	[System.IO.File]::WriteAllText($file, $head, [System.Text.UTF8Encoding]::new($false))
	Write-Host ""
	Write-Host "已创建：$relPath" -ForegroundColor Green
}

Write-Host ""
Write-Host "马上会打开记事本 —— 在最后一行写正文，写完后 Ctrl+S 保存，再关闭记事本。" -ForegroundColor Cyan
Write-Host "（正文写一句话也行，写一大段也行）"
Write-Host ""
Read-Host "按回车打开记事本"

Start-Process notepad -ArgumentList "`"$file`"" -Wait

Write-Host ""
Write-Host "文件现在的样子：" -ForegroundColor Cyan
Get-Content $file -Encoding UTF8 | ForEach-Object { "    $_" }
Write-Host ""
Write-Host "满意的话，双击「发布上线.bat」就会推送到线上（约 2 分钟后可访问）。" -ForegroundColor Green
Write-Host "网址会是：https://luoxue007.com/posts/$slug/"
Write-Host ""
