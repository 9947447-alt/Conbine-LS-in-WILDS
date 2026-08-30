# Phase 0 Moveset Freeze

冻结日：2026-08-29
仓库：`9947447-alt/Conbine-LS-in-WILDS`
工作区：`/Users/a0000/Developer/Conbine-LS-in-WILDS`

## 做 / 不做

做：

- 太刀出招起手转向（镜头对齐，不改挥刀中段轨迹）
- 红刃赤刃斩 I/II/III 循环
- 红刃看破斩·旋（不空槽，扣红刃时间）
- 兜割后练解
- 片手防御斩加强
- 攻击守势 → 反击斩
- 指定连段后的旋风刈

不做：

- 新动画、Wilds 资源进口、改 exe
- 完整集中模式（准星、伤口、FOV）
- 朝向 hook 的第一版实现（可留空函数）
- 在 Mac 上填写动作 ID 或内存偏移

## 意图名冻结

太刀：`crimson`（step 1..3）、`foresight`、`foresight_whirl`、`spirit_release`
片手：`guard_slash_plus`、`counter_slash`、`roundslash`、`spinning_reaper`

## 阶段切分

- Phase 0：工作区 + 冻结 + 离线状态机骨架（已有）
- Phase 1：Mac 本地断言，不碰 adapters 数字
- Phase 2：Windows LuaEngine 适配器，只填已 dump 的值
