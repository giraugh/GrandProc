TEMPLATES = {
  MICRO_SIZE = {5, 5},
  MACRO_SIZE = {7, 7},
  MICRO = {},
  MACRO = {
[[
r--\
]]
  },
}

require "templates.micro"

function generateMap()
  local chosen = TEMPLATES.MACRO[math.random(1, #TEMPLATES.MACRO)]
  local set = decipherMacro(chosen)

  return generateTest()
end

function decipherMacro(mac)
  --create a 2d array from the string
  local n = 1
  local maca = {}
  for c in mac:gmatch"." do
    if c == "\n" then
      n = n + 1
    else
      maca[n] = (maca[n] or "") .. c
    end
  end

  --Create macro table and expand all micros
  local set = generateProperEmpty()
  for i = 1, #maca do
    for j = 1, #(maca[i]) do
      local c = maca[i]:sub(j, j)
      set = decipherMicro(set, j, i, c)
    end
  end

  str = ""
  for i = 1, #set do
    for j = 1, #set[i] do
      str = str .. set[i][j]
    end
    str = str .. "\n"
  end

  rawprint(str)

end

function decipherMicro(set, x, y, type)
  x = ((x-1) * TEMPLATES.MICRO_SIZE[1]) + 1
  y = ((y-1) * TEMPLATES.MICRO_SIZE[1]) + 1
  local micro = TEMPLATES.MICRO[type]

  -- Lets do some organizing!
  local j = 0
  local n = 0
  for i = 1, #micro do
    local c = micro:sub(i, i)
    if c == "\n" then
      j = j + 1
      n = 0
    else
      local xx = n+x
      local yy = j+y
      set[yy][xx] = c
      n = n +1
    end
  end

  return set
end

function generateEmpty()
  local set = {}
  for i = 1, t_world.size.x do
    set[i] = {}
    for j = 1, t_world.size.y do
      set[i][j] = "Grass"
    end
  end

  return set
end

function generateProperEmpty()
  local set = {}
  for i = 1, t_world.size.x do
    set[i] = {}
    for j = 1, t_world.size.y do
      set[i][j] = ""
    end
  end

  return set
end

function generateTest()
  local set = {}
  for i = 1, t_world.size.x do
    set[i] = {}
    for j = 1, t_world.size.y do
      set[i][j] = testMap(i, j)
    end
  end

  return set
end

function testMap(x, y)
  -- GENERATE TEST TRACK --
  local ch = "Grass"
  if x == 5 then ch = "Road_Grass_E" end
  if x == 6 then ch = "Road_Middle_V" end
  if x == 7 then ch = "Road_Grass_W" end

  if y == 5 and ch == "Grass" then ch = "Road_Grass_S" end
  if y == 6 and ch == "Grass" then ch = "Road_Middle_H" end
  if y == 7 and ch == "Grass" then ch = "Road_Grass_N" end

  if x == 5 and y == 5 then ch = "Road_Intern_SW" end
  if x == 5 and y == 7 then ch = "Road_Intern_NE" end
  if x == 7 and y == 5 then ch = "Road_Intern_SE" end
  if x == 7 and y == 7 then ch = "Road_Intern_NW" end

  if x == 5 and y == 6 then ch = "Road_Middle_H" end
  if x == 7 and y == 6 then ch = "Road_Middle_H" end

  if x == 10 and y == 9 then ch =  "Road_Extern_NW" end
  if x == 10 and y == 10 then ch = "Road_Grass_E" end
  if x == 10 and y == 11 then ch = "Road_Grass_E" end
  if x == 10 and y == 12 then ch = "Road_Grass_E" end
  if x == 10 and y == 13 then ch = "Road_Grass_E" end
  if x == 10 and y == 14 then ch = "Road_Extern_SW" end
  if x == 11 and y == 14 then ch = "Road_Grass_N" end
  if x == 12 and y == 14 then ch = "Road_Grass_N" end
  if x == 13 and y == 14 then ch = "Road_Grass_N" end
  if x == 14 and y == 14 then ch = "Road_Grass_N" end
  if x == 15 and y == 14 then ch = "Road_Grass_N" end
  if x == 16 and y == 14 then ch = "Road_Grass_N" end
  if x == 17 and y == 14 then ch = "Road_Extern_SE" end
  if x == 17 and y == 13 then ch = "Road_Grass_W" end
  if x == 17 and y == 12 then ch = "Road_Grass_W" end
  if x == 17 and y == 11 then ch = "Road_Grass_W" end
  if x == 17 and y == 10 then ch = "Road_Grass_W" end
  if x == 17 and y == 9 then ch =  "Road_Extern_NE" end
  if x == 11 and y == 9 then ch = "Road_Grass_S" end
  if x == 12 and y == 9 then ch = "Road_Grass_S" end
  if x == 13 and y == 9 then ch = "Road_Grass_S" end
  if x == 14 and y == 9 then ch = "Road_Grass_S" end
  if x == 15 and y == 9 then ch = "Road_Grass_S" end
  if x == 16 and y == 9 then ch = "Road_Grass_S" end

  if x > 10 and x < 17 and y > 9 and y < 14 then
    if x == 11 or x == 16 then ch = "Road_Middle_V" end
    if y == 10 or y == 13 then ch = "Road_Middle_H" end
    if x == 11 and y == 10 then ch = "Road_Middle_NW" end
    if x == 11 and y == 13 then ch = "Road_Middle_SW" end
    if x == 16 and y == 10 then ch = "Road_Middle_NE" end
    if x == 16 and y == 13 then ch = "Road_Middle_SE" end
    if x > 11 and x < 16 and y > 10 and y < 13 then
      if y == 11 then ch = "Road_Grass_N" end
      if y == 12 then ch = "Road_Grass_S" end
      if x == 12 then ch = "Road_Intern_NW" end
      if x == 12 and y == 12 then ch = "Road_Intern_SE" end
      if x == 15 then ch = "Road_Intern_NE" end
      if x == 15 and y == 12 then ch = "Road_Intern_SW" end
    end
  end

  return ch
end
