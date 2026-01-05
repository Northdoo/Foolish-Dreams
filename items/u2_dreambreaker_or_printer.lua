--MERGE FUNCTION
local function merge_effect(...)
    local t = {}
    for _, v in ipairs({...}) do
        for _, vv in ipairs(v) do
            table.insert(t, vv)
        end
    end
    local ret = table.remove(t, 1)
    local current = ret
    for _, eff in ipairs(t) do
        assert(type(eff) == 'table', ("\"%s\" is not a table."):format(tostring(eff)))
        while current.extra ~= nil do
            if current.extra == true then
                current.extra = { remove = true }
            end
            assert(type(current.extra) == 'table', ("\"%s\" is not a table."):format(tostring(current.extra)))
            current = current.extra
        end
        current.extra = eff
    end
    return ret
end
 
--drimprint stuff (the stupid blue)
    
local stupidblue = function(card, other_joker, context)
    if pseudorandom('cymbal_dprinter') < G.GAME.probabilities.normal / card.ability.extra.odds then
        local blue1 = SMODS.blueprint_effect(card, other_joker, context)
        local blue2 = SMODS.blueprint_effect(card, other_joker, context)

        return merge_effect({blue1}, {blue2})
    end
    -- returns nil if condition fails
end
    

-- Dream Breaker
SMODS.Atlas{
    key = 'dbreaker',
    path = 'dreambreaker.png',
    px = 69,
    py = 93,
}

SMODS.Joker {
    key = "dbreaker",
        loc_txt= {
        name = 'Dream Breaker',
        text = { "{X:mult,C:white}X#1#{} when there's",
        "{C:attention}3{} hands and",
        "{C:attention}3{} discard left or less"
    },},
    atlas = 'dbreaker',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 15,
    pools = {["pseudoregamod"] = true},
    
            unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = {extra = { xmult = 15}},
    loc_vars = function(self,info_queue,card)
    info_queue[#info_queue+1] = { key = "showman_proof", set = "Other", specific_vars = { aaa, bbb } }
        return {vars = {card.ability.extra.xmult}}
    end,

    in_pool = function() 
    return  not next(SMODS.find_card("j_cymbal_dbreaker")) 
    end,

calculate = function(self, card, context)
    if context.joker_main and G.GAME.current_round.hands_left <= 3  and G.GAME.current_round.discards_left <= 3 then
            return {
        xmult = card.ability.extra.xmult
        }
    end
end

    }



    -- Dream Printer
SMODS.Atlas{
    key = 'dprinter',
    path = 'dreamprint.png',
    px = 69,
    py = 93,
}

SMODS.Joker {
    key = "dprinter",
        loc_txt= {
        name = 'Dream Printer',
        text = { "Copy the abbilities of the joker on the {C:attention}right",
        "{C:green}#1# in #2# Chances{} to trigger it 2 more times",
        "{C:inactive} (How can this exist ?)"
    },},
    atlas = 'dprinter',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 15,
    pools = {["pseudoregamod"] = true},
    
        unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    
    config = { extra = { odds = 3}},
    
    --return { vars = { center.ability.extra.mainodds, center.ability.extra.totalodds}  }
    
    

    loc_vars = function(self, info_queue, card)
        
--from vanillaremade's blueprint recration
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds }, main_end = main_end }
          end
    return { vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds }}
    end,
--gotta re-add the function of before

    calculate = function(self, card, context)
        local other_joker
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card and G.jokers.cards[i + 1] then
                other_joker = G.jokers.cards[i + 1]
            end
        end
        
    if other_joker then
        local defaultblue = SMODS.blueprint_effect(card, other_joker, context)
        local stupidblue_effect = stupidblue(card, other_joker, context)
        return merge_effect({defaultblue}, {stupidblue_effect}) --merge_effect isn't a real thing, look up the local merge effect
    end
end
}




