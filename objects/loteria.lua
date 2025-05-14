SMODS.Atlas({
    key = 'loteria_cards',
    path = 'loteria.png',
    px = '71',
    py = '95'
})

SMODS.load_file('objects/loteria_boosters.lua')()

SMODS.UndiscoveredSprite({
    key = "Loteria",
    atlas = "loteria_cards",
    pos = { x = 0, y = 4 },
    no_overlay = true
})

SMODS.ConsumableType({
    key = "Loteria",
    primary_colour = HEX("CC56CC"),
    secondary_colour = HEX("A85D7C"),
    loc_txt = {
        name = "Loteria Card",
        collection = "Loteria Cards",
        undiscovered = {
            name = 'Unknown Loteria Card',
            text = {
                'Find this card in an unseeded',
                'run to find out what it does'
            }
        }
    },
    collection_rows = {6, 5},
    shop_rate = 0.7,
    default = 'c_ortalab_lot_rooster'
})

SMODS.Consumable({
    key = 'lot_rooster',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=3, y=0},
    discovered = false,
    config = {extra = {sets = {'Loteria', 'Zodiac'}}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
    end,
    can_use = function(self, card)
        if G.GAME.Ortalab and G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
            return true
        end
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        local options = {}
        for _, type in pairs(card.ability.extra.sets) do
            if G.GAME.Ortalab.usage[type] then
                for key, count in pairs(G.GAME.Ortalab.usage[type]) do
                    for i=1, count do
                        options[#options + 1] = key
                    end
                end
            end
        end
        play_sound('timpani')
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        if #G.consumeables.cards + G.GAME.consumeable_buffer <= G.consumeables.config.card_limit then
            local card = create_card(nil, G.consumeables, nil, nil, nil, nil, pseudorandom_element(options, pseudoseed('rooster_card')), 'rooster')
            card:add_to_deck()
            G.consumeables:emplace(card)
            card:juice_up(0.3, 0.5)
        end
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
    end
})

SMODS.Consumable({
    key = 'lot_melon',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=3, y=4},
    discovered = false,
    config = {extra = {key = 'm_ortalab_recycled', amount = 3}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_scorpion',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=1, y=3},
    discovered = false,
    config = {extra = {type = 'Zodiac', amount = 2}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
        info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'no_demo', title = 'Not In Demo'}
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return standard_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        create_consumables(card)
    end
})

SMODS.Consumable({
    key = 'lot_umbrella',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=0, y=0},
    discovered = false,
    config = {extra = {key = 'm_ortalab_bent', amount = 3}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_barrel',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=0, y=3},
    discovered = false,
    config = {extra = {type = 'Loteria', amount = 2}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {card and (card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)) or self.config.extra.amount}}
    end,
    can_use = function(self, card)
        return standard_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        create_consumables(card)
    end
})

SMODS.Consumable({
    key = 'lot_mandolin',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=4, y=3},
    discovered = false,
    config = {extra = {key = 'm_ortalab_post', amount = 3}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_ladder',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=1, y=1},
    discovered = false,
    config = {extra = {key = 'm_ortalab_index', amount = 2}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_siren',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=2, y=0},
    discovered = false,
    config = {extra = {key = 'm_ortalab_rusty', amount = 3}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_bird',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=2, y=3},
    discovered = false,
    config = {extra = {key = 'm_ortalab_sand', amount = 2}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_bonnet',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=2, y=4},
    discovered = false,
    config = {extra = {min = -3, max = 25}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
        return {vars = {math.abs(card.ability.extra.min), card.ability.extra.max}}
    end,
    can_use = function (self, card)
        return standard_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        local doubled = to_big(G.GAME.dollars) >= to_big(card.ability.extra.max) and 2 or 1
        local money = pseudorandom(pseudoseed('bonnet'), card.ability.extra.min * doubled, card.ability.extra.max * doubled)
        ease_dollars(money)
    end
})

SMODS.Consumable({
    key = 'lot_pear',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=4, y=0},
    discovered = false,
    config = {extra = {chance = 4, amount = 1}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {math.max(G.GAME.probabilities.normal, 1), card.ability.extra.chance / math.min(G.GAME.probabilities.normal, 1)}}
    end,
    can_use = function(self, card)
        if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
            for _, v in pairs(G.jokers.cards) do
                if v.ability.set == 'Joker' and (not v.edition) then
                    return true
                end
            end
        end
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        local eligible_jokers = {}
        for k, v in pairs(G.jokers.cards) do
            if v.ability.set == 'Joker' and (not v.edition) then
                table.insert(eligible_jokers, v)
            end
        end
        if pseudorandom(pseudoseed('pear_roll')) < (G.GAME.probabilities.normal / card.ability.extra.chance) then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                local over = false
                local eligible_card = pseudorandom_element(eligible_jokers, pseudoseed('pear_select'))
                local edition = poll_edition('pear_poll', nil, nil, true, {'e_ortalab_anaglyphic', 'e_ortalab_greyscale', 'e_ortalab_fluorescent', 'e_ortalab_overexposed'})
                eligible_card:set_edition(edition, true)
                check_for_unlock({type = 'have_edition'})
                card:juice_up(0.3, 0.5)
            return true end }))
        else
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3, 
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.SECONDARY_SET.Loteria,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                    offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                    silent = true
                })
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4)
                return true end}))
                play_sound('tarot2', 1, 0.4)
                card:juice_up(0.3, 0.5)
            return true end }))
        end
    end
})

