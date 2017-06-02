local menuItem = require("objects.menuitem")
local widget = require( "widget" )
local composer  = require( "composer"  )
local scene = composer.newScene(  )

scene.sceneAudioChannel = util:getNextAudioChannel()
scene.nextIndex = 0
scene.indexes = {}
scene.volumeLabel = {}
scene.volumeSlider = widget.newSlider
{
	left = 50,
	top = 30,
	width = display.contentWidth - 80,
	orientation = "horizontal",
	value = util:getVolume() * 100,
	listener = function ( event )
		local value = event.value		    		    			
		--Update the volume text to reflect the new value
		scene.volumeLabel.text = "Volume: " .. util:setVolume( value )
	end
}
scene.scrollView = widget.newScrollView
{
	left = 20,
	top = 115,
	width = display.contentWidth - 30,
	height = 200,
	bottomPadding = 5,
	topPadding = 10,
	leftPadding = 5,
	rightPadding = 20,
	id = "onBottom",
	backgroundColor = { 0, 0, 0 },
	horizontalScrollDisabled = false,
	verticalScrollDisabled = true,
	listener = function( event )
		local phase = event.phase
		local direction = event.direction	
		if "began" == phase then
			--print( "Began" )
		elseif "moved" == phase then
			--print( "Moved" )
		elseif "ended" == phase then
			--print( "Ended" )
		end	
		
		-- If the scrollView has reached it's scroll limit
		if event.limitReached then
			if "up" == direction then
				print( "Reached Top Limit" )
			elseif "down" == direction then
				print( "Reached Bottom Limit" )
			elseif "left" == direction then
				print( "Reached Left Limit" )
			elseif "right" == direction then
				print( "Reached Right Limit" )
			end
		end
		return true
	end
}

function scene:emptyScrollView()
	for i = 1, self.scrollView.numChildren do
		self.scrollView:remove(i)
	end
end


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
	self.bgMusic = audio.loadStream( "assets/audios/settingsBgMusic.mp3" )
	
	local whiteRectangle = display.newRect( self.view , 0, 0, display.contentWidth, display.contentHeight )
	whiteRectangle.anchorX = 0
	whiteRectangle.anchorY = 0
	self:insertInView( whiteRectangle, "whiteRectangleIndex", false)

	local bgImage = display.newImage( "assets/images/meenu.png" )
	bgImage.x = display.contentWidth / 2
	bgImage.y = display.contentHeight / 2
	bgImage.contentWidth = display.contentWidth
	bgImage.contentHeight = display.contentHeight
	bgImage.height = display.contentHeight
	bgImage.width = display.contentWidth
	self:insertInView( bgImage, "bgImageIndex")


	
	local settingsImage = display.newImage( "assets/images/settings.png" )
	settingsImage.x = display.contentWidth / 2
	settingsImage.y = 10
	settingsImage.height = 50
	self:insertInView( settingsImage, "settingsImageIndex")

	local crossMenuItem = menuItem:newMenuItem(menuItem.cross ,400,10, false)
	self:insertInView( crossMenuItem , "crossMenuItemIndex")

	default1 = display.newImage("assets/images/default1.png")
	default1.anchorX = 0
	default1.anchorY = 0
	default1.width = 200
	default1.height = 180
	default1.x = 6
	default1.alpha = 1
	default1:addEventListener("touch",function()
		selectedImage = 1 
		default1.alpha = 1
		default2.alpha = 0.5
		default3.alpha = 0.5
	end)
	self.scrollView:insert( default1 )

	default2 = display.newImage("assets/images/default2.png")
	default2.anchorX = 0
	default2.anchorY = 0
	default2.width = 200
	default2.height = 180
	default2.x = default1.x + default1.width  + 5
	default2.alpha = 0.5
	default2:addEventListener("touch",function() 
		selectedImage = 2 
		default1.alpha = 0.5
		default2.alpha = 1
		default3.alpha = 0.5
	end)
	self.scrollView:insert( default2 )

	default3 = display.newImage("assets/images/default3.png")
	default3.anchorX = 0
	default3.anchorY = 0
	default3.width = 200
	default3.height = 180
	default3.x = default2.x + default2.width  + 5
	default3.alpha = 0.5
	default3:addEventListener("touch",function() 
		selectedImage = 3; 
		default1.alpha = 0.5
		default2.alpha = 0.5
		default3.alpha = 1 
	end)
	self.scrollView:insert( default3 )

	
	self.volumeLabel = display.newText( "Volume: " .. util.audioVolume .. "0", display.contentCenterX, self.volumeSlider.y -10, native.systemFontBold, 18 )
	self:insertInView( self.volumeLabel , "volumeLabelIndex")

	self:insertInView( scene.volumeSlider , "volumeSliderIndex")

	local defImagesBtn = display.newText( "Default Images", 80 , 100 , native.systemFontBold, 20 )
	self:insertInView( defImagesBtn , "defImagesBtn")

	-- local gallaryImagesBtn = display.newText( "Gallary ", 250 , 100 , native.systemFontBold, 20 )
	-- gallaryImagesBtn:addEventListener("tap",function() 
	-- 	default1:removeSelf()
	-- 	default2:removeSelf()
	-- 	default3:removeSelf()
	-- end)
	-- self:insertInView( gallaryImagesBtn , "gallaryImagesBtn")

	-- local onlineImagesBtn = display.newText( "Online ", 400 , 100 , native.systemFontBold, 20 )
	-- self:insertInView( onlineImagesBtn , "onlineImagesBtn")

	self:insertInView( self.scrollView, "scrollViewIndex")

end



function scene:show( event )
	audio.play( self.bgMusic, { channel= self.sceneAudioChannel, loops=-1 , fadein=1000 } )
end

function scene:hide( event )
	--stop the music
	print("stopping setting audio " .. self.sceneAudioChannel)
	audio.stop( self.sceneAudioChannel )
	scene.volumeSlider = nil
end

function scene:destroy( event )
	
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene;