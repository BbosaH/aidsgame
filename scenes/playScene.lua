
local score  = require("objects.score")
local composer  = require( "composer"  )
local widget= require("widget")
local grid = require("algoritmpuzzle.grid")
local quiz = require("questions.quiz")
local ut =require ("utils.util")
local scene = composer.newScene(  )
composer.recycleOnSceneChange = true
scene.sceneAudioChannel = util:getNextAudioChannel()
scene.nextIndex = 0
scene.indexes = {}
scene.volumeLabel = {}
scene.timeLimit = 188
scene.state = "playing"
util.pollutionLevel = 0
scene.board = {}
scene.cells = {}
local xes = {}
local yes = {}
local played = {}
local mode = "normal"
local d = nil
local dd = nil
local cntDrag = 0




--dialog_group.alpha=0

function scene:timer( event )
	if  modez == "normal" or modez == "question"  then
		timeTaken = timeTaken + 1
		timeText.text = "Time: "..timeTaken.." sec"
	elseif modez == "win" then
		timer.cancel(event.source)
		self.timer1 = nil
 	end
end

function win()
	-- --show the win scene
	composer.recycleOnSceneChange = true

	transition.to(wingroup,{alpha = 0.97,time=500,rotation = 360, onComplete = function()  wingroup.parent:insert(wingroup) end})
	
   -- composer.gotoScene( "scenes.win", "fade", 400 )
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
	
	local lev = util:getLevel()
	self.bgMusic = audio.loadStream( "assets/audios/level1BgMusic.mp3" )
	 --level_one = newGroup()
	
	--[[local whiteRectangle = display.newRect(0, 0, display.contentWidth, display.contentHeight )
	whiteRectangle.anchorX = 0
	whiteRectangle.anchorY = 0
	--whiteRectangle:setFillColor( 143/255, 72/255, 49/255 )
	whiteRectangle:setFillColor( 1,0, 0 )
	--self:insertInView( whiteRectangle, "whiteRectangleIndex", false)--]]

	local bgu = display.newImage("assets/images/wood_texture.png")
	bgu.x = display.contentWidth / 2
	bgu.y = display.contentHeight / 2
	self.view:insert(bgu)

	
	
	--whiteRectangle:setFillColor( 143/255, 72/255, 49/255 )
	
	--[[local score_Rectangle = display.newRoundedRect(  0, 5, display.contentWidth+20, 20 ,10)
	score_Rectangle.anchorX = 0
	score_Rectangle.anchorY = 0
	score_Rectangle.strokeWidth= 0
	score_Rectangle:setFillColor(0,0,0)
	score_Rectangle:setStrokeColor( 0,0,1 )
	score_Rectangle.alpha=0.2--]]

	--[[local diso_Rectangle = display.newRoundedRect(  0, 55, 180, display.contentHeight-60 ,10)
	diso_Rectangle.anchorX = 0
	diso_Rectangle.anchorY = 0
	diso_Rectangle.strokeWidth= 0
	diso_Rectangle:setFillColor(0,0,0)
	diso_Rectangle:setStrokeColor( 0,0,1 )
	diso_Rectangle.alpha=0.2--]]
	--whiteRectangle:setFillColor( 143/255, 72/255, 49/255 )
	local play_Rectangle = display.newRoundedRect(0, 32, display.contentWidth+20, display.contentHeight-35 ,20)
	play_Rectangle.anchorX = 0
	play_Rectangle.anchorY = 0
	play_Rectangle.strokeWidth= 0
	play_Rectangle:setStrokeColor( 0,0,1 )
	play_Rectangle:setFillColor(0,0,0)
	play_Rectangle.alpha=0.5
	
	self.view:insert(play_Rectangle)
	
	--[[local dialog= display.newRoundedRect(display.contentWidth/2,display.contentHeight/2,400,250,10)
	dialog.anchorX=0.5
	dialog.anchorY=0.5
	dialog:setFillColor(0,0,0)
	dialog.alpha=0.5--]]




	local levelText = display.newText("Level : " .. lev, 7, 15, native.SystemFontBold, 18 )
	levelText.anchorX = 0
	levelText:setFillColor( 1/255, 0/255, 0/255 )
	levelText.alpha=0.5;
	self.view:insert(levelText)

	scoreText = display.newText("Score: 000000", 100, 15, native.SystemFontBold, 18 )
	scoreText.anchorX = 0
	scoreText:setFillColor( 0/255, 0/255, 0/255 )
	scoreText.alpha=0.5;
	self.view:insert(scoreText)


	timeText = display.newText("Time: 200 sec", 240, 15, native.SystemFontBold, 18 )
	timeText.anchorX = 0
	timeText:setFillColor( 0/255, 0/255, 0/255 )
	timeText.alpha=0.5;
	self.view:insert(timeText)
	--levelText:setTextColor(0,0,0)
	--levelText.alpha=0.4;



    
	prevText = display.newText("Preview", 370, 15, native.SystemFontBold, 18 )
	prevText.anchorX = 0
	prevText:setFillColor( 0/255, 0/255, 0/255 )
	prevText.alpha=0.5;
	function prevText:touch(event)
		if event.phase == "began" then
			if modez == "normal" and prevcounts > 0 then
				prevcounts = prevcounts - 1
				modez = "Preview"
				if prevcounts <= 0 then
					prevText.alpha = 0.3
				end
				transition.to(preview,{alpha = 1, time=500, onComplete = function() 
					timer.performWithDelay( 10000, function ()
						preview.alpha = 0
						modez = "normal"
					end , 0)
				end})
			end
		end
	end
	prevText:addEventListener("touch",prevText);
	self.view:insert(prevText)
	
	xText = display.newText("X", 470, 15, native.SystemFontBold, 18 )
	xText.anchorX = 0
	xText:setFillColor( 0/255, 0/255, 0/255 )
	xText.alpha=0.5;
	function xText:touch(event)
		if event.phase == "began" and modez == "normal" then
			wingroup.alpha = 0	
			playedLetters = {}
			plays = 0
			answered = 0
			modez = "normal"
			playedLetters = {}
			timeTaken = 0
			playerScore = 0
			grid.filledCordinates = {}
			local composer = require("composer")
			composer.removeScene( "scenes.menu" )	
			composer.gotoScene( "scenes.menu", "slideLeft", 800  )
		end
	end
	xText:addEventListener("touch",xText);
	self.view:insert(xText)
	

	--[[local pauseImage = display.newImage( "assets/images/pause.png" )
	pauseImage.x = display.contentWidth - 20
	pauseImage.y = 18
	pauseImage.height = 45
	pauseImage:addEventListener( "touch", 
		function ( event )
			if event.phase == "began" then	
				-- if d ~= nil  then
				-- 	transition.to(d,{alpha=0, time=500, onComplete = function() 
				-- 		mode = "normal"
				-- 	end});
				-- end
				if util.gameIsPaused == true then
					--timer.resume(self.timer1 )	
					--audio.resume(self.sceneAudioChannel )
					--transition.resume()
					--util.gameIsPaused = false
				else
					--timer.pause( self.timer1 )	
					--audio.pause( self.sceneAudioChannel )
					--transition.pause( )
					--util.gameIsPaused = true
				end
				return true
			end
		end
	);
	self:insertInView(pauseImage,"pauseImageIndex")--]]

 


	self.timer1 = timer.performWithDelay( 1000, self , -1)
	
	print ("the level is  >>>>>>>>>>>>>>>>>>>>>>>>   ", lev)
	self:createEmptyGrid(tonumber(lev))
	

	---one question dialog------------

	

	---win stuff
	wingroup = display.newGroup()
    windialog= display.newRoundedRect(display.contentWidth/2,(display.contentHeight/2)+10,400,250,10)
	windialog.anchorX=0.5
	windialog.anchorY=0.5
	windialog:setFillColor(0,0,0)
	--windialog.alpha=0
	wingroup:insert(windialog)

	youImage = display.newImage("assets/images/you.png")
	youImage.x=(display.contentWidth/2)-50
	youImage.y=(display.contentHeight/2)-70
	youImage.anchorX=0.5
	youImage.anchorY=0.5

	winImage = display.newImage("assets/images/win.png")
	winImage.x=(display.contentWidth/2)+40
	winImage.y=(display.contentHeight/2)-70
	winImage.anchorX=0.5
	winImage.anchorY=0.5

	starImage = display.newImage("assets/spritesheets/starsSpriteSheet.png")
	starImage.x=(display.contentWidth/2)+5
	starImage.y=(display.contentHeight/2)-20
	starImage.xScale=0.5
	starImage.yScale=0.5
	starImage.anchorX=0.5
	starImage.anchorY=0.5

	local finalscoreText = display.newText("Total " .. scoreText.text, 50, 200, native.systemFontBold, 24 )
	finalscoreText.anchorX = 0
	finalscoreText:setFillColor( 1)
	finalscoreText.alpha=0.8;


	local finalTimeText = display.newText(timeText.text , 50, 230, native.systemFontBold, 24 )
	finalTimeText.anchorX = 0
	finalTimeText:setFillColor( 1 )
	finalTimeText.alpha=0.8;

	local menuBtnf = display.newText("MENU", 300, 270, native.systemFontBold, 24 )
	menuBtnf.anchorX = 0
	menuBtnf:setFillColor( 1 )
	menuBtnf.alpha=0.5;
	function menuBtnf:touch( event )
		if event.phase == "began" then	
			wingroup.alpha = 0	
			playedLetters = {}
			plays = 0
			answered = 0
			modez = "normal"
			playedLetters = {}
			timeTaken = 0
			playerScore = 0
			grid.filledCordinates = {}
			local composer = require("composer")
			composer.removeScene( "scenes.menu" )	
			composer.gotoScene( "scenes.menu", "slideLeft", 800  )					
		end
		return true
		--wingroup.alpha = 0		
		--composer.gotoScene( "scenes.menu", "slideLeft", 800  )	
		--composer.gotoScene( "scenes.splash", "fade", 400 )
	end
	menuBtnf:addEventListener("touch",menuBtnf)


	wingroup:insert(youImage)
	wingroup:insert(winImage)
	wingroup:insert(starImage)   
	wingroup:insert(finalscoreText)
	wingroup:insert(finalTimeText)
	wingroup:insert(menuBtnf)
	wingroup.alpha=0

	---//win stuff

	-- the grid
	--grid:new( 6,4 )

	--[[local xint = 230
	local yint = 45
	local test = display.newImage("assets/masks/I.png")
	test.anchorX = 0.5
	test.anchorY = 0.5
	test.width = 65 + 28
	test.height = 65 + 28
	test.x = xint + 32.5
	test.y = yint + 32.5--]]