SMODS.Consumable({
    key = 'lot_flag',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=1, y=2},
    discovered = false,
    config = {extra = {selected = 2, rank_change = 2}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {card.ability.extra.selected + (G.GAME and G.GAME.ortalab.vouchers.tabla), card.ability.extra.rank_change}}
    end,
    can_use = function(self, card)
        return selected_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        table.sort(G.hand.highlighted, function (a, b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
        local signs = {1, -1}
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
            local change = pseudorandom(pseudoseed('flag_change'), 1, card.ability.extra.rank_change)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    for j=1, change do
                        G.hand.highlighted[i].base.id = G.hand.highlighted[i].base.id + signs[2 - (i % 2)]
                        local rank_suffix = get_rank_suffix(G.hand.highlighted[i])
                        assert(SMODS.change_base(G.hand.highlighted[i], nil, rank_suffix))
                    end
                    return true
                end
            }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
    end
})

SMODS.Consumable({
    key = 'lot_bottle',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=3, y=2},
    discovered = false,
    config = {extra = {amount = 2, selected = 2}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return selected_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        local destroyed_cards = {}
        for i=#G.hand.highlighted, 1, -1 do
            destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function() 
                for i=#G.hand.highlighted, 1, -1 do
                    local card = G.hand.highlighted[i]
                    if SMODS.shatters(card) then 
                        card:shatter()
                    else
                        card:start_dissolve(nil, i == #G.hand.highlighted)
                    end
                end
                return true end }))
        SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.35,func = function()
            local new_cards = {}
            for i=1, card.ability.extra.amount + G.GAME.ortalab.vouchers.tabla do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                    local new_card = create_playing_card({center = G.P_CENTERS[pseudorandom_element(get_current_pool('Enhanced'), pseudoseed('bottle'))]}, G.play)
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    new_cards[i] = new_card
                    return true
                end}))
                for j=1, 10 do
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                        new_cards[i]:juice_up(0.7, 0.3)
                        play_sound('generic1')
                        bottle_randomise(new_cards[i])
                        return true
                    end}))
                end
            end
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.35,func = function()
                play_sound('holo1')
                playing_card_joker_effects(new_cards)
                for _, card in pairs(new_cards) do
                    card:juice_up(0.7, 0.3)
                    draw_card(G.play, G.hand, 1, 'up', false, card, nil, true)
                end
                delay(0.5)
                return true
            end}))
            return true
        end}))
    end
})

