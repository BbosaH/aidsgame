local menuItem = require("objects.menuitem")
local widget = require( "widget" )
local composer  = require( "composer"  )
local scene = composer.newScene(  )

scene.sceneAudioChannel = util:getNextAudioChannel()
scene.nextIndex = 0;
scene.indexes = {}
scene.scrollView = widget.newScrollView
{
	left = 50,
	top = 50,
	width = display.contentWidth - 100,
	height = display.contentHeight - 60,
	bottomPadding = 50,
	id = "onBottom",
	horizontalScrollDisabled = true,
	verticalScrollDisabled = false,
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
	self.bgMusic = audio.loadStream( "assets/audios/helpBgMusic.mp3" )
	
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

	local dialog_answer= display.newRoundedRect(display.contentWidth/2,(display.contentHeight/2)+20,400,275,10)
	dialog_answer.anchorX=0.5
	dialog_answer.anchorY=0.5
	dialog_answer:setFillColor(0,0,0)
	dialog_answer.alpha=0.5
	self:insertInView( dialog_answer, "diaImageIndex")
	--self.scrollView:insert( dialog_answer )


	--Create a text object for the scrollViews title
	local titleText = display.newText("Move Up to Scroll", display.contentCenterX - 50, 48, native.systemFontBold, 16)
	titleText:setFillColor( 0 )

	-- insert the text object into the created display group
	self.scrollView:insert( titleText )

	--Create a large text string
	local lotsOfText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet consectetur euismod. Phasellus non ipsum vel eros vestibulum consequat. Integer convallis quam id urna tristique eu viverra risus eleifend.\n\nAenean suscipit placerat venenatis. Pellentesque faucibus venenatis eleifend. Nam lorem felis, rhoncus vel rutrum quis, tincidunt in sapien. Proin eu elit tortor. Nam ut mauris pellentesque justo vulputate convallis eu vitae metus. Praesent mauris eros, hendrerit ac convallis vel, cursus quis sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque fermentum, dui in vehicula dapibus, lorem nisi placerat turpis, quis gravida elit lectus eget nibh. Mauris molestie auctor facilisis.\n\nCurabitur lorem mi, molestie eget tincidunt quis, blandit a libero. Cras a lorem sed purus gravida rhoncus. Cras vel risus dolor, at accumsan nisi. Morbi sit amet sem purus, ut tempor mauris.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet consectetur euismod. Phasellus non ipsum vel eros vestibulum consequat. Integer convallis quam id urna tristique eu viverra risus eleifend.\n\nAenean suscipit placerat venenatis. Pellentesque faucibus venenatis eleifend. Nam lorem felis, rhoncus vel rutrum quis, tincidunt in sapien. Proin eu elit tortor. Nam ut mauris pellentesque justo vulputate convallis eu vitae metus. Praesent mauris eros, hendrerit ac convallis vel, cursus quis sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque fermentum, dui in vehicula dapibus, lorem nisi placerat turpis, quis gravida elit lectus eget nibh. Mauris molestie auctor facilisis.\n\nCurabitur lorem mi, molestie eget tincidunt quis, blandit a libero. Cras a lorem sed purus gravida rhoncus. Cras vel risus dolor, at accumsan nisi. Morbi sit amet sem purus, ut tempor mauris. "

	--Create a text object containing the large text string and insert it into the scrollView
	local lotsOfTextObject = display.newText( lotsOfText, 190, 0, 310, 0, native.systemFont, 18)
	lotsOfTextObject:setFillColor( 0 ) 
	lotsOfTextObject.anchorY = 0.0		
	-- Top
	--------------------------------lotsOfTextObject:setReferencePoint( display.TopCenterReferencePoint )
	lotsOfTextObject.y = titleText.y + titleText.contentHeight + 10

	self.scrollView:insert( lotsOfTextObject )
	self:insertInView( self.scrollView, "scrollViewIndex")

	local helpImage = display.newImage( "assets/images/help.png" )
	helpImage.x = display.contentWidth / 2
	helpImage.y = 30
	helpImage.height = 50
	self:insertInView( helpImage, "helpImageIndex")

	local crossMenuItem = menuItem:newMenuItem(menuItem.cross ,417,62, false)
	self:insertInView( crossMenuItem , "crossMenuItemIndex")

	

	




end

function scene:show( event )
	audio.play( self.bgMusic, { self.sceneAudioChannel , loops=-1 , fadein=1000 } )
end

function scene:hide( event )
	--stop the music
	audio.stop( self.sceneAudioChannel )
	scene.scrollView = nil
end

function scene:destroy( event )
	
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene;