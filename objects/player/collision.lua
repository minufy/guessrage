local dists = {
    spike = TILE_SIZE*0.7,
}

return function (Player)
    function Player:init_collision()

    end

    function Player:update_collision(dt)
        Game:col(self, FILTERS.trigger_zone, self.col_trigger_zone)
        Game:dist(self, FILTERS.spike, self.col_spike, dists.spike)
        if self.y > Game:get_height() then
           	self:die()
        end
    end

    function Player:col_trigger_zone(other)
        Game:activate_trigger_zone(other)
    end

    function Player:col_spike(other)
        self:die()
    end

    function Player:die()
        for _ = 1, 4 do
            Game:add(Particle.new(self.x+self.w/2, self.y+self.h/2, math.random(-10, 10), math.random(-10, 10), math.random(6, 12)))
        end
        self.remove = true
        Camera:shake(3)
        -- Audio.play("die")
    end
end
