--------------------------------------------------------------------------------
--
-- TitleScreenState.lua
--
-- User: mlanca-c
-- URL: http://github.com/mlanca-c/CS50-flappy_bird
-- Version: 1.0
--------------------------------------------------------------------------------

TitleScreenState = Class{ __includes = BaseState }

-- changes state if enter is pressed
function TitleScreenState:update( _ )

    if love.keyboard.wasPressed( 'enter' )
		or love.keyboard.wasPressed( 'return' ) then

        gStateMachine:change( 'play' )

    end
end

-- draws a TitleScreenState to the screen
function TitleScreenState:render()

    love.graphics.setFont( fonts[ 'flappyFont' ] )
    love.graphics.printf( 'Flappy Bird', 0, 64, VIRTUAL_WIDTH, 'center' )

    love.graphics.setFont( fonts[ 'mediumFont' ] )
    love.graphics.printf( 'Press Enter', 0, 100, VIRTUAL_WIDTH, 'center' )

end
