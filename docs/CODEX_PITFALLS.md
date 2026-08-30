# 踩坑

## 已验证

- `git@github.com:` 在未配置 SSH key 的 Mac 上会 `Permission denied (publickey)`。公开仓也一样。用 HTTPS clone。
- World 不是 RE Engine。REFramework / Wilds 动作树不能用。
- LuaEngine 不在开荒 QoL 清单里。Stracker 只加载 nativePC，脚本还要 LuaEngine。
- 风灵月影和动作 hook 抢内存。测太刀时必须关。
- 当前 Mac 工作区 PATH 中无 `lua` / `luajit`（`command -v lua` 失败）。在安装解释器前不得把 `lua lua/spec_harness.lua` 写成已通过。

## 待验证候选

- LuaEngine 15.23 的入口是 `run()` 还是别的表。
- 玩家朝向是否必须另写 native hook。
- 攻击守势成功标志能否在 Lua 里直接读到。
