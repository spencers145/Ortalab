SMODS.Joker({
	key = "loteria_3",
	atlas = "jokers",
	pos = {x=2,y=10},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {chance = 4}},
	loc_vars = function(self, info_queue, card)
        if card and Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'eremel'} end
		return {vars = {G.GAME.probabilities.normal, card.ability.extra.chance}}
	end
})