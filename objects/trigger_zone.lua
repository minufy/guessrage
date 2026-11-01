TriggerZone = {}
TriggerZone.__index = TriggerZone

function TriggerZone.new(data)
    local self = setmetatable({}, TriggerZone)
    self.x = data.x
    self.y = data.y
    self.w = data.width
    self.h = data.height

    self.function_name = data.values.function_name

    return self
end

function TriggerZone:draw()
    if CONSOLE then
        love.graphics.setColor(0, 1, 1, 0.2)
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
        Color.reset()
    end
end

return TriggerZone
