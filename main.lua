io.stdout:setvbuf("no")

require("bullet")
require("enemy")
require("stats")

local debugPrint = false

-- config --
worldWidth, worldHeight = love.window.getDesktopDimensions(1)
margin = 5
px, py = width / 2, height / 2
ps = 10
d = nil
fireTimer = nil

function love.load()
   love.window.setMode(width, height, {borderless = true})
   love.window.setPosition(sx, sy, 1)

   spawnEnemy(love.math.random(0,200),love.math.random(0,200))

   fireTimer = 0
   d = 0
end

function love.update(dt)
   local centerX = math.floor(width / 2)
   local centerY = math.floor(height / 2)
   delta = dt

   love.window.setPosition(sx, sy, 1)

   if love.keyboard.isDown("escape") then
      love.event.push('quit')
   end

   if love.keyboard.isDown("d") then
      if math.abs(px - centerX-5) <= margin and sx + width < worldWidth then
         sx = math.min(sx + speed * dt, worldWidth - width)
         px = centerX
      elseif px < width - 5 then
         px = math.min(px + speed * dt, width - 5)
      end
   elseif love.keyboard.isDown("a") then
      if math.abs(px - centerX) <= margin and sx > 0 then
         sx = math.max(sx - speed * dt, 0)
         px = centerX
      elseif px > 5 then
         px = math.max(px - speed * dt, 5)
      end
   end

   local diagScale = 1
   if (love.keyboard.isDown("w") or love.keyboard.isDown("s")) and (love.keyboard.isDown("a") or love.keyboard.isDown("d")) then
      diagScale = 1 / math.sqrt(2)
   end

   if love.keyboard.isDown("s") then
      if math.abs(py - centerY-5) <= margin and sy + height < worldHeight then
         sy = math.min(sy + speed * dt * diagScale, worldHeight - height)
         py = centerY
      elseif py < height - 5 then
         py = math.min(py + speed * dt * diagScale, height - 5)
      end
   elseif love.keyboard.isDown("w") then
      if math.abs(py - centerY) <= margin and sy > 0 then
         sy = math.max(sy - speed * dt * diagScale, 0)
         py = centerY
      elseif py > 5 then
         py = math.max(py - speed * dt * diagScale, 5)
      end
   end

   if love.keyboard.isDown("right") then
      d = d + 100 * turnMultiplier * dt
   end
   if love.keyboard.isDown("left") then
      d = d - 100 * turnMultiplier * dt
   end

   fireTimer = fireTimer + dt
   if love.keyboard.isDown("up") and fireTimer >= fireCooldown then
      shootBullet(px + sx, py + sy, d + (love.math.random() * 2 * bulletSpread - bulletSpread), false, bulletSpeed, bulletDamage, bulletSize)
      fireTimer = 0
   end

   updateBullets(dt)
end

function love.keypressed(key, scancode, isrepeat)
   if key == "f3" then
      debugPrint = not debugPrint
   end
end

function love.draw()
   love.graphics.clear()
   love.graphics.setColor(1, 1, 1)
   love.graphics.rectangle("fill", px - 5, py - 5, ps, ps)
   love.graphics.setColor(1, 1, 0)
   love.graphics.arc('line', 'pie', px, py, 20, math.rad(d - bulletSpread), math.rad(d + bulletSpread), 4)
   drawBullets(sx, sy)
   drawEnemies(delta)

   if debugPrint then
      love.graphics.setColor(0, 1, 0)
      love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 0)
      love.graphics.print("E: " .. #enemies, 0, 20)
      love.graphics.print("B: " .. #bullets, 0, 30)
      love.graphics.print("X: " .. px, 0, 50)
      love.graphics.print("Y: " .. py, 0, 60)
      love.graphics.print("R: " .. d, 0, 70)
      love.graphics.print("HP: " .. health, 0, 90)
   end
end