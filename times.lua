--"times.lua"
--For use in Hachiemon on Bizhawk 1.9.1
--
--Addresses:
--0xAC is Level
--0xB8 is Game Time Minutes
--0xB9 is Game Time Seconds
--0xBA is Game Time Frames
--0xD29 is End Stage
--0x224A is Final Boss Health
--0x24E7 is 76 when Final Battle starts

function LinesFrom(file,array)
	array = {}
	for i in io.lines(file) do 
		array[#array + 1] = i
	end
	return array
end

function Save(file,array)
	saveFile = io.open(file, "w")
	for i=1,#array do
		saveFile:write(array[i].."\n")
	end
	saveFile:close()
end

function ReadTime(frame)
	minutes = memory.readbyte(0xB8)
	seconds = memory.readbyte(0xB9)
	frames = memory.readbyte(0xBA)
	if frame then
		return minutes*3600+seconds*60+frames
	end
	if seconds < 10 then
		seconds = 0 .. seconds
	end
	if frames < 10 then
		frames = 0 .. frames
	end
	return minutes ..":".. seconds .."'".. frames 
end

function Split()
	if ReadTime(true) < tonumber(bestF[lvl]) then
		bestF[lvl] = ReadTime(true)
		bestT[lvl] = ReadTime(false)
		Save(fileF,bestF)
		Save(fileT,bestT)
	end
end

fileF = "timesF.txt"
fileT = "timesT.txt"
bestF = LinesFrom(fileF,bestF) --frames
bestT = LinesFrom(fileT,bestT) --times
switch = true

while true do
	lvl = memory.readbyte(0xAC)+1
	gui.text(0,0,"Level ".. lvl)
	gui.text(0,14,"Best: ".. bestT[lvl])
	gui.text(0,28,"Now: ".. ReadTime(false))
	if lvl == 22 and switch and memory.readbyte(0x24E7) == 76 and memory.readbyte(0x224A) == 0 then
		Split()
		switch = false
	else
		done = memory.readbyte(0xD29)
		if done > 127 and switch then
			Split()
			switch = false
		elseif done < 128 and not switch then
			switch = true
		end
	end
	emu.frameadvance()
end
