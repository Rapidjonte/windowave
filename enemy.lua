enemies = {}

require("stats")
require("bullet")

function spawnEnemy(x, y)
    local minR = 7
    local maxR = 16

    if (math.random(0, 100) < bigChance) then
        maxR = 50
    end

    local _radius = math.random(minR, maxR)
    local _health = math.floor(math.pi * _radius^2 * 2)

    local enemy = {
        x = x,
        y = y,
        radius = _radius,
        health = _health,
        startHealth = _health,
        fireTimer = 0
    }
  
    table.insert(enemies, enemy)
end

function drawEnemies(dt)
    while #enemies < enemyCap do
        spawnEnemy(love.math.random(0,worldWidth),love.math.random(0,worldHeight))
    end

    for i = #enemies, 1, -1 do
        local e = enemies[i]

        if bulletCheck(e) then
            e.health = e.health - bulletDamage
            if e.health <= 0 then
                local xpGain = math.floor(e.startHealth/300)
                local textSize = math.min(30,math.floor(e.radius)+2)
                showText("+" .. xpGain .. " XP", e.x, e.y, 1000, {0, 1, 1}, textSize)
                xp = xp + xpGain * xpMult
                table.remove(enemies, i)
                goto continue
            end
        end

        love.graphics.setColor(1, 0, 0)
        love.graphics.circle("fill", e.x - math.floor(sx), e.y - math.floor(sy), e.radius)
        e.fireTimer = e.fireTimer + dt
        if e.fireTimer >= 0.5 then
            shootBullet(e.x, e.y, love.math.random(0, 360), true, 100, 200, 4)
            e.fireTimer = 0
        end

        drawEnemyHealthbar(e.x, e.y-e.radius-7, e.health, e.radius, e.startHealth)
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
            end
        end
    end
    return false
end
