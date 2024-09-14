SMODS.Joker({
	key = "reduce_reuse",
	atlas = "jokers",
	pos = {x = 6, y = 5},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {money = 2}},
	loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'} end
        return {vars = {card.ability.extra.money}}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.game_over and not context.repetition and not context.individual then
            local dollars = G.GAME.current_round.hands_left * card.ability.extra.money
            ease_dollars(dollars)
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = '$'..dollars, colour = G.C.MONEY})
        end
    end
})