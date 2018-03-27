local graphics = {}

graphics.load = function()
  love.graphics.setDefaultFilter("nearest", "nearest")

  font = love.graphics.newImageFont("font.png",
  " ABCDEFGHIJKLMNOPQRSTUVWXYZ" ..
  "abcdefghijklmnopqrstuvwxyz" ..
  "0123456789!?.,':$[]%", 1)
  love.graphics.setFont(font)

  love.graphics.setLineStyle("rough")
  love.graphics.setLineWidth(2)

  -- images
  img = {}
  files = love.filesystem.getDirectoryItems("imgs")
  for i, v in ipairs(files) do
    img[string.sub(v, 1, -5)] = love.graphics.newImage("imgs/"..v)
  end

  -- quads
  quad = {}
  quad.mapdetail = graphics.spritesheet(img.mapdetail, 64, 64)
  quad.icons = graphics.spritesheet(img.icons, 16, 16)
  quad.noteicons = graphics.spritesheet(img.noteicons, 12, 12)
  quad.cardicons = graphics.spritesheet(img.cardicons, 16, 16)
  quad.cardimgs = graphics.spritesheet(img.cardimgs, 48, 48)

  -- canvases
  canvas = {}

  love.graphics.setBackgroundColor(255, 255, 255)
end

graphics.spritesheet = function(img, tw, th)
  local quads = {}
  for y = 0, math.ceil(img:getHeight()/th)-1 do
    for x = 0, math.ceil(img:getWidth()/tw)-1 do
      quads[#quads+1] = love.graphics.newQuad(x*tw, y * th, tw, th, img:getDimensions())
    end
  end
  return quads
end

graphics.dotted_line = function(x1, y1, x2, y2, gap)
  local gap = gap or 4

  local r = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
  local theta = math.atan2((y2-y1), (x2-x1))

  for i = 0, math.floor(r / (gap*2)) do
    love.graphics.line(x1 + i*gap*2*math.cos(theta), y1 + i*gap*2*math.sin(theta), x1 + (i*gap*2+gap)*math.cos(theta), y1 + (i*gap*2+gap)*math.sin(theta))
  end
end

return graphics