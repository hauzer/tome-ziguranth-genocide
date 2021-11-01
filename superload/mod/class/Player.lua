_M = loadPrevious(...)


function _M:check_if_myssil_is_dead(zone, level)
    if zone.name == 'Zigur' and not self.is_myssil_dead then
        self.is_myssil_dead = true
        for _, entity in pairs(level.entities) do
            if entity.define_as == 'PROTECTOR_MYSSIL' then
                self.is_myssil_dead = false
                break
            end
        end
    end
end


local base_onEnterLevel = _M.onEnterLevel
function _M:onEnterLevel(zone, level)
    local retval = base_onEnterLevel(self, zone, level)

    if zone.name == 'World of Eyal' and self.is_myssil_dead and not self.are_zigur_patrols_disabled then
        -- Remove all existing Ziguranth patrols
        for _, npc in pairs(level.entities) do
            if npc.name == 'ziguranth patrol' then
                npc:die()
            end
        end

        -- Remove Ziguranth patrols from the spawn list
        local encounters_npcs = level.perm_entities_list['maj_eyal_encounters_npcs']
        for id, npc in ipairs(encounters_npcs) do
            if npc.name == 'ziguranth patrol' then
                table.remove(encounters_npcs, id)
                break
            end
        end

        self.are_zigur_patrols_disabled = true
    else
        self:check_if_myssil_is_dead(zone, level)
    end

    return retval
end


local base_onLeaveLevel = _M.onLeaveLevel
function _M:onLeaveLevel(zone, level)
    local retval = base_onLeaveLevel(self, zone, level)

    self:check_if_myssil_is_dead(zone, level)

    return retval
end


return _M
