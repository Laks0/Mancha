ia = {}

function ia:set()
  self.x = width/2-200
  self.y = height/2
  self.it = true
  self.rad = 16
  self.maxSpeed = 350
  self.acceleration = 100
  self.movement = {
    x = 0,
    y = 0
  }
  self.stone = false
  self.stoneTimer = 0
  self.sprint = false
  self.sprintTimer = 0

  self.witing = false
  self.waitTime = 0
end

function ia:update(dt)
  chase = {x = 0,y = 0}
  for i, p in ipairs(powerUps) do
    if dist(player.x,player.y,self.x,self.y) > dist(p.x,p.y,self.x,self.y) and self.it then
      chase = {x = p.x,y = p.y}
    end
  end
  if chase.x == 0 then
    chase = {x = player.x, y = player.y}
  end

  local dir = math.atan2(self.y-chase.y,self.x-chase.x)
  local dirx = math.cos(dir)
  local diry = math.sin(dir)

  if self.sprint then
    self.maxSpeed = 600

    self.sprintTimer = self.sprintTimer - dt
    if self.sprintTimer <= 0 then
      self.sprint = false
    end
  else
    self.maxSpeed = 350
  end

  if self.movement.x < self.maxSpeed and self.movement.x > -self.maxSpeed then
    if self.it then
      self.movement.x = self.movement.x - dirx*self.acceleration
    else
      self.movement.x = self.movement.x + dirx*self.acceleration
    end
  end
  if self.movement.y < self.maxSpeed and self.movement.y > -self.maxSpeed then
    if self.it then
      self.movement.y = self.movement.y - diry*self.acceleration
    else
      self.movement.y = self.movement.y + diry*self.acceleration
    end
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

  if not self.stone and not self.waiting then
    local toMoveX = self.x + self.movement.x * dt
    if toMoveX - self.rad > field.x and  toMoveX + self.rad < field.x + field.w then
      self.x = toMoveX
    end
    local toMoveY = self.y + self.movement.y * dt
    if toMoveY - self.rad > field.y and  toMoveY + self.rad < field.y + field.h then
      self.y = toMoveY
    end
  elseif self.stone then
    self.stoneTimer = self.stoneTimer - dt
    if self.stoneTimer <= 0 then
      self.stone = false
    end
  else
    self.waitTime = self.waitTime - dt
    if self.waitTime <= 0 then
      self.waiting = false
    end
  end

  if self.x + 16 > field.x + field.w then self.x = field.x + field.w - 16 end
  if self.y + 16 > field.y + field.h then self.y = field.y + field.h - 16 end
  if self.x - 16 < field.x then self.x = field.x + 16 end
  if self.y - 16 < field.y then self.y = field.y + 16 end
end

function ia:show()
  render:circle("fill",self.x,self.y,16,2,{1,.5,0})
  if self.it then
    render:circle("line",self.x,self.y,16,2,{0,0,0},5)
  end
end

function ia:wait(t)
  self.waiting = true
  self.waitTime = t
end
