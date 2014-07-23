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

local _M = loadPrevious(...)

local _init = _M.init
function _M:init(t, no_default)
    _init(self, t, no_default)
    self.max_zigur_patrols = 5
    self.zigur_patrols = 0
end

return _M
