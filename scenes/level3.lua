local physics = require("physics")
physics.start()
local pollutionmeter = require("objects.pollutionmeter")
local pollutant = require("objects.pollutant")
local score  = require("objects.score")
local nonpollutant = require("objects.nonpollutant")
local polluter = require("objects.polluter")

--physics.setDrawMode("hybrid") --Set physics Draw mode
physics.setScale( 60 ) -- a value that seems good for small objects (based on playtesting)
physics.setGravity( 0, 0 ) -- overhead view, therefore no gravity vector

local heart = require("objects.heart")
local animal = require("objects.animal")
local animalwidget = require("objects.animalwidget")
local gamepacktrees = require("objects.gamepacktrees")
local vegetation  = require("objects.vegetation");
local score  = require("objects.score")
local lifebalance = require("objects.lifebalance")
local composer  = require( "composer"  )
local scene = composer.newScene(  )
composer.recycleOnSceneChange = true
scene.sceneAudioChannel = util:getNextAudioChannel()
scene.nextIndex = 0
scene.indexes = {}
scene.volumeLabel = {}
scene.timeLimit = 20
scene.state = "playing"
util.pollutionLevel = 0

--physics.setDrawMode( "hybrid" )
--physics.setDrawMode( "debug" )
--physics.setDrawMode( "normal" )

function scene:collision( event )
	if ( event.phase == "began" ) then
		local parent = nil
		--print( "Global report: " .. event.object1.name .. " & " .. event.object2.name .. " collision began" )
		if event.object1.type == "vegetation" and event.object2.type == "herbivorous" then
			parent = event.object1.parent
			event.object1:removeSelf()
			event.object1 = nil
		elseif event.object1.type == "herbivorous" and event.object2.type == "vegetation" then
			parent = event.object2.parent
			event.object2:removeSelf()
			event.object2 = nil
		elseif event.object1.type == "herbivorous" and event.object2.type == "carnivorous" then
			parent = event.object1.parent
			event.object1:removeSelf()
			event.object1 = nil
		elseif event.object1.type == "carnivorous" and event.object2.type == "herbivorous" then
			parent = event.object2.parent
			event.object2:removeSelf()
			event.object2 = nil
		end		
		self:trackAnimals(parent)
		return true
	end
	
end
Runtime:addEventListener( "collision", scene )

function scene:trackAnimals(parent)
	if parent ~= nil then
		local animalCount =  parent:countAnimals()
		self.view[self.indexes.animalwidgetGroupIndex]:Update(animalCount)
		self.view[self.indexes.lifebalanceGroupIndex]:setValue(animalCount)
		-- 70:25:5
		-- 1v == (25/70)h && (5/70)c
		-- 0.36h  as in 1 vegetation can be consumed by atmost 0.36 herbivores
		-- 0.07   as in 1 vegetation can be consumed by atmost 0.07 carnivores but since canivores dont eat plants this ratio is useless
		-- 1h == (5/25)c
		-- 0.2    as in 1 herbivore can be consumed by atmost 0.2 carnivores 
		-- 1:0.36:0.2
		if animalCount.vegetation > 200 then --too much vegetation
			self:gameOver()
		end
		if animalCount.herbivorous > 72 then --too much herbivorous
			self:gameOver()
		end
		if animalCount.carnivorous > 14 then --too much carnivorous
			self:gameOver()
		end
		if ((animalCount.herbivorous * 1.0 ) / (animalCount.vegetation * 1.0 )) > 0.36 then --too much herbivorous
			self:gameOver()
		end
		if ((animalCount.carnivorous * 1.0 ) / (animalCount.herbivorous * 1.0 )) > 0.2 then --too much carnivorous
			self:gameOver()
		end
	end
end

