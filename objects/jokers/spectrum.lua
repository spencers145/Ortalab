SMODS.Joker({
	key = "spectrum",
	atlas = "jokers",
	pos = {x = 3, y = 8},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {x_mult = 2, type = 'Flush'}},
	loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'coro'} end
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'flare'} end
        return {vars = {card.ability.extra.x_mult, localize(card.ability.extra.type, 'poker_hands')}}
    end,
    calculate = function(self, card, context) --The Spectrum Logic
        if context.joker_main then
            if (context.scoring_name ~= 'Flush Five' or 
            context.scoring_name ~= 'Flush House' or 
            context.scoring_name ~= 'Straight Flush' or 
            context.scoring_name ~= 'Flush') then
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                    Xmult_mod = card.ability.extra.x_mult
                }
            end
        end
    end
})