SMODS.Consumable({
    key = 'lot_harp',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=4, y=1},
    discovered = false,
    config = {extra ={selected = 2}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
    end,
    can_use = function(self, card)
        if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
            if #G.hand.highlighted == card.ability.extra.selected then
                return true
            end
        end
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        table.sort(G.hand.highlighted, function (a,b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
        local card1 = G.hand.highlighted[1]
        local card_1_info = {
            rank = get_rank_suffix(card1),
            suit = card1.base.suit,
            enhancement = card1.ability.set == 'Enhanced' and card1.config.center or nil,
            edition = card1.edition and card1.edition.type and 'e_'..card1.edition.type or nil,
            seal = card1.seal or nil
        }
        local card2 = G.hand.highlighted[2]
        local card_2_info = {
            rank = get_rank_suffix(card2),
            suit = card2.base.suit,
            enhancement = card2.ability.set == 'Enhanced' and card2.config.center or nil,
            edition = card2.edition and card2.edition.type and 'e_'..card2.edition.type or nil,
            seal = card2.seal or nil
        }
        local new_card

        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.35, func = function()
            draw_card(G.hand, G.play, 1, 'up', false, card1, nil, true)
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                new_card = create_playing_card({center = pseudorandom_element({card1.config.center, card2.config.center}, pseudoseed('harp_card'))}, G.play)
                new_card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, new_card)
                harp_randomise(new_card, card_1_info, card_2_info)
                return true
            end}))
            draw_card(G.hand, G.play, 1, 'up', false, card2, nil, true)

            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                for _, card in pairs(G.play.cards) do
                    card.particles = Particles(1, 1, 0,0, {
                        timer = 0.15,
                        scale = 0.3,
                        initialize = true,
                        lifespan = 1,
                        speed = 3,
                        padding = -1,
                        attach = card,
                        colours = {G.ARGS.LOC_COLOURS.loteria, lighten(G.ARGS.LOC_COLOURS.loteria, 0.4), lighten(G.ARGS.LOC_COLOURS.loteria, 0.2), darken(G.ARGS.LOC_COLOURS.loteria, 0.2)},
                        fill = true
                    })
                    card.particles.fade_alpha = 1
                    card.particles:fade(1, 0)
                end
                return true
            end}))
            for i=1, 10 do
                for j=1, 3 do
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                        G.play.cards[j]:juice_up(0.7, 0.3)
                        play_sound('generic1')
                        harp_randomise(new_card, card_1_info, card_2_info)
                        return true
                    end}))
                end
            end
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.5,func = function()
                card1:start_dissolve()
                card2:start_dissolve()
                play_sound('holo1')
                new_card.particles:remove()
                return true
            end}))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.5,func = function()
                card1:remove()
                card2:remove()
                delay(0.5)
                return true
            end}))
            draw_card(G.play, G.hand, 1, 'up', false, new_card, nil, true)
            return true
        end}))
    end
})

SMODS.Consumable({
    key = 'lot_heron',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=2, y=1},
    discovered = false,
    config = {extra = {money = 1, value = 2, amount = 3}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {card.ability.extra.money, card.ability.extra.value, card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)        }}
    end,
    can_use = function(self, card)
        return #G.hand.cards > 0 and #G.hand.highlighted == 0
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, loteria, area, copier)
        track_usage(loteria.config.center.set, loteria.config.center_key)
        local cards = {}
        local available_cards = {}
        for _, card in pairs(G.hand.cards) do
            if card:get_chip_bonus() > 0 or get_chips_from_enhancement(card) > 0 or get_chips_from_edition(card) > 0 then
                table.insert(available_cards, card)
            end
        end

        for i=1, math.min(loteria.ability.extra.amount + G.GAME.ortalab.vouchers.tabla, #available_cards) do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.35,func = function()
                local selected = false
                while not selected do
                    local selected_card = pseudorandom_element(available_cards, pseudoseed('heron'))
                    if not selected_card.highlighted then
                        G.hand:add_to_highlighted(selected_card)
                        selected = true
                    end
                end
                return true
            end}))
        end
        table.sort(G.hand.highlighted, function (a,b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.35,func = function()
            local total = 0
            for _, card in pairs(G.hand.highlighted) do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.35,func = function()
                    local chips = card:get_chip_bonus()
                    local edition_chips = get_chips_from_edition(card)
                    local enhancement_chips = get_chips_from_enhancement(card)
                    chips = chips + edition_chips + enhancement_chips
                    local money = math.floor(chips/loteria.ability.extra.value)
                    card_eval_status_text(card, 'dollars', money, nil, nil, {instant = true})
                    total = total + money
                    return true
                end}))
            end
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.35,func = function() ease_dollars(total); return true; end}))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.35,func = function()
                G.hand:unhighlight_all()
                return true
            end}))
            return true
        end}))
    end
})

function get_chips_from_edition(card)
    if not card.edition then return 0 end
    local ret = card:calculate_edition({main_scoring = true, cardarea = G.play})
    if not ret then return 0 end
    if ret.chips then return ret.chips end
    if ret.chip_mod then return ret.chip_mod end
    return 0
end

