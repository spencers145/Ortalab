SMODS.Atlas({
    key = 'patches',
    path = 'patches.png',
    px = '34',
    py = '34'
})

SMODS.Tag({
    key = 'common',
    atlas = 'patches',
    pos = {x = 2, y = 2},
    discovered = false,
    config = {type = 'store_joker_create', dollars = 3},
    loc_vars = function(self, info_queue, card)
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = '5381'} end
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
        return {vars = {self.config.dollars, (G.GAME.blinds_defeated or 0)*self.config.dollars}}
    end,
    apply = function(tag, context)
        local card = create_card('Joker', context.area, nil, 0, nil, nil, nil, 'uta')
        if not card.edition then
            card:set_edition(poll_edition('ortalab_common_patch', nil, false, true))
        end
        create_shop_card_ui(card, 'Joker', context.area)
        card.states.visible = false
        tag:yep('+', G.C.GREEN,function() 
            card:start_materialize()
            card.ability.couponed = true
            card:set_cost()
            return true
        end)
        tag.triggered = true
        return card
    end
})

-- SMODS.Tag({
--     key = 'overexposed',
--     atlas = 'patches',
--     pos = {x = 3, y = 2},
--     discovered = false,
--     config = {type = 'store_joker_modify', edition = 'e_ortalab_overexposed'},
--     loc_vars = function(self, info_queue, card)
--         if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
--     end,
--     apply = function(tag, context)
--         if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
--             context.card.temp_edition = true
--             tag:yep('+', G.C.DARK_EDITION,function() 
--                 context.card:set_edition(tag.config.edition, true)
--                 context.card.ability.couponed = true
--                 context.card:set_cost()
--                 context.card.temp_edition = nil
--                 return true
--             end)
--             tag.triggered = true
--         end
--     end
-- })

SMODS.Tag({
    key = 'anaglyphic',
    atlas = 'patches',
    pos = {x = 4, y = 2},
    discovered = false,
    config = {type = 'store_joker_modify', edition = 'e_ortalab_anaglyphic'},
    loc_vars = function(self, info_queue, card)
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
    end,
    apply = function(tag, context)
        if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
            context.card.temp_edition = true
            tag:yep('+', G.C.DARK_EDITION,function() 
                context.card:set_edition(tag.config.edition, true)
                context.card.ability.couponed = true
                context.card:set_cost()
                context.card.temp_edition = nil
                return true
            end)
            tag.triggered = true
        end
    end
})

SMODS.Tag({
    key = 'fluorescent',
    atlas = 'patches',
    pos = {x = 0, y = 3},
    discovered = false,
    config = {type = 'store_joker_modify', edition = 'e_ortalab_fluorescent'},
    loc_vars = function(self, info_queue, card)
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
    end,
    apply = function(tag, context)
        if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
            context.card.temp_edition = true
            tag:yep('+', G.C.DARK_EDITION,function() 
                context.card:set_edition(tag.config.edition, true)
                context.card.ability.couponed = true
                context.card:set_cost()
                context.card.temp_edition = nil
                return true
            end)
            tag.triggered = true
        end
    end
})

SMODS.Tag({
    key = 'greyscale',
    atlas = 'patches',
    pos = {x = 1, y = 3},
    discovered = false,
    config = {typ = 'store_joker_modify', edition = 'e_ortalab_greyscale'},
    loc_vars = function(self, info_queue, card)
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'coro'} end
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
    end,
    apply = function(tag, context)
        if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
            context.card.temp_edition = true
            tag:yep('+', G.C.DARK_EDITION,function() 
                context.card:set_edition(tag.config.edition, true)
                context.card.ability.couponed = true
                context.card:set_cost()
                context.card.temp_edition = nil
                return true
            end)
            tag.triggered = true
        end
    end
})

SMODS.Tag({
    key = 'rewind',
    atlas = 'patches',
    pos = {x = 0, y = 0},
    discovered = false,
    in_pool = function(self)
        if G.GAME.last_selected_tag and G.GAME.last_selected_tag.key ~= 'tag_ortalab_rewind' then
            return true
        end
        return false
    end,
    config = {type = 'immediate'},
    loc_vars = function(self, info_queue, card)
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'flare'} end
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
        return {vars = {G.GAME.last_selected_tag and localize({type = 'name_text', set = 'Tag', key = G.GAME.last_selected_tag.key}) or localize('ortalab_no_tag')}}
    end,
    apply = function(tag, context)
        if G.GAME.last_selected_tag then
            tag:yep('+', G.C.GREEN,function() 
                return true
            end)
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    add_tag(Tag(G.GAME.last_selected_tag.key))
                    return true
            end}))
            tag.triggered = true
            return true
        end
    end
})

-- SMODS.Tag({
--     key = 'recycle',
--     atlas = 'patches',
--     pos = {x = 1, y = 0},
--     discovered = false,
-- })

