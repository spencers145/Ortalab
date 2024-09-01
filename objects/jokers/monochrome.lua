SMODS.Shader({key = 'monochrome', path = 'monochrome.fs'})

SMODS.Joker({
	key = "monochrome",
	atlas = "jokers",
	pos = {x = 0, y = 7},
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {suit = 'Spades'}},
	loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'crimson'} end
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'eremel', title = 'Shader'} end
        return {vars = {localize((card.ability.extra.suit), 'suits_plural'), colours = {G.C.SUITS[card.ability.extra.suit]}}}
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced then
            card.ability.extra.suit = pseudorandom_element(SMODS.Suits, pseudoseed('ortalab_monochrome')).key
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize((card.ability.extra.suit), 'suits_plural'), colour = G.C.SUITS[card.ability.extra.suit]})
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        if card.area == G.your_collection then return end
        card.ability.extra.suit = pseudorandom_element(SMODS.Suits, pseudoseed('ortalab_monochrome')).key
    end
})

local CardIs_Suit_ref = Card.is_suit
function Card.is_suit(self, suit, bypass_debuff, flush_calc) --Monochrome Logic
	local orig_CardIs_Suit_ref = CardIs_Suit_ref(self, suit, bypass_debuff, flush_calc)
	if not flush_calc and not self.debuff and not bypass_debuff and (next(SMODS.find_card('j_ortalab_monochrome'))) then
        local monochrome = SMODS.find_card('j_ortalab_monochrome')
        for _, card in pairs(monochrome) do
            if suit == card.ability.extra.suit then return true end
        end
	else
		return orig_CardIs_Suit_ref
	end
end