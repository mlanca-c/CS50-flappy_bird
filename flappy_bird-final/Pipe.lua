-------------------------------------------------------------------------------
--
-- Pipe.lua
--
-- User: mlanca-c
-- URL: http://github.com/mlanca-c/CS50-flappy_bird
-- Version: 1.0
-------------------------------------------------------------------------------

Pipe = Class{}

-- pipe image is drawn outside because it only needs to happen once
local PIPE_IMAGE = love.graphics.newImage( 'pipe.png' )

PIPE_SPEED = 60

-- pipe dimensions
PIPE_HEIGHT = 430
PIPE_WIDTH = 70

-- initializes a Pipe object with the right attributes
function Pipe:init( type, y )

	-- initializing Pipe type
	self.type = type

	-- initializing Pipe dimensions
	self.width = PIPE_WIDTH
	self.height = PIPE_HEIGHT

	-- initializing Pipe coordinates
	self.x = VIRTUAL_WIDTH
	self.y = y

end

-- updates a Pipe object's attributes
function Pipe:update( dt )
end

-- draws a Pipe object to the screen
function Pipe:render()

	love.graphics.draw(
		PIPE_IMAGE,
		self.x,
		( self.type == 'top' and self.y + PIPE_HEIGHT or self.y ),
		0,
		1,
		self.type == 'top' and -1 or 1
	)

end
