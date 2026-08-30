# 本地 agent 能力地图

## 审计基线

- 日期：2026-08-29
- 分支：`main`
- 当时 HEAD：`d54adbb0c8515c8f8171c1602b4ae833a4b532e2`
- 工作树：`/Users/a0000/Developer/Conbine-LS-in-WILDS`
- 技术栈：Lua 状态机 + 日后 Iceborne LuaEngine
- 无 pnpm、无 Vitest、无 CI

## 可协助

| 类别 | 事项 | 文件 | 验证 |
|---|---|---|---|
| 离线逻辑 | 太刀 / 片手 think 契约 | `lua/ls_state.lua` `lua/sns_state.lua` | `lua lua/spec_harness.lua` |
| 文档 | 冻结、踩坑 | `docs/*` | 与 freeze 交叉核对 |
| 日后适配 | 只填 dump 到的 ID | `lua/adapters.lua` | 训练场日志，本阶段禁止 |

## 不协助

- 编造动作 ID、气刃偏移、朝向 hook 实现
- 自动 commit / push
- 把风灵月影或 Fluffy 资源包写进脚本依赖
