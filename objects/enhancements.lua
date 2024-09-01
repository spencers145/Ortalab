SMODS.Atlas({
    key = "ortalab_enhanced",
    path = "Enhancements.png",
    px = 71,
    py = 95
})

SMODS.Enhancement({
    key = "postcard",
    loc_txt = {
        name = "Post Card",
        text = {
            "{C:chips}+#1#{} chips for every",
            "{C:attention}card{} held in hand"
        }
    },
    atlas = "ortalab_enhanced",
    pos = {x = 0, y = 0},
    discovered = false,
    config = {extra = {hand_chips = 10}},
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'notmario'} end
        return {
            vars = { card and card.ability.extra.hand_chips or self.config.extra.hand_chips }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
            local chip_return = 0
            for i, held_card in pairs(G.hand.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        held_card:juice_up()
                        play_sound('chips1', 0.8+ (0.9 + 0.2*math.random())*0.2, 1)
                        card:juice_up(0.6, 0.1)
                        G.ROOM.jiggle = G.ROOM.jiggle + 0.7    
                        return true
                    end
                }))
                chip_return = chip_return + card.ability.extra.hand_chips
                if i ~= # G.hand.cards then card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_chips',vars={chip_return}}, colour = G.C.BLUE, delay = 0, chip_mod = true}) end
            end
            SMODS.eval_this(card, {
                chip_mod = chip_return,
                message = localize({type = 'variable', key = 'a_chips', vars = {chip_return}}),
            })
            
        end
    end
})

SMODS.Enhancement({
    key = "bentcard",
    loc_txt = {
        name = "Bent Card",
        text = {
            "{C:mult}+#1#{} Mult for every",
            "{C:attention}card{} held in hand"
        }
    },
    atlas = "ortalab_enhanced",
    pos = {x = 1, y = 0},
    discovered = false,
    config = {extra = {hand_mult = 2}},
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'} end
        return {
            vars = { card and card.ability.extra.hand_mult or self.config.extra.hand_mult }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
            local mult_return = 0
            for i, held_card in pairs(G.hand.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        held_card:juice_up()
                        play_sound('chips1', 0.8+ (0.9 + 0.2*math.random())*0.2, 1)
                        card:juice_up(0.6, 0.1)
                        G.ROOM.jiggle = G.ROOM.jiggle + 0.7    
                        return true
                    end
                }))
                mult_return = mult_return + card.ability.extra.hand_mult
                if i ~= #G.hand.cards then card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_mult',vars={mult_return}}, colour = G.C.RED, delay = 0, mult_mod = true}) end
            end
            SMODS.eval_this(card, {
                mult_mod = mult_return,
                message = localize({type = 'variable', key = 'a_mult', vars = {mult_return}}),
            })
            
        end
    end
})

SMODS.Enhancement({
    key = "index",
    loc_txt = {
        name = "Index Card",
        text = {
            "{C:attention}Temporarily{} increase",
            "hand level by {C:attention}#1#"
        }
    },
    atlas = "ortalab_enhanced",
    pos = {x = 2, y = 0},
    discovered = false,
    config = {extra = {level_up = 1}},
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'luna'} end
        return {
            vars = { card and card.ability.extra.level_up or self.config.extra.level_up }
        }
    end
})

SMODS.Enhancement({
    key = "sand",
    atlas = "ortalab_enhanced",
    pos = {x = 3, y = 0},
    config = {extra = {x_mult = 2.5, change=0.25}},
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'} end
        return {
            vars = { card and card.ability.extra.x_mult or self.config.extra.x_mult, card and card.ability.extra.change or self.config.extra.change }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
            effect.x_mult = card.ability.extra.x_mult
        end
    end
})

SMODS.Enhancement({
    key = "rusty",
    atlas = "ortalab_enhanced",
    pos = {x = 0, y = 1},
    discovered = false,
    config = {extra = {x_mult = 2.5, change=0.25}},
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'} end
        return {
            vars = { card and card.ability.extra.x_mult or self.config.extra.x_mult, card and card.ability.extra.change or self.config.extra.change }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
            effect.x_mult = card.ability.extra.x_mult
        end
    end
})

SMODS.Enhancement({
    key = "ore",
    loc_txt = {
        name = "Ore Card",
        text = {
            "{C:mult}+#1#{} Mult",
            "no rank or suit"
        }
    },
    atlas = "ortalab_enhanced",
    pos = {x = 1, y = 1},
    discovered = false,
    no_rank = true,
    no_suit = true,
    replace_base_card = true,
    always_scores = true,
    config = {extra = {mult = 10}},
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'eremel'} end
        return {
            vars = { card and card.ability.extra.mult or self.config.extra.mult }
        }
    end
})

SMODS.Enhancement({
    key = "iou",
    loc_txt = {
        name = "IOU Card",
        text = {
            "{C:attention}Temporarily{} increase",
            "hand level by {C:attention}#1#"
        }
    },
    atlas = "ortalab_enhanced",
    pos = {x = 2, y = 1},
    discovered = false,
    config = {extra = {level_up = 1}},
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'} end
        return {
            vars = { card and card.ability.extra.level_up or self.config.extra.level_up }
        }
    end
})

SMODS.Enhancement({
    key = "moldy",
    atlas = "ortalab_enhanced",
    pos = {x = 3, y = 1},
    discovered = false,
    config = {extra = {x_mult = 2.5, change=0.25}},
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'} end
        return {
            vars = { card and card.ability.extra.x_mult or self.config.extra.x_mult, card and card.ability.extra.change or self.config.extra.change }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
            effect.x_mult = card.ability.extra.x_mult
        end
    end
})