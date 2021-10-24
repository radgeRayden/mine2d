local batteries = require("lib.batteries")
local vec2 = batteries.vec2
local c = require("constants")

local terragen = {}

function terragen.generate_chunk(cx, cy)
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

return terragen
