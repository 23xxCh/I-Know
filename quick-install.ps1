# I-Know 快速安装脚本 (Windows)
# 使用方法: irm https://raw.githubusercontent.com/23xxCh/I-Know/main/quick-install.ps1 | iex
#

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "╔════════════════════════════════════════╗" -ForegroundColor Blue
Write-Host "║     I-Know 工程原则守护者              ║" -ForegroundColor Blue
Write-Host "║     让新手也能写出专业代码              ║" -ForegroundColor Blue
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Blue
Write-Host ""

# 目标目录
$TargetDir = "$env:USERPROFILE\.claude\skills"
$TempDir = Join-Path $env:TEMP "i-know-install"

# 清理临时目录
if (Test-Path $TempDir) {
    Remove-Item -Recurse -Force $TempDir
}
New-Item -ItemType Directory -Force -Path $TempDir | Out-Null

Write-Host "→ 下载 I-Know..." -ForegroundColor Yellow

# 下载
$ZipUrl = "https://github.com/23xxCh/I-Know/archive/refs/heads/main.zip"
$ZipPath = Join-Path $TempDir "i-know.zip"

try {
    Invoke-WebRequest -Uri $ZipUrl -OutFile $ZipPath -UseBasicParsing
    Expand-Archive -Path $ZipPath -DestinationPath $TempDir -Force
    Write-Host "✓ 下载完成" -ForegroundColor Green
} catch {
    Write-Host "✗ 下载失败: $_" -ForegroundColor Red
    exit 1
}

# 创建目标目录
New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

# 安装 skills
$Skills = @("i-know", "feature-dev", "bug-fix", "refactor", "learn", "diagnose", "grill-me", "triage", "to-issues", "zoom-out", "caveman")
$SourceDir = Join-Path $TempDir "I-Know-main\skills"

Write-Host "→ 安装 skills..." -ForegroundColor Yellow

foreach ($skill in $Skills) {
    $SkillSource = Join-Path $SourceDir $skill
    $SkillTarget = Join-Path $TargetDir $skill

    if (Test-Path $SkillSource) {
        New-Item -ItemType Directory -Force -Path $SkillTarget | Out-Null
        Copy-Item -Path "$SkillSource\*" -Destination $SkillTarget -Recurse -Force
        Write-Host "  ✓ /$skill" -ForegroundColor Green
    }
}

# 清理
Remove-Item -Recurse -Force $TempDir

Write-Host ""
Write-Host "✓ 安装完成！" -ForegroundColor Green
Write-Host ""
Write-Host "可用的斜杠命令：" -ForegroundColor Blue
Write-Host "  /i-know        - 主 skill（路由 + 决策引擎）"
Write-Host "  /feature-dev   - 新功能开发"
Write-Host "  /bug-fix       - Bug 修复"
Write-Host "  /refactor      - 代码重构"
Write-Host "  /learn         - 学习问答"
Write-Host "  /diagnose      - 系统化调试"
Write-Host "  /grill-me      - 需求访谈"
Write-Host "  /triage        - Issue 分类"
Write-Host "  /to-issues     - 拆分 Issues"
Write-Host "  /zoom-out      - 代码概览"
Write-Host "  /caveman       - 压缩模式"
Write-Host ""
Write-Host "快速开始：" -ForegroundColor Blue
Write-Host "  1. 在你的项目根目录创建 CONTEXT.md"
Write-Host "  2. 在 Claude Code 中输入 /i-know 或直接描述需求"
Write-Host ""
Write-Host "提示：运行以下命令在你的项目初始化 CONTEXT.md：" -ForegroundColor Yellow
Write-Host "  irm https://raw.githubusercontent.com/23xxCh/I-Know/main/CONTEXT.md | Out-File -Encoding utf8 CONTEXT.md"
Write-Host ""
