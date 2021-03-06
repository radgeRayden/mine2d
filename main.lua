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
    love.graphics.translate(40, 0)

    local chunk = game_state.world.terrain[1]
    for y = 0, c.CHUNK_SIZE_HEIGHT - 1 do
        for x = 0, c.CHUNK_SIZE_WIDTH -1 do
            local v = chunk[y * c.CHUNK_SIZE_WIDTH + x]
            if v > 0 then
                local sz = c.TILE_SIZE
                love.graphics.rectangle('fill', x * sz - sz / 2, y * sz - sz / 2, sz, sz)
            end
        end
    end

    game_state.player:draw()
end

local wW, wH
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'f5' then
        love.event.quit("restart")
    elseif key == 'return' and love.keyboard.isDown("lalt") then
        -- on linux window dimensions don't get correctly restored when coming back from fullscreen.
        local fullscreen = love.window.getFullscreen()
        if not fullscreen then
            wW, wH = love.graphics.getDimensions()
            love.window.setFullscreen(true)
        else
            love.window.setMode(wW, wH, {fullscreen = false})
        end
    end
end
