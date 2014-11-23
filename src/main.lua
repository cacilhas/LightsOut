local lightsout = assert(require "lightsout")

local app = {}


------------------------------------------------------------------------
function love.load()
  local quads = {
    img = love.graphics.newImage("images/box.png"),
    [true] = love.graphics.newQuad(16, 0, 16, 16, 32, 16),
    [false] = love.graphics.newQuad(0, 0, 16, 16, 32, 16),
  }
  local font = love.graphics.newFont("resources/stocky.ttf", 32)
  app.game = lightsout.newgame(quads, font)
end


------------------------------------------------------------------------
function love.draw()
  app.game:draw()
end


------------------------------------------------------------------------
function love.mousereleased(x, y, button)
  if button == "l" then
    local rx = math.floor(x / 16) + 1
    local ry = math.floor(y / 16) + 1
    app.game:toggle(rx, ry)
  end
end
