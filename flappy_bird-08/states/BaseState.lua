-------------------------------------------------------------------------------
--
-- BaseState.lua
--
-- User: mlanca-c
-- URL: http://github.com/mlanca-c/CS50-flappy_bird
-- Version: 1.0
-------------------------------------------------------------------------------

BaseState = Class{}

-- Base class without any implemented functions
-- This class serves as an interface for the other state classes
function BaseState:init() end
function BaseState:update( dt ) end
function BaseState:render() end
function BaseState:enter() end
function BaseState:exit() end
