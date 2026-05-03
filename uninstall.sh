#!/bin/bash

# I-Know 卸载脚本
# 从 Claude Code 的全局 skills 目录移除 I-Know

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 目标目录
TARGET_DIR="$HOME/.claude/skills"

echo -e "${YELLOW}=== I-Know 卸载脚本 ===${NC}"
echo ""

# 要卸载的 skills
SKILLS=("i-know" "feature-dev" "bug-fix" "refactor" "learn" "diagnose" "grill-me" "triage" "to-issues" "zoom-out" "caveman")

for skill in "${SKILLS[@]}"; do
    if [ -d "$TARGET_DIR/$skill" ]; then
        echo "移除 /$skill ..."
        rm -rf "$TARGET_DIR/$skill"
        echo -e "  ${GREEN}✓${NC} $skill 已移除"
    else
        echo -e "  ${YELLOW}-${NC} $skill 未安装"
    fi
done

echo ""
echo -e "${GREEN}卸载完成！${NC}"
