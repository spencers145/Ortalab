SMODS.Atlas({
    key = 'patches',
    path = 'patches.png',
    px = '34',
    py = '34'
})

SMODS.Tag({
    key = 'rewind',
    atlas = 'patches',
    pos = {x = 0, y = 0},
    discovered = false,
})

SMODS.Tag({
    key = 'recycle',
    atlas = 'patches',
    pos = {x = 1, y = 0},
    discovered = false,
})

SMODS.Tag({
    key = 'dfour',
    atlas = 'patches',
    pos = {x = 2, y = 0},
    discovered = false,
})

SMODS.Tag({
    key = 'bargain',
    atlas = 'patches',
    pos = {x = 3, y = 0},
    discovered = false,
})

SMODS.Tag({
    key = 'minion',
    atlas = 'patches',
    pos = {x = 4, y = 0},
    discovered = false,
})

SMODS.Tag({
    key = 'slipup',
    atlas = 'patches',
    pos = {x = 0, y = 1},
    discovered = false,
    config = {type = 'round_start_bonus', discards = 2},
    loc_vars = function(self, info_queue, card)
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'} end
        return {vars = {self.config.discards}}
    end,
    apply = function(tag, context)
        tag:yep('+', G.C.RED ,function() 
            return true
        end)
        ease_discard(tag.config.discards)
        tag.triggered = true
    end
})

SMODS.Tag({
    key = 'extraordinary',
    atlas = 'patches',
    pos = {x = 1, y = 1},
    discovered = false,
})

SMODS.Tag({
    key = 'charm',
    atlas = 'patches',
    pos = {x = 2, y = 1},
    discovered = false,
})

SMODS.Tag({
    key = 'buffoon',
    atlas = 'patches',
    pos = {x = 3, y = 1},
    discovered = false,
})

SMODS.Tag({
    key = 'jackpot',
    atlas = 'patches',
    pos = {x = 4, y = 1},
    discovered = false,
})

SMODS.Tag({
    key = 'soul',
    atlas = 'patches',
    pos = {x = 0, y = 2},
    soul_pos = {x = 1, y = 2},
    discovered = false,
    config = {cost = 50},
    loc_vars = function(self, info_queue, card)
        if Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'kosze'} end
        return {vars = {self.config.cost}}
    end,
})