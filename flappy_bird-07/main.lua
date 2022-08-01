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

-- library used for a more retro looking game
push = require 'push'

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

-- bird init
local bird = Bird()

-- pipes init
local pipes = {}

-- timer for spawning pipes
local spawnTimer = 0

-- scrolling variable that when set to false, stops the game
local scrolling = true

-- initialize our last recorded Y value for a gap placement to base other gaps
-- off of
local lastY = -PIPE_HEIGHT + math.random(80) + 20

-- love.load() it's used to initialize game state at the very beginning.
function love.load()
    -- initialize our nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

	-- Setting up window title
	love.window.setTitle( 'flappy bird' )

	-- Setting up screen
	push:setupScreen(
		VIRTUAL_WIDTH,
		VIRTUAL_HEIGHT,
		WINDOW_WIDTH,
		WINDOW_HEIGHT,
		{ fullscreen = false, resizable = true, vsync = true }
	)

	-- initialize keyspressed table
	love.keyboard.keysPressed = {}

end

-- love.update(dt) updates the state of the game every frame.
function love.update( dt )
	if scrolling then
		-- claculating groundScroll
		groundScroll = ( groundScroll + GROUND_SCROLL_SPEED * dt )
						% GROUND_LOOP_POINT

		-- claculating backgroundScroll
		backgroundScroll = ( backgroundScroll + BACKGROUND_SCROLL_SPEED * dt )
						% BACKGROUND_LOOP_POINT

		-- update spawnTimer
		spawnTimer = spawnTimer + dt

		-- spawn a new pipe in every two seconds
		if spawnTimer > 2 then

			-- getting y value of pipePair
			local y = math.random(
				-PIPE_HEIGHT + 10,
				math.min(
					lastY + math.random( -20, 20 ),
					VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT
				)
			)
			lastY = y

			-- inserting one more pipePair object in image
			table.insert( pipes, PipePair( y ))
			spawnTimer = 0

		end

		-- update bird
		bird:update( dt )

		-- for every pipe in the scene
		for k, pair in pairs( pipes ) do
			-- update each pipe
			pair:update( dt )

			-- check for collisions
			for l, pipe in pairs( pair.pipes ) do
				if bird:collides( pipe ) then
					scrolling = false
				end
			end

			if pair.x < -PIPE_WIDTH then
				pair.remove = true
			end

		end

		-- for every pipe in the scene
		for k, pipe in pairs( pipes ) do

			-- remove pipes out of the scene
			if pipe.remove then
				table.remove( pipes, k )
			end
		end
	end

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

	-- draw pipes
	for k, pipe in pairs( pipes ) do
		pipe:render()
	end

	-- draw floor image
	-- ground:getHeight == 16
	love.graphics.draw( ground, -groundScroll, VIRTUAL_HEIGHT - 16 )

	-- draw bird
	bird:render()

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

function love.keyWasPressed( key )
	return love.keyboard.keysPressed[ key ]
end

function love.resize( w, h )
	push:resize( w, h)
end
