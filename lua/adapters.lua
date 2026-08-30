-- Windows 上填。Mac 上保持 stub，逻辑层才能先写。
-- LuaEngine 的真实函数名以你装上的版本为准，这里只定契约。

local A = {}

A.WP_SNS = 1
A.WP_LS = 3

-- 下面全部是占位。训练场 dump 后再改数字，不要在 Mac 上猜。
A.ID = {
  ls_slash_1 = 0,
  ls_slash_2 = 0,
  ls_slash_3 = 0,
  ls_foresight = 0,
  ls_roundslash = 0,
  ls_helm_breaker = 0,
  ls_iai_spirit = 0,
  ls_spirit_1 = 0,
  sns_guard = 0,
  sns_guard_slash = 0,
  sns_roundslash = 0,
  sns_advancing = 0,
}

A.SPIRIT = {
  none = 0,
  white = 1,
  yellow = 2,
  red = 3,
}

function A.weapon_type()
  -- TODO Windows: Game_Player_Weapon_GetWeaponType 或 engine 等价接口
  return nil
end

function A.action_id()
  -- TODO Windows: Game_Player_GetPlayerActionId
  return nil
end

function A.spirit_level()
  -- TODO Windows: 读练气颜色。没有现成接口就从内存读，偏移不要写在逻辑层。
  return A.SPIRIT.none
end

function A.camera_yaw()
  -- TODO Windows: 镜头朝向。LuaEngine 对朝向支持弱，这一项可能要另写 hook。
  return nil
end

function A.snap_facing_to_camera()
  -- TODO Windows: 出招起手拧朝向。第一版可以空实现。
  return false
end

function A.offensive_guard_just_now()
  -- TODO Windows: 攻击守势触发，或复刻同一时间窗。
  return false
end

function A.input()
  -- TODO Windows: 轻/重/特殊/防御/方向
  return {
    light = false,
    heavy = false,
    special = false,
    guard = false,
    guard_released = false,
  }
end

function A.force_action(kind, id)
  -- TODO Windows: RunFsmAction(kind, id)
  return false
end

function A.log(msg)
  print("[wilds-layer] " .. tostring(msg))
end

return A
