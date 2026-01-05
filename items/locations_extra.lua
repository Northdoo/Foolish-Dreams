SMODS.Joker {
    key = "voidball",
    
        loc_txt= {
        name = 'Black Hole',
        text = { "Retrigger  all {C:attention}cards{}",
        "{C:green}#1# in #2#{} chance  for scoring cards",
        " to get {C:attention}destroyed{} after scoring",
    },},
    
    atlas = 'locations', 
    pos = { x = 4, y = 0 },
    rarity = 2,
    cost = 4,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    	config = {
		extra = { numerator = 1, odds = 6,retriggers = 1}},
    loc_vars = function(self, info_queue, card)
    local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.odds, 'voidball')
        return { vars = { new_numerator, new_denominator, card.ability.extra.retriggers } }
    end,

    calculate = function(self, card, context)

            if context.repetition and context.cardarea == G.play then
		   return {
                        message = localize("k_again_ex"),
                        repetitions = card.ability.extra.retriggers or 1,
                    }
		end
		
       
		if context.destroying_card and not context.blueprint and  SMODS.pseudorandom_probability(card, 'cymbal_voidball', card.ability.extra.numerator, card.ability.extra.odds, 'voidball')  then
		if context.cardarea == G.play then
		return {remove = true}
		
		end
        end
    end
}			
                --if context.other_card == G.jokers.cards[i] then
        --for i = 1, #G.jokers.cards do
                --end
            --end

SMODS.Joker {
    key = "bubble",
    
        loc_txt= {
        name = 'Bubble',
        text = { 
            "{C:attention}#1#%{} blind reduction when card is sold",
         "increases by {C:attention}#2#%{} each skipped blind",
        "self destructs and apply",
        "the reduction at {C:attention}#3#%{} or above",
    },},
    
    atlas = 'locations', 
    pos = { x = 4, y = 2 },
    rarity = 2,
    cost = 6,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    
    	config = { extra = {reduction_skip = 0, reduction_skiped = 5, reduction_max = 25 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.reduction_skip, card.ability.extra.reduction_skiped, card.ability.extra.reduction_max }}
    end,

    calculate = function(self, card, context)
    if context.skip_blind and not context.blueprint  then
    card.ability.extra.reduction_skip = card.ability.extra.reduction_skip + card.ability.extra.reduction_skiped
    return {
        message = "+".. card.ability.extra.reduction_skiped .. "%"
    }
    end

    if context.selling_self and not context.blueprint then
            G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.blind.chips =  G.GAME.blind.chips * ((100 - card.ability.extra.reduction_skip) / 100)
              G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		       G.hand_text_area.blind_chips:juice_up()
                return true
            end
        }))
    end

    if card.ability.extra.reduction_skip == card.ability.extra.reduction_max and context.setting_blind and not context.blueprint  then
                G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.blind.chips =  G.GAME.blind.chips * ((100 - card.ability.extra.reduction_skip) / 100)
              G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		       G.hand_text_area.blind_chips:juice_up()
               SMODS.destroy_cards(card, nil, nil, true)
                return true
            end
        }))
    end    
    end
}	       
            

SMODS.Joker {
    key = "untextured",
    --[[
        loc_txt= {
        name = 'U.. extu  ..d J.k. r',
        text = { "{C:inactive} (Does something different each round..)",
    },},
    ]]
    
    atlas = 'locations',
    pos = { x = 4, y = 1 },
    rarity = 3,
    cost = 1,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    config = { extra = {numerator = 1, odds = 10, mult = 20, chips=100, xmult = 3, dollar= 5, dollars = 20, min = 1, max = 4, set_value = 0 }},
    
    loc_vars = function(self, info_queue, card)
		return {vars = { card.ability.extra.dollars }, 
		key = card.ability.extra.set_value == 2 and self.key.."_alt" or card.ability.extra.set_value == 1 and self.key.."_alt2"or card.ability.extra.set_value == 3 and self.key.."_alt3" or card.ability.extra.set_value == 4 and self.key.."_alt4" or self.key}
    end,
    
    calculate = function(self, card, context)
    
    if context.setting_blind then
    card.ability.extra.set_value = pseudorandom('cymbal_untextured', card.ability.extra.min, card.ability.extra.max)
    return {
    message = "New Effect .",
    color = G.C.DARK_EDTION
    }
    end
    
    
if context.joker_main then
    if card.ability.extra.set_value == 1 then
        return {
            mult = card.ability.extra.mult
        }
    elseif card.ability.extra.set_value == 2 then
        return {
            chips = card.ability.extra.chips
        }
    elseif card.ability.extra.set_value == 3 then
        return {
            xmult = card.ability.extra.xmult
        }
    end
end

if context.ending_shop then
card.ability.extra.set_value = 0
end

if context.main_eval and card.edition then
card:set_edition(nil)
     return {
            dollars = card.ability.extra.dollar,
        }
 end
end,

    calc_dollar_bonus = function(self, card)
        if card.ability.extra.set_value == 4 then
            return card.ability.extra.dollars
        end
    end,
}
