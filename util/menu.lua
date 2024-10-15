SMODS.current_mod.config_tab = function()
    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 4, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
        {n=G.UIT.R, config = {align = 'cm'}, nodes={
            {n=G.UIT.C, config = {padding = 0.2, align = 'cm'}, nodes = {
                create_toggle({label = localize('ortalab_config_artists'), ref_table = Ortalab.config, ref_value = 'artist_credits', info = localize('ortalab_config_artists_desc'), active_colour = Ortalab.badge_colour, right = true, callback = artist_toggle}),
                create_toggle({label = localize('ortalab_config_full'), ref_table = Ortalab.config, ref_value = 'full_credits', info = localize('ortalab_config_full_desc'), active_colour = Ortalab.badge_colour, right = true, callback = full_toggle}),
            }}
        }},
        -- {n=G.UIT.R, config={minh=0.1}},
        {n=G.UIT.R, config = {minh = 0.04, minw = 4.5, colour = G.C.L_BLACK}},
        {n=G.UIT.R, nodes = {
            {n=G.UIT.C, config={minw = 3, padding=0.2}, nodes={
                create_toggle({label = localize('ortalab_config_placeholder'), ref_table = Ortalab.config, ref_value = 'placeholders', info = localize('ortalab_config_placeholder_desc'), active_colour = Ortalab.badge_colour, right = true, callback = purge_collection}),
            }},
        }},
        
}}
end

function artist_toggle()
    if not Ortalab.config.artist_credits and Ortalab.config.full_credits then
        Ortalab.config.full_credits = false
    end
end

function full_toggle()
    if Ortalab.config.full_credits and not Ortalab.config.artist_credits then
        Ortalab.config.artist_credits = true
    end
end
