require "physics.physicsWorld"
require "controls"

function love.init()

end

function love.update(dt)
  world:update(dt)

  handleControls()
end

function love.load()
  initPhysicsWorld()
  placeCars()
end

function love.draw()
  carGraphic = love.graphics.newImage("graphics/car_blue.png")
  love.graphics.draw (carGraphic, car.body:getX(), car.body:getY(), car.body:getAngle())
end
