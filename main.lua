local batteries = require("lib.batteries")
local vec2 = batteries.vec2

local c = require("constants")
local Player = require("player")
local terragen = require("terrain_generation")
local game_state = require("game_state")

local chunk

function love.load()
    love.graphics.setBackgroundColor(0.17, 0.17, 0.17)
    game_state.init()
end

function love.update(dt)
   game_state.player:update(dt) 
end

function love.draw()
    love.graphics.setColor(0.7, 0.7, 0.7)

    local chunk = game_state.world.terrain[1]
    for y = 0, c.CHUNK_SIZE_HEIGHT - 1 do
        for x = 0, c.CHUNK_SIZE_WIDTH -1 do
            local v = chunk[y * c.CHUNK_SIZE_WIDTH + x]
            if v > 0 then
                love.graphics.rectangle('fill', x * c.TILE_SIZE, y * c.TILE_SIZE, c.TILE_SIZE, c.TILE_SIZE)
            end
        end
    end

    game_state.player:draw()
end