-- SMODS.Tag({
--     key = 'dfour',
--     atlas = 'patches',
--     pos = {x = 2, y = 0},
--     discovered = false,
-- })

-- SMODS.Tag({
--     key = 'bargain',
--     atlas = 'patches',
--     pos = {x = 3, y = 0},
--     discovered = false,
-- })

SMODS.Tag({
    key = 'minion',
    atlas = 'patches',
    pos = {x = 4, y = 0},
    discovered = false,
    config = {type = 'round_start_bonus', modifier = 0.5},
    loc_vars = function(self, info_queue, card)
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'} end
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
    end,
    apply = function(tag, context)
        if G.GAME.blind:get_type() == 'Boss' then return end
        tag:yep('+', G.C.GREEN ,function() 
            return true
        end)
        G.E_MANAGER:add_event(Event({
            delay = 0.2,
            trigger = 'after',
            func = function()
        G.GAME.blind.chips = G.GAME.blind.chips * tag.config.modifier
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        return true
            end}))
        tag.triggered = true
    end
})

SMODS.Tag({
    key = 'slipup',
    atlas = 'patches',
    pos = {x = 0, y = 1},
    discovered = false,
    config = {type = 'round_start_bonus', discards = 2},
    loc_vars = function(self, info_queue, card)
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'} end
        return {vars = {self.config.discards}}
    end,
    apply = function(tag, context)
        tag:yep('+', G.C.RED ,function() 
            return true
        end)
        ease_discard(tag.config.discards)
        tag.triggered = true
    end
})

-- SMODS.Tag({
--     key = 'extraordinary',
--     atlas = 'patches',
--     pos = {x = 1, y = 1},
--     discovered = false,
-- })

-- SMODS.Tag({
--     key = 'charm',
--     atlas = 'patches',
--     pos = {x = 2, y = 1},
--     discovered = false,
-- })

-- SMODS.Tag({
--     key = 'buffoon',
--     atlas = 'patches',
--     pos = {x = 3, y = 1},
--     discovered = false,
-- })

-- SMODS.Tag({
--     key = 'jackpot',
--     atlas = 'patches',
--     pos = {x = 4, y = 1},
--     discovered = false,
-- })

SMODS.Tag({
    key = 'soul',
    atlas = 'patches',
    pos = {x = 0, y = 2},
    soul_pos = {x = 1, y = 2},
    discovered = false,
    min_ante = 3,
    config = {type = 'store_joker_create'},
    in_pool = function(self)
        local chance = pseudoseed('ortalab_soul_patch')
        if chance < 0.25 then
            return true
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
        return {vars = {self.config.cost}}
    end,
    apply = function(tag, context)
        local card = create_card('Joker', context.area, true, 1, nil, nil, nil, 'uta')
        create_shop_card_ui(card, 'Joker', context.area)
        card.states.visible = false
        tag:yep('+', G.C.GREEN,function() 
            card:start_materialize()
            card.ability.couponed = true
            card:set_cost()
            return true
        end)
        tag.triggered = true
        return card
    end
})

SMODS.Tag({
    key = 'slayer',
    atlas = 'patches',
    pos = {x = 0, y = 4},
    discovered = false,
    min_ante = 2,
    config = {type = 'immediate', dollars = 3},
    loc_vars = function(self, info_queue, card)
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
        return {vars = {self.config.dollars, (G.GAME.blinds_defeated or 0)*self.config.dollars}}
    end,
    apply = function(tag, context)
        tag:yep('+', G.C.MONEY,function() 
            G.CONTROLLER.locks[tag.ID] = nil
            return true
        end)
        ease_dollars((G.GAME.blinds_defeated or 0)*tag.config.dollars)
        tag.triggered = true
        return true
    end
})

SMODS.Tag({
    key = 'dandy',
    atlas = 'patches',
    pos = {x = 3, y = 3},
    discovered = false,
    min_ante = 2,
    config = {type = 'immediate', dollars = 1},
    loc_vars = function(self, info_queue, card)
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
        return {vars = {self.config.dollars, (G.GAME.unused_hands or 0)*self.config.dollars}}
    end,
    apply = function(tag, context)
        tag:yep('+', G.C.MONEY,function() 
            return true
        end)
        ease_dollars((G.GAME.unused_hands or 0)*tag.config.dollars)
        tag.triggered = true
        return true
    end
})

local skip_blind = G.FUNCS.skip_blind
G.FUNCS.skip_blind = function(e)
    skip_blind(e)
    local _tag = e.UIBox:get_UIE_by_ID('tag_container').config.ref_table
    if _tag.key == 'tag_ortalab_rewind' then return end
    G.GAME.last_selected_tag = _tag or G.GAME.last_selected_tag
end