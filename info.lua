--"info.lua"
--For use in Hachiemon on Bizhawk 1.9.1
--
--Addresses:
--0x1D30 is X
--0x1D34 is Y

local x1 = memory.read_u16_le(0x1D30)
local y1 = memory.read_u16_le(0x1D34)
function text(i,msg)
	gui.text(0,14*i,msg)
end
while true do
	x0 = x1
	y0 = y1
	x1 = memory.read_u16_le(0x1D30)
	y1 = memory.read_u16_le(0x1D34)
	dx = x1-x0
	dy = y1-y0
	
	text(0,"x: "..x1)
	text(1,"y: "..y1)
	text(2,"dx: "..dx)
	text(3,"dy: "..dy)
	emu.frameadvance()
end
