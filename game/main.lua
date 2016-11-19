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
  love.graphics.draw (carGraphic, car.body:getX() + 16, car.body:getY() + 32, car.body:getAngle() + math.pi/2)
end
