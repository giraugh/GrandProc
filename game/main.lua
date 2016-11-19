require "car"

function love.load()
  car1 = placeCar(100, 100, love.graphics.newImage("graphics/car_blue.png"))
  car2 = placeCar(200, 200, love.graphics.newImage("graphics/car_red.png"))
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
