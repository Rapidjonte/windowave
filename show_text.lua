texts = {}

require("stats")

function showText(_str,_x,_y,_m, _c, _sz)
	local text = {
		str = _str,
		x = _x,
		y = _y,
		m = _m,
		c = _c,
		sm = _m,
		sz = _sz
	}
	table.insert(texts, text)
end

function drawText(dt)
	for i = #texts, 1, -1 do
		t = texts[i]

		t.m = t.m - dt*1000
		if t.m <= 0 then
			table.remove(texts, i)
			goto continue
		end
		
		t.c[4] = (t.m / t.sm) > 0.5 and 1 or math.pow((t.m / t.sm) * 2, 2)
		love.graphics.setColor(t.c)  

		local font = love.graphics.newFont(t.sz)
		local text = love.graphics.newText(font, t.str)
		local textWidth = text:getWidth()
    	local textHeight = text:getHeight()

    	love.graphics.draw(text, t.x - textWidth / 2 - math.floor(sx), t.y - textHeight / 2 - math.floor(sy))

    	::continue::
	end
end