function scene:gameOver()
	-- audio.pause( self.sceneAudioChannel ) 
	-- transition.pause( )
	-- util.gameIsPaused = true

	-- timer.pause( self.timer1 )
	-- --pause all animations
	-- util.stopAllAnimations = true 

	-- --hide the pause menu item
	-- self.view[self.indexes.pauseImageIndex].alpha = 0

	

	-- --capture screen
	-- local baseDir = system.TemporaryDirectory
	-- display.save( display.currentStage, "entireScreen.jpg", baseDir, display.contentCenterX, display.contentCenterY )
	
	-- --hide the time 
	-- if self.timeNow ~= nil then
	-- 	self.timeNow:removeSelf( )
	-- 	self.timeNow = nil
	-- end

	-- --show the game over scene
	-- composer.recycleOnSceneChange = true
 --    composer.gotoScene( "scenes.gameover", "fade", 400 )
end

function scene:win()
	-- audio.pause( self.sceneAudioChannel ) 
	-- transition.pause( )
	-- util.gameIsPaused = true

	-- timer.pause( self.timer1 )
	-- --pause all animations
	-- util.stopAllAnimations = true 

	-- --hide the pause menu item
	-- self.view[self.indexes.pauseImageIndex].alpha = 0

	

	-- --capture screen
	-- local baseDir = system.TemporaryDirectory
	-- display.save( display.currentStage, "entireScreen.jpg", baseDir, display.contentCenterX, display.contentCenterY )
	
	-- --hide the time 
	-- if self.timeNow ~= nil then
	-- 	self.timeNow:removeSelf( )
	-- 	self.timeNow = nil
	-- end

	-- --show the win scene
	composer.recycleOnSceneChange = true
    composer.gotoScene( "scenes.win", "fade", 400 )
end


function scene:timer( event )

	self.timeLimit = scene.timeLimit  - 1	
	local minutes = math.floor( self.timeLimit / 60 )
	local seconds = self.timeLimit - ( minutes * 60 )
	if minutes < 10 then
		minutes = "0" .. minutes
	end
	if seconds < 10 then
		seconds = "0" .. seconds
	end	
	local timeText = minutes .. ":" .. seconds
	--print(timeText)
	if self.timeNow ~= nill  then	
		self.timeNow:removeSelf( )
		self.timeNow = nil
	end

	self.view[self.indexes.gameGroupIndex][3]:countDown()
	self.view[self.indexes.gameGroupIndex][3]:countDownAnimal()

	self:trackAnimals(self.view[self.indexes.gameGroupIndex][3])

	if util.stopAllAnimations == false then 
		self.timeNow = util:textToPicture(timeText,1,display.contentCenterX-(120 / 2),50,30)
		if self.timeLimit <= 0 then
			timer.cancel( self.timer1 )
		end
	end
	if self.timeLimit <= 0 then
		self:win()
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

function scene:touch(event)
	local t = event.target
	local phase = event.phase
	if "began" == phase then
		-- Spurious events can be sent to the target, e.g. the user presses 
		-- elsewhere on the screen and then moves the finger over the target.
		-- To prevent this, we add this flag. Only when it's true will "move"
		-- events be sent to the target.
		t.isFocus = true
		self.view[self.indexes.gameGroupIndex].x0 = event.x - self.view[self.indexes.gameGroupIndex].x
		self.view[self.indexes.gameGroupIndex].y0 = event.y - self.view[self.indexes.gameGroupIndex].y
	elseif t.isFocus then
		if "moved" == phase then
			-- Make object move (we subtract t.x0,t.y0 so that moves are
			-- relative to initial grab point, rather than object "snapping").
			self.view[self.indexes.gameGroupIndex].x = event.x - self.view[self.indexes.gameGroupIndex].x0
			self.view[self.indexes.gameGroupIndex].y = event.y - self.view[self.indexes.gameGroupIndex].y0
			if self.view[self.indexes.gameGroupIndex].x > 0 then
			   self.view[self.indexes.gameGroupIndex].x = 0
			end
			if self.view[self.indexes.gameGroupIndex].x < -(0.5)* display.contentWidth then
			   self.view[self.indexes.gameGroupIndex].x = - (0.5)* display.contentWidth
			end
			if self.view[self.indexes.gameGroupIndex].y > 0 then
			   self.view[self.indexes.gameGroupIndex].y = 0
			end
			if self.view[self.indexes.gameGroupIndex].y < -(0.5)* display.contentHeight then
			   self.view[self.indexes.gameGroupIndex].y = - (0.5)* display.contentHeight
			end
		elseif "ended" == phase or "cancelled" == phase then
			t.isFocus = false
		end
	end
	return false
