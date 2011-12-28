-- 
-- Abstract: Ghosts Vs Monsters sample project 
-- Designed and created by Jonathan and Biffy Beebe of Beebe Games exclusively for Ansca, Inc.
-- http://beebegamesonline.appspot.com/

-- (This is easiest to play on iPad or other large devices, but should work on all iOS and Android devices)
-- 
-- Version: 1.1
-- 
-- Sample code is MIT licensed, see http://developer.anscamobile.com/code/license
-- Copyright (C) 2010 ANSCA Inc. All Rights Reserved.

--====================================================================--
-- Set up Playtomic
--====================================================================--

--local playtomic = require "old-playtomic"
local playtomic = require "playtomic"
playtomic.makeDefault()

--====================================================================--
-- GAME INITIAL SETTINGS
--====================================================================--

-- SOME INITIAL SETTINGS
display.setStatusBar( display.HiddenStatusBar ) --Hide status bar from the beginning

local oldTimerCancel = timer.cancel
timer.cancel = function(t) if t then oldTimerCancel(t) end end

local oldRemove = display.remove
display.remove = function( o )
	if o ~= nil then
		
		Runtime:removeEventListener( "enterFrame", o )
		oldRemove( o )
		o = nil
	end
end


-- Import director class
local director = require("director")
ui = require( "ui" )
movieclip = require( "movieclip" )

-- Create a main group
local mainGroup = display.newGroup()

-- Main function
local function main()
	
	-- Add the group from director class
	mainGroup:insert(director.directorView)
	
	-- Uncomment below code and replace init() arguments with valid ones to enable openfeint
	--[[
	openfeint = require ("openfeint")
	openfeint.init( "App Key Here", "App Secret Here", "Ghosts vs. Monsters", "App ID Here" )
	]]--
	
	director:changeScene( "loadmainmenu" )
	
	-- Playtomic: Initialize
	analytics.init(5241,"a2b1dd20c3e1481b","89ebb4c8f6b644e89e590616d6b3ca")
	
	return true
end

-- Begin
main()
