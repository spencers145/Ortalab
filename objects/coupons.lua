SMODS.Atlas({
    key = 'coupons',
    path = 'coupons.png',
    px = '71',
    py = '95'
})

SMODS.Voucher({
	key = "catalog",
	atlas = "coupons",
	pos = {x = 0, y = 0},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
	config = {extra = {booster_gain = 1}},
	redeem = function(self)
        G.GAME.modifiers.booster_count = G.GAME.modifiers.booster_count + self.config.extra.booster_gain
        G.GAME.current_round.used_packs = G.GAME.current_round.used_packs or {}
        if not G.GAME.current_round.used_packs[1] then
            G.GAME.current_round.used_packs[1] = get_pack('shop_pack').key
        end

        if G.GAME.current_round.used_packs[1] ~= 'USED' then 
            local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2,
            G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.used_packs[1]], {bypass_discovery_center = true, bypass_discovery_ui = true})
            create_shop_card_ui(card, 'Booster', G.shop_booster)
            card.ability.booster_pos = #G.shop_booster.cards + 1
            card:start_materialize()
            G.shop_booster:emplace(card)
        end
    end,
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'flare'} end
        return {vars = {self.config.extra.booster_gain}}
    end,
})

SMODS.Voucher({
	key = "ad_campaign",
	atlas = "coupons",
	pos = {x = 1, y = 0},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    requires = {'v_ortalab_catalog'},
	config = {extra = {voucher_gain = 1}},
	redeem = function(self)
        G.GAME.current_round.voucher_2 = get_next_voucher_key()
        G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + self.config.extra.voucher_gain
        if G.GAME.current_round.voucher_2 and G.P_CENTERS[G.GAME.current_round.voucher_2] then
            local card = Card(G.shop_vouchers.T.x + G.shop_vouchers.T.w/2,
            G.shop_vouchers.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.voucher_2],{bypass_discovery_center = true, bypass_discovery_ui = true})
            card.shop_voucher = true
            create_shop_card_ui(card, 'Voucher', G.shop_vouchers)
            card:start_materialize()
            G.shop_vouchers:emplace(card)
        end
    end,
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'flare'} end
        return {vars = {self.config.extra.voucher_gain}}
    end,
})

SMODS.Voucher({
	key = "window_shopping",
	atlas = "coupons",
	config = {extra = {free_rerolls = 1, cost = 1}},
	pos = {x = 4, y = 0},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
	redeem = function(self)
        G.E_MANAGER:add_event(Event({func = function()
            window_infinite(self)
            return true 
        end }))
    end,
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'flare'} end
        return {vars = {self.config.extra.free_rerolls, self.config.extra.cost}}
    end,
})

SMODS.Voucher({
	key = "infinite_scroll",
	atlas = "coupons",
	pos = {x = 5, y = 0},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
	requires = {'v_ortalab_window_shopping'},
	config = {extra = {free_rerolls = 2, cost = 2}},
	redeem = function(self)
        G.E_MANAGER:add_event(Event({func = function()
            window_infinite(self)
            return true 
        end }))
    end,
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'flare'} end
        return {vars = {self.config.extra.free_rerolls, self.config.extra.cost}}
    end,
})



SMODS.Voucher({
	key = "abacus",
	atlas = "coupons",
	pos = {x = 2, y = 1},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
	config = {extra = {ante_gain = 1, dollars = 35}},
	redeem = function(self)
        ease_ante(self.config.extra.ante_gain)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + self.config.extra.ante_gain
        ease_dollars(self.config.extra.dollars)
    end,
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'} end
        return {vars = {self.config.extra.ante_gain, self.config.extra.dollars}}
    end,
})

SMODS.Voucher({
	key = "calculator",
	atlas = "coupons",
	pos = {x = 3, y = 1},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    requires = {'v_ortalab_abacus'},
	config = {extra = {ante_gain = 1, joker_slots = 1}},
	redeem = function(self)
        ease_ante(self.config.extra.ante_gain)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + self.config.extra.ante_gain
        G.E_MANAGER:add_event(Event({func = function()
            if G.jokers then 
                G.jokers.config.card_limit = G.jokers.config.card_limit + self.config.extra.joker_slots
            end
            return true end }))
    end,
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.artist_credits then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'} end
        return {vars = {self.config.extra.ante_gain, self.config.extra.joker_slots}}
    end,
})




local BackApply_to_run_ref = Back.apply_to_run
function Back.apply_to_run(self)
	BackApply_to_run_ref(self)
    G.GAME.modifiers.booster_count = 2
    G.GAME.modifiers.voucher_count = 1
end

function window_infinite(card)
    G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + card.config.extra.free_rerolls
    G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + card.config.extra.cost
    G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost + card.config.extra.cost)
    G.GAME.current_round["ortalab_rerolls"] = (G.GAME.current_round["ortalab_rerolls"] or 0) + card.config.extra.free_rerolls
    calculate_reroll_cost(true)
end