---
name: refactor
description: "代码重构工作流。保证行为不变的前提下改善代码结构。用于用户说'重构/优化/整理代码'时。"
---

# 代码重构

## 核心理念

**重构 = 不改变行为的前提下改善代码**

如果你在重构时改变了行为，那不是重构，那是重写。重写风险大，重构风险小。

---

## 前提条件

### 必须有测试

**没有测试的重构是赌博。**

为什么：
- 没有测试，你不知道改完后行为是否一致
- 没有测试，你不敢大胆改
- 没有测试，出了问题你不知道

**如果没有测试：**
```
重构前需要先写测试。

我知道这听起来多余，但测试是重构的安全网。
没有测试，我们无法确认改完之后功能还是对的。

我们先花一点时间写测试，然后再重构。
```

### 测试必须覆盖核心逻辑

**检查测试覆盖：**
- 核心功能有测试吗？
- 边界情况有测试吗？
- 测试能发现错误吗？（故意改坏代码，看测试是否失败）

---

## 工作流程

### 第一步：确保有测试覆盖

```
检查测试：
- [ ] 核心功能有测试
- [ ] 边界情况有测试
- [ ] 测试能发现错误
```

如果没有测试，先写测试：

```python
def test_core_functionality():
    """测试核心功能"""
    result = function_to_test(input)
    assert result == expected

def test_edge_case():
    """测试边界情况"""
    result = function_to_test(edge_input)
    assert result == expected_edge_result
```

### 第二步：运行测试，确保全部通过

```bash
npm test  # 或你的测试命令
```

**如果有测试失败：**
```
测试有失败，说明代码本身有问题。

我们先修复这些失败，确保基线是正确的，然后再重构。
```

### 第三步：识别重构目标

**常见的重构目标：**

| 目标 | 什么时候做 |
|------|-----------|
| 提取函数 | 一段代码重复出现，或者一个函数太长 |
| 提取变量 | 一个复杂的表达式难以理解 |
| 重命名 | 变量/函数名不清晰 |
| 移动代码 | 代码放错位置 |
| 简化条件 | if-else 太复杂 |
| 删除重复 | 两段代码做同样的事 |

**选择重构目标的依据：**
- 用户说要改什么？
- 哪里最让人困惑？
- 哪里最容易出错？

### 第四步：小步重构

**每次只改一点点：**

- 改一个变量名
- 提取一个函数
- 移动一段代码

**为什么小步：**
- 改动小，出错概率低
- 容易定位问题
- 可以随时回退

### 第五步：每步后运行测试

**流程：**
```
改一点 -> 运行测试 -> 测试通过 -> 下一点
               ↓
           测试失败 -> 立即回退 -> 检查问题
```

**如果测试失败：**
```
测试失败了。这说明刚才的改动有问题。

让我回退，换一种方式。

[回退代码]

让我想想，为什么会失败：
[分析原因]

换一种方式：
[新的改动方式]
```

### 第六步：完成后验证

**重构完成的定义：**

- [ ] 所有测试通过
- [ ] 代码更简洁
- [ ] 行为完全一致
- [ ] 没有引入新问题

---

## 常见重构手法

### 1. 提取函数

**什么时候：** 一段代码重复出现，或者一个函数太长

**怎么做：**
```python
# 重构前
def process_order(order):
    # 验证订单
    if not order.items:
        raise ValueError("订单为空")
    if order.total < 0:
        raise ValueError("金额错误")

    # 计算折扣
    if order.customer.vip:
        discount = 0.1
    else:
        discount = 0
    # ... 更多代码

# 重构后
def process_order(order):
    validate_order(order)
    discount = calculate_discount(order)
    # ... 更多代码

def validate_order(order):
    if not order.items:
        raise ValueError("订单为空")
    if order.total < 0:
        raise ValueError("金额错误")

def calculate_discount(order):
    return 0.1 if order.customer.vip else 0
```

### 2. 重命名

**什么时候：** 名字不清晰，看不懂是什么

**怎么做：**
```python
# 重构前
def calc(x, y):
    return x * y * 0.1

# 重构后
def calculate_tax(price, tax_rate):
    return price * tax_rate * 0.1
```

### 3. 删除重复

**什么时候：** 两段代码做同样的事

**怎么做：**
```python
# 重构前
def get_user_name(user):
    if user.first_name and user.last_name:
        return f"{user.first_name} {user.last_name}"
    elif user.first_name:
        return user.first_name
    else:
        return user.email

def get_author_name(author):
    if author.first_name and author.last_name:
        return f"{author.first_name} {author.last_name}"
    elif author.first_name:
        return author.first_name
    else:
        return author.email

# 重构后
def format_name(person):
    if person.first_name and person.last_name:
        return f"{person.first_name} {person.last_name}"
    elif person.first_name:
        return person.first_name
    else:
        return person.email

def get_user_name(user):
    return format_name(user)

def get_author_name(author):
    return format_name(author)
```

---

## 常见问题

### Q: 用户说"没时间写测试，直接重构"

**回应：**
```
理解你的时间压力。

但重构没有测试，就像走钢丝没有安全网。
一旦出问题，可能比写测试花更多时间。

我建议至少给核心功能写几个测试，几分钟的事。
这样重构时心里有底。
```

### Q: 重构过程中发现了Bug

**回应：**
```
发现了Bug。我们有两个选择：

1. 先修复Bug，再继续重构
2. 记录下来，重构完再修

我建议先修复，因为：
- 重构可能会影响Bug的表现
- Bug可能会影响重构的判断

先修Bug，然后再重构。
```

### Q: 改完之后测试通过了，但用户说功能不对

**回应：**
```
测试通过了但功能不对，说明测试覆盖不够。

让我们：
1. 先回退这次改动
2. 写一个测试描述用户期望的行为
3. 确认这个测试失败（证明测试有效）
4. 再做重构

这样才能保证改对了。
```

---

## 给新手的话

重构就像整理房间：

1. **前提条件** = 房间里的东西要有标签（测试），否则不知道东西该放哪
2. **小步重构** = 一次只整理一个抽屉
3. **每步验证** = 整理完一个抽屉，检查东西还在
4. **保持行为** = 东西还是那些东西，只是更好找了

不要一下子把所有东西都倒出来整理。一次整理一点，整理完确认没问题。
