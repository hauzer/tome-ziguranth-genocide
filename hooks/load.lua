-- Ziguranth Genocide - ToME addon
-- Copyright (C) 2014 Никола "hauzer" Вукосављевић
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

class:bindHook('Entity:loadList', function(self, data)
    if data.file == '/data/zones/town-zigur/npcs.lua' then
        local on_die = data.res.PROTECTOR_MYSSIL.on_die
        data.res.PROTECTOR_MYSSIL.on_die = function(self)
            require('engine.ui.Dialog'):simplePopup('Zigur, gone', [[Protector Myssil lies slain. You have dealt a heavy blow to the Ziguranth order, ]]
                                                                .. [[and their ranks will surely fall into confusion.]])
            game.state.max_zigur_patrols = 1
            
            on_die(self)
        end
    end
end)

class:bindHook('Actor:move', function(self, data)
    if self.name == 'ziguranth patrol' then
        if game.state.zigur_patrols > game.state.max_zigur_patrols then
            self:die(nil, nil)
        end
    end
end)
