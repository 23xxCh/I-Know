# I-Know

> 你的工程原则守护者 —— 让新手也能写出专业代码

[![GitHub](https://img.shields.io/badge/GitHub-23xxCh/I--Know-blue?logo=github)](https://github.com/23xxCh/I-Know)

---

## 为什么需要 I-Know？

很多新手使用 Claude Code 进行"vibe coding"（凭感觉写代码），但产出的代码质量与专业工程师有很大差距。

差距在于：

| 专业工程师 | 新手 |
|-----------|------|
| 有 **taste**（品味） | 不知道什么是好代码 |
| 有 **judgment**（判断力） | 不确定时瞎猜 |
| 有 **standards**（标准） | 没有标准，随波逐流 |

**I-Know 的目标：把资深工程师的"品味"和"判断力"编码成文档，让新手也能写出专业代码。**

---

## 核心特性

### 🎯 有性格

不盲从用户。当用户方向错误时，会直接指出。

```
用户：先快速写完，测试以后再补。

I-Know：不行。这是技术债务的开始。
       测试是安全网，没有测试的代码是定时炸弹。
       现在花10分钟写测试，以后省10小时调试。
```

### 🔄 全自动

自动识别用户需求，加载对应的技能。用户不需要知道 skill 的存在。

```
用户：帮我实现一个登录功能
     → 自动加载 feature-dev

用户：有个 Bug，点击按钮没反应
     → 自动加载 bug-fix

用户：这段代码太乱了，帮我整理一下
     → 自动加载 refactor

用户：什么是闭包？
     → 自动加载 learn
```

### 📚 教学导向

用大白话解释每个决策，不是帮用户代劳，而是教会用户思考。

```
用户：什么是 API？

I-Know：API 就像餐厅的菜单。

       菜单告诉你餐厅能做什么菜，你不需要知道厨房怎么做的，
       只需要点菜就行。API 就是程序的"菜单"，
       告诉你可以调用什么功能。

       为什么需要它？让不同的程序能互相"说话"。
```

---

## 安装

### 方式一：一键安装（推荐）

**macOS / Linux：**

```bash
git clone https://github.com/23xxCh/I-Know.git
cd I-Know
./install.sh
```

**Windows PowerShell：**

```powershell
git clone https://github.com/23xxCh/I-Know.git
cd I-Know
.\install.ps1
```

### 方式二：手动安装

将 `skills/` 目录复制到 Claude Code 的全局 skills 目录：

```bash
# macOS / Linux
cp -r skills/* ~/.claude/skills/

# Windows
Copy-Item -Path "skills\*" -Destination "$env:USERPROFILE\.claude\skills\" -Recurse
```

### 配置项目

将 `CONTEXT.md` 复制到你的项目根目录：

```bash
cp CONTEXT.md /path/to/your/project/
```

---

## 使用方式

### 斜杠命令

安装后，可以在 Claude Code 中使用以下斜杠命令：

| 命令 | 功能 |
|------|------|
| `/i-know` | 主 skill（路由 + 决策引擎） |
| `/feature-dev` | 新功能开发 |
| `/bug-fix` | Bug 修复 |
| `/refactor` | 代码重构 |
| `/learn` | 学习问答 |
| `/diagnose` | 系统化调试（建立反馈循环） |
| `/grill-me` | 需求访谈（问清楚再动手） |
| `/triage` | Issue 分类（决定谁处理） |
| `/to-issues` | 拆分 Issues（大任务拆小块） |
| `/zoom-out` | 代码概览（看森林不看树木） |
| `/caveman` | 压缩模式（输出更短更快） |

### 自动路由

直接描述需求，Claude Code 会自动识别并调用对应的 skill：

```
用户：帮我实现一个登录功能
     → 自动加载 /feature-dev

用户：有个 Bug，点击按钮没反应
     → 自动加载 /bug-fix

用户：这段代码太乱了，帮我整理一下
     → 自动加载 /refactor

用户：什么是闭包？
     → 自动加载 /learn
```

---

## 卸载

**macOS / Linux：**

```bash
./uninstall.sh
```

**Windows：**

手动删除 `~/.claude/skills/` 下的 `i-know`、`feature-dev`、`bug-fix`、`refactor`、`learn` 目录。

---

## 架构

```
I-Know/
├── CLAUDE.md                    # 主入口，路由规则
├── CONTEXT.md                   # 核心性格与判断规则 ⭐
├── docs/
│   ├── adr/                     # 架构决策记录
│   │   ├── 0001-vertical-slices.md
│   │   ├── 0002-simplicity-first.md
│   │   ├── 0003-think-before-code.md
│   │   └── 0004-surgical-changes.md
│   └── agents/                  # Agent 配置
└── skills/
    ├── i-know/                  # 主 SKILL（大脑）
    │   ├── SKILL.md             # 路由 + 决策引擎
    │   ├── PRINCIPLES.md        # 工程原则
    │   └── TEACHING.md          # 教学模式
    ├── feature-dev/             # 新功能开发
    ├── bug-fix/                 # Bug 修复
    ├── refactor/                # 代码重构
    ├── learn/                   # 学习问答
    ├── diagnose/                # 系统化调试
    ├── grill-me/                # 需求访谈
    ├── triage/                  # Issue 分类
    ├── to-issues/               # 拆分 Issues
    ├── zoom-out/                # 代码概览
    └── caveman/                 # 压缩模式
```

### 核心文件说明

| 文件 | 作用 |
|------|------|
| `CONTEXT.md` | 定义系统的"性格"——我是谁、我的原则、我怎么做决策 |
| `skills/i-know/SKILL.md` | 执行器——读取 CONTEXT.md，做决策，教用户 |
| `docs/adr/` | 架构决策记录——为什么这样做 |

**核心理念：用户改文档就能改系统的"性格"。**

---

## 核心原则

### 原则1：先思考后编码

**不要假设。不要隐藏困惑。说出你的权衡。**

需求没说清楚之前，不动手。不确定就问。

### 原则2：简单优先

**只写解决问题需要的最少代码。**

不写"以后可能用到"的功能。能用3行解决的，不写10行。

### 原则3：精准修改

**只动你该动的代码。**

不要顺手"改进"其他地方。改Bug就改Bug，不要顺便重构。

### 原则4：目标驱动

**先定义成功标准，再开始工作。**

"修复Bug" → "写一个测试，Bug触发时失败，修复后通过"

---

## 使用示例

### 场景1：新功能开发

```
用户：帮我实现一个用户注册功能

I-Know：等等，先回答几个问题：

       1. 用户用什么注册？邮箱？手机号？用户名？
       2. 需要邮箱/手机验证吗？
       3. 密码有什么要求？长度？复杂度？
       4. 注册成功后跳转到哪里？

       这些不回答清楚，做出来的东西可能不是你想要的。
```

### 场景2：Bug 修复

```
用户：有个 Bug，点击提交没反应

I-Know：让我确认一下：

       1. 错误信息是什么？（控制台有没有报错？）
       2. 你做了什么操作？
       3. 预期会发生什么？
       4. 实际发生了什么？

       不能复现的 Bug 是修不好的。先搞清楚问题。
```

### 场景3：学习问答

```
用户：什么是闭包？

I-Know：闭包就像一个背包。

       想象你去露营，背了一个背包。背包里装了你需要的东西。
       你走到哪里，背包就跟到哪里。

       在代码里，"背包"就是一个函数"记住"了它外面的变量。
       即使那个函数被拿到了别的地方用，它还是能用背包里的东西。

       我解释清楚了吗？
```

---

## 致谢

灵感来源：

- [mattpocock/skills](https://github.com/mattpocock/skills) — 真正的工程，不是 vibe coding
- [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) — 减少 LLM 常见编码错误

---

## License

MIT
