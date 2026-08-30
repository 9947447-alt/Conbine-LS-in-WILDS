-- 太刀逻辑。不读内存，不写死动作 ID。

local LS = {}

function LS.new()
  return {
    crimson_step = 0,      -- 0=不在赤刃连, 1/2/3
    helm_window = 0,       -- 兜割后练解输入窗（帧，占位）
    last_action = nil,
  }
end

local function is_red(spirit)
  return spirit == 3
end

-- 红刃下 △ 循环：I → II → III → I
function LS.crimson_intent(s, spirit, pressed_light)
  if not is_red(spirit) or not pressed_light then
    s.crimson_step = 0
    return nil
  end
  s.crimson_step = (s.crimson_step % 3) + 1
  return { move = "crimson", step = s.crimson_step }
end

-- 红刃看破：不空槽，走「看破旋」意图
function LS.foresight_intent(spirit, pressed_foresight)
  if not pressed_foresight then
    return nil
  end
  if is_red(spirit) then
    return { move = "foresight_whirl", drain = "red_time" }
  end
  return { move = "foresight", drain = "full_gauge" }
end

-- 兜割后短窗口按特殊攻击 → 练解
function LS.on_action(s, action_name)
  if action_name == "helm_breaker" then
    s.helm_window = 20 -- 占位帧数，Windows 上按手感改
  end
end

function LS.tick_window(s)
  if s.helm_window > 0 then
    s.helm_window = s.helm_window - 1
  end
end

function LS.release_intent(s, pressed_special)
  if s.helm_window > 0 and pressed_special then
    s.helm_window = 0
    return { move = "spirit_release" }
  end
  return nil
end

function LS.think(s, ctx)
  LS.tick_window(s)
  if ctx.action_name == "helm_breaker" and s.last_action ~= "helm_breaker" then
    LS.on_action(s, "helm_breaker")
  end
  s.last_action = ctx.action_name

  local foresight = LS.foresight_intent(ctx.spirit, ctx.input.foresight)
  if foresight then return foresight end

  local release = LS.release_intent(s, ctx.input.special)
  if release then return release end

  return LS.crimson_intent(s, ctx.spirit, ctx.input.light)
end

return LS
