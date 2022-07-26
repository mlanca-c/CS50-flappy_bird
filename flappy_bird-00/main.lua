-------------------------------------------------------------------------------
--
-- main.lua
--
-- User: mlanca-c
-- URL: http://github.com/mlanca-c/CS50-flappy_bird
-- Version: 1.0
-------------------------------------------------------------------------------

-- requiring push library for a more retro looking game
push = require 'push'

-- window dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- love.graphics.newImage( filename ) creates a new Image from a filepath,
--                                    and optionally generates or specifies
--                                    mipmaps for the image
local background = love.graphics.newImage( 'background.png' )
local ground = love.graphics.newImage( 'ground.png' )


-- love.load() it's used to initialize game state at the very beginning.
function love.load()

	-- window title
	love.window.setTitle( 'Flappy Bird Game' )

	-- sets the default scaling filters used with images, canvases, and fonts
	-- (for push library).
	love.graphics.setDefaultFilter( 'nearest', 'nearest' )

	-- window dimensions setup
	push:setupScreen(
		VIRTUAL_WIDTH,
		VIRTUAL_HEIGHT,
		WINDOW_WIDTH,
		WINDOW_HEIGHT,
		{ fullscreen = false, resizable = true, vsync = true }
	)

end

-- love.update(dt) updates the state of the game every frame.
function love.update( dt )
	--
end

-- love.draw() is called right after love.update(dt) and draws an image to the
-- window
function love.draw()

	-- drawing starts here
	push:start()

	-- draw background
	love.graphics.draw( background, 0, 0 )

	-- draw ground
	love.graphics.draw( ground, 0, VIRTUAL_HEIGHT - 16 )

	-- drawing ends here
	push:finish()

end

-- love.keypressed( key ) is triggered when a key is pressed.
function love.keypressed( key )

	if key == 'escape' then
		love.event.quit()
	end

end

-- love.resize( w, h ) is called when the window is resized.
function love.resize( w, h )
	-- push library resize function call
	push:resize( w, h )
end

