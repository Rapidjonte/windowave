enemies = {}

require("stats")

function spawnEnemy(x, y)
    local enemy = {
        x = x,
        y = y,
        radius = 7,
        health = 1000,
        alive = true,
        fireTimer = 0
    }
  
    table.insert(enemies, enemy)
end

function drawEnemies(dt)
    love.graphics.setColor(1, 0, 0)

    for i = #enemies, 1, -1 do
        local e = enemies[i]
        love.graphics.circle("fill", e.x - sx, e.y - sy, e.radius)
        e.fireTimer = e.fireTimer + dt
        if e.fireTimer >= 0.5 then
            shootBullet(e.x, e.y, love.math.random(0, 360), true, bulletSpeed, bulletDamage, bulletSize)
            e.fireTimer = 0
        end
    end
end