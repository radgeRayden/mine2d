local batteries = require("lib.batteries")
local vec2 = batteries.vec2

local c = require("constants")
local World = require("world")
local Player = require("player")

local gs = {}

function gs.init()
    gs.world = World()
    gs.player = Player(vec2(c.CHUNK_SIZE_WIDTH / 2 * c.TILE_SIZE, c.TILE_SIZE * 5))
end

return gs

