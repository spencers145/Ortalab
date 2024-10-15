SMODS.Atlas({
    key = 'zodiac_cards',
    path = 'zodiac.png',
    px = '71',
    py = '95'
})

SMODS.UndiscoveredSprite({
    key = "Zodiac",
    atlas = "zodiac_cards",
    pos = { x = 0, y = 3 },
    no_overlay = true
})

G.ARGS.LOC_COLOURS['Zodiac'] = HEX("a84040")

SMODS.ConsumableType({
    key = "Zodiac",
    primary_colour = HEX("a84040"),
    secondary_colour = HEX("a84040"),
    loc_txt = {
        name = "Zodiac Card",
        collection = "Zodiac Cards",
        undiscovered = {
            name = 'Unknown Zodiac Card',
            text = {
                'Find this card in an unseeded',
                'run to find out what it does'
            }
        }
    },
    collection_rows = {6, 6},
    shop_rate = 1,
    default = 'c_ortalab_zod_aries'
})

SMODS.Consumable({
    key = 'zod_aries',
    set = 'Zodiac',
    atlas = 'zodiac_cards',
    pos = {x=0, y=0},
    discovered = false,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        sendDebugMessage("Not yet implemented")
    end
})

SMODS.Consumable({
    key = 'zod_taurus',
    set = 'Zodiac',
    atlas = 'zodiac_cards',
    pos = {x=1, y=0},
    discovered = false,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        sendDebugMessage("Not yet implemented")
    end
})

SMODS.Consumable({
    key = 'zod_gemini',
    set = 'Zodiac',
    atlas = 'zodiac_cards',
    pos = {x=2, y=0},
    discovered = false,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        sendDebugMessage("Not yet implemented")
    end
})

SMODS.Consumable({
    key = 'zod_cancer',
    set = 'Zodiac',
    atlas = 'zodiac_cards',
    pos = {x=3, y=0},
    discovered = false,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then 
            info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'}
            info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'salad'}
        end
        
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        sendDebugMessage("Not yet implemented")
    end
})

SMODS.Consumable({
    key = 'zod_leo',
    set = 'Zodiac',
    atlas = 'zodiac_cards',
    pos = {x=0, y=1},
    discovered = false,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        sendDebugMessage("Not yet implemented")
    end
})

SMODS.Consumable({
    key = 'zod_virgo',
    set = 'Zodiac',
    atlas = 'zodiac_cards',
    pos = {x=1, y=1},
    discovered = false,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        sendDebugMessage("Not yet implemented")
    end
})

SMODS.Consumable({
    key = 'zod_libra',
    set = 'Zodiac',
    atlas = 'zodiac_cards',
    pos = {x=2, y=1},
    discovered = false,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        sendDebugMessage("Not yet implemented")
    end
})

SMODS.Consumable({
    key = 'zod_scorpio',
    set = 'Zodiac',
    atlas = 'zodiac_cards',
    pos = {x=3, y=1},
    discovered = false,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        sendDebugMessage("Not yet implemented")
    end
})

SMODS.Consumable({
    key = 'zod_sag',
    set = 'Zodiac',
    atlas = 'zodiac_cards',
    pos = {x=0, y=2},
    discovered = false,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        sendDebugMessage("Not yet implemented")
    end
})

SMODS.Consumable({
    key = 'zod_capr',
    set = 'Zodiac',
    atlas = 'zodiac_cards',
    pos = {x=1, y=2},
    discovered = false,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        sendDebugMessage("Not yet implemented")
    end
})

SMODS.Consumable({
    key = 'zod_aquarius',
    set = 'Zodiac',
    atlas = 'zodiac_cards',
    pos = {x=2, y=2},
    discovered = false,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        sendDebugMessage("Not yet implemented")
    end
})

SMODS.Consumable({
    key = 'zod_pisces',
    set = 'Zodiac',
    atlas = 'zodiac_cards',
    pos = {x=3, y=2},
    discovered = false,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        if Ortalab.config.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'parchment'} end
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        sendDebugMessage("Not yet implemented")
    end
})