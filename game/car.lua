--Car Constants
CAR_SPEED_DAMPENING = 0.1 --  Velocity lost per second
CAR_ANGLE_DAMPING = 0.05
CAR_TURN_SPEED = .06 -- Angle in radians per second

CAR_MAX_SPEED = 200 -- Max velocity
CAR_ACCELERATION_SPEED = 110 -- Speed gained per second

CAR_MAX_REVERSE_SPEED = -80 -- Min velocity
CAR_REVERSE_ACCELERATION_SPEED = 60 -- Speed gained per second

function handleCarControls(car, delta)
  --get inputs
  local ainput, vinput
  ainput = (love.keyboard.isDown(car.controls.right) and 1 or 0) - (love.keyboard.isDown(car.controls.left) and 1 or 0)
  vinput = (love.keyboard.isDown(car.controls.up) and 1 or 0)    - (love.keyboard.isDown(car.controls.down) and 1 or 0)

  --apply angular velocity
  car.avelocity = car.avelocity + (ainput * (CAR_TURN_SPEED * delta))

  --apply velocity
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
  --Handle Inputs
  handleCarControls(car, delta)

  --Apply Velocity to position
  carAngle = car.angle
  car.x = car.x + math.cos(carAngle) * delta * car.velocity
  car.y = car.y + math.sin(carAngle) *  delta * car.velocity

  --apply damping to velocity
  if car.velocity > 0 then
    car.velocity = math.max(0, car.velocity - CAR_SPEED_DAMPENING * delta)
  else
    car.velocity = math.min(0, car.velocity + CAR_SPEED_DAMPENING * delta)
  end

  --Add Angular Velocity to angle
  car.angle = car.angle + car.avelocity
end

function drawCar(car)
  love.graphics.draw (car.image, car.x, car.y, car.angle + math.pi / 2, 1, 1, 16, 60)
end
