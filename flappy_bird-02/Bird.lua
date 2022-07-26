-------------------------------------------------------------------------------
--
-- Bird.lua
--
-- User: mlanca-c
-- URL: http://github.com/mlanca-c/CS50-flappy_bird
-- Version: 1.0
-------------------------------------------------------------------------------

Bird = Class{}


-- initializes a Bird object with the right attributes
function Bird:init()

	-- initialize bird image
	self.image = love.graphics.newImage( 'bird.png' )

	-- initialize bird dimensions
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()

	-- initialize bird coordinates
	self.x = VIRTUAL_WIDTH / 2 - ( self.width / 2 )
	self.y = VIRTUAL_HEIGHT / 2 - ( self.height / 2 )

end

-- updates a Bird object's attributes
function Bird:update( dt )
	--
end

-- draws a Bird object to the screen
function Bird:render()
	love.graphics.draw( self.image, self.x, self.y )
end
