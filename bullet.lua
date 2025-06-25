bullets = {}

require("stats")

local function deg2rad(deg)
    return deg * math.pi / 180
end

function shootBullet(x, y, _dir, _enemyBullet, _speed, _damage, _radius)
    local dir = deg2rad(_dir)

    local bullet = {
        x = x,
        y = y,
        dx = math.cos(dir) * _speed,
        dy = math.sin(dir) * _speed,
        radius = _radius,
        enemyBullet = _enemyBullet,
        damage = _damage,
        m = 2.5 + _radius / _speed
    }

    if not _enemyBullet then
        bullet.m = bulletLifespan
    end

    table.insert(bullets, bullet)
end

function updateBullets(dt)
    for i = #bullets, 1, -1 do
        local b = bullets[i]

        b.x = b.x + b.dx * dt
        b.y = b.y + b.dy * dt
        b.m = b.m - dt

        if b.x < 0 or b.x > worldWidth or b.y < 0 or b.y > worldHeight or b.m <= 0 then
            table.remove(bullets, i)
        else
            if b.enemyBullet then
                local playerL = px + math.floor(sx) - 5
                local playerR = px + math.floor(sx) + 5
                local playerT = py + math.floor(sy) - 5
                local playerB = py + math.floor(sy) + 5

                local bulletL = b.x - b.radius
                local bulletR = b.x + b.radius
                local bulletT = b.y - b.radius
                local bulletB = b.y + b.radius

                if bulletR > playerL and bulletL < playerR 
                and bulletB > playerT and bulletT < playerB then
                    health = health - b.damage
                    table.remove(bullets, i)
                    if health <= 0 then
                        love.event.push('quit')
                    end
                end
            end
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