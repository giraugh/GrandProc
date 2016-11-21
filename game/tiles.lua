-- Tile Quads
TILES = {

  --BG TILES
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

  --DETAILS
  Tree_Stump =       {6, 3},
  Tree_Trunk =       {6, 2},
  Tree_Canopy_CD_1 = {6, 1},
  Tree_Canopy_CU_1 = {6, 0},
  Tree_Canopy_LD_1 = {5, 1},
  Tree_Canopy_RD_1 = {7, 1},
  Tree_Canopy_LU_1 = {5, 0},
  Tree_Canopy_RU_1 = {7, 0},
  Tree_Canopy_CD_2 = {3, 5},
  Tree_Canopy_CU_2 = {3, 4},
  Tree_Canopy_LD_2 = {2, 5},
  Tree_Canopy_RD_2 = {4, 5},
  Tree_Canopy_LU_2 = {2, 4},
  Tree_Canopy_RU_2 = {4, 4},
  Bush_1_Left =      {2, 2},
  Bush_1_Right =     {3, 2},
  Bush_2_Left =      {0, 5},
  Bush_2_Right =     {1, 5},
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
      t_world[i][j] = {x = i, y = j, name = "Grass"}
    end
  end

  --Details
  t_world.details = {}
  for i = 1, t_world.size.x do
    t_world.details[i] = {}
    for j = 1, t_world.size.y do
      t_world.details[i][j] = {x = i, y = j, name = "None"}
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

function setDetailWorldFromSet(set)
  for i = 1, t_world.size.x do
    for j = 1, t_world.size.y do
      t_world.details[i][j].name = set[i][j]
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
      love.graphics.draw(IMAGE_TILES, TILES[t.name], i * t_world.tile_size.x, j * t_world.tile_size.y)
    end
  end
end

function drawTileWorldForeground()
  for i = 1, t_world.size.x do
    for j = 1, t_world.size.y do
      --Get Tile from Co-Ord
      local t = t_world.details[i][j]
      if t.name ~= "None" then
        love.graphics.draw(IMAGE_TILES, TILES[t.name], i * t_world.tile_size.x, j * t_world.tile_size.y)
      end
    end
  end
end
