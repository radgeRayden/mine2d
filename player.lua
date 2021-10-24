local batteries = require("lib.batteries")
local class = batteries.class

local c = require("constants")

local Player = class({
	name = "Player",
})

function Player:new(position)
    self.position = position
end

function Player:update(dt)
end

function Player:draw()
        local pos = self.position
        love.graphics.setColor(1,0,0)
        -- pivot is bottom center
        love.graphics.rectangle('fill', pos.x - c.TILE_SIZE / 2, pos.y - c.TILE_SIZE * 2, c.TILE_SIZE, c.TILE_SIZE * 2)
        love.graphics.setColor(1,1,1)
end

return Player
