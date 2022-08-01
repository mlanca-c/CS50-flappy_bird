-------------------------------------------------------------------------------
--
-- PipePair.lua
--
-- User: mlanca-c
-- URL: http://github.com/mlanca-c/CS50-flappy_bird
-- Version: 1.0
-------------------------------------------------------------------------------

PipePair = Class{}

local PIPE_GAP = 90

-- initializes a PipePair object with the right attributes
function PipePair:init( y )

	-- initializing pipePair coordinates
	self.x = VIRTUAL_WIDTH + 32
	self.y = y

	-- initializing each pipePair individually
	self.pipes = {
		[ 'upper' ] = Pipe( 'top', self.y ),
		[ 'lower' ] = Pipe( 'bottom', self.y + PIPE_GAP + PIPE_HEIGHT )
	}

	self.remove = false

end

-- updates a PipePair object's attributes
function PipePair:update( dt )

	-- updating each pipePair's x
	if self.x > -PIPE_WIDTH then
		self.x = self.x + PIPE_SCROLL_SPEED * dt
		self.pipes[ 'upper' ].x = self.x
		self.pipes[ 'lower' ].x = self.x
	else
		self.remove = true
	end
end

-- draws a PipePair object to the screen
function PipePair:render()

	-- render each pipePair
	for k, pipe in pairs( self.pipes ) do
		pipe:render()
	end
end
