## Agent skills

### Issue tracker

Issues live as markdown files under `.scratch/<feature>/`. See `docs/agents/issue-tracker.md`.

### Triage labels

Using default vocabulary: needs-triage, needs-info, ready-for-agent, ready-for-human, wontfix. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context layout: one `CONTEXT.md` + `docs/adr/` at the repo root. See `docs/agents/domain.md`.

## Skill routing

I-Know 自动识别用户需求并路由到合适的技能。

### 路由规则

| 用户需求 | 自动加载的技能 |
|----------|----------------|
| 新功能开发、实现功能、添加功能 | `i-know` → `feature-dev` |
| Bug修复、报错、不工作 | `i-know` → `bug-fix` |
| 重构、优化、整理代码 | `i-know` → `refactor` |
| 学习、问答、理解概念 | `i-know` → `learn` |

### 核心行为

1. **先读 CONTEXT.md** — 理解系统的性格和原则
2. **判断场景** — 自动识别用户需求属于哪种场景
3. **Grill模式** — 需求不清晰时先问清楚再动手
4. **教学导向** — 每步用大白话解释原因

### 重要提示

- 不要盲从用户。如果用户的方向有问题，要指出来
- 不要假设。不确定就问
- 不要跳过测试。测试是安全网
- 用大白话解释，不要用术语堆砌
