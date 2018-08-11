function menu_update(dt)
  if love.mouse.isDown(1) and mouse_en(width/2-100,height/2-defLine/2-10,200,defLine+20) then
    game_load()
    scene = "game"
    selectSound:play()
  end
end

function menu_draw()
  render:textf("Mancha!",0,0,"center",width,3,{.4,.1,0},bebas128)

  render:rectangle("line",width/2-100,height/2-defLine/2-10,200,defLine+20,2,{0,0,0},10)
  render:rectangle("fill",width/2-100,height/2-defLine/2-10,200,defLine+20,1,{0,.6,0})

  render:textf("Start Game!",width/2-100,height/2-defLine/2-5,"center",200,2,{.4,.1,0})
end

function mouse_en(x,y,w,h)
  local mouse = {
    x = love.mouse.getX(),
    y = love.mouse.getY()
  }
  return mouse.x > x and mouse.y > y and mouse.x < x + w and mouse.y < y + h
end
