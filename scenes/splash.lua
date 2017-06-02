local composer  = require( "composer"  )
local scene = composer.newScene(  )

scene.sceneAudioChannel = util:getNextAudioChannel()

function scene:touch( event )
	if event.phase == "began" then		
		composer.gotoScene( "scenes.menu", "slideLeft", 800  )		
		return true
	end
end

function scene:beepTapText( )
	if self == nil or self.view == nil then
		return
	end
	transition.to( self.view[4], { time=1000, alpha = 0 , onComplete = 
		function()
			if self == nil or self.view == nil then
				return
			end
			transition.to( self.view[4], { time=1000, alpha = 1 , onComplete = 
				function()
					self:beepTapText() 
				end
			} )
		end
	} )
end




function scene:create( event )
	local container = self.view

	print( "my channel is " .. self.sceneAudioChannel )

	local whiteRectangle = display.newRect( container , 0, 0, display.contentWidth, display.contentHeight )
	whiteRectangle.anchorX = 0
	whiteRectangle.anchorY = 0
	container:insert(whiteRectangle)

	local sunraysImage = display.newImage( "assets/images/wood_texture.png" )
	sunraysImage.x = display.contentWidth / 2
	sunraysImage.y = display.contentHeight / 2
	
	sunraysImage:addEventListener( "touch", self )
	container:insert(sunraysImage)	

	local splashImage = display.newImage( "assets/images/splash_imageee.png"  )
	splashImage.x = display.contentWidth / 2
	splashImage.y = display.contentHeight / 2
	splashImage.xScale = 0.8
	splashImage.yScale = 0.8
	splashImage.alpha=0.6
	container:insert(splashImage)

	local splashBgMusic = audio.loadStream( "assets/audios/splashBgMusic.wav" )
	self.bgMusic = splashBgMusic

	local loadText = display.newText( "TAP TO CONTINUE .....", 0, 0, native.systemFontBold, 25 )
	loadText:setFillColor( 1,0,0 );
	loadText.x = display.contentWidth * 0.5 
	loadText.y = display.contentHeight - 20
	container:insert( loadText )

	--[[local loadImage = display.newImage( "assets/images/lod.png" )
	loadImage.x = display.contentWidth * 0.5
	loadImage.y = display.contentHeight -20
	
	loadImage:addEventListener( "touch", self )
	container:insert(loadImage)--]]

	--[[local tapText = display.newText( "Touch to continue.", 0, 0, native.systemFontBold, 18 )
	tapText:setFillColor( 0.5 );
	tapText.x = display.contentWidth * 0.5 
	tapText.y = display.contentHeight - 20
	container:insert( tapText )--]]

	-- self.view = container
end

function scene:show( event )

	audio.play( self.bgMusic, { channel=self.sceneAudioChannel, loops=-1, fadein=500 } )
	self:beepTapText( )

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
scene:addEventListener( "destroy", scene)


return scene;