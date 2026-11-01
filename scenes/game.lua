Game = {}

require("scenes.base.draw")(Game)
require("scenes.base.physics")(Game)
require("scenes.base.update")(Game)

function Game:init(level)
    self.current_level = level or 1
    Level:init()
    self:reset()
    self.activate_once = ToDict({
        "falling"
    })
    self.functions = {
        falling = function ()
            Log(1)
            for _, object in ipairs(self:get_objects("start_spike")) do
                object:move(0, 100)
            end
        end
    }
end

function Game:update(dt)
    if CONSOLE and Input.refresh.pressed then
        Level:refresh()
        self:reset()
    end

    Camera:update(dt)
    self:update_objects(dt)

    if Input.restart.pressed then
        self:reset()
    end
end

function Game:draw()
    love.graphics.setColor(COLORS.bg)
    love.graphics.rectangle("fill", 0, 0, Res.w, Res.h)
    Color.reset()

    Shaders.shadow:start()
    Camera:start()

    self:draw_objects()

    Camera:stop()
    Shaders.shadow:stop()
end

---@generic T
---@param o T
---@return T
function Game:add(o)
    local group_name = tostring(o)
    if self.objects[group_name] == nil then
        self.objects[group_name] = {}
    end
    table.insert(self.objects[group_name], o)
    return o
end

function Game:reset()
    self.objects = {}
    self.id_objects = {}
    self.called = {}
    Level:load_level(tostring(self.current_level), self)
end

function Game:get_height()
	return self.objects.tiles[1].cells_y*TILE_SIZE
end

function Game:activate_trigger_zone(trigger_zone)
    local name = trigger_zone.function_name
    if self.activate_once[name] and self.called[name] then
        return
    end
    self.called[name] = true
    self.functions[name]()
end

function Game:register(id, object)
    if self.id_objects[id] == nil then
        self.id_objects[id] = {}
    end
	table.insert(self.id_objects[id], object)
end

function Game:get_objects(id)
    return self.id_objects[id]
end

return Game
