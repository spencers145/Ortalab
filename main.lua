--- STEAMODDED HEADER
--- MOD_NAME: Ortalab Dev
--- MOD_ID: ortalab
--- PREFIX: ortalab
--- MOD_AUTHOR: [Eremel_]
--- MOD_DESCRIPTION: A dev environment for the Ortalab mod
--- BADGE_COLOUR: 3FC7EB
--- VERSION: 0.1
--- PRIORITY: -5
--- DEPENDENCIES: [Talisman>=2.0.0-beta5]

Ortalab = SMODS.current_mod
Ortalab.usage = {}
Ortalab.artist_credits = true
Ortalab.full_credits = false

local load_table = {
    jokers = true,
    enhancements = true,
    editions = true,
    loteria = true,
    zodiac = false,
    patches = true,
    decks = true,
    coupons = true
}
loc_colour('red')
for k, v in pairs(load_table) do
    if v then SMODS.load_file('objects/'..k..'.lua')() end
end

SMODS.load_file('util/artists.lua')()

SMODS.Atlas({
    key = 'modicon',
    path = 'modicon.png',
    px = '34',
    py = '34'
})


-- Config tab stuff to go below