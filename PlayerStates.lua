local _G = getfenv(0)
local f = CreateFrame("Frame")
local states = {}
f:RegisterEvent("SPELLCAST_START")
f:RegisterEvent("SPELLCAST_STOP")
f:RegisterEvent("SPELLCAST_CHANNEL_START")
f:RegisterEvent("SPELLCAST_CHANNEL_STOP")
f:RegisterEvent("SPELLCAST_CHANNEL_UPDATE")
f:RegisterEvent("PLAYER_DEAD")
f.Print = function(msg)
  local out = "|cff008800PlayerStates: |r"..tostring(msg)
  if not DEFAULT_CHAT_FRAME:IsVisible() then
    FCF_SelectDockFrame(DEFAULT_CHAT_FRAME)
  end
  DEFAULT_CHAT_FRAME:AddMessage(out)
end
f.SPELLCAST_START = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11)
  -- not used atm
end
f.SPELLCAST_STOP = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11)
  if states["Channeling"] == true then
    states["Channeling"] = false
  end
end
f.SPELLCAST_CHANNEL_START = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11)
  states["Channeling"] = true
end
f.SPELLCAST_CHANNEL_UPDATE = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11)
  local timeleft = tonumber(arg1)
  if timeleft and timeleft > 0 then
    states["Channeling"] = true
  else
    states["Channeling"] = false
  end
end
f.SPELLCAST_CHANNEL_STOP = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11)
  states["Channeling"] = false
end
f.PLAYER_DEAD = function(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11)
  states["Channeling"] = false
end
f.OnEvent = function(event,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11) 
  return f[event]~=nil and f[event](arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11)
end
f:SetScript("OnEvent",function() f.OnEvent(event,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11) end)


_G["PlayerState"] = states
