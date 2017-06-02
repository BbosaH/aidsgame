local target = require("objects.target");
local menuItem = require("objects.menuitem")
local composer  = require( "composer"  )
local scene = composer.newScene(  )

scene.sceneAudioChannel = util:getNextAudioChannel()
scene.nextIndex = 0;
scene.indexes = {}

function scene:getNextIndex()
	self.nextIndex = self.nextIndex + 1
	return self.nextIndex
end

function scene:insertInView( objectToInsert, indexName, shouldObjectBeInserted)
	if shouldObjectBeInserted == nil then
		shouldObjectBeInserted = true
	end

	if shouldObjectBeInserted == true then
		self.view:insert(objectToInsert)		
	end

	self.indexes[indexName] = self:getNextIndex()
end

function scene:create( event )

	plays = 0
	answered = 0
	modez = "normal"
	playedLetters = {}
	timeTaken = 0
	playerScore = 0

	self.bgMusic = audio.loadStream( "assets/audios/menuBgMusic.mp3" )

	print( "my menu channel is " .. self.sceneAudioChannel )
	
	local whiteRectangle = display.newRect( self.view , 0, 0, display.contentWidth, display.contentHeight )
	whiteRectangle.anchorX = 0
	whiteRectangle.anchorY = 0
	self:insertInView( whiteRectangle, "whiteRectangleIndex", false)

	local bgImage = display.newImage( "assets/images/meenu.png" )
	bgImage.x = display.contentWidth / 2
	bgImage.y = display.contentHeight / 2
	--bgImage.contentWidth = display.contentWidth
	--bgImage.contentHeight = display.contentHeight
	bgImage.height = display.contentHeight
	bgImage.width = display.contentWidth
	self:insertInView( bgImage, "bgImageIndex")


	local settingsMenuItem = menuItem:newMenuItem(menuItem.settings,85,70)
	self:insertInView( settingsMenuItem , "settingsMenuItemIndex")

	local helpMenuItem = menuItem:newMenuItem(menuItem.help ,390,70)
	self:insertInView( helpMenuItem , "helpMenuItemIndex")

	local playMenuItem = menuItem:newMenuItem(menuItem.play ,display.contentWidth/2,display.contentHeight/2)
	self:insertInView( playMenuItem , "playMenuItemIndex")

	local quitMenuItem = menuItem:newMenuItem(menuItem.quit ,245,70)
	self:insertInView( quitMenuItem , "quitMenuItemIndex")

	local level = util:getLevel()
	local targetSelector = target:newTarget( 0, 0);
	targetSelector.alpha = 1
	targetSelector.width = 100
	targetSelector.height = 100
	targetSelector:rotate()
	print("level is"..level)
	if level == "1" then
		print("level is is " , level)
		targetSelector.x = 100
		targetSelector.y = 250
	elseif level == "2" then
		targetSelector.x = 250  
		targetSelector.y = 250
	else
		targetSelector.x = 390  
		targetSelector.y = 250
	end

	self:insertInView( targetSelector , "targetSelector")

	local levelSelectImage1 = display.newImage("assets/images/1.png")
	levelSelectImage1.x = 100
	levelSelectImage1.y = 250
	levelSelectImage1:addEventListener("touch",
		function() 
			targetSelector.x = 100  
			targetSelector.y = 250
			util:setLevel(1)
		end
	)
	self:insertInView( levelSelectImage1 , "levelSelectImage1")
	

	local levelSelectImage2 = display.newImage("assets/images/2.png")
	levelSelectImage2.x = 250
	levelSelectImage2.y = 250
	levelSelectImage2:addEventListener("touch",
		function() 
			targetSelector.x = 250  
			targetSelector.y = 250
			util:setLevel(2)
		end
	)
	self:insertInView( levelSelectImage2 , "levelSelectImage2")

	local levelSelectImage3 = display.newImage("assets/images/3.png")
	levelSelectImage3.x = 390
	levelSelectImage3.y = 250
	levelSelectImage3:addEventListener("touch",
		function() 
			targetSelector.x = 390  
			targetSelector.y = 250
			util:setLevel(3)
		end
	)
	self:insertInView( levelSelectImage3 , "levelSelectImage1")

	--local text = display.newText( "Tap to launch Photo Picker", centerX, centerY, nil, 16 )
	--text:setFillColor( 1, 1, 1 )
	
end

function scene:show( event )
	composer.removeScene( "scenes.help" )
	composer.removeScene( "scenes.settings" )
	audio.play( self.bgMusic, { channel= self.sceneAudioChannel, loops=-1 , fadein=1000 } )
end

function scene:hide( event )
	--stop the music
	print( "stopping menu  is " .. self.sceneAudioChannel )
	audio.stop( self.sceneAudioChannel )
end

function scene:destroy( event )
	
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene;