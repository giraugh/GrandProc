CAMERA_FOLLOW_AVERAGE = false

--Create Camera
local xscale = t_world.size.x * t_world.tile_size.x * t_world.tile_scale[1]
local yscale = t_world.size.y * t_world.tile_size.y * t_world.tile_scale[2]
Camera = Gamera.new(64, 64, xscale, yscale)

--Set Window size
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600
love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)


function updateCamera()
  if CAMERA_FOLLOW_AVERAGE then
    updateCamerAv()
  else
    updateCameraTr()
  end
end

function updateCameraTr()

  --which car?
  local car = car1

  --where is it?
  local x, y = car:getScreenPos()

  --leave room in front of car (cool visual effect)
  local offdist = 64
  local xoff = math.cos(car.angle) * offdist
  local yoff = math.sin(car.angle) * offdist

  --set Cam position
  Camera:setPosition(x + xoff, y + yoff)
end

function updateCameraAv()
  --get p1 pos
  local p1x, p1y = car1:getScreenPos()
  local p2x, p2y = car2:getScreenPos()

  --set pos to average
  Camera:setPosition((p1x+p2x) / 2, (p1y+p2y) / 2)

  --difference in x
  local dx = math.abs(p2x - p1x)
  local dy = math.abs(p2y - p1y)

  --get bigger difference
  local dd
  if dx > dy then dd = dx else dd = dy end

  --get in terms of screen size ( plus padding )
  dd = (dd + 64) / (WINDOW_WIDTH - 128)

  --clamp it
  dd = math.max(dd, 1)

  --set zoom
  Camera:setScale((1 / dd), (1 / dd))
end
