require "graphics.import"
require "tiles"
require "car"

function love.load()
  --Load (Generate) Background
  createTileWorld()

  --Create Players
  car1 = newCar(100, 100, IMAGE_CAR_BLUE)
  car2 = newCar(200, 200, IMAGE_CAR_RED)
  car2.controls = {left = "a", right = "d", up = "w", down = "s"}
end

function love.update(dt)
  --Update Players
  updateCar(car1, dt)
  updateCar(car2, dt)
end

function love.draw()
  --Draw Background
  drawTileWorldBackground()

  --Draw Cars
  drawCar(car1)
  drawCar(car2)

  --Draw Foreground
  drawTileWorldForeground()
end
