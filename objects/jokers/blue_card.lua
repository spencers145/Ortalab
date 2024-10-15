SMODS.Joker({
	key = "blue_card",
	atlas = "jokers",
	pos = {x=2,y=4},
	rarity = 1,
	cost = 3,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {chips = 0, gain = 10}},
	loc_vars = function(self, info_queue, card)
        if card and Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'} end
		return {vars = {card.ability.extra.gain, card.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}},
                Xmult_mod = card.ability.extra.xmult
            }
        end
        if context.using_consumeable then
            if context.consumeable.area_check == 'consumeable' then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.gain
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = '+'..card.ability.extra.gain, colour = G.C.BLUE})
            end
        end
    end
})