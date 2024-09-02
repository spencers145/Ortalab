SMODS.Joker({
	key = "woo_all_1",
	atlas = "jokers",
	config = {},
	pos = {x = 8, y = 7},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'crimson'} end
    end,
})

local CardAdd_to_deck_ref = Card.add_to_deck
	function Card.add_to_deck(self, from_debuff)
		-- This whole joker needs redone logic, too lazy to bother
		if not self.added_to_deck then
			if self.config.center_key == 'j_ortalab_woo_all_1' then
				self.added_to_deck = true
				for k, v in pairs(G.GAME.probabilities) do 
					if G.GAME.probabilities[k] == 1 and not next(SMODS.find_card('j_oops')) then
						G.GAME.probabilities[k] = 0
					else
						G.GAME.probabilities[k] = v/2
					end
				end
			end
		end
		CardAdd_to_deck_ref(self, from_debuff)
		if self.added_to_deck then
			if self.ability.name == 'Oops! All 6s' then
				for k, v in pairs(G.GAME.probabilities) do 
					if G.GAME.probabilities[k] == 0 then
						G.GAME.probabilities[k] = 1
					end
				end
			end
		end
	end

	local CardRemove_from_deck_ref = Card.remove_from_deck
	function Card.remove_from_deck(self, from_debuff)
		if self.added_to_deck then 
			if self.config.center_key == 'j_ortalab_woo_all_1' then
				self.added_to_deck = false
				for k, v in pairs(G.GAME.probabilities) do 
					if G.GAME.probabilities[k] == 0 then
						G.GAME.probabilities[k] = 1
						if next(SMODS.find_card('j_oops')) then
							for kk, vv in pairs(G.jokers.cards) do
								if vv.ability.name == 'Oops! All 6s' then
									G.GAME.probabilities[k] = v*2
								end
							end
						end
					else
						G.GAME.probabilities[k] = v*2
					end
				end
			end
		end
		CardRemove_from_deck_ref(self, from_debuff)
	end