end

function scene:createEmptyGrid( ... )
	local level = ...
	local dimx =0 local xint = 0  local yint = 0 
	local dimy =0
	if level == 1 then 
		xint = 230--100  --230
		yint = 45  --5
		dimx =4
		dimy =4
	elseif  level == 2 then
		xint = 165  --230
		yint = 45  --5
		dimx =4
		dimy =5
	elseif  level == 3 then
		xint = 100  --230
		yint = 45  --5
		dimx =4
		dimy =6
	end
	--local xint = 100  --230
	--local yint = 5  --45
	local num = 1
	local col =1
	local row = 1
	for i=1, dimx do
		local y = (yint+(65*(i-1)))
		yes[i] = y
		local foo = {}
		for j=1, dimy do
			foo[j] = "n"
			played[i..""..j] = 0
			local x = xint+(65*(j-1))
			xes[j] = x
			local cell = display.newRect(x,y,65,65);
			cell.anchorX = 0
			cell.anchorY = 0
			
				if i==1 or (i%2)==1 then
					if j == 1  or (j%2)==1 then
						cell:setFillColor(j/1)	
						--cell:setFillColor(242/255,243/255,242/255)
					elseif (j%2)==0  then
						--cell:setFillColor(192/255,192/255,192/255)
						cell:setFillColor(239/255,163/255,15/255)
					end
				elseif (i%2)==0  then
					if j == 1 or (j%2)==1 then
						cell:setFillColor(239/255,163/255,15/255)
					elseif (j%2)==0 then
						cell:setFillColor(1)
					end
				end
				row = row + 1
			
			self.view:insert(cell)
			self.cells[num] = cell
			-- local tile = display.newImage("assets/images/img" .. 2 ..".png");
			-- tile.anchorX = 0.5
			-- tile.anchorY = 0.5
			-- tile.rotation = math.random(360)
			-- tile.x = math.random(tile.width, 200 - tile.width)
			-- tile.y = math.random(100 + tile.height, display.contentHeight - (tile.height * 2))			
			-- function tile:touch( event )
			-- 	local t = event.target

			-- 	local phase = event.phase
			-- 	if "began" == phase  and mode ~= "question" then
			-- 		-- Make target the top-most object
			-- 		local parent = t.parent
			-- 		parent:insert( t )
			-- 		display.getCurrentStage():setFocus( t )

			-- 		if t.cell ~= nil then
			-- 				played[t.cell] = 0
			-- 				t.cell = nil
			-- 		end

			-- 		-- Spurious events can be sent to the target, e.g. the user presses 
			-- 		-- elsewhere on the screen and then moves the finger over the target.
			-- 		-- To prevent this, we add this flag. Only when it's true will "move"
			-- 		-- events be sent to the target.
			-- 		t.isFocus = true

			-- 		-- Store initial position
			-- 		t.x0 = event.x - t.x
			-- 		t.y0 = event.y - t.y
			-- 	elseif t.isFocus   and mode ~= "question" then
			-- 		if "moved" == phase then
			-- 			-- Make object move (we subtract t.x0,t.y0 so that moves are
			-- 			-- relative to initial grab point, rather than object "snapping").
			-- 			t.x = event.x - t.x0
			-- 			t.y = event.y - t.y0
			-- 		elseif "ended" == phase or "cancelled" == phase then
			-- 			if t.x > 200 and t.y > 40 then 
			-- 				t.rotation = 0
			-- 				local xx = 0
			-- 				local yy = 0
			-- 				local cely = 0
			-- 				local celx = 0
			-- 				for i =1, 4 do
			-- 					if t.y > yes[i] then
			-- 						yy = yes[i]
			-- 						cely = i
			-- 					end
			-- 					for j = 1, 4 do
			-- 						if t.x > xes[j] then
			-- 							xx = xes[j]
			-- 							celx = j
			-- 						end
			-- 					end
			-- 				end
			-- 				if cely ~= 0 and celx ~= 0 then
			-- 					if played[cely..""..celx] == 0 then
			-- 						t.x = xx + ( 65 / 2)
			-- 						t.y = yy + (65 / 2)
			-- 						played[cely..""..celx] = 1
			-- 						t.cell = cely..""..celx
			-- 						cntDrag = cntDrag + 1
									
			-- 					else
			-- 						t.rotation = 0
			-- 						transition.to(t,{x = math.random(t.width, 200 - t.width),time=500,rotation = math.random(360)})
			-- 					end
			-- 				end
			-- 			else
			-- 				t.rotation = math.random(360)
			-- 			end
			-- 			display.getCurrentStage():setFocus( nil )
			-- 			t.isFocus = false

			-- 			if cntDrag == 3 then
			-- 				cntDrag = 0
			-- 				if  mode == "normal"  then
			-- 				 	mode = "question"
			-- 					if d ~= nil  then
			-- 						 d.alpha = 1
			-- 						 parent  = d.parent
			-- 						 parent:insert( d )
			-- 						 d.isFocus = true
			-- 					end 
			-- 			 	end
			-- 			end

			-- 			local tot = 0
			-- 			for i =1, dimx do
			-- 				for j = 1, dimy do
			-- 					tot = tot + played[i..""..j] 
			-- 				end
			-- 			end
			-- 			if level==1 then
			-- 				if tot == 16 then
			-- 					win();
			-- 				end
			-- 			elseif level ==2 then
			-- 				if tot == 20 then
			-- 					win();
			-- 				end
			-- 			elseif level ==3 then
			-- 				if tot == 20 then
			-- 					win();
			-- 				end
			-- 			end
						
			-- 		end
			-- 	end

			-- 	-- Important to return true. This tells the system that the event
			-- 	-- should not be propagated to listeners of any objects underneath.
			-- 	return true
			-- end
			-- tile:addEventListener( "touch", tile )
			-- self.board[num] = tile
			
				num = num + 1
				--row = row + 1
				
			--end
		end
		playedLetters[i] = foo
	end


	grid:new(dimy,dimx,xint,yint, self.view )
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