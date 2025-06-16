enemies = {}

function spawnEnemy(x, y, enemyType)
    local enemyType = 1

    local enemy = {
        x = x,
        y = y,
        radius = 4,
        health = 1000,
        alive = true
    }

    table.insert(enemy, enemies)
end