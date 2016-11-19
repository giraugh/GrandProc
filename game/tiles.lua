-- Tile Quads
TILES = {
  Grass = love.graphics.newQuad(0, 0, 32, 32, 32, 32),
}

function createTileWorld()
  t_world = {}
  t_world.size = {x = 10, y = 10}
  t_world.tile_size = {32, 32}
  for i = 1, t_world.size.x do
    for j = 1, t_world.size.y do
      t_world[i] = {}
      t_world[i][j] = {x = i, y = j, name = "Grass", back = true}
    end
  end
end

function drawTileWorldBackground()
  for i = 1, t_world.size.x do
    for j = 1, t_world.size.y do
      --Get Tile from Co-Ord
      local t = t_world[i][j]

      --print(t.name)

      --[[
      --Is it in the background?
      if t.back then
        love.graphics.draw(IMAGE_TILES, TILES[t.name], i * t_world.size[1], j * t_world.size[2])
      end
      --]]
    end
  end
end

function drawTileWorldForeground()
  for i = 1, t_world.size.x do
    for j = 1, t_world.size.y do

    end
  end
end
