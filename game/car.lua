-- CAR CONSTANTS --
CAR_SPEED_DAMPENING = 0.02          -- Velocity negative interpolation per second
CAR_ANGLE_DAMPENING = 0.07          -- Angular velocity negative interpolation per second
CAR_TURN_SPEED = .08                 -- Angle in radians per second
CAR_MAX_TURN_SPEED = .1             -- Max angular velocity per second

CAR_MAX_SPEED =  300                -- Max velocity
CAR_ACCELERATION_SPEED = 210        -- Speed gained per second

CAR_MAX_REVERSE_SPEED = -80         -- Min velocity
CAR_REVERSE_ACCELERATION_SPEED = 60 -- Speed gained per second

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
  car.avelocity = math.min(CAR_MAX_TURN_SPEED, car.avelocity + (sign(car.velocity) * ainput * (CAR_TURN_SPEED * delta)))

  -- apply velocity
  car.velocity = math.min(CAR_MAX_SPEED, car.velocity + (vinput * CAR_ACCELERATION_SPEED * delta))

end


function newCar(x, y, image)
  local car = {}
  car.x = x
  car.y = y
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

  -- Apply Velocity to position
  carAngle = car.angle
  car.x = car.x + math.cos(carAngle) * delta * car.velocity
  car.y = car.y + math.sin(carAngle) * delta * car.velocity

  -- Apply damping to velocity
  if (not (love.keyboard.isDown(car.controls.up) or love.keyboard.isDown(car.controls.down))) then
    car.velocity = car.velocity  * (1 - CAR_SPEED_DAMPENING)
  end

  -- Apply damping to angular velocity
  if (not (love.keyboard.isDown(car.controls.right) or love.keyboard.isDown(car.controls.left))) then
    car.avelocity = car.avelocity  * (1 - CAR_ANGLE_DAMPENING)
  end

  -- Add Angular Velocity to angle
  car.angle = car.angle + car.avelocity
end

function drawCar(car)
  love.graphics.draw (car.image, car.x, car.y, car.angle + math.pi / 2, 1, 1, 16, 60)
end
