trace = {
  visible = true,
  texts = { },
  styles = { },
  styles = {
    white = {
      r = 255,
      g = 255,
      b = 255
    },
    red = {
      r = 255,
      g = 127,
      b = 127
    },
    green = {
      r = 191,
      g = 255,
      b = 127
    },
    blue = {
      r = 127,
      g = 159,
      b = 255
    },
    default = {
      r = 224,
      g = 224,
      b = 224
    }
  },
  count = 0,
  limit = 44,
  append = function(text)
    if trace.texts[trace.count] == nil then
      trace.print("")
    end
    trace.texts[trace.count] = trace.texts[trace.count] .. text
  end,
  print = function(text, style)
    if style == nil then
      style = trace.styles.default
    end
    if trace.count > trace.limit then
      table.remove(trace.texts, 1)
      table.remove(trace.styles, 1)
    else
      trace.count = trace.count + 1
    end
    trace.texts[trace.count] = text
    trace.styles[trace.count] = style
  end,
  draw = function(x, y)
    if x == nil then
      x = 16
    end
    if y == nil then
      y = 16
    end
    if trace.visible then
      for i = 1, trace.count do
        local s = trace.styles[i]
        local t = trace.texts[i]
        if s == nil then
          s = trace.styles.default
        end
        if type(t) == "table" then
          t = "<table>"
        end
        if type(t) == "boolean" then
          t = "<bool>"
        end
        t = string.rep("\n", i) .. t
        if (s.r < 160) and (s.g < 160) and (s.b < 160) then
          love.graphics.setColor(255, 255, 255)
        else
          love.graphics.setColor(0, 0, 0)
          love.graphics.print(t, x + 1, y)
          love.graphics.print(t, x - 1, y)
          love.graphics.print(t, x, y + 1)
          love.graphics.print(t, x, y - 1)
          love.graphics.setColor(s.r, s.g, s.b)
          love.graphics.print(t, x, y)
        end
      end
    end
  end
}
rawprint = print
print = function(...)
  local tp = {
    ...
  }
  for a, b in pairs(tp) do
    if type(tp[a]) == "table" then
      tp[a] = Tserial.pack(tp[a])
    end
    if type(tp[a]) == "boolean" then
      if tp[a] == true then
        tp[a] = "true"
      else
        tp[a] = "false"
      end
    end
  end
  return trace.print(table.concat(tp, " "), trace.styles.default)
end
