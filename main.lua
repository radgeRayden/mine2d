local batteries = require("lib.batteries")
local vec2 = batteries.vec2

local c = require("constants")
local Player = require("player")
local terragen = require("terrain_generation")

local chunk

function love.load()
    love.graphics.setBackgroundColor(0.17, 0.17, 0.17)
    chunk = terragen.generate_chunk(0,0)
end

local player = Player(vec2(c.CHUNK_SIZE_WIDTH / 2 * c.TILE_SIZE, c.TILE_SIZE * 5))

function love.update(dt)
end

function love.draw()
    love.graphics.setColor(0.7, 0.7, 0.7)

    for y = 0, c.CHUNK_SIZE_HEIGHT - 1 do
        for x = 0, c.CHUNK_SIZE_WIDTH -1 do
            local v = chunk[y * c.CHUNK_SIZE_WIDTH + x]
            if v > 0 then
                love.graphics.rectangle('fill', x * c.TILE_SIZE, y * c.TILE_SIZE, c.TILE_SIZE, c.TILE_SIZE)
            end
        end
    end

    player:draw()
end
