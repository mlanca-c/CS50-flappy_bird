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

	-- score
	self.score = 0

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

	-- update pipes and score
	for _, pair in pairs( self.pairs ) do

		-- update score
		if not pair.scored then
			if pair.x + PIPE_WIDTH < self.bird.x then

				self.score = self.score + 1
				pair.scored = true
				sounds[ 'score' ]:play()
			end
		end

		-- update pipes
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

				sounds[ 'explosion' ]:play()
				sounds[ 'hurt' ]:play()
				gStateMachine:change( 'score', { score = self.score })
            end
        end
    end

	-- check collision with ground
	if self.bird.y > VIRTUAL_HEIGHT - 15 then

		sounds[ 'explosion' ]:play()
		sounds[ 'hurt' ]:play()
		gStateMachine:change( 'score', { score = self.score })
	end

end

-- draws a PlayState object to the screen
function PlayState:render()
	-- draw pipePairs
	for _, pair in pairs( self.pairs ) do
		pair:render()
	end


	-- draw score
    love.graphics.setFont(fonts[ 'flappyFont' ] )
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

	-- draw bird
	self.bird:render()

end
