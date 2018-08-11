powerUps = {}

local stoneSound = love.audio.newSource("assets/pu.wav", "static")
local sprintSound = love.audio.newSource("assets/sprint.wav", "static")

powers = {
  {
    {.3,.3,.3},
    function (p)
      if p == "player" then
        ia.stone = true
        ia.stoneTimer = 1.5
      else
        player.stone = true
        player.stoneTimer = 1.5
      end
      stoneSound:play()
    end
  },
  {
    {1,0,0},
    function (p)
      if p == "ia" then
        ia.sprint = true
        ia.sprintTimer = 1.5
      else
        player.sprint = true
        player.sprintTimer = 1.5
      end
      sprintSound:play()
    end
  }
}

function powerUps:create()
  local p = {}
  p.x = love.math.random(field.x+20,field.x+field.w-20)
  p.y = love.math.random(field.y+20,field.y+field.h-20)
  p.power = love.math.random(1,#powers)
  p.color = powers[p.power][1]
  p.func = powers[p.power][2]
  table.insert(self,p)
end

function powerUps:show()
  for i, p in ipairs(self) do
    render:circle("fill",p.x,p.y,16,2,p.color)
  end
end

function powerUps:update(dt)
  for i, p in ipairs(self) do
    if dist(p.x,p.y,player.x,player.y) <= 32 then
      p.func("player")
      table.remove(self,i)
    end
    if dist(p.x,p.y,ia.x,ia.y) <= 32 then
      p.func("ia")
      table.remove(self,i)
    end
  end
end
