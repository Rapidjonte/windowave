require("bullet")

width, height = 200, 200
worldWidth, worldHeight = love.window.getDesktopDimensions(1)
speed = 100
playerSpeed = 100
margin = 5

sx, sy = 0, 0
px, py = width / 2, height / 2
ps = 10

function love.load()
   love.window.setMode(width, height, {borderless = true})
   love.window.setPosition(sx, sy, 1)
   love.graphics.setColor(1, 1, 1)
end

function love.update(dt)
   local centerX = width / 2
   local centerY = height / 2

   if love.keyboard.isDown("escape") then
      love.event.push('quit')
   end

    if love.keyboard.isDown("d") then
      if math.abs(px - centerX-5) <= margin and sx + width < worldWidth then
         sx = math.min(sx + speed * dt, worldWidth - width)
      elseif px < width - 5 then
         px = math.min(px + playerSpeed * dt, width - 5)
      end
   elseif love.keyboard.isDown("a") then
      if math.abs(px - centerX) <= margin and sx > 0 then
         sx = math.max(sx - speed * dt, 0)
      elseif px > 5 then
         px = math.max(px - playerSpeed * dt, 5)
      end
   end

   if love.keyboard.isDown("s") then
      if math.abs(py - centerY-5) <= margin and sy + height < worldHeight then
         sy = math.min(sy + speed * dt, worldHeight - height)
      elseif py < height - 5 then
         py = math.min(py + playerSpeed * dt, height - 5)
      end
   elseif love.keyboard.isDown("w") then
      if math.abs(py - centerY) <= margin and sy > 0 then
         sy = math.max(sy - speed * dt, 0)
      elseif py > 5 then
         py = math.max(py - playerSpeed * dt, 5)
      end
   end

   updateBullets(dt)
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

   love.graphics.setColor(1, 1, 0)
   for _, b in ipairs(bullets) do
      love.graphics.circle("fill", b.x - offsetX, b.y - offsetY, b.radius)
   end
   love.graphics.setColor(1, 1, 1)
end

function love.keypressed(key, scancode, isrepeat)
   if key == "up" then
      shootBullet(px+sx, py+sy, 0)
   end
end

function love.draw()
   love.window.setPosition(sx, sy, 1)
   love.graphics.clear()
   love.graphics.rectangle("fill", px - 5, py - 5, ps, ps)
   drawBullets(sx, sy)
end