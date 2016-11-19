
CAR_TURN_SPEED = 5000
CAR_SPEED = 1000
CAR_REVERSE_SPEED = 500

function handleControls()

  if love.keyboard.isDown("right") then
    print(car.body:getX())
    car.body:applyTorque(CAR_TURN_SPEED)
  elseif love.keyboard.isDown("left") then
    car.body:applyTorque(-CAR_TURN_SPEED)
  elseif love.keyboard.isDown("up") then
    carAngle = car.body:getAngle()
    car.body:applyForce(math.cos(carAngle) * CAR_SPEED, math.sin(carAngle) * CAR_SPEED)
  elseif love.keyboard.isDown("down") then
    carAngle = car.body:getAngle()
    car.body:applyForce(-math.cos(carAngle) * CAR_REVERSE_SPEED, -math.sin(carAngle) * CAR_REVERSE_SPEED)
  end

end
