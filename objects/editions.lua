SMODS.Shader({key = 'greyscale', path = "greyscale.fs"})
SMODS.Shader({key = 'fluorescent', path = "fluorescent.fs"})
SMODS.Shader({key = 'anaglyphic', path = "anaglyphic.fs"})
SMODS.Shader({key = 'overexposed', path = "overexposed.fs"})

SMODS.Edition({
    key = "anaglyphic",
    loc_txt = {
        name = "Anaglyphic",
        label = "Anaglyphic",
        text = {
            "{C:chips}+#1#{} Chips",
            "{C:red}+#2#{} Mult"
        }
    },
    discovered = false,
    unlocked = true,
    shader = 'anaglyphic',
    config = { chips = 20, mult = 6 },
    in_shop = true,
    weight = 8,
    extra_cost = 4,
    apply_to_float = true,
    loc_vars = function(self, info_queue)
        if Ortalab.artist_credits and (card or Ortalab.full_credits) then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'eremel', title = 'Shader'} end
        return { vars = {self.config.chips, self.config.mult}}
    end,
})

SMODS.Edition({
    key = "fluorescent",
    loc_txt = {
        name = "Fluorescent",
        label = "Fluorescent",
        text = {
            "Earn {C:money}$#1#{} when this",
            "card is scored"
        }
    },
    discovered = false,
    unlocked = true,
    shader = 'fluorescent',
    config = { p_dollars = 3 },
    in_shop = true,
    weight = 8,
    extra_cost = 4,
    apply_to_float = true,
    loc_vars = function(self, info_queue)
        if Ortalab.artist_credits and (card or Ortalab.full_credits) then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'eremel', title = 'Shader'} end
        return { vars = {self.config.p_dollars}}
    end
})

SMODS.Edition({
    key = "greyscale",
    loc_txt = {
        name = "Greyscale",
        label = "Greyscale",
        text = {
            "Swap {C:chips}Chips",
            "and {C:mult}Mult"
        }
    },
    shader = "greyscale",
    discovered = false,
    unlocked = true,
    config = {swap = true},
    in_shop = true,
    weight = 8,
    extra_cost = 6,
    badge_colour = HEX("858585"),
    apply_to_float = true,
    loc_vars = function(self, info_queue, card)
        if Ortalab.artist_credits and (card or Ortalab.full_credits) then info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'eremel', title = 'Shader'} end
        return { vars = { self.config.chips, self.config.mult, self.config.x_mult } }
    end
})

-- Awaiting retrigger API
-- SMODS.Edition({
--     key = "overexposed",
--     loc_txt = {
--         name = "Overexposed",
--         label = "Overexposed",
--         text = {
--             "{C:green}Retrigger{} this card"
--         }
--     },
--     discovered = false,
--     unlocked = true,
--     shader = 'overexposed',
--     config = { repetitions = 1 },
--     in_shop = true,
--     weight = 8,
--     extra_cost = 4,
--     apply_to_float = true,
--     loc_vars = function(self, info_queue)
--         return {}
--     end,
--     calculate = function(self, context, ret)
--         if context.repetition then
--             sendDebugMessage("Retrigger pls")
--             return {
--                 message = localize('k_again_ex'),
--                 repetitions = self.config.repetitions
--             }
--         end
--     end
-- })