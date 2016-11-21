PIXELS_PER_METER = 20

--Car Constants
CAR_DRAG = 4.257                   -- Drag constant (Air resistance)
CAR_ROLLING_FRICTION = 12.8         -- Rolling friction lost
CAR_ANGLE_DAMPENING = 0.07          -- Angular velocity negative interpolation per second
CAR_TURN_FRICTION = 200

CAR_HANDLING = 2                  -- Max turn size
CAR_TURN_SPEED = 2                 -- Turn size per second
CAR_STABELIZE_SPEED = 10

CAR_ENGINE_FORCE = 20000             -- Force of engine in newtons
CAR_MASS = 1500                     -- Mass of car in kg

CAR_REVERSE_ACCELERATION_SPEED = 60 -- Speed gained per second

LOOP_SCREEN = false
PRINT_SPEED = true

-- HELPER FUNCTIONS --
function sign(x)
  if x == 0 then return x end
  if x > 0 then return 1 end
  return -1
end

function clamp(x, min, max)
  return math.max(min, math.min(x, max))
end

-- CAR METHODS --
function handleCarControls(car, delta)
  -- get inputs
  local ainput, vinput
  ainput = (love.keyboard.isDown(car.controls.right) and 1 or 0) - (love.keyboard.isDown(car.controls.left) and 1 or 0)
  vinput = (love.keyboard.isDown(car.controls.up) and 1 or 0)    - (love.keyboard.isDown(car.controls.down) and 1 or 0)

  -- apply angular velocity
  car.turnForce = clamp(car.turnForce + ainput * CAR_TURN_SPEED * delta, -CAR_HANDLING, CAR_HANDLING)

  car.turnForce = car.turnForce - CAR_STABELIZE_SPEED * car.turnForce * delta

  -- Apply traction
  car.traction = CAR_ENGINE_FORCE * vinput
end


function newCar(x, y, image)
  local car = {}
  car.x = x
  car.y = y
  car.traction = 0
  car.velocity = 0
  car.angle = 0
  car.avelocity = 0
  car.turnForce = 0
  car.image = image
  car.controls = {left = "left", right = "right", up = "up", down = "down"}

  function car:getScreenPos()
    return self.x * PIXELS_PER_METER, self.y * PIXELS_PER_METER
  end

  function car:getTileAtFeet()
    return (tileAtPosition(self:getScreenPos()) or {name = "None"}).name
  end

  return car
end

function updateCar(car, delta)
  -- Handle Inputs
  handleCarControls(car, delta)

  -- calculate drag
  drag = CAR_DRAG * car.velocity * math.abs(car.velocity)

  terrainFriction = 1
  if car:getTileAtFeet() == "Grass" then
    terrainFriction = 2
  end

  -- calculate rolling friction
  rollingFriction = CAR_ROLLING_FRICTION * terrainFriction * car.velocity

  -- calculate turning friction
  turningFriction = math.sin(math.abs(car.turnForce)) * terrainFriction * CAR_TURN_FRICTION * car.velocity * math.abs(car.velocity)

  -- Apply forces to car
  netForce = car.traction - drag - rollingFriction - turningFriction
  acceleration = netForce / CAR_MASS
  car.velocity = car.velocity + delta * acceleration

  -- Apply turning force
  car.angle = car.angle + car.turnForce * delta * car.velocity

  -- Apply Velocity to position
  carAngle = car.angle
  car.x = car.x + math.cos(carAngle) * delta * car.velocity
  car.y = car.y + math.sin(carAngle) * delta * car.velocity

  -- Loop the car back onto the screen if need be
  if LOOP_SCREEN then
    if car.x < -5 then
      car.x = 40
    end
    if car.x > 40 then
      car.x = -5
    end
    if car.y < -5 then
      car.y = 40
    end
    if car.y > 40 then
      car.y = -5
    end
  end

end

function drawCar(car)
  love.graphics.draw (car.image, car.x * PIXELS_PER_METER, car.y * PIXELS_PER_METER, car.angle + math.pi / 2, 1, 1, 16, 60)
  if PRINT_SPEED then
    love.graphics.print(string.format("%d kph", car.velocity * 3.6), car:getScreenPos())
    love.graphics.print(car:getTileAtFeet(), car.x * PIXELS_PER_METER, car.y * PIXELS_PER_METER + 32)
  end
end
