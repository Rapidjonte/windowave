local EnemyIndicator = {}

local function clamp(val, min, max)
    return math.max(min, math.min(max, val))
end

function EnemyIndicator.drawIndicators(enemies, cameraX, cameraY, screenWidth, screenHeight, playerX, playerY)
    local maxIndicatorDistance = 400 
    local minFadeDistance = math.floor(height/2)

    for _, enemy in ipairs(enemies) do
        local ex, ey = enemy.x, enemy.y
        local sx = ex - cameraX
        local sy = ey - cameraY

        local dx = ex - playerX
        local dy = ey - playerY
        local dist = math.sqrt(dx * dx + dy * dy)

        if (sx < 0 or sx > screenWidth or sy < 0 or sy > screenHeight) and dist <= maxIndicatorDistance then
            local angle = math.atan2(dy, dx)
            local margin = 16
            local radius = math.min(screenWidth, screenHeight) / 2 - margin

            local cx = screenWidth / 2 + math.cos(angle) * radius
            local cy = screenHeight / 2 + math.sin(angle) * radius

            local size = 8
            local a1 = angle + math.rad(150)
            local a2 = angle - math.rad(150)

            local x1 = cx + math.cos(a1) * size
            local y1 = cy + math.sin(a1) * size
            local x2 = cx + math.cos(a2) * size
            local y2 = cy + math.sin(a2) * size

            local alpha = clamp(1 - (dist - minFadeDistance) / (maxIndicatorDistance - minFadeDistance), 0.2, 1)

            love.graphics.setColor(1, 0.4, 0.5, alpha)
            love.graphics.polygon("fill", cx, cy, x1, y1, x2, y2)
        end
    end
end

return EnemyIndicator
