require "car"

function love.init()

end

function love.update(dt)
  handleCarControls(dt)
  updateCar(dt)
end

function love.load()
  placeCar()
end

function love.draw()
  carGraphic = love.graphics.newImage("graphics/car_blue.png")
  love.graphics.draw (carGraphic, car.x, car.y, car.angle + math.pi / 2, 1, 1, 16, 60)
end
