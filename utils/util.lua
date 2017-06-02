local util = {
	isSimulator = false,
	isIOS = false,
	isAndroid = false,
	isWin = false,
	isMac = false,
	nextAudioChannel = 0,
	audioVolume = 1,
	audioVolumefilePath = system.pathForFile( "greenMasterVolumeData.txt", system.DocumentsDirectory ),
	level = 1,
	levelfilePath = system.pathForFile( "greenMasterLevelData.txt", system.DocumentsDirectory ),
	font1ImageSheet = graphics.newImageSheet(
	 	"assets/spritesheets/font1SpriteSheet.png" ,
	 	{
			width = 56,
			height = 60,
			numFrames = 11,
			sheetContentWidth = 625,
			sheetContentHeight = 60,
		} 
	),
	stopAllAnimations = false,
	gameIsPaused = false,
	pollutionLevel = 0,
	roadImageTimerDelay     =     500,
	pavementImageTimerDelay =     500,
	roadTime                =   10000,
	polluterTime			=   500,
	pavmentTime             =   10000,
	pavmentGrassTime        =   15000,
	pavmentTreeTime         =   17000,
	houseTime               =	18000,
	behindTime				= 	30000,
	cityTime                =  120000,
	movingHillsTime         =  300000,




}
local error={
	

}

if string.lower(system.getInfo("environment")) == "simulator" then
	util.isSimulator = true;
end
if string.lower(system.getInfo("platformName")) == "iphone os" then
	util = true;
end
if string.lower(system.getInfo("platformName")) == "android" then
	util.isAndroid = true;
end
if string.lower(system.getInfo("platformName")) == "win" then
	util.isWin = true;
end
if string.lower(system.getInfo("platformName")) == "mac os x" then
	util.isMac = true;
end

function util:getAudioFileName(inAudioName)
	if util.isIOS == true then
		return inAudioName .. ".m4a";
	elseif util.isAndroid == true then
		return inAudioName .. ".ogg";
	elseif util.isWin == true then
		return inAudioName .. ".ogg";
	elseif util.isMac == true then
		return inAudioName .. ".m4a";
	else
		return inAudioName .. ".ogg";
	end
end
function util:log(inFile,Errorobject)
	if Errorobject==nil then 
		Errorobject=" "
	else
		Errorobject="-" .. json.encode(Errorobject);
	end
	local errorMessage=infile .. ErrorObject;
	print(errorMessage);
end

function util:clearScreen()
	os.execute("cls");
end

function util:reseedRandom()
	math.randomseed(os.time());
end

function util:quit()
	if self.isWin then
		os.exit( 0 );
	elseif util.isAndroid  then
		native.requestExit();
	else
		--mac os
	end
end

function util:getNextAudioChannel()
	self.nextAudioChannel = self.nextAudioChannel + 1
	return self.nextAudioChannel;
end

function util:setVolume( volume )
	--Convert the value to a floating point number we can use it to set the audio volume	
	self.audioVolume = volume / 100
	self.audioVolume = string.format('%.02f', self.audioVolume )
   	audio.setVolume( self.audioVolume )
	self:audioFile(true)	
   	return self.audioVolume 
end

function util:getVolume()	
	self:audioFile()
	return  self.audioVolume
end

function util:audioFile(saveData)
	if saveData ~= nil and saveData == true then
		--print( "Saving audio data file..." )
		-- create file b/c it doesn't exist yet
		local file = io.open( self.audioVolumefilePath, "w" )
		file:write( self.audioVolume )	
		io.close( file )
	end

	local file = io.open( self.audioVolumefilePath, "r" )  

	if file then		
		-- read all contents of file into a string
		local contents = file:read( "*a" )
		print( "Contents of " .. self.audioVolumefilePath )
		print( contents )
		io.close( file )
		if contents == nil or #contents <= 0 then
			contents = 1
		end
		print( contents )
		self.audioVolume = contents
	else
		print( "Creating audio data file..." )
		-- create file b/c it doesn't exist yet
		file = io.open( self.audioVolumefilePath, "w" )
		file:write( self.audioVolume )	
		io.close( file )
	end 
	
end

function util:setLevel( levelToSet )
	self.level = levelToSet
	self:levelFile(true)	
   	return self.level 
end

function util:getLevel()	
	self:levelFile()
	return  self.level
end

function util:levelFile(saveData)
	if saveData ~= nil and saveData == true then
		--print( "Saving level data file..." )
		-- create file b/c it doesn't exist yet
		local file = io.open( self.levelfilePath, "w" )
		file:write( self.level )	
		io.close( file )
	end

	local file = io.open( self.levelfilePath, "r" )  

	if file then		
		-- read all contents of file into a string
		local contents = file:read( "*a" )
		--print( "Contents of " .. self.levelfilePath )
		--print( contents )
		io.close( file )
		self.level = contents
	else
		--print( "Creating level data file..." )
		-- create file b/c it doesn't exist yet
		file = io.open( self.levelfilePath, "w" )
		file:write( self.level )	
		io.close( file )
	end 
	
end

function util:textToPicture( stringToConvert, fontNumber, xposition, yposition, fontSize, container)
	if fontNumber == nil or fontNumber < 1 then
		fontNumber = 1
	end
	local pictureGroup = display.newGroup( )
	for i = 1, string.len( stringToConvert )  do
		--print("This is character number " .. i )
		local character = stringToConvert:sub( i, i )
		--print(character)
		if character == ":" then
			character = 11
		elseif character == "0" then
			character = 10
		end
		local pictureCharacter = display.newImage( self["font"..fontNumber.."ImageSheet"], character )
		pictureCharacter.x = xposition + ( fontSize * ( i - 1 ) )
		pictureCharacter.y = yposition
		pictureCharacter.width = fontSize
		pictureCharacter.height = fontSize
		pictureGroup:insert( pictureCharacter )
	end
	if container ~= nil then
		container:insert(pictureGroup)
	end
	return pictureGroup
end



return util;