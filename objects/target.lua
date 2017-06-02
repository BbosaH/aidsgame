target = {
	targetAudioChannel = util:getNextAudioChannel(),
	targetSound1 = audio.loadSound( "assets/audios/pollutantSelect.wav" ),
	targetSound2 = audio.loadSound( "assets/audios/pollutantSelect2.wav" ),
	targetSound3 = audio.loadSound( "assets/audios/pollutantSelect3.wav" ),
	targetSound4 = audio.loadSound( "assets/audios/pollutantSelect4.wav" ),
	targetSound5 = audio.loadSound( "assets/audios/pollutantSelect5.wav" )
}


function target:newTarget( xposition, yposition)
	local targetObject  = display.newImage( "assets/images/target.png" )
	targetObject.alpha = 0
	targetObject.x = xposition
	targetObject.y = yposition
	function targetObject:animate(callBack)
		self.alpha = 0.9
		transition.to(self,{ xScale = 0.25, yScale = 0.25, time=100 , onComplete = 
			function (  )
				transition.to(self,{ rotation = 180, time = 200, onComplete = 
					function (  )
						audio.play(target["targetSound"..math.random(1,5)])
						self.rotation = 0
						self.alpha = 0.0
						if callBack ~= nil then
							callBack()
						end
					end
				})
			end
		})
	end
	function targetObject:rotate()
		transition.to(self,{ rotation = 360, time = 7000, onComplete = 
			function (  )
				self.rotation = 0
				self:rotate()
			end
		})
	end
	return targetObject
end

return target