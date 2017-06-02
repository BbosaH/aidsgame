-- hide device status bar
display.setStatusBar( display.HiddenStatusBar )

local composer  = require( "composer" )

util = require("utils.util")
util:setVolume(  util:getVolume())
tileSize = 65
util:setLevel( util:getLevel()  )

plays = 0
answered = 0
modez = "normal"
playedLetters = {}
timeTaken = 0
playerScore = 0
selectedImage = 1;
prevcounts = 4 - tonumber(util:getLevel())


photo	= nil	-- holds the photo object
PHOTO_FUNCTION = media.PhotoLibrary 		-- or media.SavedPhotosAlbum

gameFont = 16
gameLongText = "The Answer is C. In the first few weeks after infection, some people experience flu-like symptoms for a few days. But after that, on average, a person can go up to 10 years or more without experiencing any symptoms of HIV or AIDS"


--composer.recycleOnSceneChange = true
composer.gotoScene( "scenes.splash", "fade", 400 );