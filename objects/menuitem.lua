local composer = require( "composer")
local menuItem = {
	help = "help",
	settings = "settings",
	play = "play",
	quit = "quit",
	cross = "cross",
	playAgain = "playAgain",
	menu = "menumenu",
	
	menuItemSound = audio.loadSound( "assets/audios/menuItemSound.mp3"),
	sceneAudioChannel = util:getNextAudioChannel()
}

function menuItem:newMenuItem( name , xposition, yposition, resizeItem)
	local menuItemObject = display.newImage( "assets/images/" .. name .. ".png")
	menuItemObject.name = name
	if resizeItem == nil then
		resizeItem = true
	end
	if resizeItem == true then
		menuItemObject.height = 50
		menuItemObject.width = 200
    end
	menuItemObject.y = yposition
	menuItemObject.x = xposition
	menuItemObject.alpha = 0.6
	function menuItemObject:touch( event )
		if event.phase == "began" then --and util:getLevel() == "1" then
			audio.play( menuItem.menuItemSound, { channel= menuItem.sceneAudioChannel, loops=0  } )
	        transition.to(self, {
	        	time = 1000,
	        	alpha = 1,
	        	xScale = 100,
	        	yScale = 100,
	        	onComplete = function()
	        		composer.recycleOnSceneChange = true
	        		-- Completely removes all scenes except for the currently active scene
					composer.removeHidden()
	        		if self.name == "help" then
						composer.removeScene( "scenes.menu" )
						composer.removeHidden()
	        			composer.gotoScene( "scenes.help", "fade", 400 )
	        		elseif self.name == "settings" then
	        			composer.removeScene( "scenes.menu" )
	        			composer.removeHidden()
	        			composer.gotoScene( "scenes.settings", "fade", 400 )
	        		elseif self.name == "play" then
	        			composer.removeScene( "scenes.menu" )
	        			audio.stop()
	        			composer.removeHidden()
	        			if util:getLevel() == "1" or util:getLevel() == "2" or util:getLevel()=="3" then
	        				prevcounts = 4 - tonumber(util:getLevel())
	        				--composer.gotoScene( "scenes.level" .. util:getLevel(), "fade", 400 )
	        				composer.gotoScene( "scenes.playScene", "fade", 400 )
	        			
	        			end
	        		elseif self.name == "quit" then
	        			composer.removeHidden()
	        			composer.removeScene( "scenes.menu" )
	        			util:quit()
	        		elseif self.name == "cross" then
	        			composer.removeHidden()
	        			composer.gotoScene( "scenes.menu", "slideRight", 400 )
	        		elseif self.name == "playAgain" then
	        			composer.removeScene( "scenes.gameover" )
	        			audio.stop()
	        			util.stopAllAnimations = false
	        			composer.removeHidden()
	        			--composer.gotoScene( "scenes.level" .. util:getLevel(), "fade", 400 )
	        			composer.gotoScene( "scenes.playScene", "fade", 400 )
	        		elseif self.name == "menumenu" then
	        			composer.removeScene( "scenes.gameover" )
	        			--composer.removeScene( "scenes.win" ) --nyd
	        			audio.stop()
	        			util.stopAllAnimations = false
	        			composer.removeHidden()
	        			composer.gotoScene( "scenes.menu" , "fade",400 )
	        		end
	        	end
	        })
	    end
	end
	menuItemObject:addEventListener( "touch", menuItemObject )
	return menuItemObject
end

return menuItem