_M = loadPrevious(...)


local base_die = _M.die
function _M:die(src, death_note)
    local retval = base_die(self, src, death_note)

    if self.define_as == 'PROTECTOR_MYSSIL' then
        require('engine.ui.Dialog'):simplePopup(
            'Zigur, decimated',

            [[Protector Myssil lies slain. ]] ..
            [[You have dealt a fatal blow to the Ziguranth order, ]] ..
            [[and their numbers will surely dwindle into insignificance.]]
        )

        game.player.is_myssil_dead = true
        game.player.are_zigur_patrols_disabled = false
    end

    return retval
end


return _M
