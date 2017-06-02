local score = {
	starImageSheet = graphics.newImageSheet( 
		"assets/spritesheets/starsSpriteSheet.png", 
		{
			width = 113,
			height = 113,
			numFrames = 5,
			sheetContentWidth = 567,
			sheetContentHeight = 113
		} 
	);
}

function score:newScore( xposition, yposition)
	local scoreGroup = display.newGroup( )
	local scoreText = display.newText("score", xposition, yposition, native.systemFont, 18 )
	scoreText.anchorX = 0
	scoreText:setFillColor( 245/255, 152/255, 169/255)
	scoreGroup:insert( scoreText )
	local scoreValueText = display.newText("000000", xposition - 8, yposition + 16 , native.systemFont, 18 )
	scoreValueText.anchorX = 0
	scoreValueText:setFillColor( 240/255, 255/255, 0 )
	scoreGroup:insert( scoreValueText )
	scoreGroup.value = 0
	function scoreGroup:setValue( value, xpositionOfStar, ypositionOfStar , scale)
		print("Value to set " .. value)
		value = value * 1
		if value < 0 then
			value = value * 1
		end
		self.value = self.value + value
		local valueStr = self.value .. ""
		if string.len( valueStr )  == 1 then
			valueStr = "00000" .. valueStr
		elseif string.len( valueStr )  == 2 then
			valueStr = "0000" .. valueStr
		elseif string.len( valueStr )  == 3 then
			valueStr = "000" .. valueStr
		elseif string.len( valueStr )  == 4 then
			valueStr = "00" .. valueStr
		elseif string.len( valueStr )  == 5 then
			valueStr = "0" .. valueStr
		end	
		print(self[2].text)
		-- play 5 frames every 500 ms
		local star = display.newSprite(score.starImageSheet, { 
			name="star", start=1, count=5, time= 250
		})
		star.x = xpositionOfStar
		star.y = ypositionOfStar
		star:play()
		if scale == nil then
			scale =  0.25
		end
		star.xScale = scale
		star.yScale = scale	
		transition.to(star, { 
			x = self[1].x + ( self[1].width / 2 ) , 
			y = self[1].y, 
			time = math.random(1000, 5000) ,
			onComplete = function()
				if star ~= nil then
					star:removeSelf( )
					star = nil
				end
				if self ~= nil and self[2] ~= nil and self[2].text ~= nil then
					self[2].text = valueStr
				end
			end
		})		
	end
	return scoreGroup
end

return score