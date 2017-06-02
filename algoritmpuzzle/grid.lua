local tile = require("algoritmpuzzle.tile")
local judiciary= require("algoritmpuzzle.judiciary")
local quiz = require("questions.quiz")
grid={
	width=0,
	height=0,
	tiles={
		A=tile:new({"f","f","v","v"}),
		B=tile:new({"f","f","p","v"}),
		C=tile:new({"f","f","p","p"}),
		D=tile:new({"f","f","v","p"}),
		E=tile:new({"v","v","v","v"}),
		F=tile:new({"v","p","v","v"}),
		G=tile:new({"v","p","p","v"}),
		H=tile:new({"v","p","p","p"}),
		I=tile:new({"p","p","p","p"}),
		J=tile:new({"f","v","v","v"}),
		K=tile:new({"f","p","v","v"}),
		L=tile:new({"f","p","p","v"}),
		M=tile:new({"f","p","p","p"}),
		N=tile:new({"f","v","p","v"}),
		O=tile:new({"f","p","v","p"}),
		P=tile:new({"f","v","p","p"}),
		Q=tile:new({"f","v","v","p"})
	},
	column_no =4,
	row_no=4,
	board={},
	chops = {},	
	composites = {},
	filledCordinates = {},
	dna
}

function grid:orient_tile(tile,degree )
	local a=tile.boundary[1]
	local b=tile.boundary[2]
	local c=tile.boundary[3]
	local d=tile.boundary[4]

	if degree==0 then
		a,b,c,d=a,b,c,d
	elseif degree==90 then
		a,b,c,d=d,a,b,c
	elseif degree==180 then
		a,b,c,d=c,d,a,b
	elseif degree == 270 then
		a,b,c,d=b,c,d,a
	end
	tile.boundary={a,b,c,d}
	tile.orientation = degree
	return tile, degree
end

function grid:new( column_no,row_no,xint,yint, view )
	local o={}
 	setmetatable(o,self)
 	self.__index=self
 	o.column_no=column_no
 	o.row_no=row_no
 	local previous_tile=nil
 	local randomchoice=math.random(4)
 	o:fill_default_board( )
 	o:fill_board()
    --o:pull_masks(xint,yint)
    --o:chop_image(xint,yint)
 	o:make_tile_composites(xint,yint, view)
 	o.filledCordinates = {}
 	local imageName = "assets/images/default"..selectedImage..(tileSize * o.column_no )..( tileSize *  o.row_no)..".png";
 	preview = display.newImage(imageName);
 	preview.anchorX = 0
 	preview.anchorY = 0
 	preview.x = xint
 	preview.y = yint
 	preview.alpha = 0
 	return o
end

function grid:fill_default_board( ... )
	
	for i=1,self.row_no do
 		local temp= {}
 		for j=1,self.column_no do
 			local default_tile=  tile:new({"n","n","n","n"})
 			
 			if i==1 or i==self.row_no  then
 				default_tile.boundary[judiciary:where_is_fy(i,self.row_no)] = "f"
 			end
 			if j==1 or j==self.column_no  then
 				default_tile.boundary[judiciary:where_is_fx(j,self.column_no)] = "f" --what we see now
 			end
 			temp[j]=default_tile
 			
 		end
 		self.board[i] = temp
 		
 	end
 	--print("check this ",self.board[4][4]:name_mask()) 
	-- body
end

