--------------------------------------------------------------------------------
--
-- CountdownState.lua
--
-- User: mlanca-c
-- URL: http://github.com/mlanca-c/CS50-flappy_bird
-- Version: 1.0
--------------------------------------------------------------------------------

CountdownState = Class{ __includes = BaseState }

COUNTDOWN_TIME = 0.75

-- initializes a CountdownState object with the right attributes
function CountdownState:init()

	self.count = 3
	self.timer = 0

end

-- updates a CountdownState object's attributes
function CountdownState:update( dt )

	self.timer = self.timer + dt

	if self.timer > COUNTDOWN_TIME then

		self.timer = self.timer % COUNTDOWN_TIME
		self.count = self.count - 1

		if self.count == 0 then

			gStateMachine:change( 'play' )
		end
	end
end

-- draws a CountdownState object to the screen
function CountdownState:render()

	love.graphics.setFont( fonts[ 'hugeFont' ] )
	love.graphics.printf(
		tostring( self.count ),
		0,
		120,
		VIRTUAL_WIDTH,
		'center'
	)

end
