-------------------------------------------------------------------------------
--
-- Pipe.lua
--
-- User: mlanca-c
-- URL: http://github.com/mlanca-c/CS50-flappy_bird
-- Version: 1.0
-------------------------------------------------------------------------------

Pipe = Class{}

-- pipe image and the starting location of scroll
local PIPE_IMAGE = love.graphics.newImage( 'pipe.png' )
local PIPE_SCROLL = -60

-- initializes a Pipe object with the right attributes
function Pipe:init()

	self.x = VIRTUAL_WIDTH
	self.y = math.random( VIRTUAL_HEIGHT / 4, VIRTUAL_HEIGHT - 10 )

	self.width = PIPE_IMAGE:getWidth()

end

-- updates a Pipe object's attributes
function Pipe:update( dt )
	self.x = self.x + PIPE_SCROLL * dt
end

-- draws a Pipe object to the screen
function Pipe:render()

	love.graphics.draw(
		PIPE_IMAGE,
		math.floor( self.x + 0.5 ),
		math.floor( self.y )
	)

end
