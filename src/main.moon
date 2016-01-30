lightsout = assert require "lightsout"
import floor from math

app = :nil


--------------------------------------------------------------------------------
love.load = ->
    with love.graphics
        quads =
            img: .newImage "images/box.png"
            [true]: .newQuad 16, 0, 16, 16, 32, 16
            [false]: .newQuad 0, 0, 16, 16, 32, 16
        font = .newFont "resources/stocky.ttf", 32
        app.game = lightsout.newgame quads, font


--------------------------------------------------------------------------------
love.draw = -> app.game\draw!


--------------------------------------------------------------------------------
love.mousereleased = (x, y, button) ->
    if button == 1
        app.game\toggle (floor (x / 16)) + 1,
                        (floor (y / 16)) + 1
