-------------------------------------------------------------------------------
--
-- main.lua
--
-- User: mlanca-c
-- URL: http://github.com/mlanca-c/CS50-flappy_bird
-- Version: 1.0
-------------------------------------------------------------------------------

-- template file for all classes
Class = require 'class'

-- bird class
require 'Bird'

-- pipe class
require 'Pipe'

-- pipePair class
require 'PipePair'

-- all states classes
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/ScoreState'

-- library used for a more retro looking game
local push = require 'push'

-- window dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual dimensions for the push library
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- ground image
local ground = love.graphics.newImage( 'ground.png' )

-- ground attributes
local GROUND_LOOP_POINT = VIRTUAL_WIDTH
local GROUND_SCROLL_SPEED = 60
local groundScroll = 0

-- background image
local background = love.graphics.newImage( 'background.png' )

-- background attributes
local BACKGROUND_LOOP_POINT = 413
local BACKGROUND_SCROLL_SPEED = 30
local backgroundScroll = 0

-- scrolling variable that when set to false, stops the game
local scrolling = true

-- love.load() it's used to initialize game state at the very beginning.
function love.load()
    -- initialize our nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

	-- Setting up window title
	love.window.setTitle( 'flappy bird' )

	-- initializing all game fonts
	fonts = {
		[ 'smallFont' ] = love.graphics.newFont( 'font.ttf', 8 ),
		[ 'mediumFont' ] =  love.graphics.newFont( 'flappy.ttf', 14 ),
		[ 'flappyFont' ] =  love.graphics.newFont( 'flappy.ttf', 28 ),
		[ 'hugeFont' ] =  love.graphics.newFont( 'flappy.ttf', 56 )
	}
	-- setting up initial font
	love.graphics.setFont( fonts[ 'flappyFont' ] )

	-- Setting up screen
	push:setupScreen(
		VIRTUAL_WIDTH,
		VIRTUAL_HEIGHT,
		WINDOW_WIDTH,
		WINDOW_HEIGHT,
		{ fullscreen = false, resizable = true, vsync = true }
	)

	-- initializing gStateMachine with all states returning functions
	gStateMachine = StateMachine{
		[ 'title' ] = function() return TitleScreenState() end,
		[ 'play' ] = function() return PlayState() end,
		[ 'score' ] = function() return ScoreState() end
	}
	-- setting up initial game state
	gStateMachine:change( 'title' )

	-- initialize keyspressed table
	love.keyboard.keysPressed = {}

end

-- love.update(dt) updates the state of the game every frame.
function love.update( dt )
	-- claculating groundScroll
	groundScroll = ( groundScroll + GROUND_SCROLL_SPEED * dt )
					% GROUND_LOOP_POINT

	-- claculating backgroundScroll
	backgroundScroll = ( backgroundScroll + BACKGROUND_SCROLL_SPEED * dt )
					% BACKGROUND_LOOP_POINT

	gStateMachine:update( dt )

	-- restart keyspressed table
	love.keyboard.keysPressed = {}

end

-- love.draw() is called right after love.update(dt) and draws an image to the
-- window
function love.draw()

	push:start()
	-- drawing starts here

	-- draw background image
	love.graphics.draw( background, -backgroundScroll, 0 )

	-- render whatever's to render in the gStateMachine.current state
	gStateMachine:render()

	-- draw floor image
	-- ground:getHeight == 16
	love.graphics.draw( ground, -groundScroll, VIRTUAL_HEIGHT - 16 )

	-- drawing finishes here
	push:finish()

end

function love.keypressed( key )
	-- update keyspressed table with pressed key
	love.keyboard.keysPressed[ key ] = true

	if key == 'escape' then
		love.event.quit()
	end
end

function love.keyboard.wasPressed( key )
	return love.keyboard.keysPressed[ key ]
end

function love.resize( w, h )
	push:resize( w, h)
end
