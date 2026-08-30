# 踩坑

## 已验证

- `git@github.com:` 在未配置 SSH key 的 Mac 上会 `Permission denied (publickey)`。公开仓也一样。用 HTTPS clone。
- World 不是 RE Engine。REFramework / Wilds 动作树不能用。
- LuaEngine 不在开荒 QoL 清单里。Stracker 只加载 nativePC，脚本还要 LuaEngine。
- 风灵月影和动作 hook 抢内存。测太刀时必须关。
- 当前 Mac 工作区 PATH 有 `/opt/homebrew/bin/lua`（Lua 5.5.1）。`lua lua/spec_harness.lua` 与 `lua lua/dump_probe.lua` 可跑。dump_probe 在 stub 下打印 `weapon_type` nil、`action_id` nil、`spirit_level` 0、`A.ID` 全 0、`force_action` false；这不是 Windows 游戏 dump，不得写成已对接。

## 待验证候选

- LuaEngine 15.23 的入口是 `run()` 还是别的表。
- 玩家朝向是否必须另写 native hook。
- 攻击守势成功标志能否在 Lua 里直接读到。
