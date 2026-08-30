# Conbine LS in WILDS

Monster Hunter World: Iceborne 太刀 / 片手层。目标是把 Wilds 太刀的赤刃循环、看破斩·旋、练解，以及片手的防御斩加强、攻击守势反击斩、旋风刈，用 World 现有动作冒充出来。

不是跨引擎移植。没有新动画。

## 结构

```
lua/
  adapters.lua    唯一允许碰游戏的文件
  ls_state.lua    太刀状态机
  sns_state.lua   片手状态机
  main.lua        调度
docs/
  design.md       招式对照与施工顺序
```

## 环境

- 编辑：macOS `~/Developer/Conbine-LS-in-WILDS`
- 运行：Windows Iceborne 15.23 + Stracker’s Loader + LuaEngine + CRC Bypass
- 管理：Fluffy 只管资源包，脚本不走 Fluffy 开关
- 测试时关闭风灵月影

## 当前阶段

Phase 0 — 工作区与离线骨架。`adapters.lua` 全是 stub。动作 ID 等训练场 dump 后再填。
