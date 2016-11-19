CAR_SPEED_DAMPENING = 0.1 --  Velocity lost per second
CAR_TURN_SPEED = 1 -- Angle in radians per second

CAR_MAX_SPEED = 100 -- Max velocity
CAR_ACCELERATION_SPEED = 100 -- Speed gained per second

CAR_MAX_REVERSE_SPEED = -100 -- Min velocity
CAR_REVERSE_ACCELERATION_SPEED = 100 -- Speed gained per second

function handleCarControls(delta)

  if love.keyboard.isDown("right") then
    car.angle = car.angle + CAR_TURN_SPEED * delta
  end

  if love.keyboard.isDown("left") then
    car.angle = car.angle - CAR_TURN_SPEED * delta
  end

  if love.keyboard.isDown("up") then
    car.velocity = math.min(CAR_MAX_SPEED, car.velocity + CAR_ACCELERATION_SPEED * delta)
  end

  if love.keyboard.isDown("down") then
    car.velocity = math.max(CAR_MAX_REVERSE_SPEED, car.velocity - CAR_REVERSE_ACCELERATION_SPEED * delta)
  end

end


function placeCar()
  car = {}
  car.x = 620 / 2
  car.y = 620 / 2
  car.velocity = 0
  car.angle = 0
end

function updateCar(delta)

  carAngle = car.angle
  car.x = car.x + math.cos(carAngle) * delta * car.velocity
  car.y = car.y + math.sin(carAngle) *  delta * car.velocity

  if car.velocity > 0 then
    car.velocity = math.max(0, car.velocity - CAR_SPEED_DAMPENING * delta)
  else
    car.velocity = math.min(0, car.velocity + CAR_SPEED_DAMPENING * delta)
  end
end
