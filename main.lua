--- STEAMODDED HEADER
--- MOD_NAME: Ortalab
--- MOD_ID: ortalab
--- PREFIX: ortalab
--- MOD_AUTHOR: [Balatro Discord]
--- MOD_DESCRIPTION: Every action has an opposite reaction. In another world, in the nation of "Virtue", a simple indie developer created Ortalab, which so happened to be the opposite of our world's Balatro. This mod is intended to port everything from that parallel world to Balatro. Within this demo, it includes 75 Jokers, 10 Decks, 7 sets of Coupons, a new Consumable Type with Boosters - Loteria Cards, 8 Enhancements, 4 Editions, 12 patches, and 2 Stakes for you to try out.
--- BADGE_COLOUR: 990000
--- BADGE_TEXT_COLOUR: E28585
--- VERSION: 0.9-demo-2.0.1
--- PRIORITY: -5

Ortalab = SMODS.current_mod
Ortalab.load_table = {
    jokers = true,
    enhancements = true,
    editions = true,
    loteria = true,
    zodiac = true,
    patches = true,
    decks = true,
    coupons = true,
    stakes = true,
    blinds = true,
    curses = true,
    mythos = false
}
loc_colour('red')
G.ARGS.LOC_COLOURS['Ortalab'] = HEX('990000')
for k, v in pairs(Ortalab.load_table) do
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

AltTextures_Utils.default_atlas['Zodiac'] = 'ortalab_zodiac_cards'
AltTextures_Utils.loc_keys['Zodiac'] = 'b_zodiac_cards'

if (SMODS.Mods['Malverk'] or {}).can_load then
    AltTexture({
        key = 'alt_zodiac',
        set = 'Zodiac',
        path = 'zodiac_coloured.png',
        display_pos = 'c_ortalab_zod_virgo',
        loc_txt = {
            name = 'Rainbow Zodiac'
        }
    })

    AltTexture({
        key = 'alt_zodiac_tag',
        set = 'Tag',
        path = 'zodiac_tags_alt.png',
        keys = {
            'tag_ortalab_zod_scorpio',
            'tag_ortalab_zod_aquarius'
        },
        loc_txt = {
            name = 'Rainbow Tags'
        }
    })

    TexturePack{
        key = 'alt_orta',
        textures = {
            'ortalab_alt_zodiac',
            'ortalab_alt_zodiac_tag'
        },
        loc_txt = {
            name = 'Ortalab Alternate Art',
            text = {
                'Alternate art for {C:zodiac}Zodiac',
                'and {C:loteria}Loteria{} cards'
            }
        }
    }
end

-- Config tab stuff to go below