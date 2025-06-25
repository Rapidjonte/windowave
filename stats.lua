-- player stats --
width, height = 200, 200
health = 1000
xp = 0
xpMult = 1
lvl = 1
speed = 40
turnMultiplier = 1
bulletSize = 4
bulletDamage = 200
bulletSpeed = 100
bulletSpread = 15
bulletLifespan = 1.5
fireCooldown = 0.75

-- config --
worldWidth, worldHeight = love.window.getDesktopDimensions(1)
margin = 5
px, py = width / 2, height / 2
ps = 10
d = nil
fireTimer = nil
sx, sy = 0, 0
delta = 0

-- game options --
enemyCap = worldWidth*worldHeight/100000
bigChance = 5