class:bindHook('Entity:loadList', function(self, list)
    if list.file == '/data/zones/town-zigur/npcs.lua' then
        if not game.addons then
            game.addons = {}
        end

        if not game.addons.ziguranth_genocide then
            game.addons.ziguranth_genocide = {}
        end

        game.addons.ziguranth_genocide.base_myssil_on_die = list.res.PROTECTOR_MYSSIL.on_die
        list.res.PROTECTOR_MYSSIL.on_die = function(self)
            require('engine.ui.Dialog'):simplePopup(
                'Zigur, decimated',

                [[Protector Myssil lies slain. ]] ..
                [[You have dealt a fatal blow to the Ziguranth order, ]] ..
                [[and their numbers will surely dwindle into insignificance.]]
            )

            game.addons.ziguranth_genocide.base_player_onEnterLevel = game.player.onEnterLevel
            game.player.onEnterLevel = function(self, zone, level)
                if zone.name == 'World of Eyal' then
                    self.onEnterLevel = base_onEnterLevel

                    -- Remove all existing Ziguranth patrols
                    for _, npc in pairs(level.entities) do
                        if npc.name == 'ziguranth patrol' then
                            npc:die()
                        end
                    end

                    -- Remove Ziguranth patrols from the spawn list
                    for id, npc in pairs(level.perm_entities_list['maj_eyal_encounters_npcs']) do
                        if npc.name == 'ziguranth patrol' then
                            table.remove(level.perm_entities_list['maj_eyal_encounters_npcs'], id)
                            break
                        end
                    end
                end

                return game.addons.ziguranth_genocide.base_player_onEnterLevel(self, zone, level)
            end

            return game.addons.ziguranth_genocide.base_myssil_on_die(self)
        end
    end
end)
