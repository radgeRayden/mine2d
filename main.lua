local WORLD_CHUNKS_WIDTH = 32
local WORLD_CHUNKS_HEIGHT = 10
local CHUNK_SIZE_WIDTH = 32
local CHUNK_SIZE_HEIGHT = 32
local TILE_SIZE = 16

local world = {}
local function generate_chunk(cx, cy)
    local chunk = {}
    for y = 0, CHUNK_SIZE_HEIGHT - 1 do
        for x = 0, CHUNK_SIZE_WIDTH - 1 do
            local v = y / CHUNK_SIZE_HEIGHT > 0.5 and 1 or 0
            chunk[y * CHUNK_SIZE_WIDTH + x] = v
        end
    end
    return chunk
end

function love.load()
    for y = 0, WORLD_CHUNKS_HEIGHT do
        for x = 0, WORLD_CHUNKS_WIDTH - 1 do
            world[y * WORLD_CHUNKS_WIDTH + x] = generate_chunk(x, y)
        end
    end

    love.graphics.setBackgroundColor(0.17, 0.17, 0.17)
end

function love.update(dt)
end

function love.draw()
    love.graphics.setColor(0.7, 0.7, 0.7)

    local chunk = world[0]
    for y = 0, CHUNK_SIZE_HEIGHT - 1 do
        for x = 0, CHUNK_SIZE_WIDTH -1 do
            local v = chunk[y * CHUNK_SIZE_WIDTH + x]
            if v > 0 then
                love.graphics.rectangle('fill', x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE)
            end
        end
    end
end