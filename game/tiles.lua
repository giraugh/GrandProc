-- Tile Quads
TILES = {
  Grass =          {0, 0},
  Road_Grass_E =   {1, 0},
  Road_Grass_W =   {2, 0},
  Road_Grass_S =   {0, 1},
  Road_Grass_N =   {4, 2},
  Road_Middle_H =  {1, 4},
  Road_Middle_V =  {0, 4},
  Road_Middle_NE = {1, 2},
  Road_Middle_NW = {0, 2},
  Road_Middle_SE = {1, 3},
  Road_Middle_SW = {0, 3},
  Road_Intern_NE = {5, 2},
  Road_Intern_NW = {7, 2},
  Road_Intern_SE = {2, 1},
  Road_Intern_SW = {1, 1},
  Road_Extern_NE = {4, 0},
  Road_Extern_NW = {3, 0},
  Road_Extern_SE = {4, 1},
  Road_Extern_SW = {3, 1},
}

-- Make Quad Defs above into actual quads
for i, tile in pairs(TILES) do
  TILES[i] = love.graphics.newQuad(tile[1] * 32, tile[2] * 32, 32, 32, IMAGE_TILES:getWidth(), IMAGE_TILES:getHeight())
end

function createTileWorld()
  t_world = {}
  t_world.size = {x = 20, y = 20}
  t_world.tile_size = {x = 32, y = 32}
  for i = 1, t_world.size.x do
    t_world[i] = {}
    for j = 1, t_world.size.y do
      t_world[i][j] = {x = i, y = j, name = "Grass", back = true}
    end
  end
end

function setTileWorldFromSet(set)
  for i = 1, t_world.size.x do
    for j = 1, t_world.size.y do
      t_world[i][j].name = set[i][j]
    end
  end
end

function tileAtPosition(x, y)
  x = math.floor(x / 32)
  y = math.floor(y / 32)
  if (x <= 0 or x >= t_world.size.x or y <= 0 or y >= t_world.size.y) then
    return nil
  end
  return t_world[x][y]
end

function drawTileWorldBackground()
  for i = 1, t_world.size.x do
    for j = 1, t_world.size.y do
      --Get Tile from Co-Ord
      local t = t_world[i][j]

      --Is it in the background?
      if t.back then
        love.graphics.draw(IMAGE_TILES, TILES[t.name], i * t_world.tile_size.x, j * t_world.tile_size.y)
      end
    end
  end
end

function drawTileWorldForeground()
  for i = 1, t_world.size.x do
    for j = 1, t_world.size.y do
      --Get Tile from Co-Ord
      local t = t_world[i][j]

      --Is it in the foreground?
      if not t.back then
        love.graphics.draw(IMAGE_TILES, TILES[t.name], i * t_world.tile_size.x, j * t_world.tile_size.y)
      end
    end
  end
end
