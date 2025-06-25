function drawPlayerHealthbar(x, y, hp)
	local w = math.ceil(hp / 30)
	love.graphics.setColor(0, 1, 0)
	love.graphics.rectangle("fill", x - (w / 2), y-1, w, 2)
end

function drawEnemyHealthbar(x, y, hp, r, startHealth)
    local w = math.ceil((hp / startHealth) * r * 3)
	love.graphics.setColor(0, 1, 0)
	love.graphics.rectangle("fill", x - (w / 2) - math.floor(sx), y-1 - math.floor(sy), w, 2)
end