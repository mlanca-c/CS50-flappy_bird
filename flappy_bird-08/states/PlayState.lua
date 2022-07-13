--------------------------------------------------------------------------------
--
-- PlayState.lua
--
-- User: mlanca-c
-- URL: http://github.com/mlanca-c/CS50-flappy_bird
-- Version: 1.0
--------------------------------------------------------------------------------

PlayState = Class{ __includes = BaseState }

-- PIPE_SPEED = 60
-- PIPE_WIDTH = 70
-- PIPE_HEIGHT = 288
--
-- BIRD_WIDTH = 38
-- BIRD_HEIGHT = 24

-- initializes a PlayState object with the right attributes
function PlayState:init()

	-- initializing Bird
	self.bird = Bird()

	-- initializing PipePairs
	self.pairs = {}

	-- timer for spawning pipes
	self.timer = 0

    -- initialize our last recorded Y value for a gap placement to base other
	-- gaps off of
	self.lastY = -PIPE_HEIGHT + math.random( 80 ) + 20

end

-- updates a PlayState object's attributes
function PlayState:update( dt )
	-- update timer
	self.timer = self.timer + dt

	-- spawn one more pipe
	if self.timer > 2 then
		-- getting y value of pipePair
		local y = math.random(
			-PIPE_HEIGHT + 10,
			math.min(
				self.lastY + math.random( -20, 20 ),
				VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT
			)
		)
		self.lastY = y

		-- inserting one more pipePair object in image
		table.insert( self.pairs, PipePair( y ))

		-- reset timer
		self.timer = 0

	end

	-- update pipes
	for _, pair in pairs( self.pairs ) do
		pair:update( dt )
	end

	-- remove out of the scene pipes
	for k, pair in pairs( self.pairs ) do
		if pair.remove then
			table.remove( self.pairs, k )
		end
	end

	-- update bird
	self.bird:update( dt )

	-- check collision with pipes
    for _, pair in pairs( self.pairs ) do

        for _, pipe in pairs( pair.pipes ) do

            if self.bird:collides( pipe ) then

                gStateMachine:change( 'title' )
            end
        end
    end

	-- check collision with ground
	if self.bird.y > VIRTUAL_HEIGHT - 15 then
		gStateMachine:change( 'title' )
	end

end

-- draws a PlayState object to the screen
function PlayState:render()
	-- draw pipePairs
	for _, pair in pairs( self.pairs ) do
		pair:render()
	end

	-- draw bird
	self.bird:render()

end
