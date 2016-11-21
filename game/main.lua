--ext
require "ext.TSerial"
require "ext.console"
Gamera = require "ext.gamera"

--script
require "graphics.import"
require "tiles"
require "camera"
require "generate"
require "car"

function love.load()
  --Seed Random
  math.randomseed(os.time())

  --Generate Map
  local set, dset = generateMap()
  setTileWorldFromSet(set)
  setDetailWorldFromSet(dset)

  --Create Players
  car1 = newCar(10, 10, IMAGE_CAR_BLUE)
  car2 = newCar(10, 12, IMAGE_CAR_RED)
  car2.controls = {left = "a", right = "d", up = "w", down = "s"}
end

function love.update(dt)
  --Update Players
  updateCar(car1, dt)
  updateCar(car2, dt)

  --Update Camera Tracking
  updateCamera()
end

function love.draw()
  world = function()
    --Draw Background
    drawTileWorldBackground()

    --Draw Cars
    drawCar(car1)
    drawCar(car2)

    --Draw Foreground
    drawTileWorldForeground()
  end

  --draw world
  Camera:draw(world)

  --Draw Console
  trace.draw()

end
