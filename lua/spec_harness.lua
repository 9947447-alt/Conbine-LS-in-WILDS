-- 离线断言。用法（仓库根目录）：lua lua/spec_harness.lua
-- 锁太刀 / 片手 think 契约与 adapters 占位数字，不碰游戏。

local function script_dir()
  local src = arg and arg[0] or ""
  local dir = src:match("^(.*[/\\])")
  if dir and dir ~= "" then return dir end
  return "./"
end

package.path = script_dir() .. "?.lua;" .. package.path

local LS = require("ls_state")
local SNS = require("sns_state")
local A = require("adapters")
local main = require("main")

local passes = 0
local fails = 0

local function fmt(v)
  if type(v) == "table" then
    local parts = {}
    for k, val in pairs(v) do
      parts[#parts + 1] = tostring(k) .. "=" .. fmt(val)
    end
    table.sort(parts)
    return "{" .. table.concat(parts, ",") .. "}"
  end
  if v == nil then return "nil" end
  if type(v) == "string" then return string.format("%q", v) end
  if type(v) == "boolean" then return v and "true" or "false" end
  return tostring(v)
end

local function deep_eq(a, b)
  if type(a) ~= type(b) then return false end
  if type(a) ~= "table" then return a == b end
  for k, v in pairs(a) do
    if not deep_eq(v, b[k]) then return false end
  end
  for k, _ in pairs(b) do
    if a[k] == nil then return false end
  end
  return true
end

local function check(cond, name, extra)
  if cond then
    passes = passes + 1
    print("PASS " .. name)
  else
    fails = fails + 1
    if extra then
      print("FAIL " .. name .. " " .. extra)
    else
      print("FAIL " .. name)
    end
  end
end

local function eq(actual, expected, name)
  check(deep_eq(actual, expected), name, "got " .. fmt(actual) .. " want " .. fmt(expected))
end

local function input(overrides)
  local i = {
    light = false,
    heavy = false,
    special = false,
    guard = false,
    guard_released = false,
    foresight = false,
  }
  if overrides then
    for k, v in pairs(overrides) do
      i[k] = v
    end
  end
  return i
end

local function ls_ctx(fields)
  fields = fields or {}
  return {
    spirit = fields.spirit or 0,
    action_name = fields.action_name,
    input = input(fields.input),
  }
end

local function sns_ctx(fields)
  fields = fields or {}
  return {
    offensive_guard = fields.offensive_guard and true or false,
    input = input(fields.input),
  }
end

-- --- adapters：Mac 阶段数字保持 stub ---

do
  local nonzero = {}
  for k, v in pairs(A.ID) do
    if v ~= 0 then
      nonzero[#nonzero + 1] = tostring(k) .. "=" .. tostring(v)
    end
  end
  table.sort(nonzero)
  check(#nonzero == 0, "adapters.ID all zero", table.concat(nonzero, ","))
  eq(A.SPIRIT.red, 3, "adapters.SPIRIT.red is 3 (ls_state is_red)")
end

-- --- 太刀 think ---

do
  local s = LS.new()
  local steps = {}
  for n = 1, 4 do
    local intent = LS.think(s, ls_ctx({ spirit = 3, input = { light = true } }))
    steps[n] = intent
  end
  eq(steps[1], { move = "crimson", step = 1 }, "LS red light crimson 1")
  eq(steps[2], { move = "crimson", step = 2 }, "LS red light crimson 2")
  eq(steps[3], { move = "crimson", step = 3 }, "LS red light crimson 3")
  eq(steps[4], { move = "crimson", step = 1 }, "LS red light crimson wrap to 1")
end

do
  local s = LS.new()
  eq(
    LS.think(s, ls_ctx({ spirit = 2, input = { light = true } })),
    nil,
    "LS non-red light is not crimson"
  )
end

do
  local s = LS.new()
  eq(
    LS.think(s, ls_ctx({ spirit = 3, input = { foresight = true } })),
    { move = "foresight_whirl", drain = "red_time" },
    "LS red foresight is foresight_whirl / red_time"
  )
end

do
  local s = LS.new()
  eq(
    LS.think(s, ls_ctx({ spirit = 2, input = { foresight = true } })),
    { move = "foresight", drain = "full_gauge" },
    "LS non-red foresight is foresight / full_gauge"
  )
  eq(
    LS.think(s, ls_ctx({ spirit = 0, input = { foresight = true } })),
    { move = "foresight", drain = "full_gauge" },
    "LS empty-gauge foresight is foresight / full_gauge"
  )
end

do
  local s = LS.new()
  local open = LS.think(s, ls_ctx({ action_name = "helm_breaker" }))
  eq(open, nil, "LS helm_breaker open window yields no move")
  eq(
    LS.think(s, ls_ctx({ input = { special = true } })),
    { move = "spirit_release" },
    "LS special inside helm window is spirit_release"
  )
end

do
  local s = LS.new()
  LS.think(s, ls_ctx({ action_name = "helm_breaker" }))
  for _ = 1, 30 do
    LS.think(s, ls_ctx({}))
  end
  eq(
    LS.think(s, ls_ctx({ input = { special = true } })),
    nil,
    "LS special after helm window is not spirit_release"
  )
end

-- --- 片手 think ---

do
  local s = SNS.new()
  eq(
    SNS.think(s, sns_ctx({ input = { guard = true, heavy = true } })),
    { move = "guard_slash_plus" },
    "SNS guard+heavy is guard_slash_plus"
  )
end

do
  local s = SNS.new()
  eq(SNS.think(s, sns_ctx({ offensive_guard = true })), nil, "SNS offensive_guard arms just_guard")
  eq(
    SNS.think(s, sns_ctx({ input = { guard_released = true, light = true } })),
    { move = "counter_slash" },
    "SNS guard_released+light after offensive_guard is counter_slash"
  )
end

do
  local s = SNS.new()
  eq(
    SNS.think(s, sns_ctx({
      offensive_guard = true,
      input = { guard_released = true, light = true },
    })),
    { move = "counter_slash" },
    "SNS same-frame offensive_guard+guard_released+light is counter_slash"
  )
end

do
  local s = SNS.new()
  eq(
    SNS.think(s, sns_ctx({ input = { light = true, heavy = true } })),
    { move = "roundslash" },
    "SNS light+heavy below combo 3 is roundslash"
  )
end

do
  local s = SNS.new()
  for _ = 1, 3 do
    eq(SNS.think(s, sns_ctx({ input = { light = true } })), nil, "SNS light advances combo")
  end
  eq(
    SNS.think(s, sns_ctx({ input = { light = true, heavy = true } })),
    { move = "spinning_reaper" },
    "SNS light+heavy at combo>=3 is spinning_reaper"
  )
end

-- --- main 入口在 Mac stub 下应空跑 ---

do
  local ok, err = pcall(main.run)
  check(ok, "main.run no-ops when weapon_type is nil", err and tostring(err) or nil)
end

print(string.format("RESULT %d passed %d failed", passes, fails))
if fails > 0 then
  os.exit(1)
end
