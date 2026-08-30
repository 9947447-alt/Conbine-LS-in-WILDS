local A = require("adapters")
local LS = require("ls_state")
local SNS = require("sns_state")

local ls = LS.new()
local sns = SNS.new()

local ACTION_NAME = {
  -- Windows dump 后把 action_id → 名字补在这里
}

local function action_name(id)
  if id == nil then return nil end
  return ACTION_NAME[id]
end

local function apply_ls(intent)
  if not intent then return end
  A.log("LS " .. intent.move)
  if intent.move == "crimson" then
    local key = "ls_slash_" .. tostring(intent.step)
    A.force_action(3, A.ID[key])
  elseif intent.move == "foresight_whirl" then
    A.force_action(3, A.ID.ls_foresight)
  elseif intent.move == "foresight" then
    A.force_action(3, A.ID.ls_foresight)
  elseif intent.move == "spirit_release" then
    A.force_action(3, A.ID.ls_iai_spirit)
  end
end

local function apply_sns(intent)
  if not intent then return end
  A.log("SnS " .. intent.move)
  if intent.move == "counter_slash" then
    A.force_action(3, A.ID.sns_advancing)
  elseif intent.move == "guard_slash_plus" then
    A.force_action(3, A.ID.sns_guard_slash)
  elseif intent.move == "spinning_reaper" or intent.move == "roundslash" then
    A.force_action(3, A.ID.sns_roundslash)
  end
end

function run()
  local wp = A.weapon_type()
  if wp == nil then
    return
  end

  local ctx = {
    spirit = A.spirit_level(),
    action_name = action_name(A.action_id()),
    offensive_guard = A.offensive_guard_just_now(),
    input = A.input(),
  }
  ctx.input.foresight = ctx.input.special and ctx.input.heavy

  if wp == A.WP_LS then
    A.snap_facing_to_camera()
    apply_ls(LS.think(ls, ctx))
  elseif wp == A.WP_SNS then
    apply_sns(SNS.think(sns, ctx))
  end
end

return { run = run }
