--------------------------------------------------------------------------------
--
-- ScoreState.lua
--
-- User: mlanca-c
-- URL: http://github.com/mlanca-c/CS50-flappy_bird
-- Version: 1.0
--------------------------------------------------------------------------------

ScoreState = Class{ __includes = BaseState }

-- initializes a ScoreState object with the right attributes
function ScoreState:enter( params )
	self.score = params.score
end

-- updates a ScoreState object's attributes
function ScoreState:update( dt )
    if love.keyboard.wasPressed( 'enter' )
		or love.keyboard.wasPressed( 'return' ) then

        gStateMachine:change( 'play' )

    end
end

-- draws a ScoreState object to the screen
function ScoreState:render()

    -- simply render the score to the middle of the screen
    love.graphics.setFont( fonts[ 'flappyFont' ] )
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont( fonts[ 'mediumFont' ] )
    love.graphics.printf(
		'Score: ' .. tostring(self.score),
		0,
		100,
		VIRTUAL_WIDTH,
		'center'
	)

    love.graphics.printf(
		'Press Enter to Play Again!',
		0,
		160,
		VIRTUAL_WIDTH,
		'center'
	)

end
