local batteries = require("lib.batteries")
local class = batteries.class
local intersect = batteries.intersect
local vec2 = batteries.vec2

local c = require("constants")
local terragen = require("terrain_generation")
local Collider = require("collider")

local World = class({
    name = "World"
})

function World:new()
    self.things = {}
    self.terrain = {}
    self.terrain[1] = terragen.generate_chunk(0, 0)
end

--- thing: Collider
function World:add_thing(thing)
    table.insert(self.things, thing)
end

--- thing: Collider
--- dir: vec2
function World:move_thing(thing, dir)
    for k,v in ipairs(self.things) do
        if not (thing == v) then
            -- object B is always static
            local msv = thing:collide(v)
            if msv then
                intersect.resolve_msv(thing.position, v.position, msv, 1)
            end
        end
    end

    -- priority is not overlapping terrain, so we do this last
    -- for now we only have one chunk, so let's keep it dumb.
    local chunk = self.terrain[1]
    local pos = vec2()
    local tilecol = Collider('aabb', pos, vec2(c.TILE_SIZE, c.TILE_SIZE))
    for y=0, c.CHUNK_SIZE_HEIGHT-1 do
        for x=0, c.CHUNK_SIZE_WIDTH-1 do
            local tilev = chunk[y*c.CHUNK_SIZE_WIDTH+x]
            if tilev > 0 then
                pos.x, pos.y = c.TILE_SIZE * x, c.TILE_SIZE * y
                local msv = thing:collide_with_aabb(tilecol)
                if msv then
                    intersect.resolve_msv(thing.position, tilecol.position, msv, 1)
                end
            end
        end
    end
end

return World
