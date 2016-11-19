require "graphics.import"
require "car"

function love.load()
  car1 = newCar(100, 100, IMAGE_CAR_BLUE)
  car2 = newCar(200, 200, IMAGE_CAR_RED)
  car2.controls = {left = "a", right = "d", up = "w", down = "s"}
end

function love.update(dt)
  updateCar(car1, dt)
  updateCar(car2, dt)
end

function love.draw()
  drawCar(car1)
  drawCar(car2)
end
