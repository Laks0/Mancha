player = {}

function player:set()
  self.x = width/2
  self.y = height/2
  self.it = false
  self.rad = 16
  self.maxSpeed = 350
  self.acceleration = 50
  self.movement = {
    x = 0,
    y = 0
  }
  self.stone = false
  self.stoneTimer = 0
  self.sprint = false
  self.sprintTimer = 0
end

function player:update(dt)
  joysticks = love.joystick.getJoysticks()
  keys = {
    left = love.keyboard.isDown("a") or joysticks[1]:getAxis(1) < -.5,
    right = love.keyboard.isDown("d") or joysticks[1]:getAxis(1) > .5,
    up = love.keyboard.isDown("w") or joysticks[1]:getAxis(2) < -.5,
    down = love.keyboard.isDown("s") or joysticks[1]:getAxis(2) > .5,
  }

  if self.sprint then
    self.maxSpeed = 600
    self.acceleration = 100

    self.sprintTimer = self.sprintTimer - dt
    if self.sprintTimer <= 0 then
      self.sprint = false
    end
  else
    self.maxSpeed = 350
    self.acceleration = 50
  end

  if keys.right and self.movement.x < self.maxSpeed then
    self.movement.x = self.movement.x + self.acceleration
  end
  if keys.down and self.movement.y < self.maxSpeed then
    self.movement.y = self.movement.y + self.acceleration
  end
  if keys.left and self.movement.x > -self.maxSpeed then
    self.movement.x = self.movement.x - self.acceleration
  end
  if keys.up and self.movement.y > -self.maxSpeed then
    self.movement.y = self.movement.y - self.acceleration
  end

  if self.movement.x < -10 or self.movement.x > 10 then
    self.movement.x = self.movement.x - self.acceleration/2*sign(self.movement.x)
  else
    self.movement.x = 0
  end
  if self.movement.y < -10 or self.movement.y > 10 then
    self.movement.y = self.movement.y - self.acceleration/2*sign(self.movement.y)
  else
    self.movement.y = 0
  end

  if not self.stone then
    local toMoveX = self.x + self.movement.x * dt
    if toMoveX - self.rad > field.x and  toMoveX + self.rad < field.x + field.w then
      self.x = toMoveX
    end
    local toMoveY = self.y + self.movement.y * dt
    if toMoveY - self.rad > field.y and  toMoveY + self.rad < field.y + field.h then
      self.y = toMoveY
    end
  else
    self.stoneTimer = self.stoneTimer - dt
    if self.stoneTimer <= 0 then
      self.stone = false
    end
  end

  if self.x + 16 > field.x + field.w then self.x = field.x + field.w - 16 end
  if self.y + 16 > field.y + field.h then self.y = field.y + field.h - 16 end
  if self.x - 16 < field.x then self.x = field.x + 16 end
  if self.y - 16 < field.y then self.y = field.y + 16 end
end

function player:show()
  render:circle("fill",self.x,self.y,16,2,{0,0,.8})
  if self.it then
    render:circle("line",self.x,self.y,16,2,{0,0,0},3)
  end
end
