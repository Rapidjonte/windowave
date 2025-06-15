bullets = {}

local function deg2rad(deg)
    return deg * math.pi / 180
end

function shootBullet(x, y, angleDeg)
    local angleRad = deg2rad(angleDeg)
    local speed = 300

    local bullet = {
        x = x,
        y = y,
        dx = math.cos(angleRad) * speed,
        dy = math.sin(angleRad) * speed,
        radius = 4,
        alive = true
    }

    table.insert(bullets, bullet)
end