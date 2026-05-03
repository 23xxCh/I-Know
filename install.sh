#!/bin/bash

# I-Know 安装脚本
# 将 I-Know skills 安装到 Claude Code 的全局 skills 目录

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 目标目录
TARGET_DIR="$HOME/.claude/skills"

echo -e "${GREEN}=== I-Know 安装脚本 ===${NC}"
echo ""

# 创建目标目录
echo "创建 skills 目录..."
mkdir -p "$TARGET_DIR"

# 安装 skills
SKILLS=("i-know" "feature-dev" "bug-fix" "refactor" "learn" "diagnose" "grill-me" "triage" "to-issues" "zoom-out" "caveman")

for skill in "${SKILLS[@]}"; do
    echo "安装 /$skill ..."
    mkdir -p "$TARGET_DIR/$skill"

    if [ -d "$SCRIPT_DIR/skills/$skill" ]; then
        cp -r "$SCRIPT_DIR/skills/$skill/"* "$TARGET_DIR/$skill/"
        echo -e "  ${GREEN}✓${NC} $skill 已安装"
    else
        echo -e "  ${RED}✗${NC} 找不到 $skill"
    fi
done

echo ""
echo -e "${GREEN}安装完成！${NC}"
echo ""
echo "可用的斜杠命令："
echo "  /i-know        - 主 skill（路由 + 决策引擎）"
echo "  /feature-dev   - 新功能开发"
echo "  /bug-fix       - Bug 修复"
echo "  /refactor      - 代码重构"
echo "  /learn         - 学习问答"
echo "  /diagnose      - 系统化调试"
echo "  /grill-me      - 需求访谈"
echo "  /triage        - Issue 分类"
echo "  /to-issues     - 拆分 Issues"
echo "  /zoom-out      - 代码概览"
echo "  /caveman       - 压缩模式"
echo ""
echo "使用方式："
echo "  1. 直接输入斜杠命令，如 /i-know"
echo "  2. 或者直接描述需求，系统会自动路由"
echo ""
echo -e "${YELLOW}提示：${NC}需要将 CONTEXT.md 复制到你项目的根目录才能生效"
