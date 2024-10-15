--- STEAMODDED HEADER
--- MOD_NAME: Ortalab Dev
--- MOD_ID: ortalab
--- PREFIX: ortalab
--- MOD_AUTHOR: [Balatro Discord]
--- MOD_DESCRIPTION: Every action has an opposite reaction. In another world, in the nation of "Virtue", a simple indie developer created Ortalab, which so happened to be the opposite of our world's Balatro. This mod is intended to port everything from that parallel world to Balatro. Within this demo, it includes 60 Jokers, 10 Decks, 5 sets of Coupons, a new Consumable Type, 8 Enhancements, 3 Editions, 10 patches, and 2 Challenges for you to check out.
--- BADGE_COLOUR: 990000
--- VERSION: 0.9-demo-2.0.0
--- PRIORITY: -5
--- DEPENDENCIES: [Talisman>=2.0.0-beta5]

Ortalab = SMODS.current_mod

local load_table = {
    jokers = true,
    enhancements = true,
    editions = true,
    loteria = true,
    zodiac = false,
    patches = true,
    decks = true,
    coupons = true,
    stakes = true
}
loc_colour('red')
G.ARGS.LOC_COLOURS['Ortalab'] = HEX('990000')
for k, v in pairs(load_table) do
    if v then SMODS.load_file('objects/'..k..'.lua')() end
end

SMODS.load_file('util/artists.lua')()
SMODS.load_file('util/functions.lua')()
SMODS.load_file('util/menu.lua')()

SMODS.Atlas({
    key = 'modicon',
    path = 'modicon.png',
    px = '34',
    py = '34'
})


-- Config tab stuff to go below