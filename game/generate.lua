function generateMap()
  set = {}
  for i = 1, t_world.size.x do
    set[i] = {}
    for j = 1, t_world.size.y do
      set[i][j] = generateTile(i, j)
    end
  end

  return set
end

function generateTile(x, y)
  return testMap(x, y)
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
