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
        }}
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

local main_menu = Game.main_menu
function Game:main_menu(context)
    if Ortalab.config.initial_setup then
        G.FUNCS.overlay_menu({
            definition = create_initial_config()
        })
    end
    main_menu(self, context)
end

function create_initial_config()

    local t = create_UIBox_generic_options({ back_func = 'close_initial_config', contents = {
        {n = G.UIT.C, config = {r = 0.1, minw = 4, align = "tm", padding = 0.2, colour = G.C.L_BLACK}, nodes = {
            {n=G.UIT.R, config = {align = 'cm', minw = 10, padding = 0.2, r=0.1, colour = G.C.BLACK}, nodes = {
                {n=G.UIT.R, config={align='cm'}, nodes = {{n=G.UIT.T, config={text = 'Welcome to Ortalab Demo 2',colour = G.C.WHITE, scale = 0.5}}}},
                {n=G.UIT.R, config={align='cm'}, nodes = {{n=G.UIT.T, config={text = 'Every action has an opposite reaction. In another world, in the nation of Virtue,',colour = G.C.WHITE, scale = 0.35}}}},
                {n=G.UIT.R, config={align='cm'}, nodes = {{n=G.UIT.T, config={text = 'a simple indie developer created Ortalab, which so happened to be the opposite of',colour = G.C.WHITE, scale = 0.35}}}},
                {n=G.UIT.R, config={align='cm'}, nodes = {{n=G.UIT.T, config={text = "our world's Balatro. This mod is intended to port everything from that parallel world to Balatro.",colour = G.C.WHITE, scale = 0.35}}}},
            }},
            {n=G.UIT.R, config = {align = 'cm', padding = 0.2, r=0.1, colour = G.C.BLACK}, nodes = {
                {n=G.UIT.C, nodes = {
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
            }},
        }}
    }})
    return t

end

G.FUNCS.close_initial_config = function()
    Ortalab.config.initial_setup = false
    SMODS.save_mod_config(Ortalab)
    G.FUNCS:exit_overlay_menu()
    -- G:main_menu()
end
