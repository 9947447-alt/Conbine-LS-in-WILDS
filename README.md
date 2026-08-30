# Conbine LS in WILDS

Monster Hunter World: Iceborne 太刀 / 片手层。目标是把 Wilds 太刀的赤刃循环、看破斩·旋、练解，以及片手的防御斩加强、攻击守势反击斩、旋风刈，用 World 现有动作冒充出来。

不是跨引擎移植。没有新动画。

本地 agent 先读 `AGENTS.md` 与 `docs/PHASE0_MOVESET_FREEZE.md`。

## 结构

```
AGENTS.md
lua/
  adapters.lua
  ls_state.lua
  sns_state.lua
  main.lua
docs/
  PHASE0_MOVESET_FREEZE.md
  design.md
  CODEX_CAPABILITIES.md
  CODEX_PITFALLS.md
```

## 环境

- 编辑：macOS `~/Developer/Conbine-LS-in-WILDS`
- 运行：Windows Iceborne 15.23 + Stracker’s Loader + LuaEngine + CRC Bypass
- Fluffy 只管资源包；测试时关风灵月影

## 当前阶段

Phase 0 冻结已写。Phase 1 由本地 agent 补离线断言，不填 adapters 数字。