function get_chips_from_enhancement(card)
    if card.config.center.set ~= 'Enhanced' then return 0 end
    local ret = card:calculate_enhancement({heron_check = true})
    if not ret then return 0 end
    if ret.chips then return ret.chips end
    if ret.chip_mod then return ret.chip_mod end
    return 0
end

SMODS.Consumable({
    key = 'lot_rose',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=1, y=4},
    discovered = false,
    config = {extra = {key = 'm_ortalab_iou', amount = 2}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key) 
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_dandy',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=2, y=2},
    discovered = false,
    config = {extra = {key = 'm_ortalab_ore', amount = 2}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_boot',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=4, y=2},
    discovered = false,
    config = {extra = {selected = 3, suit = 'Diamonds'}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {card.ability.extra.selected + (G.GAME and G.GAME.ortalab.vouchers.tabla), card.ability.extra.suit,
            colours = {G.C.SUITS[card.ability.extra.suit]}}}
    end,
    can_use = function(self, card)
        return selected_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        change_suit(card)
    end
})

SMODS.Consumable({
    key = 'lot_parrot',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=0, y=1},
    discovered = false,
    config = {extra = {selected = 3, suit = 'Clubs'}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {card.ability.extra.selected + (G.GAME and G.GAME.ortalab.vouchers.tabla), card.ability.extra.suit,
        colours = {G.C.SUITS[card.ability.extra.suit]}}}
    end,
    can_use = function(self, card)
        return selected_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        change_suit(card)
    end
})

SMODS.Consumable({
    key = 'lot_heart',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=3, y=1},
    discovered = false,
    config = {extra = {selected = 3, suit = 'Hearts'}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {card.ability.extra.selected + (G.GAME and G.GAME.ortalab.vouchers.tabla), card.ability.extra.suit,
        colours = {G.C.SUITS[card.ability.extra.suit]}}}
    end,
    can_use = function(self, card)
        return selected_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        change_suit(card)
    end
})

SMODS.Consumable({
    key = 'lot_hand',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=0, y=2},
    discovered = false,
    config = {extra = {selected = 1}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {card.ability.extra.selected}}
    end,
    can_use = function(self, card)
        if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
            if #G.jokers.highlighted == card.ability.extra.selected then
                local base_rarities = {'Common', 'Uncommon', 'Rare', 'Legendary'}
            local rarity = base_rarities[G.jokers.highlighted[1].config.center.rarity] or G.jokers.highlighted[1].config.center.rarity
                local pool = get_current_pool('Joker', rarity, rarity == 'Legendary')
                if #pool == 1 and pool[1] == 'j_joker' then return false end
                return true
            end
        end
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        local joker = G.jokers.highlighted[1]
        local original = joker.config.center
        local base_rarities = {'Common', 'Uncommon', 'Rare', 'Legendary'}
        local rarity = base_rarities[original.rarity] or original.rarity
        delay(0.5)
        draw_card(G.jokers, G.play, 1, 'up', false, joker, nil, true)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.35, func = function()
            local _center = G.P_CENTERS[original.key]
            if joker.remove_from_deck and type(joker.remove_from_deck) == 'function' then joker:remove_from_deck() end
            joker:check_chameleon()
            for i=1, 40 do
                local new_joker = pseudorandom_element(get_current_pool('Joker', rarity, rarity == 'Legendary'), pseudoseed('loteria_hand'))
                if G.P_CENTERS[new_joker] and new_joker ~= original.key then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                        _center = G.P_CENTERS[new_joker]
                        joker.children.center = Sprite(joker.T.x, joker.T.y, joker.T.w, joker.T.h, G.ASSET_ATLAS[_center.atlas or 'Joker'], _center.pos)
                        joker.children.center.states.hover = joker.states.hover
                        joker.children.center.states.click = joker.states.click
                        joker.children.center.states.drag = joker.states.drag
                        joker.children.center.states.collide.can = false
                        joker.children.center:set_role({major = joker, role_type = 'Glued', draw_major = joker})
                        if _center.soul_pos then 
                            joker.children.floating_sprite = Sprite(joker.T.x, joker.T.y, joker.T.w, joker.T.h, G.ASSET_ATLAS[_center[G.SETTINGS.colourblind_option and 'hc_atlas' or 'lc_atlas'] or _center.atlas or _center.set], _center.soul_pos)
                            joker.children.floating_sprite.role.draw_major = joker
                            joker.children.floating_sprite.states.hover.can = false
                            joker.children.floating_sprite.states.click.can = false
                        end
                        if i == 1 then
                            for key, _ in pairs(joker.T) do
                                joker.T[key] = joker.T_ref[key]
                            end
                        end
                        play_sound('generic1')
                        return true
                    end}))
                end
            end
            
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                joker:set_ability(_center)
                joker:set_cost()
                joker:add_to_deck()
                joker:check_chameleon()
                joker:juice_up()
                play_sound('holo1')
                return true
            end}))
            draw_card(G.play, G.jokers, 1, 'up', false, joker, nil, true)
            return true
        end}))
    end
})

function Card:check_chameleon()
    if self.config.center_key == 'j_ortalab_chameleon' then
        self.children.front:remove()
        self.children.front = nil
        self.ignore_base_shader.chameleon = nil
        self.ignore_shadow.chameleon = nil
        self.config.center_key = 'old chameleon'
    end
end

SMODS.Consumable({
    key = 'lot_tree',
    set = 'Loteria',
    atlas = 'loteria_cards',
    pos = {x=1, y=0},
    discovered = false,
    config = {extra = {selected = 3, suit = 'Spades'}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
        return {vars = {card.ability.extra.selected + (G.GAME and G.GAME.ortalab.vouchers.tabla), card.ability.extra.suit,
        colours = {G.C.SUITS[card.ability.extra.suit]}}}
    end,
    can_use = function(self, card)
        return selected_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        change_suit(card)
    end
})

-- Functions

function standard_use()
    if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
        return true
    end
end

function selected_use(self, card)
    if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
        if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.selected + (G.GAME and G.GAME.ortalab.vouchers.tabla) then
            return true
        end
    end
end

function can_enhance_cards(self, card)
    if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
        for _, v in pairs(G.hand.cards) do
            if v.config.center_key ~= card.ability.extra.key then
                return true
            end
        end
    end
end

function use_enhance_cards(self, loteria, area, copier)
    G.hand:unhighlight_all()
    local valid_cards = 0
    for _,v in ipairs(G.hand.cards) do
        if v.config.center_key ~= loteria.ability.extra.key then valid_cards = valid_cards + 1 end
    end
    shuffle_cards()
    for i=1, math.min(loteria.ability.extra.amount + G.GAME.ortalab.vouchers.tabla, valid_cards) do
        local set = true
        while set do
            local card = pseudorandom_element(G.hand.cards, pseudoseed(loteria.ability.extra.key..'_select'))
            if not Ortalab.config.loteria_skip then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() card:highlight(true); play_sound('card3', math.random()*0.2 + 0.9, 0.35); return true; end}))
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() card:highlight(false); return true; end}))
            end
            if card.config.center_key ~= loteria.ability.extra.key and not card.changed then
                if pseudorandom(pseudoseed(loteria.ability.extra.key..'_set')) < (1 / (card.ability.set == 'Enhanced' and 8 or 3)) then
                    set_enhancement(card, loteria.ability.extra.key)
                    card.changed = true
                    set = false
                end
            end
        end
    end
    for _, card in pairs(G.hand.cards) do
        if card.changed then card.changed = false end
    end
end

function shuffle_cards()
    if Ortalab.config.loteria_skip then return end
    for i = math.random(5, 10), 1, -1 do
        local card = pseudorandom_element(G.hand.cards, pseudoseed('loteria_roll'))
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() card:highlight(true); play_sound('card3', math.random()*0.2 + 0.9, 0.35); return true; end}))
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() card:highlight(false); return true; end}))
    end
end

function set_enhancement(card, key)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() card:highlight(true); card:flip(); play_sound('generic1', 0.7, 0.35); card:juice_up(0.3,0.3); return true; end}))
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4,
        func = function()
            card:set_ability(G.P_CENTERS[key])
            card:juice_up()
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() card:highlight(false); card:flip(); play_sound('tarot2', 0.85, 0.6); card:juice_up(0.3,0.3); return true; end}))
end

function create_consumables(card)
    for i = 1, math.min(card.ability.extra.amount + G.GAME.ortalab.vouchers.tabla, G.consumeables.config.card_limit - #G.consumeables.cards) do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = create_card(card.ability.extra.type, G.consumeables, nil, nil, nil, nil, nil, 'barrel')
                card:add_to_deck()
                G.consumeables:emplace(card)
                card:juice_up(0.3, 0.5)
            end
            return true end }))
    end
    delay(0.6)
