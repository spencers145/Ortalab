SMODS.Atlas({
    key = 'stakes',
    path = 'stakes.png',
    px = '29',
    py = '29'
})

SMODS.Atlas({
    key = 'stickers',
    path = 'stake_stickers.png',
    px = 71,
    py = 95
})

SMODS.Stake({
    key = "ortalab_1",
    applied_stakes = {},
    above_stake = 'gold',
    atlas = 'stakes',
    pos = {x = 0, y = 0},
    shiny = true,
    sticker_pos = {x = 0, y = 0},
    sticker_atlas = 'stickers',
    modifiers = function()
        G.GAME.modifiers.ortalab_only = true
    end,
})

SMODS.Stake({
    key = "ortalab_2",
    applied_stakes = {'ortalab_1'},
    above_stake = 'ortalab_1',
    atlas = 'stakes',
    pos = {x = 1, y = 0},
    shiny = true,
    sticker_pos = {x = 1, y = 0},
    sticker_atlas = 'stickers',
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
})

function get_pack(_key, _type)
    if not G.GAME.first_shop_buffoon and not G.GAME.banned_keys['p_buffoon_normal_1'] then
        G.GAME.first_shop_buffoon = true
        return G.P_CENTERS['p_buffoon_normal_'..(math.random(1, 2))]
    end
    local cume, it, center = 0, 0, nil
	local temp_in_pool = {}
    for k, v in ipairs(G.P_CENTER_POOLS['Booster']) do
		local add
		v.current_weight = v.get_weight and v:get_weight() or v.weight or 1
        if (not _type or _type == v.kind) then add = true end
		if v.in_pool and type(v.in_pool) == 'function' then 
			local res, pool_opts = v:in_pool()
			pool_opts = pool_opts or {}
			add = res and (add or pool_opts.override_base_checks)
		end
        if v.kind ~= 'Buffoon' and G.GAME.modifiers.ortalab_only then
            if not v.mod or v.mod.id ~= 'ortalab' then add = false end
        end
		if add and not G.GAME.banned_keys[v.key] then cume = cume + (v.current_weight or 1); temp_in_pool[v.key] = true end
    end
    local poll = pseudorandom(pseudoseed((_key or 'pack_generic')..G.GAME.round_resets.ante))*cume
    for k, v in ipairs(G.P_CENTER_POOLS['Booster']) do
        if temp_in_pool[v.key] then 
            it = it + (v.current_weight or 1)
            if it >= poll and it - (v.current_weight or 1) <= poll then center = v; break end
        end
    end
   if not center then center = G.P_CENTERS['p_buffoon_normal_1'] end  return center
end