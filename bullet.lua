bullets = {}

local function deg2rad(deg)
    return deg * math.pi / 180
end

function shootBullet(x, y, _dir, _enemyBullet, _speed, _damage, _radius)
    local dir = deg2rad(_dir)
    local speed = _speed

    local bullet = {
        x = x,
        y = y,
        dx = math.cos(dir) * speed,
        dy = math.sin(dir) * speed,
        radius = _radius,
        enemyBullet = _enemyBullet ~= nil and _enemyBullet or false,
        damage = _damage,
        alive = true
    }

    table.insert(bullets, bullet)
end

function updateBullets(dt)
    for i = #bullets, 1, -1 do
        local b = bullets[i]
        b.x = b.x + b.dx * dt
        b.y = b.y + b.dy * dt

        if b.x < 0 or b.x > worldWidth or b.y < 0 or b.y > worldHeight then
            table.remove(bullets, i)
        end
    end
end

function drawBullets(offsetX, offsetY)
    offsetX = offsetX or 0
    offsetY = offsetY or 0

    for _, b in ipairs(bullets) do
        if (not b.enemyBullet) then
            love.graphics.setColor(1, 1, 0)
        else
            love.graphics.setColor(1, 0, 0)
        end

        love.graphics.circle("fill", b.x - offsetX, b.y - offsetY, b.radius)
    end
end