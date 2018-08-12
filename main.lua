--[[
As the ancient legend says "a good code doesn't need comments", so this is my
gift to you, the perfect code, enjoy.
]]

require "tools/render"

require "scenes/game"
require "scenes/menu"
require "scenes/endgame"

defaultFont = love.graphics.newFont("assets/BebasNeue.ttf", 30)
defLine = defaultFont:getHeight("_")-15

bebas128 = love.graphics.newFont("assets/BebasNeue.ttf", 128)
bebas128Line = bebas128:getHeight("A")

width = love.graphics.getWidth()
height = love.graphics.getHeight()

selectSound = love.audio.newSource("assets/select.wav", "static")

mouse_pres = false

borderless = true

function love.load()
  render:create(3)
  scene = "menu"

  audio = true

  menu_load()

  love.graphics.setBackgroundColor(.9,.8,.8)
end

function love.update(dt)
  render:clear()

  if audio then
    love.audio.setVolume(.1)
  else
    love.audio.setVolume(0)
  end

  if scene == "game" then
    game_update(dt)
  elseif scene == "menu" then
    menu_update(dt)
  elseif scene == "endgame" then
    endgame_update(dt)
  end
end

function love.draw()
  if scene == "game" then
    game_draw()
  elseif scene == "menu" then
    menu_draw()
  elseif scene == "endgame" then
    endgame_draw()
  end

  for i = 1, #render do
    render:show(i)
  end

  mouse_pres = false
end

function dist(x,y,x2,y2)
  local c1 = x - x2
  local c2 = y - y2
  return math.sqrt(math.pow(c1,2) + math.pow(c2,2))
end

function sign(n)
  if n > 0 then
    return 1
  elseif n < 0 then
    return -1
  end
  return 0
end

function love.mousepressed(x, y, b, isTouch)
  mouse_pres = b == 1
end
