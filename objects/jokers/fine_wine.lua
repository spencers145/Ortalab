SMODS.Joker({
	key = "fine_wine",
	atlas = "jokers",
	pos = {x = 2, y = 5},
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	config = {extra = {discards = 2, odds = 5}},
	loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'flare'} end
        return {vars = {card.ability.extra.discards, ''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds}}
    end,
    calculate = function(self, card, context) --Fine Wine Logic
        if not context.blueprint then
            if context.setting_blind and not card.getting_sliced then
                ease_discard(card.ability.extra.discards)
                card.ability.extra.discards = card.ability.extra.discards + 1
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
            end
            if context.end_of_round and not context.individual and not context.repetition then
                if pseudorandom('fine_wine') < G.GAME.probabilities.normal/card.ability.extra.odds then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                func = function()
                                        G.jokers:remove_card(card)
                                        card:remove()
                                        card = nil
                                    return true; end})) 
                            return true
                        end
                    }))
                    return {
                        message = localize('k_drank_ex')
                    }
                else
                    return {
                        message = localize('k_safe_ex')
                    }
                end
            end
        end
    end
})
