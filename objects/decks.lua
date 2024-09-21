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

SMODS.Back({
    key = "brown", 
    atlas = "decks",
    pos = {x = 3, y = 0}, 
    config = {}, 
    apply = function(self)
        G.GAME.interest_amount = 2
        G.GAME.modifiers.no_extra_hand_money = true
    end,
    loc_vars = function(self, info_queue, card)
        -- info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'flare'}
        return {vars = {self.config.debt}}
    end,
})

SMODS.Voucher:take_ownership('v_seed_money', {loc_vars = function(self, info_queue, card) return {vars = {self.config.extra/5 * G.GAME.interest_amount}} end}, true)
SMODS.Voucher:take_ownership('v_money_tree', {loc_vars = function(self, info_queue, card) return {vars = {self.config.extra/5 * G.GAME.interest_amount}} end}, true)

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
    key = "royal", 
    atlas = "decks",
    pos = {x = 3, y = 1}, 
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local faces = {}
                for k, rank in pairs(SMODS.Ranks) do
                    if rank.face then faces[#faces + 1] = k end
                end
                for k, v in pairs(G.playing_cards) do
                    if not v:is_face() then 
                        v.to_remove = true
                        -- SMODS.change_base(v, nil, pseudorandom_element(faces, pseudoseed('royal_deck_'..k)))
                    end
                end
                local i = 1
                while i <= #G.playing_cards do
                    if G.playing_cards[i].to_remove then
                        G.playing_cards[i]:remove()
                    else
                        i = i + 1
                    end
                end
                G.GAME.starting_deck_size = #G.playing_cards
                return true
            end
        }))
    end,
    trigger_effect = function(self, args)
        if args.context == 'eval' then
            local faces = {}
            for k, rank in pairs(SMODS.Ranks) do
                if rank.face then faces[#faces + 1] = k end
            end
            local new_card = create_playing_card(nil, G.deck)
            new_card:add_to_deck()
            SMODS.change_base(new_card, nil, pseudorandom_element(faces, pseudoseed('royal_deck_spawn')))
            bottle_randomise(new_card)
        end
    end,
    loc_vars = function(self, info_queue, card)
        -- info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'salad'}
    end,
})

SMODS.Back({
    key = "striped", 
    atlas = "decks",
    pos = {x = 4, y = 1}, 
    config = {wild_rank = 8},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local ranks = {}
                for k, rank in pairs(SMODS.Ranks) do
                    ranks[rank.id] = pseudorandom_element({'Spades','Hearts','Diamonds','Clubs'})
                end
                for k, v in pairs(G.playing_cards) do
                    if v:get_id() == self.config.wild_rank then
                        v:set_ability(G.P_CENTERS['m_wild'])
                    else
                        local rank = v:get_id()
                        SMODS.change_base(v, ranks[rank], nil)
                    end
                end
                return true
            end
        }))
    end,
    loc_vars = function(self, info_queue, card)
        -- info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'crimson'}
        return {vars = {self.config.wild_rank}}
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

SMODS.Back({
    key = 'frozen',
    atlas = 'decks',
    pos = {x = 3, y = 2},
    config = {round = 1},
    trigger_effect = function(self, args)
        if args.context == 'final_scoring_step' and G.GAME.current_round.hands_played == 0 then
            G.GAME.modifiers.frozen_deck = true
        else
            G.GAME.modifiers.frozen_deck = false
        end
    end,
    loc_vars = function(self, info_queue, card)
        -- info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'crimson'}
        return {vars = {self.config.round}}
    end,
})