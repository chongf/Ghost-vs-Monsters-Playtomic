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
local playtomic = require "Playtomic"
analytics = {}

function analytics.init( swfid, guid, apikey, debug )
	playtomic.Log.View( swfid, guid, apikey, "", debug )
end

function analytics.logEvent( event, eventData )
	ed = eventData or { }
	eventType = ed.type or "custom"
	if event == "Play" then
		playtomic.Log.Play()
	elseif eventType == "custom" then
		playtomic.Log.CustomMetric(event, ed.eventGroup, ed.unique )
	elseif eventType == "counter" then		
		playtomic.Log.LevelCounterMetric(event, ed.levelName, ed.unique )
	elseif eventType == "average" then
		playtomic.Log.LevelAverageMetric(event, ed.levelName, ed.value, ed.unique )
	elseif eventType == "ranged" then
		playtomic.Log.LevelRangedMetric(event, ed.levelName, ed.value, ed.unique )
	elseif eventType == "heatmap" then
		playtomic.Log.Heatmap(event, ed.mapName, ed.x , ed.y )
	end
end

function analytics.forceSend()
	playtomic.Log.ForceSend()
end

function analytics.freeze()
	playtomic.Log.Freeze()
end

function analytics.unFreeze()
	playtomic.Log.UnFreeze()
end

function analytics.isFrozen()
	return playtomic.Log.isFrozen()
end

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
