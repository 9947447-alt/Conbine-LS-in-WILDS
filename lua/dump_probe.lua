-- 只读 adapters 并打印。用法（仓库根目录）：lua lua/dump_probe.lua
-- Mac stub 可见 nil / 0 / false。这不是游戏 dump，不要写成已对接。

local function script_dir()
  local src = arg and arg[0] or ""
  local dir = src:match("^(.*[/\\])")
  if dir and dir ~= "" then return dir end
  return "./"
end

package.path = script_dir() .. "?.lua;" .. package.path

local A = require("adapters")

print("dump_probe adapters stub read")
print("not a Windows game dump")
print("weapon_type " .. tostring(A.weapon_type()))
print("action_id " .. tostring(A.action_id()))
print("spirit_level " .. tostring(A.spirit_level()))

local keys = {}
for k, _ in pairs(A.ID) do
  keys[#keys + 1] = k
end
table.sort(keys)
print("A.ID")
for _, k in ipairs(keys) do
  print("  " .. k .. " " .. tostring(A.ID[k]))
end

-- 只调用冻结签名并打印返回值，不猜真实动作 ID。
print("force_action " .. tostring(A.force_action(3, A.ID.ls_slash_1)))
