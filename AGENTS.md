# 仓库协作规则

本文件适用于本仓库根目录的当前主工作树。开始任务前先确认边界：

```bash
git rev-parse --show-toplevel
git branch --show-current
git rev-parse HEAD
git status --short
```

根目录必须是 `Conbine-LS-in-WILDS`。若不是，或状态与任务假设不符，先停止并报告。不得覆盖、清理、回滚或重置无关改动，也不得读写其他 linked worktree。

## 查找顺序

1. 先查本任务相关的 `docs/CODEX_PITFALLS.md`。
2. 招式与范围先查 `docs/PHASE0_MOVESET_FREEZE.md`，再查 `docs/design.md`。
3. 代码从 `lua/ls_state.lua` 和 `lua/sns_state.lua` 开始，再查 `lua/main.lua`。
4. 游戏接口只允许出现在 `lua/adapters.lua`。

## 已确认的保护不变量

- 这是 Iceborne 上的冒充层，不是 Wilds 动画移植。
- `lua/adapters.lua` 是唯一允许碰游戏 / 填 ID / 填偏移的文件。Mac 阶段不得往里面写猜测数字。
- 太刀已有看破、特殊纳刀、居合、兜割不删不改语义；只在红刃和兜割后加层。
- 练解键位：兜割后再次特殊攻击。
- 反击斩键位：攻击守势成功后松开防御再点轻攻击。
- 精准格挡判定复用攻击守势窗，不新写判定。

## 命令与验证

当前无 Node / pnpm / CI。本地可验证命令以本文件和 `docs/CODEX_CAPABILITIES.md` 为准，不得虚构 script。

存在系统 `lua` 时：

```bash
lua lua/spec_harness.lua
```

没有 `lua` 时，在报告里写明未运行，不要把未跑的断言写成通过。

不得自动 commit、push、打 tag，除非用户明确要求。不得读取密钥。只有经过实际验证的项目特异性问题才能写入 `docs/CODEX_PITFALLS.md`；推测留在「待验证候选」。
