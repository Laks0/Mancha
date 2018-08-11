local border = 10
field = {}

require "objects/player"
require "objects/ia"
require "objects/power_up"

local tagSound = love.audio.newSource("assets/tag.wav", "static")
local endGameSound = love.audio.newSource("assets/endGame.wav", "static")

function game_load()
  player:set()
  ia:set()
  timer = 30
  puTimer = love.math.random(6,8)
  border = 10
end

function game_update(dt)
  puTimer = puTimer - dt
  timer = timer - dt

  if timer > 6 then
    border = border + dt*22
  end
  render:rectangle("line",0,0,width,height,3,{0,0,0},border)
  field = {
    x = border/2,
    y = border/2,
    w = width-border,
    h = height-border
  }

  player:update(dt)
  ia:update(dt)

  if dist(player.x,player.y,ia.x,ia.y) < 64 then
    player.it = not player.it
    ia.it = not ia.it
    ia.movement.x = 500 * sign(ia.x-player.x)
    player.movement.x = 500 * sign(player.x-ia.x)
    ia.movement.y = 500 * sign(ia.y-player.y)
    player.movement.y = 500 * sign(player.y-ia.y)

    tagSound:play()
  end

  if puTimer <= 0 then
    puTimer = love.math.random(6,8)
    powerUps:create()
  end

  powerUps:update(dt)

  if timer <= 0 then
    endGameSound:play()
    scene = "endgame"
    endgame_load(player.it ~= true)
  end
end

function game_draw()
  render:textf(math.floor(timer),0,height/2-bebas128Line/2,"center",width,1,{.4,.1,0},bebas128)

  powerUps:show()

  player:show()
  ia:show()
end
