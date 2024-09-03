SMODS.Atlas({
    key = 'decks',
    path = 'decks.png',
    px = '71',
    py = '95'
})



SMODS.Back({
	key = "orange", 
	atlas = "decks",
	pos = {x = 0, y = 0}, 
	config = {hands = -1, discards = 2}, 
	loc_vars = function(self, info_queue, card)
        -- if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'crimson'} end
        return {vars = {self.config.hands, self.config.discards}}
    end,
})

SMODS.Back({
    key = "cyan", 
    atlas = "decks",
    pos = {x = 1, y = 0}, 
    config = {hands = 2, discards = -1}, 
    loc_vars = function(self, info_queue, card)
        -- info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'crimson'}
        return {vars = {self.config.hands, self.config.discards}}
    end,
})
SMODS.Back({
    key = "cobalt", 
    atlas = "decks",
    pos = {x = 2, y = 0}, 
    config = {debt = 25}, 
    apply = function(self)
        G.GAME.bankrupt_at = -self.config.debt
    end,
    loc_vars = function(self, info_queue, card)
        -- info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'flare'}
        return {vars = {self.config.debt}}
    end,
})

-- SMODS.Back({
--     key = "cyan", 
--     atlas = "decks",
--     pos = {x = 1, y = 0}, 
--     config = {hands = 2, discards = -1, atlas = "Ortalab-Enhancers"}, 
--     loc_vars = function(self, info_queue, card)
--         -- info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'crimson'}
--         return {vars = {self.config.hands, self.config.discards}}
--     end,
-- })

SMODS.Back({
    key = "experimental", 
    atlas = "decks",
    pos = {x = 0, y = 1}, 
    config = {consumables = {'c_ortalab_lot_barrel'}, hand_size = 1}, 
    loc_vars = function(self, info_queue, card)
        -- info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'crimson'}
        return {vars = {self.config.hand_size}}
    end,
})

SMODS.Back({
	key = "sketched", 
	atlas = "decks",
	pos = {x = 1, y = 2}, 
	config = {hand_size = -1, joker_slot = 1}, 
	loc_vars = function(self, info_queue, card)
        -- info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'flare'}
        return {vars = {self.config.hand_size, self.config.joker_slot}}
    end,
})

SMODS.Back({
    key = 'hoarder',
    atlas = 'decks',
    pos = {x = 2, y = 2},
    config = {amount = 2},
    trigger_effect = function(self, args)
        if args.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss then
            for i=1, self.config.amount do
                local tag_pool = get_current_pool('Tag')
                local selected_tag = pseudorandom_element(tag_pool, pseudoseed('ortalab_hoarder'))
                local it = 1
                while selected_tag == 'UNAVAILABLE' do
                    it = it + 1
                    selected_tag = pseudorandom_element(tag_pool, pseudoseed('ortalab_hoarder_resample'..it))
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after', delay = 0.4,
                    func = (function()
                        add_tag(Tag(selected_tag))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        -- info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'}
        return {vars = {self.config.amount}}
    end,
})
