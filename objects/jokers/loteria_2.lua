SMODS.Joker({
	key = "loteria_2",
	atlas = "jokers",
	pos = {x=1,y=10},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {xmult = 1.2, gain = 0.2}},
	loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'eremel'} end
		return {vars = {card.ability.extra.gain, card.ability.extra.xmult}}
	end,
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable.ability.set == 'Loteria' then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.gain
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.xmult}}})
		end
        if context.joker_main then
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}},
                Xmult_mod = card.ability.extra.xmult
            }
        end
    end
})