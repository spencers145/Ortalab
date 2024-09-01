SMODS.Joker({
	name = "Mint Condition",
	key = "mint_condition",
	atlas = "jokers",
	pos = {x = 0, y = 6},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {Xmult = 1.5}},
	loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'hat'} end
        return {vars = {card.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context) --Mint Condition Logic
        if context.other_joker and not context.repetition and not context.indiviual then
            local money_bonus_check = context.other_joker:calculate_dollar_bonus()
            if (money_bonus_check or context.other_joker.ability.name == 'To the Moon') and context.other_joker ~= card then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_joker:juice_up(0.5, 0.5)
                        return true
                    end
                })) 
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                    Xmult_mod = card.ability.extra.Xmult
                }
            end
        end
    end
})