#!/bin/bash
#
# I-Know 快速安装脚本
# 使用方法: curl -fsSL https://raw.githubusercontent.com/23xxCh/I-Know/main/quick-install.sh | bash
#

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     I-Know 工程原则守护者              ║${NC}"
echo -e "${BLUE}║     让新手也能写出专业代码              ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# 检测操作系统
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
    IS_WINDOWS=true
else
    IS_WINDOWS=false
fi

# 目标目录
TARGET_DIR="$HOME/.claude/skills"

# 创建临时目录
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

echo -e "${YELLOW}→ 下载 I-Know...${NC}"

# 下载仓库
if command -v git &> /dev/null; then
    git clone --depth 1 https://github.com/23xxCh/I-Know.git "$TEMP_DIR/I-Know" 2>/dev/null
elif command -v curl &> /dev/null; then
    curl -fsSL https://github.com/23xxCh/I-Know/archive/refs/heads/main.tar.gz | tar -xzf - -C "$TEMP_DIR"
    mv "$TEMP_DIR/I-Know-main" "$TEMP_DIR/I-Know"
else
    echo -e "${RED}✗ 需要安装 git 或 curl${NC}"
    exit 1
fi

echo -e "${GREEN}✓ 下载完成${NC}"

# 创建目标目录
mkdir -p "$TARGET_DIR"

# 安装 skills
SKILLS=("i-know" "feature-dev" "bug-fix" "refactor" "learn" "diagnose" "grill-me" "triage" "to-issues" "zoom-out" "caveman")

echo -e "${YELLOW}→ 安装 skills...${NC}"

for skill in "${SKILLS[@]}"; do
    if [ -d "$TEMP_DIR/I-Know/skills/$skill" ]; then
        mkdir -p "$TARGET_DIR/$skill"
        cp -r "$TEMP_DIR/I-Know/skills/$skill/"* "$TARGET_DIR/$skill/"
        echo -e "  ${GREEN}✓${NC} /$skill"
    fi
done

echo ""
echo -e "${GREEN}✓ 安装完成！${NC}"
echo ""
echo -e "${BLUE}可用的斜杠命令：${NC}"
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
echo -e "${BLUE}快速开始：${NC}"
echo "  1. 在你的项目根目录创建 CONTEXT.md"
echo "  2. 在 Claude Code 中输入 /i-know 或直接描述需求"
echo ""
echo -e "${YELLOW}提示：${NC}运行以下命令在你的项目初始化 CONTEXT.md："
echo "  curl -fsSL https://raw.githubusercontent.com/23xxCh/I-Know/main/CONTEXT.md > CONTEXT.md"
echo ""
