SMODS.Joker {
    key = "remancedream",
        loc_txt= {
        name = 'Remnants of the Dream',
        text = { 
        {    
        "{C:green}#1# in #2# chance{} for each",
        "card held in hand to gain",
        "a random {C:attention}non-negative edition{}",
        "a the end of the round",
        },
        {
        "{C:green}#3# in #4# chance{} for each",
        "discarded card to gain",
        "a random {C:attention}enhancement",
        }
    },},
    atlas = 'sol',
    pos = { x = 1, y = 0 },
    rarity = 3,
    cost = 20,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    
    config = { extra = { numerator = 1, odds = 15, numeratwo = 1, odders = 6}},
    loc_vars = function(self, info_queue, card)
    local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.odds, 'dream')
    local rusty_numerator, rusty_denominator = SMODS.get_probability_vars(card, card.ability.extra.numeratwo, card.ability.extra.odders, 'dreemurr')
return {vars = {new_numerator, new_denominator, rusty_numerator, rusty_denominator}}
    end,
    
    calculate = function(self, card, context)
    
 if context.individual and context.end_of_round and context.cardarea == G.hand and not context.other_card.edition and SMODS.pseudorandom_probability(card, 'cymbal_remancedream', card.ability.extra.numerator, card.ability.extra.odds, 'dream') and not context.retrigger_joker and not context.blueprint then
    context.other_card:set_edition(poll_edition("cymbal_remancedream", nil, true, true))
    end
    
 if context.discard and not context.retrigger_joker and not context.blueprint and not next(SMODS.get_enhancements(context.other_card)) and SMODS.pseudorandom_probability(card, 'cymbal_remancedream', card.ability.extra.numeratwo, card.ability.extra.odders, 'dreemurr') then

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
        test = "Lucky !"
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true
        end
    }))

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
            context.other_card:flip()
            play_sound('card1', 1.0)
            context.other_card:juice_up(0.3, 0.3)
            return true
        end
    }))

    delay(0.2)

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            context.other_card:set_ability(SMODS.poll_enhancement {key = "cymbal_remancedream", guaranteed = true})
            return true
        end
    }))

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
            context.other_card:flip()
            play_sound('tarot2', 1.0, 0.6)
            context.other_card:juice_up(0.3, 0.3)
            return true
        end
    }))

    return {
        message = "Lucky !"
    }
end
end,

    --[[draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
       ]]--
       
}


--[[
    return {
    message = "Lucky !",
        context.other_card:set_ability(SMODS.poll_enhancement {key = "cymbal_remancedream", guaranteed = true})    
    }

   end
   end
   --]]
