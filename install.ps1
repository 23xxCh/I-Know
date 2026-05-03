# I-Know 安装脚本 (Windows PowerShell)
# 将 I-Know skills 安装到 Claude Code 的全局 skills 目录

$ErrorActionPreference = "Stop"

# 获取脚本所在目录
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# 目标目录
$TargetDir = "$env:USERPROFILE\.claude\skills"

Write-Host "=== I-Know 安装脚本 ===" -ForegroundColor Green
Write-Host ""

# 创建目标目录
Write-Host "创建 skills 目录..."
New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

# 安装 skills
$Skills = @("i-know", "feature-dev", "bug-fix", "refactor", "learn", "diagnose", "grill-me", "triage", "to-issues", "zoom-out", "caveman")

foreach ($skill in $Skills) {
    Write-Host "安装 /$skill ..."
    $SkillTarget = Join-Path $TargetDir $skill
    $SkillSource = Join-Path $ScriptDir "skills\$skill"

    New-Item -ItemType Directory -Force -Path $SkillTarget | Out-Null

    if (Test-Path $SkillSource) {
        Copy-Item -Path "$SkillSource\*" -Destination $SkillTarget -Recurse -Force
        Write-Host "  ✓ $skill 已安装" -ForegroundColor Green
    } else {
        Write-Host "  ✗ 找不到 $skill" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "安装完成！" -ForegroundColor Green
Write-Host ""
Write-Host "可用的斜杠命令："
Write-Host "  /i-know        - 主 skill（路由 + 决策引擎）"
Write-Host "  /feature-dev   - 新功能开发"
Write-Host "  /bug-fix       - Bug 修复"
Write-Host "  /refactor      - 代码重构"
Write-Host "  /learn         - 学习问答"
Write-Host ""
Write-Host "使用方式："
Write-Host "  1. 直接输入斜杠命令，如 /i-know"
Write-Host "  2. 或者直接描述需求，系统会自动路由"
Write-Host ""
Write-Host "提示：需要将 CONTEXT.md 复制到你项目的根目录才能生效" -ForegroundColor Yellow
