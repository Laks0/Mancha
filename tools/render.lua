render = {}

function render:create(n)
  for i = 1, n do
    table.insert(self,{ayer})
  end
end

function render:clear()
  for i = 1,#render do
    render[i] = {}
  end
end

function render:text(t,x,y,l,c,font)
  local r = {}
  r.type = "txt"
  r.t = t or "Empty"
  r.x = x or 0
  r.y = y or 0
  r.c = c or {1,1,1}
  r.font = font or defaultFont

  local layer = l or 1
  if layer < 1 then
    layer = 1
  elseif layer > #render then
    layer = #render
  end

  table.insert(self[layer],r)
end

function render:textf(t,x,y,format,limit,l,c,font)
  local r = {}
  r.type = "txtf"
  r.t = t or "Empty"
  r.x = x or 0
  r.y = y or 0
  r.c = c or {1,1,1}
  r.format = format or "left"
  r.limit = limit or "100"
  r.font = font or defaultFont

  local layer = l or 1
  if layer < 1 then
    layer = 1
  elseif layer > #render then
    layer = #render
  end

  table.insert(self[layer],r)
end

function render:rectangle(m,x,y,w,h,l,c,line)
  local r = {}
  r.type = "rect"
  r.m = m or "fill"
  r.x = x or 0
  r.y = y or 0
  r.w = w or 10
  r.h = h or 10
  r.line = line or 1
  r.c = c or {1,1,1}

  local layer = l or 1
  if layer < 1 then
    layer = 1
  elseif layer > #render then
    layer = #render
  end

  table.insert(self[layer],r)
end

function render:circle(m,x,y,rad,l,c,line)
  local r = {}
  r.type = "circ"
  r.m = m or "fill"
  r.x = x or 0
  r.y = y or 0
  r.rad = rad or 10
  r.c = c or {1,1,1}
  r.line = line or 1

  local layer = l or 1
  if layer < 1 then
    layer = 1
  elseif layer > #render then
    layer = #render
  end

  table.insert(self[layer],r)
end

function render:img(img,x,y,l,c)
  local r = {}
  r.type = "img"
  r.img = img
  r.x = x
  r.y = y
  r.c = c or {1,1,1}

  local layer = l or 1
  if layer < 1 then
    layer = 1
  elseif layer > #render then
    layer = #render
  end

  table.insert(self[layer],r)
end

function render:show(n)
  for i, r in ipairs(render[n]) do
    love.graphics.setColor(r.c)
    if r.type == "txt" then
      love.graphics.setFont(r.font)
      love.graphics.print(r.t,r.x,r.y)
    elseif r.type == "txtf" then
      love.graphics.setFont(r.font)
      love.graphics.printf(r.t,r.x,r.y,r.limit,r.format)
    elseif r.type == "rect" then
      love.graphics.setLineWidth(r.line)
      love.graphics.rectangle(r.m,r.x,r.y,r.w,r.h)
    elseif r.type == "circ" then
      love.graphics.setLineWidth(r.line)
      love.graphics.circle(r.m,r.x,r.y,r.rad)
    elseif r.type == "img" then
      love.graphics.draw(r.img,r.x,r.y)
    end
  end
end
