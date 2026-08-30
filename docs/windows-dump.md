# Windows 训练场 dump 清单

Phase 2A（Mac）：在仓库根目录跑 `lua lua/dump_probe.lua`。探针只 `require` `lua/adapters.lua` 并打印冻结接口，不填数字、不写偏移、不实现朝向 hook。

当前 stub 期望输出：`weapon_type` nil、`action_id` nil、`spirit_level` 0、`A.ID` 全 0、`force_action` false。该输出不是游戏 dump，不是已对接。

Phase 2B（Windows 到场后）：只把训练场实际打出来的数字填进 `lua/adapters.lua`。未 dump 到的键保持 0。

## 必须 dump 的动作

### 太刀

| 动作名 | A.ID 键 |
|---|---|
| 直斩 | `ls_slash_1` |
| 纵斩 | `ls_slash_2` |
| 上捞 | `ls_slash_3` |
| 看破斩 | `ls_foresight` |
| 气刃斩 I | `ls_spirit_1` |
| 气刃大回旋 | `ls_roundslash` |
| 气刃兜割 | `ls_helm_breaker` |
| 居合气刃斩 | `ls_iai_spirit` |

### 片手

| 动作名 | A.ID 键 |
|---|---|
| 防御 | `sns_guard` |
| 防御斩 | `sns_guard_slash` |
| 回旋斩 | `sns_roundslash` |
| 突进斩 / 上捞斩 | `sns_advancing` |

### 通用读数

- `weapon_type()`
- `action_id()`
- `spirit_level()`

## 约束

- 不得在 Mac 上猜 ID / 偏移
- 朝向 hook 2A 保持空实现
- 不得把 dump_probe 的 stub 输出写成已对接游戏
