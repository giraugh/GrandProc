WORLD_SPRITES = {
  Grass = "graphics/tile_grass.png"
}

function createBGWorld()
  bg_world = {}
  bg_world.size = {x = 10, y = 10}
  for i = 1, bg_world.size.x do
    for j = 1, bg_world.size.y do
      bg_world[i] = {}
      bg_world[i][j] = {x = i, y = j, name = "Grass"}
    end
  end
end

function drawBGWorld() {
  for i = 1, bg_world.size.x do
    for j = 1, bg_world.size.y do
      
    end
  end
}
