-- 片手逻辑。精准格挡判定复用攻击守势，不新写判定。

local SNS = {}

function SNS.new()
  return {
    combo = 0,
    just_guard = false,
  }
end

function SNS.think(s, ctx)
  if ctx.offensive_guard then
    s.just_guard = true
  end

  if s.just_guard and ctx.input.guard_released and ctx.input.light then
    s.just_guard = false
    s.combo = 0
    return { move = "counter_slash" }
  end

  if ctx.input.guard and ctx.input.heavy then
    return { move = "guard_slash_plus" }
  end

  if ctx.input.light and ctx.input.heavy then
    local move = (s.combo >= 3) and "spinning_reaper" or "roundslash"
    s.combo = 0
    return { move = move }
  end

  if ctx.input.light or ctx.input.heavy then
    s.combo = s.combo + 1
  end

  return nil
end

return SNS
