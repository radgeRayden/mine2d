local batteries = require("lib.batteries")
local intersect = batteries.intersect
local vec2 = batteries.vec2

local Collider = class({
    name = "Collider"
})

function Collider:new(shape, position, size)
    -- currently we support rect and circle shapes.
    if shape == 'circle' then
        assert(type(size) == 'number')
        self.radius = size
        self.colfun = Collider.collide_with_circle
    elseif shape == 'aabb' then
        self.hs = size:sdiv(2)
        self.colfun = Collider.collide_with_aabb
    else
        error(string.format("shape %s not supported", shape))
    end
    self.position = position
    self.shape = shape
end

function Collider:collide_with_aabb(other)
    if self.shape == 'aabb' then
        return intersect.aabb_aabb_collide(self.position, self.hs, other.position, other.hs)
    else
        return intersect.circle_aabb_collide(self.position, self.radius, other.position, other.hs)
    end
end

function Collider:collide_with_circle(other)
    if self.shape == 'aabb' then
        return intersect.aabb_circle_collide(self.position, self.hs, other.position, other.radius)
    else
        return intersect.circle_circle_collide(self.position, self.radius, other.position, other.radius)
    end
end

function Collider:collide(other)
    -- there's probably a better way to do this?
    other.colfun(self, other)
end

return Collider
