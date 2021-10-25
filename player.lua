local batteries = require("lib.batteries")
local class = batteries.class
local vec2 = batteries.vec2

local c = require("constants")
local Collider = require("collider")

local Player = class({
	name = "Player",
})

function Player:new(position)
    self.position = position
    self.size = vec2(c.TILE_SIZE, c.TILE_SIZE * 2)
    self.collider = Collider('aabb', position, self.size)
    self.game_state = require("game_state")
    self.game_state.world:add_thing(self.collider)
end

function Player:update(dt)
    local world = self.game_state.world

    -- apply gravity
    world:move_thing(self.collider, vec2(0, 100 * dt))
    self.position:set(self.collider.position)
end

function Player:draw()
    local pos, sz = self.position, self.size
    love.graphics.setColor(1,0,0)

    -- match colliders having pivot at center
    -- I'll rework this later, just want to have graphics match representation atm.
    love.graphics.rectangle('fill', pos.x - sz.x / 2, pos.y - sz.y / 2, sz.x, sz.y)
    love.graphics.setColor(1,1,1)
end

return Player
