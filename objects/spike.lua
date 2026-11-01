Spike = {}
Spike.__index = Spike

Image.new("spike")

local move_damp = 0.4

function Spike.new(data)
    local self = setmetatable({}, Spike)
    self.w = TILE_SIZE
    self.h = TILE_SIZE
    Game:register(data.values.id, self)
    self.r = data.rotation
    self.ox = data.x
    self.oy = data.y
    self:update_xy()
    self.x = self._x
    self.y = self._y
    Smooth(self, {
        ox = move_damp,
        oy = move_damp,
    })
    return self
end

function Spike:update(dt)
    self:update_smooth(dt)
    self.x = self.x+(self._x-self.x)*Damp(dt, move_damp)
    self.y = self.y+(self._y-self.y)*Damp(dt, move_damp)
end

function Spike:update_xy()
    self.sin = math.sin(self.r)
    self.cos = math.cos(self.r)
    if self.sin == 1 or self.cos == -1 then
        self._x = self.ox-TILE_SIZE
    end
    if self.sin == -1 or self.cos == -1 then
        self._y = self.oy-TILE_SIZE
    end
end

function Spike:move(dx, dy)
    self.ox = self.ox+dx
    self.oy = self.oy+dy
    self:update_xy()
end

function Spike:set_pos(x, y)
    self.ox = x
    self.oy = y
    self:update_xy()
end

function Spike:draw()
    love.graphics.draw(Image.spike, self.smooth_ox, self.smooth_oy, self.r)
end

return Spike
