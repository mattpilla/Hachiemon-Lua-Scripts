-- "ingame_time".lua
-- For use in Hachiemon on Bizhawk

-- Addresses:
lvlAddr = 0xac -- Level
minuteAddr = 0xb8 -- Ingame time minutes
secondAddr = 0xb9 -- Ingame time seconds
frameAddr = 0xba -- Ingame time frames

-- Function to format the ingame time display
function readTime()
    minutes = memory.readbyte(minuteAddr)
    seconds = memory.readbyte(secondAddr)
    frames = memory.readbyte(frameAddr)
    if seconds < 10 then
        seconds = 0 .. seconds
    end
    if frames < 10 then
        frames = 0 .. frames
    end
    return minutes .. ":" .. seconds .."'" .. frames
end

-- Main loop
while true do
    lvl = memory.readbyte(lvlAddr) + 1
    gui.text(0, 0, "Level " .. lvl)
    gui.text(0, 14, "Time: " .. readTime())
    emu.frameadvance()
end
