-------------------------------------------------------------------------------
--
-- StateMachine.lua
--
-- User: mlanca-c
-- URL: http://github.com/mlanca-c/CS50-flappy_bird
-- Version: 1.0
-------------------------------------------------------------------------------

StateMachine = Class{}

-- initializes a StateMachine object with the right attributes
function StateMachine:init( states )

	self.empty = {
		render = function() end,
		update = function() end,
		enter = function() end,
		exit = function() end
	}

	self.states = states or {}

	self.current = self.empty

end

-- changes self.current state for `state`
function StateMachine:change( stateName, enterParams )
	-- The assert function checks whether its first argument is not false and
	-- simply returns that argument; if the argument is false (that is, false
	-- or nil), assert raises an error.
	assert( self.states[ stateName ] )
	self.current:exit()

	self.current = self.states[ stateName ]()
	self.current:enter( enterParams )

end

-- updates a StateMachine object's attributes
function StateMachine:update( dt )
	self.current:update( dt )
end

-- draws a StateMachine object to the screen
function StateMachine:render()
	self.current:render()
end
