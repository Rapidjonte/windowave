io.stdout:setvbuf("no")
require("bullet")

-- STATS --
width, height = 200, 200
speed = 100
shotSpread = 15
turnSpeed = 1
fireCooldown = 0.5
fireTimer = nil

-- config --
worldWidth, worldHeight = love.window.getDesktopDimensions(1)
margin = 5
sx, sy = 0, 0
px, py = width / 2, height / 2
ps = 10
d = nil

function love.load()
   love.window.setMode(width, height, {borderless = true})
   love.window.setPosition(sx, sy, 1)
   love.graphics.setColor(1, 1, 1)
   fireTimer = 0
   d = 0
end

function love.update(dt)
   local centerX = math.floor(width / 2)
   local centerY = math.floor(height / 2)

   love.window.setPosition(sx, sy, 1)

   if love.keyboard.isDown("escape") then
      love.event.push('quit')
   end

    if love.keyboard.isDown("d") then
      if math.abs(px - centerX-5) <= margin and sx + width < worldWidth then
         sx = math.min(sx + speed * dt, worldWidth - width)
      elseif px < width - 5 then
         px = math.min(px + speed * dt, width - 5)
      end
   elseif love.keyboard.isDown("a") then
      if math.abs(px - centerX) <= margin and sx > 0 then
         sx = math.max(sx - speed * dt, 0)
      elseif px > 5 then
         px = math.max(px - speed * dt, 5)
      end
   end

   if love.keyboard.isDown("s") then
      if math.abs(py - centerY-5) <= margin and sy + height < worldHeight then
         sy = math.min(sy + speed * dt, worldHeight - height)
      elseif py < height - 5 then
         py = math.min(py + speed * dt, height - 5)
      end
   elseif love.keyboard.isDown("w") then
      if math.abs(py - centerY) <= margin and sy > 0 then
         sy = math.max(sy - speed * dt, 0)
      elseif py > 5 then
         py = math.max(py - speed * dt, 5)
      end
   end

   if love.keyboard.isDown("right") then
      d = d + 100 * turnSpeed * dt
   end

   if love.keyboard.isDown("left") then
      d = d - 100 * turnSpeed * dt
   end

   fireTimer = fireTimer + dt
   if love.keyboard.isDown("up") and fireTimer >= fireCooldown then
      shootBullet(px + sx, py + sy, d + (love.math.random() * 2 * shotSpread - shotSpread))
      fireTimer = 0
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

function love.draw()
   love.graphics.clear()
   love.graphics.rectangle("fill", px - 5, py - 5, ps, ps)
   love.graphics.setColor(1, 1, 0)
   love.graphics.arc(
      'line', 'pie', px, py, 20,
      math.rad(d - shotSpread), math.rad(d + shotSpread),
      4
   ) 
   love.graphics.setColor(1, 1, 1)
   print(math.floor(d-15) .. " " .. math.floor(d+15))
   drawBullets(sx, sy)
end