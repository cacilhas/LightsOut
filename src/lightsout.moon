_VERSION = "1.0"
_DESCRIPTION = "MoonScript implementation of Smalltalk Lights Out"
_AUTHOR = "ℜodrigo ℭacilhας <batalema@cacilhas.info>"
_URL = "https://bitbucket.org/cacilhas/lightsout"
_LICENSE = "BSD 3-Clause License"


import random, randomseed from math
randomseed os.time!

local *


--------------------------------------------------------------------------------
class LOCell
    pressed: false

    new: (game, x, y, quads) =>
        @game = game
        @quads = quads
        @x, @y = x, y

    toggle: => @pressed = not @pressed

    draw: (xoffset, yoffset) =>
        love.graphics.draw @quads.img, @quads[@pressed],
                           (@x - 1) * 16 + xoffset,
                           (@y - 1) * 16 + yoffset


--------------------------------------------------------------------------------
class LOGame
    activecount: 0

    new: (quads, font, width=10, height=10) =>
        @quads = quads
        @font = font
        @width, @height = width, height
        @board = [LOCell @, x, y, quads for y = 1, height for x = 1, width]
        (@\get (random width), (random height))\toggle!
        @activecount = 1

    toggle: (x, y) =>
        unless @activecount == 0
            @\get(x, y-1)\toggle! if y > 1
            @\get(x-1, y)\toggle! if x > 1
            @\get(x+1, y)\toggle! if x < @width
            @\get(x, y+1)\toggle! if y < @height
            @\recalculate!

    recalculate: =>
        @activecount = 0
        for cell in *@board
            @activecount += 1 if cell.pressed

    get: (x, y) => @board[x + (y - 1) * @width]

    draw: (xoffset=0, yoffset=0) =>
        cell\draw xoffset, yoffset for cell in *@board
        
        if @activecount == 0
            with love.graphics
                .setFont @font
                .setColor 0xff, 0x00, 0x00
                .print "DONE!", 20, 64
                .reset!


--------------------------------------------------------------------------------
{
    :_VERSION
    :_DESCRIPTION
    :_AUTHOR
    :_URL
    :_LICENSE
    newgame: LOGame
}
