local composer  = require( "composer"  )
local menuItem = require("objects.menuitem")
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

	composer.removeScene( "scenes.level" .. util:getLevel() )

	print( "my channel is " .. self.sceneAudioChannel )

	--the captured screen
	local baseDir = system.TemporaryDirectory
	local entireScreenImage = display.newImage( "entireScreen.jpg", baseDir )
	if entireScreenImage then
		entireScreenImage.width = display.contentWidth
		entireScreenImage.height = display.contentHeight
		entireScreenImage.x = display.contentCenterX
		entireScreenImage.y = display.contentCenterY
		self:insertInView(entireScreenImage, "entireScreenImageIndex")
	end

	local transparentRectangle = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	transparentRectangle.anchorX = 0
	transparentRectangle.anchorY = 0
	transparentRectangle:setFillColor( 0, 0, 0, 0.5 )
	self:insertInView(transparentRectangle, "transparentRectangleIndex")

	local gameOverBgImage = display.newImage( "assets/images/gameOverBgImage.png" )
	gameOverBgImage.width = display.contentWidth - 100
	gameOverBgImage.height = display.contentHeight -100
	gameOverBgImage.x = display.contentWidth / 2
	gameOverBgImage.y = display.contentHeight / 2 + 20
	self:insertInView(gameOverBgImage, "gameOverBgIndex")

	local playAgainMenuItem = menuItem:newMenuItem(menuItem.playAgain,display.contentCenterX,160,false)
	self:insertInView( playAgainMenuItem , "playAgainMenuItemIndex")

	local menuMenuItem = menuItem:newMenuItem(menuItem.menu,120,display.contentHeight-30,false)
	self:insertInView( menuMenuItem , "menuMenuItemIndex")

	local menuMenuItem = menuItem:newMenuItem(
		menuItem.quit,display.contentWidth-100,display.contentHeight-30,false
	)
	self:insertInView( menuMenuItem , "menuMenuItemIndex")


	audio.play( audio.loadStream( "assets/audios/gameOverMusic.mp3" ), { loops= 1 } )
	

end

function scene:show( event )

	
end

function scene:hide( event )
	print( "stopping " .. self.sceneAudioChannel )
	--stop the music
	audio.stop( self.sceneAudioChannel )
end

function scene:destroy( event )
	
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene;