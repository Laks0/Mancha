local start = false
local startTimer = 0
local instructions = false

local music = love.audio.newSource("assets/introMusic.ogg", "static")
local mancha = love.audio.newSource("assets/mancha!.ogg", "static")

function menu_load()
  music:play()
  startTimer = 2.1
  start = false
end

function menu_update(dt)
  if start then
    if mouse_pres then
      if mouse_en(width/2-100,height/2-defLine/2-10,200,defLine+20) then
        game_load()
        scene = "game"
        selectSound:play()
      end
      if mouse_en(width/2-100,height/2-defLine/2-100,200,defLine+20) then
        start = false
        instructions = true
        selectSound:play()
      end
      if mouse_en(width/2-100,height/2-defLine/2+100,200,defLine+20) then
        audio = not audio
        if audio then selectSound:play() end
      end
      if mouse_en(width/2-100,height/2-defLine/2+200,200,defLine+20) then
        love.window.close()
      end
      if mouse_en(width/2-100,height/2-defLine/2+300,200,defLine+20) then
        borderless = not borderless
        love.window.setMode(1280, 720, {borderless = borderless})
        selectSound:play()
      end
    end
  elseif not instructions then
    startTimer = startTimer - dt
    if startTimer <= 0 then
      start = true
      mancha:play()
    end
  else
    if mouse_en(width/2-100,height/2-defLine/2+300,200,defLine+20) and mouse_pres then
      instructions = false
      start = true
      selectSound:play()
    end
  end
end

function menu_draw()
  if start then
    render:textf("Lakso's",0,0,"center",width,3,{.4,.1,0})
    render:textf("Mancha!",0,15,"center",width,3,{.4,.1,0},bebas128)
    render:textf("The classic game of Tag",0,bebas128Line-10,"center",width,3,{.4,.1,0})

    render:rectangle("line",width/2-100,height/2-defLine/2-10,200,defLine+20,2,{0,0,0},10)
    render:rectangle("fill",width/2-100,height/2-defLine/2-10,200,defLine+20,1,{0,.6,0})

    render:textf("Start Game!",width/2-100,height/2-defLine/2-5,"center",200,2,{.4,.1,0})

    local audioText = "Volume on"
    if not audio then
      audioText = "Volume off"
    end
    render:rectangle("line",width/2-100,height/2-defLine/2+100,200,defLine+20,2,{0,0,0},10)
    render:rectangle("fill",width/2-100,height/2-defLine/2+100,200,defLine+20,1,{0,.6,0})

    render:textf(audioText,width/2-100,height/2-defLine/2+105,"center",200,2,{.4,.1,0})

    render:rectangle("line",width/2-100,height/2-defLine/2+200,200,defLine+20,2,{0,0,0},10)
    render:rectangle("fill",width/2-100,height/2-defLine/2+200,200,defLine+20,1,{0,.6,0})

    render:textf("Exit game",width/2-100,height/2-defLine/2+205,"center",200,2,{.4,.1,0})

    render:rectangle("line",width/2-100,height/2-defLine/2+300,200,defLine+20,2,{0,0,0},10)
    render:rectangle("fill",width/2-100,height/2-defLine/2+300,200,defLine+20,1,{0,.6,0})

    render:textf("Borderless on/off",width/2-100,height/2-defLine/2+305,"center",200,2,{.4,.1,0})


    render:rectangle("line",width/2-100,height/2-defLine/2-100,200,defLine+20,2,{0,0,0},10)
    render:rectangle("fill",width/2-100,height/2-defLine/2-100,200,defLine+20,1,{0,.6,0})

    render:textf("Instructions",width/2-100,height/2-defLine/2-95,"center",200,2,{.4,.1,0})
  elseif instructions then
    render:textf("Lakso's",0,0,"center",width,3,{.4,.1,0})
    render:textf("Mancha!",0,15,"center",width,3,{.4,.1,0},bebas128)
    render:textf("The classic game of Tag",0,bebas128Line-10,"center",width,3,{.4,.1,0})

    render:text("You are the blue circle",20,defLine*10,2,{.4,.1,0})
    render:circle("fill",defaultFont:getWidth("You are the blue circle")+52,defLine*10.8,16,2,{0,0,.8})

    render:text("Whoever has the black ring is it",20,defLine*12,2,{.4,.1,0})
    render:circle("line",defaultFont:getWidth("Whoever has the black ring is it")+52,defLine*12.8,16,2,{0,0,0},5)

    render:text("These are the power ups, both you and the AI can pick them up",20,defLine*14.8,2,{.4,.1,0})
    render:circle("fill",36,defLine*17.8,16,2,{.2,.2,.2})
    render:text("Stuns the other player",62,defLine*17,2,{.4,.1,0})
    render:circle("fill",36,defLine*19.8,16,2,{1,0,0})
    render:text({{.4,.1,0},"Speed boost"},62,defLine*19,2)

    render:text("Use WASD to move of the left stick of a joystick",20,defLine*21.8,2,{.4,.1,0})

    render:text("Tag the AI and don't let it tag you",20,defLine*23.8,2,{.4,.1,0})

    render:rectangle("line",width/2-100,height/2-defLine/2+300,200,defLine+20,2,{0,0,0},10)
    render:rectangle("fill",width/2-100,height/2-defLine/2+300,200,defLine+20,1,{0,.6,0})

    render:textf("Back",width/2-100,height/2-defLine/2+305,"center",200,2,{.4,.1,0})
  end
end

function mouse_en(x,y,w,h)
  local mouse = {
    x = love.mouse.getX(),
    y = love.mouse.getY()
  }
  return mouse.x > x and mouse.y > y and mouse.x < x + w and mouse.y < y + h
end
