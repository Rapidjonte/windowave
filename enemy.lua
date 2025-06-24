enemies = {}

require("stats")
require("bullet")

function spawnEnemy(x, y)
    local enemy = {
        x = x,
        y = y,
        radius = 8,
        health = 1000,
        fireTimer = 0
    }
  
    table.insert(enemies, enemy)
end

function drawEnemies(dt)
    for i = #enemies, 1, -1 do
        if bulletCheck(enemies[i]) then
            enemies[i].health = enemies[i].health - bulletDamage
            if enemies[i].health <= 0 then
                table.remove(enemies, i)
                goto continue
            end
        end

        local e = enemies[i]
        love.graphics.setColor(1, 0, 0)
        love.graphics.circle("fill", e.x - sx, e.y - sy, e.radius)
        e.fireTimer = e.fireTimer + dt
        if e.fireTimer >= 0.5 then
            shootBullet(e.x, e.y, love.math.random(0, 360), true, bulletSpeed, bulletDamage, bulletSize)
            e.fireTimer = 0
        end
        ::continue::
    end
end

function bulletCheck(e)
    for i = #bullets, 1, -1 do
        local b = bullets[i]

        if not b.enemyBullet then
            local dx = b.x - e.x
            local dy = b.y - e.y
            local dist = math.sqrt(dx * dx + dy * dy)
            
            if dist < (b.radius + e.radius) then
                table.remove(bullets, i)
                return true
            else
                return false
            end
        end
    end
end