end



function scene:create( event )
	self.bgMusic = audio.loadStream( "assets/audios/level2BgMusic.wav" )
	
	local whiteRectangle = display.newRect( self.view , 0, 0, display.contentWidth, display.contentHeight )
	whiteRectangle.anchorX = 0
	whiteRectangle.anchorY = 0
	whiteRectangle:setFillColor( 143/255, 72/255, 49/255 )
	self:insertInView( whiteRectangle, "whiteRectangleIndex", false)

	


	local gameGroup = display.newGroup();
	gameGroup.anchorX = 0
	gameGroup.anchorY = 0
	gameGroup.x = -(1/2) * display.contentWidth
	gameGroup.y = -(1/2) * display.contentHeight

	local bgImage = display.newImage("assets/images/level2bg2.png")
	bgImage.width = display.contentWidth * 2
	bgImage.height = display.contentHeight * 2 
	bgImage.anchorX = 0
	bgImage.anchorY = 0
	bgImage.x = -0.5 * display.contentWidth
	bgImage.y = -0.5 * display.contentHeight
	gameGroup:insert( bgImage)


	local gamepacktrees = gamepacktrees:newGamepacktrees(10)
	gamepacktrees.x = - 0.5 * display.contentWidth
	gamepacktrees.y = - 0.5 * display.contentHeight
	gameGroup:insert(gamepacktrees)

	-- 1:0.36:0.2

	local vegetationGroup = vegetation:newVegetation(90) 
	vegetationGroup.x = - 0.5 * display.contentWidth
	vegetationGroup.y = - 0.5 * display.contentHeight

	animal:newAnimals(vegetationGroup)
	vegetationGroup:makeAnimals(6, animal.herbivorous, animal.zebra)
	vegetationGroup:makeAnimals(5, animal.herbivorous, animal.elephant)
	vegetationGroup:makeAnimals(4, animal.herbivorous, animal.kob)
	vegetationGroup:makeAnimals(3, animal.herbivorous, animal.giraff)
	vegetationGroup:makeAnimals(2, animal.herbivorous, animal.buffalo)
	vegetationGroup:makeAnimals(1, animal.carnivorous, animal.lion)
	vegetationGroup:makeAnimals(1, animal.carnivorous, animal.leopard)
	vegetationGroup:makeAnimals(1, animal.carnivorous, animal.tiger)
	vegetationGroup:animate()

	gameGroup:insert(vegetationGroup)



	-- local gamepacktrees2 = gamepacktrees:newGamepacktrees(10)
	-- gamepacktrees2.x = - 0.5 * display.contentWidth
	-- gamepacktrees2.y = - 0.5 * display.contentHeight
	-- gameGroup:insert(gamepacktrees2)


	self:insertInView( gameGroup, "gameGroupIndex")




 	local level1MenuBgImage = display.newImage( "assets/images/level1MenuBg.png" )
	level1MenuBgImage.height = 50
	level1MenuBgImage.contentHeight = 50
	level1MenuBgImage.width = display.contentWidth
	level1MenuBgImage.contentWidth = display.contentWidth	
	level1MenuBgImage.x = display.contentCenterX
	level1MenuBgImage.y = 10	
	self:insertInView( level1MenuBgImage, "level1MenuBgImageIndex")


	local animalwidgetGroup  = animalwidget:newAnimalWidget(0,display.contentHeight-32)
	self:insertInView( animalwidgetGroup, "animalwidgetGroupIndex")

	local lifebalanceGroup = lifebalance:newLifeBalance(display.contentWidth - 102, display.contentHeight - 122 );
	self:insertInView( lifebalanceGroup, "lifebalanceGroupIndex")

	self:insertInView( heart:createHearts(3) , "heartsGroupIndex")
	local heartsGroup = self.view[self.indexes.heartsGroupIndex]
	for i = 1, heartsGroup.numChildren do
		heartsGroup[i]:animate()
	end	

	self:insertInView( pollutionmeter:newPollutionMeter( 100 , 10, 
		function() 
			--composer.gotoScene( "scenes.menu" )
		end
	), "polutionMeterIndex" )

	
	local levelText = display.newText("level : 3", 250, 10, native.systemFont, 18 )
	levelText.anchorX = 0
	levelText:setFillColor( 245/255, 152/255, 169/255 )
	self:insertInView( levelText, "levelTextIndex")

	self:insertInView( score:newScore(350, 8) , "scoreIndex")

	local pauseImage = display.newImage( "assets/images/pause.png" )
	pauseImage.x = display.contentWidth - 20
	pauseImage.y = 18
	pauseImage.height = 45
	pauseImage:addEventListener( "touch", 
		function ( event )
			if event.phase == "began" then	
				if util.gameIsPaused == true then
					timer.resume(self.timer1 )	
					audio.resume(self.sceneAudioChannel )
					transition.resume()
					util.gameIsPaused = false
				else
					timer.pause( self.timer1 )	
					audio.pause( self.sceneAudioChannel )
					transition.pause( )
					util.gameIsPaused = true
				end
				return true
			end
		end
	);
	self:insertInView(pauseImage,"pauseImageIndex")



	local clearRectangle = display.newRect( -(1/2) * display.contentWidth, -(1/2) * display.contentHeight, display.contentWidth * 2, display.contentHeight * 2 )
	clearRectangle.anchorX = 0
	clearRectangle.anchorY = 0
	clearRectangle:setFillColor( 143/255, 72/255, 49/255, 0.1 )
	--clearRectangle.strokeWidth = 1
	clearRectangle:addEventListener("touch",self)
	self:insertInView( clearRectangle, "clearRectangleIndex")


	local polluterGroup = polluter:newPolluter(100,display.contentHeight - 95);
	self:insertInView(polluterGroup, "polluterGroupIndex")



	local leftBlackRectangle = display.newRect( self.view , -60, 0, 60, display.contentHeight )
	leftBlackRectangle.anchorX = 0
	leftBlackRectangle.anchorY = 0
	leftBlackRectangle:setFillColor( 0 )
	self:insertInView( leftBlackRectangle, "leftBlackRectangleIndex", false)

	local rightBlackRectangle = display.newRect( self.view , display.contentWidth, 0, 60, display.contentHeight )
	rightBlackRectangle.anchorX = 0
	rightBlackRectangle.anchorY = 0
	rightBlackRectangle:setFillColor( 0 )
	self:insertInView( rightBlackRectangle, "rightBlackRectangleIndex", false)
	

	
	self.timer1 = timer.performWithDelay( 1000, self , -1)

	timer.performWithDelay(5000,function()
		audio.play(animal.sounds["anim" .. math.random(1,5)])
	end, -1)
end

function scene:show( event )
	audio.play( self.bgMusic, { channel= self.sceneAudioChannel, loops=-1 , fadein=1000 } )
end

function scene:hide( event )

	if self ~= nil then
		self.nextIndex = 0
		self.indexes = {}
		self.volumeLabel = {}
		self.timeLimit = 188
		self.state = "playing"
	end
	
	composer.recycleOnSceneChange = true
	--stop the music
	print("stopping setting audio " .. self.sceneAudioChannel)
	audio.stop( self.sceneAudioChannel )

	
end

function scene:destroy( event )
	if self ~= nil then
		self.nextIndex = 0
		self.indexes = {}
		self.volumeLabel = {}
		self.timeLimit = 188
		self.state = "playing"
	end

	composer.recycleOnSceneChange = true
	
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene;