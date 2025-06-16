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