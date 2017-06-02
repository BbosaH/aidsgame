local heart = {
	heartsCount = 0,
	heartSound = audio.loadSound( "assets/audios/menuItemSound.mp3"),
	heartAudioChannel = util:getNextAudioChannel()
}

function heart:newHeart()
	heart.heartsCount = heart.heartsCount + 1
	local lifeHeart  = display.newImage( "assets/images/heart.png" )
	lifeHeart.height = 35
	lifeHeart.width = 45
	lifeHeart.y = 15
	lifeHeart.x = (10 * heart.heartsCount ) + ( 15 * (heart.heartsCount - 1) )
	function lifeHeart:animate(  )
		if util.stopAllAnimations == true  or self == nil then
			return
		end
		transition.to(self,{ time = 500, width = 40, onComplete = 
			function ()
				transition.to(self,{ time = 250, width = 45, onComplete = 
					function ( )
						self:animate()
					end
				});
			end
		});
	end
	function lifeHeart:die( )
		self:removeSelf( )
		heart.heartsCount = heart.heartsCount - 1
	end
	return lifeHeart
end

function heart:createHearts( numberOfHearts )
	if util.stopAllAnimations == true then
			return
		end
	local heartsGroup = display.newGroup( )
	for i = 1, numberOfHearts do
		heartsGroup:insert( heart:newHeart() )
	end
	return heartsGroup
end

function heart:looseHeart()
	audio.play( heart.heartSound, { channel= heart.heartAudioChannel, loops=0  } )
	local hat  = display.newImage( "assets/images/heart.png" )
	hat.height = 35
	hat.width = 45
	hat.x = display.contentWidth / 2
	hat.y = display.contentHeight / 2
	transition.to(hat, { xScale = 20, yScale = 20, alpha = 0 , time = 1000, onComplete = 
		function()
			hat:removeSelf()
		end
	})
end

return heart