end

function change_suit(card)
    local suits = {'Spades', 'Hearts', 'Diamonds', 'Clubs'}
    for i,v in ipairs(suits) do
        if v == card.ability.extra.suit then
            table.remove(suits, i)
        end
    end
    local chosen_suit = pseudorandom_element(suits, pseudoseed(card.config.center_key..'_suit'))
    for i=1, #G.hand.highlighted do
        local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
    end
    for _, selected in pairs(G.hand.highlighted) do
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            assert(SMODS.change_base(selected, chosen_suit, nil))
        return true; end}))
    end
    for i=1, #G.hand.highlighted do
        local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
    end
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    delay(0.5)
end

function track_usage(type, key)
    if not G.GAME.Ortalab then G.GAME.Ortalab = {usage = {}} end
    if not G.GAME.Ortalab.usage[type] then G.GAME.Ortalab.usage[type] = {} end
    G.GAME.Ortalab.usage[type][key] = G.GAME.Ortalab.usage[type][key] and G.GAME.Ortalab.usage[type][key] + 1 or 1     
end

function get_rank_suffix(card)
    local rank_suffix = (card.base.id - 2) % 13 + 2
    if rank_suffix < 11 then rank_suffix = tostring(rank_suffix)
    elseif rank_suffix == 11 then rank_suffix = 'Jack'
    elseif rank_suffix == 12 then rank_suffix = 'Queen'
    elseif rank_suffix == 13 then rank_suffix = 'King'
    elseif rank_suffix == 14 then rank_suffix = 'Ace'
    end
    return rank_suffix
end

function harp_randomise(new_card, card_1_info, card_2_info)
    Ortalab.harp_usage = true
    local weighting = 0.2
    assert(SMODS.change_base(new_card, pseudorandom_element({card_1_info.suit, card_2_info.suit}, pseudoseed('harp_suit')), pseudorandom_element({card_1_info.rank, card_2_info.rank}, pseudoseed('harp_rank'))))
    local edition = pseudoseed('harp_edition') > (0.5 - (card_1_info.edition and weighting or 0) + (card_2_info.edition and weighting or 0)) and (card_1_info.edition or 'none') or (card_2_info.edition or 'none')
    if edition ~= 'none' then new_card:set_edition(edition, true, true) else new_card:set_edition(nil, nil, true) end
    local enhancement = pseudoseed('harp_enhancement') > (0.5 - (card_1_info.enhancement and weighting or 0) + (card_2_info.enhancement and weighting or 0)) and (card_1_info.enhancement or 'none') or (card_2_info.enhancement or 'none')
    if enhancement ~= 'none' then new_card:set_ability(enhancement) else new_card:set_ability(G.P_CENTERS.c_base) end
    local seal = pseudoseed('harp_seal') > (0.5 - (card_1_info.seal and weighting or 0) + (card_2_info.seal and weighting or 0)) and (card_1_info.seal or 'none') or (card_2_info.seal or 'none')
    if seal ~= 'none' then new_card:set_seal(seal, true, true) else new_card:set_seal() end
    Ortalab.harp_usage = false
end

function bottle_randomise(card)
    local modifier = 8
    local edition = poll_edition('bottle_edition', modifier, false, false)
    -- local enhance = pseudorandom_element(get_current_pool('Enhanced'), pseudoseed('bottle_enhancement'))
    -- while enhance == 'UNAVAILABLE' do
    --     enhance = pseudorandom_element(get_current_pool('Enhanced'), pseudoseed('bottle_enhancement'))
    -- end
    local enhance = SMODS.poll_enhancement({key = 'bottle_enhance', guaranteed = true})
    local seal = SMODS.poll_seal({key = 'bottle_seal', mod = modifier})
    card:set_edition(edition, true, true)
    card:set_ability(G.P_CENTERS[enhance])
    card:set_seal(seal, true, true)
end

function loteria_joker_save_check(card)
    local loteria_joker = SMODS.find_card('j_ortalab_black_cat')
    for _, joker_card in pairs(loteria_joker) do        
        if pseudorandom(pseudoseed('loteria_check_keep')) > (joker_card.ability.extra.num*G.GAME.probabilities.normal) / joker_card.ability.extra.chance then
            joker_card:juice_up()
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ortalab_loteria_saved')})
            return true
        end
    end
    return false
end
