local batteries = require("lib.batteries")
local vec2 = batteries.vec2

local c = require("constants")
local Player = require("player")

local world = {}
local function generate_chunk(cx, cy)
    local cw, ch = c.CHUNK_SIZE_WIDTH, c.CHUNK_SIZE_HEIGHT

    local chunk = {}
    for y = 0, ch - 1 do
        for x = 0, cw - 1 do
            local v = y / ch > 0.5 and 1 or 0
            chunk[y * cw + x] = v
        end
    end
    return chunk
end

function love.load()
    local ww, wh = c.WORLD_CHUNKS_WIDTH, c.WORLD_CHUNKS_HEIGHT
    for y = 0, wh do
        for x = 0, ww - 1 do
            world[y * ww + x] = generate_chunk(x, y)
        end
    end

    love.graphics.setBackgroundColor(0.17, 0.17, 0.17)
end

local player = Player(vec2(c.CHUNK_SIZE_WIDTH / 2 * c.TILE_SIZE, c.TILE_SIZE * 5))

function love.update(dt)
end

function love.draw()
    love.graphics.setColor(0.7, 0.7, 0.7)

    local chunk = world[0]
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
