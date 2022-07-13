-------------------------------------------------------------------------------
--
-- Bird.lua
--
-- User: mlanca-c
-- URL: http://github.com/mlanca-c/CS50-flappy_bird
-- Version: 1.0
-------------------------------------------------------------------------------

Bird = Class{}

local GRAVITY = 20

-- initializes a Bird object with the right attributes
function Bird:init()

	-- initializing Bird image
	self.image = love.graphics.newImage( 'bird.png' )

	-- initializing Bird dimensions
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()

	-- initializing Bird coordinates
	self.x = ( VIRTUAL_WIDTH / 2 ) - ( self.width / 2 )
	self.y = ( VIRTUAL_HEIGHT / 2 ) - ( self.height / 2 )

	-- initializing delta y for speed
	self.dy = 0

end

-- updates a Bird object's attributes
function Bird:update( dt )

	self.dy = self.dy + GRAVITY * dt

	if love.keyboard.wasPressed( 'space' ) then
		self.dy = -5
	end

	self.y = self.y + self.dy

end

-- draws a Bird object to the screen
function Bird:render()
	love.graphics.draw( self.image, self.x, self.y )
end

function Bird:collides( pipe )

    if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
        if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end

    return false
end
