# Phase 2 Adapter Freeze

冻结日：2026-08-29
仓库：`9947447-alt/Conbine-LS-in-WILDS`
工作区：`/Users/a0000/Developer/Conbine-LS-in-WILDS`
基线 HEAD：`f7615c162a51cddb573a90a88bf4588b651c57cc`

Windows 不在手边。Phase 2 拆两刀。

## Phase 2A（现在，Mac）

做：

- 写清 adapters 必须暴露的函数与返回值
- 写 `lua/dump_probe.lua`：调用这些函数并打印，不猜测数字
- 列出训练场必须 dump 的动作名

不做：

- 填写 `A.ID.*`
- 写内存偏移
- 实现朝向 hook
- 把探针结果写成「已对接游戏」

## Phase 2B（Windows 到场后）

只允许把训练场实际打出来的数字填进 `lua/adapters.lua`。
未 dump 到的键保持 0。

## 必须 dump 的名字

太刀：直斩 / 纵斩 / 上捞、看破斩、气刃斩 I、气刃大回旋、气刃兜割、居合气刃斩
片手：防御、防御斩、回旋斩、突进斩 / 上捞斩
通用：weapon_type、action_id、spirit_level

## adapters 契约（已冻结，不得改名）

- `weapon_type()` → number | nil
- `action_id()` → number | nil
- `spirit_level()` → 0..3
- `input()` → light / heavy / special / guard / guard_released
- `offensive_guard_just_now()` → bool
- `force_action(kind, id)` → bool
- `snap_facing_to_camera()` → bool（2A 保持空实现）
- `log(msg)`
