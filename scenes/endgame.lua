local win = false

function endgame_load(w)
  win = w
end

function endgame_update(dt)
  if love.mouse.isDown(1) then
    if mouse_en(width/2-100,height/2-defLine/2+100,200,defLine+20) then
      scene = "game"
      game_load()
      selectSound:play()
    end
    if mouse_en(width/2-100,height/2-defLine/2+200,200,defLine+20) then
      scene = "menu"
      menu_load()
      selectSound:play()
    end
  end
end

function endgame_draw()
  local text = "Player Loses"
  if win then
    text = "Player wins"
  end
  render:textf(text,0,height/2-bebas128Line/2,"center",width,3,{.4,.1,0},bebas128)

  render:rectangle("line",width/2-100,height/2-defLine/2+100,200,defLine+20,2,{0,0,0},10)
  render:rectangle("fill",width/2-100,height/2-defLine/2+100,200,defLine+20,1,{0,.6,0})

  render:textf("Play again",width/2-100,height/2-defLine/2+105,"center",200,2,{.4,.1,0})


  render:rectangle("line",width/2-100,height/2-defLine/2+200,200,defLine+20,2,{0,0,0},10)
  render:rectangle("fill",width/2-100,height/2-defLine/2+200,200,defLine+20,1,{0,.6,0})

  render:textf("Go to menu",width/2-100,height/2-defLine/2+205,"center",200,2,{.4,.1,0})
end
