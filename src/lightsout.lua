local lightsout = {
    _VERSION = "1.0",
    _DESCRIPTION = "Lua implementation of Smalltalk Lights Out",
    _AUTHOR = "ℜodrigo ℭacilhας <batalema@cacilhas.info>",
    _URL = "https://bitbucket.org/cacilhas/lightsout",
    _LICENSE = "BSD 3-Clause License",
}


local LOCell, LOGame


------------------------------------------------------------------------
math.randomseed(os.time())


------------------------------------------------------------------------
LOCell = {
    new = function(cls, game, x, y, quads)
        return setmetatable({
            game = game,
            quads = quads,
            x = x,
            y = y,
            pressed = false,
        }, cls)
    end,

    __index = {
        toggle = function(self)
            self.pressed = not self.pressed
        end,

        draw = function(self, xoffset, yoffset)
            love.graphics.draw(
                self.quads.img, self.quads[self.pressed],
                (self.x - 1) * 16 + xoffset, (self.y - 1) * 16 + yoffset
            )
        end,
    },
}


------------------------------------------------------------------------
LOGame = {
    new = function(cls, quads, font, width, height)
        local x, y
        width = width or 10
        height = height or 10
        local self = {width=width, height=height, font=font}

        for y = 1, height do
            for x = 1, width do
                self[x + ((y-1) * width)] = LOCell:new(self, x, y, quads)
            end
        end
        self = setmetatable(self, cls)
        x = math.random(width)
        y = math.random(height)
        self:get(x, y):toggle()
        self.activecount = 1

        return self
    end,

    __index = {
        toggle = function(self, x, y)
            if self.activecount == 0 then return end

            if y > 1 then self:get(x, y-1):toggle() end
            if x > 1 then self:get(x-1, y):toggle() end
            if x < self.width then self:get(x+1, y):toggle() end
            if y < self.height then self:get(x, y+1):toggle() end

            self.activecount = 0
            table.foreachi(self, function(_, cell)
                if cell.pressed then self.activecount = self.activecount + 1 end
            end)
        end,

        get = function(self, x, y)
            return self[x + ((y-1) * self.width)]
        end,

        draw = function(self, xoffset, yoffset)
            xoffset = xoffset or 0
            yoffset = yoffset or 0
            table.foreachi(self, function(_, cell)
                cell:draw(xoffset, yoffset)
            end)

            if self.activecount == 0 then
                love.graphics.setFont(self.font)
                love.graphics.setColor({0xff, 0x00, 0x00})
                love.graphics.print("DONE!", 20, 64)
                love.graphics.reset()
            end
        end,
    },
}


------------------------------------------------------------------------
lightsout.newgame = function(...) return LOGame:new(...) end


------------------------------------------------------------------------
return lightsout
