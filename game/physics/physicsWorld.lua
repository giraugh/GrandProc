function initPhysicsWorld()
  love.physics.setMeter(20)
  world = love.physics.newWorld(0, 0, true)
end

CAR_WEIGHT = 1

function placeCars()
  car = {}
  car.body = love.physics.newBody(world, 32 / 2, 64 / 2, "dynamic")
  car.shape = love.physics.newRectangleShape(32, 64)
  car.fixture = love.physics.newFixture(car.body, car.shape, CAR_WEIGHT)
  car.body:setAngularDamping(0.1)
end
