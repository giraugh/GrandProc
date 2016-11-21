TEMPLATES = {
  MICRO_SIZE = {5, 5},
  MACRO_SIZE = {7, 7},
  MICRO = {},
  MACRO = {},
}

--DETAIL CHANCES
BUSH_CHANCE = .1
TREE_CHANCE = .05

require "templates.micro"
require "templates.macro"

function generateMap()
  --TEMPLATES
  local chosen = TEMPLATES.MACRO[math.random(1, #TEMPLATES.MACRO)]
  local cset = decipherMacro(chosen)
  local set = rasterizeCset(cset)

  --DETAILS
  local dset = generateDetailEmpty()

  --Padding
  for i = 0, #set+1 do
    for j = 0, #set+1 do
      if i == 0 or i>#set then
        set[i] = {}
      end

      if j == 0 or j>#dset then
        set[i][j] = "None"
      end
    end
  end

  --Padding
  for i = 0, #dset+1 do
    for j = 0, #dset+1 do
      if i == 0 or i>#dset then
        dset[i] = {}
      end

      if j == 0 or j>#dset then
        dset[i][j] = "None"
      end
    end
  end

  --find grass and put stuff on it
  for i = 1, #set do
    for j = 1, #(set[i]) do

      --Bush 1
      if math.random() < BUSH_CHANCE/2 then
        if set[i][j] == "Grass" and set[i+1][j] == "Grass" then
          if dset[i][j] == "None" and dset[i+1][j] == "None" then
            dset[i][j] =   "Bush_1_Left"
            dset[i+1][j] = "Bush_1_Right"
          end
        end

      --Bush 2
      elseif math.random() < BUSH_CHANCE/2 then
        if set[i][j] == "Grass" and set[i+1][j] == "Grass" then
          if dset[i][j] == "None" and dset[i+1][j] == "None" then
            dset[i][j] =   "Bush_2_Left"
            dset[i+1][j] = "Bush_2_Right"
          end
        end

      elseif math.random() < TREE_CHANCE then
        if set[i][j] == "Grass"
        and set[i][j-1] == "Grass" then
          if dset[i][j] == "None"
          and dset[i][j-1] == "None"
          and dset[i-1][j] == "None"
          and dset[i+1][j] == "None"
          and dset[i-1][j-1] == "None"
          and dset[i+1][j-1] == "None"
          and dset[i-1][j-2] == "None"
          and dset[i+1][j-2] == "None" then
            --decide on type
            local type
            if math.random() < .5 then type = 1 else type = 2 end

            --decide on high
            local isHigh
            if math.random() < .5 then isHigh = 0 else isHigh = 1 end

            dset[i][j] = "Tree_Stump"
            if isHigh == 1 then dset[i][j-1] = "Tree_Trunk" end
            dset[i][j-(1+isHigh)] = "Tree_Canopy_CD_"..type
            dset[i-1][j-(1+isHigh)] = "Tree_Canopy_LD_"..type
            dset[i+1][j-(1+isHigh)] = "Tree_Canopy_RD_"..type
            dset[i][j-(2+isHigh)] = "Tree_Canopy_CU_"..type
            dset[i-1][j-(2+isHigh)] = "Tree_Canopy_LU_"..type
            dset[i+1][j-(2+isHigh)] = "Tree_Canopy_RU_"..type
          end
        end
      end


    end
  end

  --RETURNS
  return set, dset
end

function rasterizeCset(cset)
  local rasterizeCSetChar = function(char)
    if char == "" or char == "g" then return "Grass" end
    if char == "#" then return "Road_Grass_N" end
    if char == "|" then return "Road_Middle_H" end
    if char == "-" then return "Road_Middle_V" end
    if char == "r" then return "Road_Middle_NW" end
    if char == "L" then return "Road_Middle_NE" end
    if char == "/" then return "Road_Middle_SE" end
    if char == "\\" then return "Road_Middle_SW" end
  end

  --translate
  for i = 1, #cset do
    for j = 1, #(cset[i]) do
      cset[i][j] = rasterizeCSetChar(cset[i][j])
    end
  end

  --Padding
  for i = 0, #cset+1 do
    for j = 0, #cset+1 do
      if i == 0 or i>#cset then
        cset[i] = {}
      end

      if j == 0 or j>#cset then
        cset[i][j] = "Road_Middle_H"
      end
    end
  end

  --Orient
  for i = 1, #cset do
    for j = 1, #(cset[i]) do
      local c = cset[i][j]
      local t = c

      --Grass Above?
      if cset[i][j-1] == "Grass" and c == "Road_Grass_N" then
        t = "Road_Grass_S"
      end

      --Grass Left?
      if cset[i-1][j] == "Grass" and c == "Road_Grass_N" then
        t = "Road_Grass_E"
      end

      --Grass Right?
      if cset[i+1][j] == "Grass" and c == "Road_Grass_N" then
        t = "Road_Grass_W"
      end

      --Grass Diag-Right-Down?
      if cset[i+1][j+1] == "Grass"
         and cset[i][j+1] ~= "Grass"
         and cset[i+1][j] ~= "Grass"
         and c == "Road_Grass_N" then
        t = "Road_Intern_NW"
      end

      --Grass Diag-Left-Down?
      if cset[i-1][j+1] == "Grass"
         and cset[i][j+1] ~= "Grass"
         and cset[i-1][j] ~= "Grass"
         and c ~= "Grass" then
        t = "Road_Intern_NE"
      end

      --Grass Diag-Right-Up?
      if cset[i+1][j-1] == "Grass"
         and cset[i][j-1] ~= "Grass"
         and cset[i+1][j] ~= "Grass"
         and c ~= "Grass" then
        t = "Road_Intern_SE"
      end

      --Grass Diag-Left-Up?
      if cset[i-1][j-1] == "Grass"
         and cset[i][j-1] ~= "Grass"
         and cset[i-1][j] ~= "Grass"
         and c ~= "Grass" then
        t = "Road_Intern_SW"
      end

      --Grass (Extern) Diag-Left-Up?
      if cset[i-1][j-1] == "Grass"
         and c ~= "Grass"
         and t == "Road_Grass_W" then
        t = "Road_Extern_NE"
      end

      --Grass (Extern) Diag-Right-Up?
      if cset[i+1][j-1] == "Grass"
         and c ~= "Grass"
         and t == "Road_Grass_E" then
        t = "Road_Extern_NW"
      end

      --Grass (Extern) Diag-Left-Down?
      if cset[i-1][j+1] == "Grass"
         and c ~= "Grass"
         and t == "Road_Grass_W" then
        t = "Road_Extern_SE"
      end

      --Grass (Extern) Diag-Right-Down?
      if cset[i+1][j+1] == "Grass"
         and c ~= "Grass"
         and t == "Road_Grass_E" then
        t = "Road_Extern_SW"
      end

      --set
      cset[i][j] = t
    end
  end

  return cset
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

  -- DEBUG DISPLAY --
  str = ""
  for i = 1, #set do
    for j = 1, #set[i] do
      str = str .. set[i][j]
    end
    str = str .. "\n"
  end
  rawprint(str)

  return set
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

function generateDetailEmpty()
  local set = {}
  for i = 1, t_world.size.x do
    set[i] = {}
    for j = 1, t_world.size.y do
      set[i][j] = "None"
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
