windowSize = {
  800,
  800
}
game_setup = function()
  love.graphics.setDefaultFilter("nearest")
  love.graphics.setFont(love.graphics.newFont(10))
  return love.keyboard.setKeyRepeat(false)
end
love.conf = function(t)
  t.identity = "Lime"
  t.window.title = "Lime"
  t.window.msaa = 0
  t.window.width = windowSize[1]
  t.window.height = windowSize[2]
  return t
end