function  grid:fill_board( ... )
	self.dna = ""
	for i=1,self.row_no do
 		for j=1,self.column_no do
 				--current tile
 				--print("where we are  >>"..i..j)
 				local current_tile=self.board[i][j]
 				--print("found boundary>>" ,current_tile:name_mask()) 
 				local texture = current_tile:name_mask() 				
 				local rule_set = judiciary[texture]
 				--print("rule set number of contents>>  " , #rule_set)
 				for k=1,#rule_set do
 					local rotation,tiles =rule_set[k].rotation ,rule_set[k].tiles
 					--print("rule at " .. k .. " rotation is >>" , rotation .. "   " .. "tiles are  >>" , unpack(tiles))
 				end
 				local foo = math.random(#rule_set)
 				--print("choosen rule at " , foo)
 				local rule = rule_set[foo]
 				local rotation = rule.rotation
 				local letter = rule.tiles[math.random(#(rule.tiles))]
 				self.dna = self.dna .. letter .. rotation
 				--print("rotation is " .. rotation .. " and letter is " .. letter )
 				local masked_tile = tile:new( self.tiles[letter].boundary)
 				masked_tile.name = letter
 				--print("masket tile name " .. masked_tile.name .. " and boundary " .. masked_tile:name_mask() )
 				--fiting sizes
 				local the_boundary = masked_tile.boundary
 				local L,T,R,B  = unpack(the_boundary)
 				local widthInc = 0
 				local heightInc = 0
 				local juice = 13
 				if L == 'p' then
 					widthInc = widthInc + juice
 				end
 				if T == 'p' then
 					heightInc = heightInc + juice
 				end
 				if R == 'p' then
 					widthInc = widthInc + juice
 				end
 				if B == 'p' then
 					heightInc = heightInc + juice
 				end
 				masked_tile.width_inc = widthInc
				masked_tile.height_inc = heightInc
 				--//fitting sizes
 				masked_tile = self:orient_tile(masked_tile,rotation)
 				masked_tile.orientation = rotation
 				--print("after orient at " .. rotation  .. " name = "  .. masked_tile.name .. " and boundary " .. masked_tile:name_mask().. masked_tile.orientation  )
 				self.board[i][j] = masked_tile
 				--neighbouring tile across
 				if j < self.column_no and i < self.row_no then
 					self.board[i][j+1].boundary[1] = masked_tile.boundary[3]
 					self.board[i+1][j].boundary[2] = masked_tile.boundary[4]
 				elseif j == self.column_no and i < self.row_no then
 					self.board [i+1][j].boundary[2] = masked_tile.boundary[4]
 				elseif i == self.row_no and j < self.column_no  then
 					self.board[i][j+1].boundary[1] = masked_tile.boundary[3]
 				end 
 				--[[
 				if j < self.column_no then
					self.board[i][j+1].boundary[1] = masked_tile.boundary[3] 						
 				else if j =self.column_no and i < self.row_no then
 					self.board [i+1][j].boundary[2] = masked_tile.boundary[4]	
 				end
 				if i < self.row_no then
 					self.board[i+1][j].boundary[2] = masked_tile.boundary[4]
 				elseif i = self.row_no and j < column_no  then
 					self.board[i][j+1].boundary[1] = masked_tile.boundary[3]
 				end--]]
 			
 		end
 	end
end

function grid:pull_masks(xint,yint)
	--local xint = 230
	--local yint = 45

	for i=1,self.row_no do
		local y = (yint+(tileSize*(i-1)))
 		for j=1,self.column_no do
 			local x = xint+(tileSize*(j-1))
 			local current_tile=self.board[i][j]
 			local realmask = display.newImage("assets/masks/".. current_tile.name .. ".png")
 			realmask.anchorX = 0.5
 			realmask.anchorY = 0.5
 			realmask.width = tileSize  --+ current_tile.width_inc
 			realmask.height = tileSize --+ current_tile.height_inc
 			realmask.x = x + (tileSize / 2)
 			-- if  current_tile.width_inc == 13 then
 			-- 	realmask.x = realmask.x  + 6.5
 			-- elseif  current_tile.width_inc == 26 then
 			-- 	realmask.x = realmask.x  + 13
 			-- end
 			-- if  current_tile.height_inc == 13 then
 			-- 	realmask.y = realmask.y  + 6.5
 			-- elseif  current_tile.height_inc == 26 then
 			-- 	realmask.y = realmask.y  + 13
 			-- end
 			realmask.y = y + (tileSize/2)

 			realmask.rotation = current_tile.orientation
 			--print("tile " .. i .. j.. current_tile.name .. " " .. current_tile.orientation, current_tile:name_mask() )
 		end
 	end
end

function grid:getChop(row,col)
	local options =
	{
	    width = tileSize,
	    height = tileSize,
	    numFrames = self.row_no * self.column_no,
	    sheetContentWidth = tileSize * self.column_no ,  -- width of original 1x size of entire sheet
	    sheetContentHeight = tileSize *  self.row_no -- height of original 1x size of entire sheet
	}
	local imageName = "assets/images/default"..selectedImage..(tileSize * self.column_no )..( tileSize *  self.row_no)..".png";

	----print("imgName:"..imageName)
	----print(row, col, options.numFrames)
	local imageSheet = graphics.newImageSheet( imageName, options )

	local count = 0
	for i=1,self.row_no do
 		for j=1,self.column_no do
 			count = count + 1
 			----print("at",i,j)
 			if j == col and i == row then
 				
 				local paint = {
			    	type = "image",
			    	sheet = imageSheet,
			    	frame = count
				}

				local rect = display.newRect( 0, 0, tileSize  , tileSize  )
				rect.anchorX = 0.5
				rect.anchorY = 0.5
				rect.fill = paint
				return rect
 			end
 		end
 	end
end

function grid:chop_image(xint,yint)
	local options =
	{
	    width = tileSize,
	    height = tileSize,
	    numFrames = self.row_no * self.column_no,
	    sheetContentWidth = tileSize * self.column_no ,  -- width of original 1x size of entire sheet
	    sheetContentHeight = tileSize *  self.row_no -- height of original 1x size of entire sheet
	}
	local imageName = "assets/images/default3"..(tileSize * self.column_no )..( tileSize *  self.row_no)..".png";
	--print("imgName:"..imageName)
	local imageSheet = graphics.newImageSheet( imageName, options )

	local count = 0
	for i=1,self.row_no do
		local temp= {}
		local y = (yint+(tileSize*(i-1)))
 		for j=1,self.column_no do
 			local x = xint+(tileSize*(j-1))
			count = count + 1

			local paint = {
		    	type = "image",
		    	sheet = imageSheet,
		    	frame = count
			}

			local rect = display.newRect( x + (tileSize/2), y + (tileSize/2), tileSize  , tileSize  )
			rect.anchorX = 0.5
			rect.anchorY = 0.5
			rect.fill = paint

			
			temp[j]=rect
		end
		self.chops[i] = temp
	end
end

function grid:make_tile_composites(xint,yint,view)
	print( self.dna)
	for i=1,self.row_no do
		local temp = {}
 		for j=1,self.column_no do
 			local current_tile=self.board[i][j]



 			local composite = display.newGroup()
 			composite.anchorX = 0.5
 			composite.anchorY = 0.5
 			composite.name = current_tile.name
 			composite.xint = xint
 			composite.yint = yint
 			composite.gridWidth = tileSize * self.column_no
 			composite.gridHeight = tileSize *  self.row_no 
 			composite.grid = self
 			composite.orientation = current_tile.orientation
 			function composite:touch(event )
				local t = event.target
				local phase = event.phase
				if "began" == phase and modez == "normal" then
					local cord = grid.filledCordinates[t.x .. t.y]
					if cord ~= nil   then
						grid.filledCordinates[t.x .. t.y].value =  "empty"
						local cellx = grid.filledCordinates[t.x .. t.y].cellx
						local celly = grid.filledCordinates[t.x .. t.y].celly
						playedLetters[celly][cellx] = "n"
					end
						
					-- Make target the top-most object
					local parent = t.parent
					parent:insert( t )
					display.getCurrentStage():setFocus( t )

					-- Spurious events can be sent to the target, e.g. the user presses 
					-- elsewhere on the screen and then moves the finger over the target.
					-- To prevent this, we add this flag. Only when it's true will "move"
					-- events be sent to the target.
					t.isFocus = true

					-- Store initial position
					t.x0 = event.x - t.x
					t.y0 = event.y - t.y
				elseif t.isFocus  then
					if "moved" == phase and modez == "normal" then
						-- Make object move (we subtract t.x0,t.y0 so that moves are
						-- relative to initial grab point, rather than object "snapping").
						t.x = event.x - t.x0
						t.y = event.y - t.y0
					elseif ("ended" == phase or "cancelled" == phase ) and modez == "normal"  then
						
						display.getCurrentStage():setFocus( nil )
						t.isFocus = false
						local lowerX = - t.width / 2 + tileSize / 2
						local upperX = t.xint - (tileSize * 2) - 15
						local lowerY = 0
						local upperY = display.contentHeight - t.height / 2 - tileSize / 2 - 10
						if event.x > t.xint and event.y  > t.yint and event.x < display.contentWidth - 5 and event.y < display.contentHeight - 10 then
							local xx = t.xint
							local cellx = 0
							local celly = 0
							for m = 1, 6 do
								local xnow = t.xint + (tileSize * (m - 1))
								if event.x > xnow then
									xx = xnow
									cellx = m
								end
							end
							t.x = xx - tileSize
							local yy = t.yint
							for m = 1, 6 do
								local ynow = t.yint + (tileSize * (m - 1))
								if event.y > ynow then
									yy = ynow
									celly = m
								end
							end
							t.y = yy - tileSize
							
							--the cord
							local cord = grid.filledCordinates[t.x .. t.y]
							if cord == nil  or cord.value == "empty" then
								plays = plays + 1
								
								grid.filledCordinates[t.x .. t.y] = { value = "filled", cellx = cellx, celly = celly}
								playedLetters[celly][cellx] =  t.name..t.orientation
								--the winning
								local totals = 0
								local playedTotals = 0
								for k = 1, #playedLetters do
									local cols = playedLetters[k]
									for l = 1, #cols do
										totals = totals + 1
										local thisLetter= cols[l]
										if thisLetter ~= "n" then
											playedTotals = playedTotals + 1
										end
									end
								end
								if totals == playedTotals then
									if t.grid.dna == t.grid:getPlayersDna() then
										modez = "win"
										transition.to(wingroup,{alpha = 0.97,time=500,rotation = 360, onComplete = function() 
										 	wingroup.parent:insert(wingroup) 
										 	wingroup[5].text = "Total " .. scoreText.text
										 	wingroup[6].text = timeText.text

										 end})
									end
								else
									if plays == 3 then
										modez = "question"
										quiz:new(math.random(58))
									end
								end
							else
								transition.to(t, { 
									x = math.random(lowerX,upperX),
									y = math.random(lowerY,upperY),
									time = 500,
									onComplete = function()
									end
								})
							end
						else
							--print("cords ", lowerX, upperX)
							transition.to(t, { 
								x = math.random(lowerX,upperX),
								y = math.random(lowerY,upperY),
								time = 500,
								onComplete = function()
								end
							})
						end 
						print(t.grid:getPlayersDna())
					end
				end

				-- Important to return true. This tells the system that the event
				-- should not be propagated to listeners of any objects underneath.
				return true
 			end
 			composite:addEventListener( "touch", composite )

 			--local blackRect = display.newRect(0,0,tileSize,tileSize)
 			--blackRect:setFillColor(1/16)
 			--blackRect.x = tileSize / 2
 			--blackRect.y = tileSize / 2
 			--local plainMask = graphics.newMask( "masks2/plain.png" )
			-- blackRect:setMask( plainMask )
		 	--blackRect.maskX = -tileSize / 2
		 	--blackRect.maskY = -tileSize / 2
 			--composite:insert(blackRect)

 			if i == 1 then
	 			--local blackRect2 = display.newRect(0,0,tileSize,tileSize)
	 			--blackRect2:setFillColor(2/16)
	 			--blackRect2.x = tileSize + (tileSize / 2)
	 		    --blackRect2.y = tileSize / 2
	 			--blackRect2:setMask( plainMask )
			 	--blackRect2.maskX = -tileSize / 2
			 	--blackRect2.maskY = -tileSize / 3
	 			--composite:insert(blackRect2)
	 		else
	 			local current_square = self:getChop(i-1,j)
	 			current_square.x = tileSize + (tileSize / 2)
	 			current_square.y = tileSize / 2
	 			current_square:setMask( plainMask )
			 	--current_square.maskX = -tileSize / 2
			 	current_square.maskY = -tileSize / 3
	 			composite:insert(current_square)
	 		end

 			--local blackRect3 = display.newRect(0,0,tileSize,tileSize)
 			--blackRect3:setFillColor(3/16)
 			--blackRect3.x = (tileSize * 2 ) + (tileSize / 2)
 			--blackRect3.y = tileSize / 2
 			--blackRect3:setMask( plainMask )
 			--composite:insert(blackRect3)


 			if j == 1 then
	 			--local blackRect4 = display.newRect(0,0,tileSize,tileSize)
	 			--blackRect4:setFillColor(4/16)
	 			--blackRect4.x = tileSize / 2
	 			--blackRect4.y = tileSize + (tileSize / 2)
	 			--blackRect4:setMask( plainMask )
			 	--blackRect4.maskX = -tileSize / 3
			 	--blackRect4.maskY = -tileSize / 3
	 			--composite:insert(blackRect4)
	 		else
	 			local current_square = self:getChop(i,j-1)
	 			current_square.x = tileSize / 2
	 			current_square.y = tileSize + (tileSize / 2)
	 			current_square:setMask( plainMask )
			 	current_square.maskX = -tileSize / 3
			 	--current_square.maskY = -tileSize / 3
	 			composite:insert(current_square)
 			end

 			local current_square = self:getChop(i,j)
 			current_square.x = tileSize + tileSize / 2
 			current_square.y = tileSize + (tileSize / 2)
	 		composite:insert(current_square)

	 		if j == self.column_no then
	 			--local blackRect6 = display.newRect(0,0,tileSize,tileSize)
	 			--blackRect6:setFillColor(6/16)
	 			--blackRect6.x = tileSize * 2 + tileSize / 2
	 			--blackRect6.y = tileSize + (tileSize / 2)
	 			--composite:insert(blackRect6)
	 		else
	 			local current_square = self:getChop(i,j+1)
	 			current_square.x = tileSize * 2 + tileSize / 2
	 			current_square.y = tileSize + (tileSize / 2)
		 		composite:insert(current_square)
	 		end

 			--local blackRect7 = display.newRect(0,0,tileSize,tileSize)
 			--blackRect7:setFillColor(7/16)
 			--blackRect7.x = tileSize / 2
 			--blackRect7.y = tileSize * 2 + (tileSize / 2)
 			--blackRect7:setMask( plainMask )
			--blackRect7.maskX = -tileSize / 3
			--blackRect4.maskY = -tileSize / 3
 			--composite:insert(blackRect7)

 			if i == self.row_no then
	 			--local blackRect8 = display.newRect(0,0,tileSize,tileSize)
	 			--blackRect8:setFillColor(8/16)
	 			--blackRect8.x = tileSize  + tileSize / 2
	 			--blackRect8.y = tileSize * 2 + (tileSize / 2)
	 			--composite:insert(blackRect8)
	 		else
	 			local current_square = self:getChop(i + 1 ,j)
	 			current_square.x = tileSize  + tileSize / 2
	 			current_square.y = tileSize * 2 + (tileSize / 2)
		 		composite:insert(current_square)
	 		end 

 			--local blackRect9 = display.newRect(0,0,tileSize,tileSize)
 			--blackRect9:setFillColor(9/16)
 			--blackRect9.x = tileSize * 2  + tileSize / 2
 			--blackRect9.y = tileSize * 2+ (tileSize / 2)
 			--composite:insert(blackRect9)

 			--print("myname ", current_tile.name)
 			
			local mask = graphics.newMask( "masks2/"..current_tile.name..".png" )
			composite:setMask( mask )
		 	composite.maskX = 98.5
		 	composite.maskY = 98.5
		 	composite.maskRotation = current_tile.orientation

		 	local lowerXdot = - composite.width / 2 + tileSize / 2
			local upperXdot = composite.xint - (tileSize * 2) - 15
			local lowerYdot = 0
			local upperYdot = display.contentHeight - composite.height / 2 - tileSize / 2 - 10

			composite.x = math.random(lowerXdot, upperXdot)
			composite.y = math.random(lowerYdot, upperYdot)
 			
		 	temp[j] = composite
		 	view:insert(composite)
 		end
 		self.composites[i] = temp
 	end 
end

function grid:getPlayersDna()
	local dna = ""
	for i=1,self.row_no do
 		for j=1,self.column_no do
 			dna = dna .. playedLetters[i][j] 
 		end
 	end
 	return dna
end


function grid:kukimayoLetter(boundary_name)
	local boundary = self[boundary_name];
	local sub_boundary = boundary[math.random(#boundary)]
	local letter = sub_boundary.tiles[math.random(#(sub_boundary.tiles))]
	return letter, sub_boundary.rotation
end


--[[function grid:rando( ... )
	local x= ...
	return math.random(x)
end--]]

return grid

--[[local current_tile = tile:new(grid.tiles[current_rule.tiles[randomchoice.boundary)
 				current_tile=self:orient_tile(current_tile,current_rule.rotation)
 				previous_tile=current_tile
 				temp[j]=current_tile
 				previous_tile.x=j
 				previous_tile.y=i--]]


