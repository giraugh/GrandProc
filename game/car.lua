CAR_SPEED_DAMPENING = 0.1
CAR_TURN_SPEED = .06

CAR_MAX_SPEED = 100
CAR_ACCELERATION_SPEED = 100

CAR_MAX_REVERSE_SPEED = -100
CAR_REVERSE_ACCELERATION_SPEED = 100

function handleCarControls(delta)

  if love.keyboard.isDown("right") then
    car.avelocity = car.avelocity + CAR_TURN_SPEED * delta
  end

  if love.keyboard.isDown("left") then
    car.avelocity = car.avelocity - CAR_TURN_SPEED * delta
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
  car.avelocity = 0
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

  car.angle = car.angle + car.avelocity
end
