PIXELS_PER_METER = 20

--Car Constants
CAR_DRAG = 0.4257                   -- Drag constant (Air resistance)
CAR_ROLLING_FRICTION = 12.8         -- Rolling friction lost
CAR_ANGLE_DAMPENING = 0.07          -- Angular velocity negative interpolation per second
CAR_HANDLING = 0.2                  -- Angle in radians per second
CAR_MAX_TURN_SPEED = .1             -- Max angular velocity per second

CAR_ENGINE_FORCE = 4000             -- Force of engine in newtons
CAR_MASS = 1500                     -- Mass of car in kg

CAR_REVERSE_ACCELERATION_SPEED = 60 -- Speed gained per second

LOOP_SCREEN = true
PRINT_SPEED = true

-- HELPER FUNCTIONS --
function sign(x)
  if x == 0 then return x end
  if x > 0 then return 1 end
  return -1
end

-- CAR METHODS --
function handleCarControls(car, delta)
  -- get inputs
  local ainput, vinput
  ainput = (love.keyboard.isDown(car.controls.right) and 1 or 0) - (love.keyboard.isDown(car.controls.left) and 1 or 0)
  vinput = (love.keyboard.isDown(car.controls.up) and 1 or 0)    - (love.keyboard.isDown(car.controls.down) and 1 or 0)

  -- apply angular velocity
  car.turnForce = CAR_HANDLING * ainput

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
  car.image = image
  car.controls = {left = "left", right = "right", up = "up", down = "down"}
  return car
end

function updateCar(car, delta)
  -- Handle Inputs
  handleCarControls(car, delta)

  -- calculate drag
  drag = CAR_DRAG * car.velocity * math.abs(car.velocity)

  -- calculate rolling friction
  rollingFriction = CAR_ROLLING_FRICTION * car.velocity

  -- Apply forces to car
  netForce = car.traction - drag - rollingFriction
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
    love.graphics.print(string.format("%d kph", car.velocity * 3.6), car.x * PIXELS_PER_METER, car.y * PIXELS_PER_METER)
  end
end
