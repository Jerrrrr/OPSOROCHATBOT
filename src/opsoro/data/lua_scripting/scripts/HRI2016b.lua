blink_anim = AnimatePeriodic({0, 4.8, 4.9, 5}, {0, 0, 1, 0})
mouth_anim = nil

function blink_overlay(dofpos, dof)
  if blink_anim() > 0 then
    return -0.8
  else
    return dofpos
  end
end

function mouth_overlay(dofpos, dof)
  if mouth_anim == nil then
    return dofpos
  else
  	--return dofpos + mouth_anim()
  	return mouth_anim()
  end
end

function wait_and_update(duration)
  local end_t = seconds() + duration
  while end_t > seconds() do
    Expression.update()
  end
end

function setup()
  -- Called once, when the script is started

  -- Generate TTS files:
  Sound:say_tts("Hello, my name is Ono", true)
  Sound:say_tts("And I am an opsoro robot!", true)
  Sound:say_tts("Sometimes I can be sad", true)
  Sound:say_tts("But usually I'm very happy!", true)

  -- Initialize hardware and expressions
  Hardware:servo_init()
  Hardware:servo_neutral()

  Expression.dofs.r_e_lid.add_overlay(blink_overlay)
  Expression.dofs.l_e_lid.add_overlay(blink_overlay)
  Expression.dofs.m_mid.add_overlay(mouth_overlay)
  Expression:set_emotion_r_phi(1.0, 15, true, 1.5)

  Expression.update()
  Hardware:servo_enable()

  -- Run demo scenario
  while true do
  	lipsync("Hello, my name is Ono", 1.6, {0.1, 0.45, 0.8})
    sleep(0.5)
    lipsync("I am an opsoro robot!", 1.8, {0.1, 0.45, 0.8})
    sleep(0.5)

    lipsync("Sometimes I can be sad", 1.6, {0.1, 0.45, 0.8})
    sleep(0.5)
    Expression:set_emotion_r_phi(1.0, 200, true, 1.0)
    wait_and_update(2.5)

    Expression:set_emotion_r_phi(0.0, 15, true, 1.0)
    wait_and_update(1.5)

    lipsync("But usually I'm very happy!", 2.0, {0.1, 0.45, 0.8})
    sleep(0.5)
    Expression:set_emotion_r_phi(1.0, 35, true, 1.0)
    wait_and_update(3)
    Expression:set_emotion_r_phi(1.0, 15, true, 1.0)
    wait_and_update(3.5)
  end
end

function lipsync(text, dur, o_pos)
  t = {}
  pos = {}

  table.insert(t,   0)
  table.insert(pos, 0.5)

  for k,v in pairs(o_pos) do
  	--print(k,v)
  	table.insert(t,    dur*v - 0.2 )
  	table.insert(t,    dur*v)
  	table.insert(t,    dur*v + 0.2 )
  	table.insert(pos,  1)
  	table.insert(pos, -1)
  	table.insert(pos,  1)
  end

  table.insert(t,   dur)
  table.insert(pos, 0.5)

  Sound:say_tts(text)
  mouth_anim = Animate(t, pos)
  wait_and_update(dur)
  mouth_anim = nil
end

function loop()
  Expression.update()
end

function quit()
  -- Called when the script is stopped
  Hardware:servo_disable()
end
