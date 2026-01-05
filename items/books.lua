SMODS.Joker {
    key = "princesbook", --in works
        loc_txt= {
        name = 'The Waiting Princess',
        text = {         "Prevents you to go further",
        "than the {C:attention}winning Ante or higher{}",
        "{C:inactive}(Ex : If winning Ante is 8",
        "{C:inactive}you can't go further than Ante 7){}",
    },},
    atlas = 'locations',
    pos = { x = 1, y = 2 },
    rarity = 3,
    cost = 10,
    pools = {["pseudoregamod"] = true, ["cymbal_books"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    
    config = { extra = {real_ante = 0}},
        loc_vars = function(self, info_queue, card)
		return { vars = { }  }
    end, 
    calculate = function(self, card, context)
if  G.GAME.round_resets.ante == (G.GAME.win_ante-1) then
if context.modify_ante and (context.ante_end or context.end_of_round) and not context.blueprint  then
    return {modify = (G.GAME.win_ante-1)-G.GAME.round_resets.ante, message ="Waiting.." }
end
        end
    end
}

SMODS.Joker {
    key = "cooking_book", --in works
        loc_txt= {
        name = 'Forbbiden Cooking Secrets',
        text = {         "Create a random food Joker",
        "with a {C:attention}guarenteed edition{}",
        "and increase blind's requirement by {X:attention,C:white}+20%{}",
        "at the start of the round",
        "{C:inactive}(Must have room){}",
    },},
    atlas = 'locations',
    pos = { x = 0, y = 2 },
    rarity = 3,
    cost = 10,
    pools = {["pseudoregamod"] = true, ["cymbal_books"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { },
        loc_vars = function(self, info_queue, card)
		return { vars = {  }  }
    end, 
    
       calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
    G.GAME.blind.chips = math.floor(G.GAME.blind.chips * 1.2)
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    if  #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
    local random_edition = poll_edition("modprefix_seed", nil, true, true)

    SMODS.add_card { set = "pr_food", edition = random_edition }
    return {message = "Hot and Ready !"}
    end
    end
    end
    
}

SMODS.Joker {
    key = "aquatic_book", -- in works
    loc_txt = {
        name = 'Aquatic Life',
        text = {
            "{C:green}#2# in #3#{} chance to",
            "when using a {C:planet}Planet{} card,",
            "give a random card in hand a {C:planet}Blue Seal{}",
        }
    },
    atlas = 'locations',
    pos = { x = 1, y = 3 },
    rarity = 2,
    cost = 7,
    pools = { ["pseudoregamod"] = true, ["cymbal_books"] = true },
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {seal = "Blue", numerator = 1, odds = 8,}},
        loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.odds, 'aquaplanet')
		return { vars = { card.ability.extra.seal, new_numerator, new_denominator }  }
    end, 
    
       calculate = function(self, card, context)
    if  context.using_consumeable and context.consumeable.ability.set == 'Planet' and  SMODS.pseudorandom_probability(card, 'cymbal_aquatic_book', card.ability.extra.numerator, card.ability.extra.odds, 'aquaplanet') then

    local no_seal = {}
    for i = 1, #G.hand.cards do
    local c = G.hand.cards[i]
    if c.seal == nil then
        no_seal[#no_seal + 1] = c
     end
    end
        
   if #no_seal > 0 then
    local sealed_card = pseudorandom_element(no_seal, pseudoseed('cymbal_aquatic_book'))
                G.E_MANAGER:add_event(Event({
                func = function()
                play_sound('tarot1')
                sealed_card:juice_up(0.3, 0.5)
                return true
                end
            }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                sealed_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))
    elseif #no_seal == nil then
    return
    end
    end
    end
    
}

SMODS.Joker {
    key = "jester_book", 
        loc_txt= {
        name = 'Jester Book',
        text = {  
            {"Create a {C:attention}Death{} and",
        " a {C:attention}Hanged Man{} after a boss blind",
        "{C:inactive}(Must have room){}",
            },
         --[[  {
        "{C:attention}Destroy{} all {C:hearts}Hearts{} in your deck",
        "if it gets {C:attention}destroyed{}",
            }]] 
    },},
    atlas = 'locations',
    pos = { x = 0, y = 3 },
    rarity = 2,
    cost = 7,
    pools = {["pseudoregamod"] = true, ["cymbal_books"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    
    config = { extra = {}},
        loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_death
        info_queue[#info_queue+1] = G.P_CENTERS.c_hanged_man
		return { vars = {  }  }
    end, 
    
       calculate = function(self, card, context)
 if context.end_of_round and (G.GAME.blind.boss) and context.main_eval and not context.blueprint then
if  #G.consumeables.cards + G.GAME.consumeable_buffer <= G.consumeables.config.card_limit - 2 then
 SMODS.add_card{ set = 'Tarot',key = 'c_death', skip_materialize = false,}
  SMODS.add_card{ set = 'Tarot',key = 'c_hanged_man', skip_materialize = false,}
 elseif #G.consumeables.cards + G.GAME.consumeable_buffer <= G.consumeables.config.card_limit - 1 then
    local choices = { 'c_death', 'c_hanged_man' }
    local pick = choices[math.random(#choices)]

    SMODS.add_card{ set = 'Tarot', key = pick }
 	return { message = "Wonderful !"}
    end
end
    end,

    --[[
remove_from_deck = function(self, card, from_debuff)
  if not G.CONTROLLER.locks.selling_card  then
    local hearts = {}
    for k, v in pairs(G.deck.cards) do
        if v:is_suit('Hearts') then
            hearts[#hearts+1] = v
        end
    end
    for k, v in pairs(G.hand.cards) do
        if v:is_suit('Hearts') then
            hearts[#hearts+1] = v
        end
    end
    SMODS.destroy_cards(hearts, nil, nil, true)
        return {
            message = "Adieu !"} 
end
end,
 ]]   
}

SMODS.Joker {
    key = "reading_book", 
        loc_txt= {
        name = 'A book about reading',
        text = {         "Change the blind's chips requirement between",
        "{X:attention,C:white}-70%{} and {X:attention,C:white}+100%{}",
    },},
    atlas = 'locations',
    pos = { x = 3, y = 3 },
    rarity = 1,
    cost = 3,
    pools = {["pseudoregamod"] = true, ["cymbal_books"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {min = 0.3, max = 2, blind_requirement}},
        loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.min, card.ability.extra.max, card.ability.extra.blind_requirement }  }
    end, 
    
       calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
    card.ability.extra.blind_requirement = pseudorandom('cymbal_reading_book', card.ability.extra.min, card.ability.extra.max)
    G.GAME.blind.chips = math.floor(G.GAME.blind.chips*card.ability.extra.blind_requirement)
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
 	return { message = "Re-Requirement !"}
    end
    end
    
}

SMODS.Joker {
    key = "little_thimble", 
        loc_txt= {
        name = "Little thimble's Big adventure", 
        text = {
            "At the end of round",
            "gain {C:chips}+#2#{} Chips.",
            "Bonus increase by {C:attention}Ante level{}",
            " {C:inactive}(Currently at{} {C:chips}+#1#{} {C:inactive}Chips{}",
    },},
    atlas = 'locations',
    pos = { x = 2, y = 2 },
    display_size = { w = 71 * 0.6, h = 95 * 0.6 },
    rarity = 1,
    cost = 4,
    pools = {["pseudoregamod"] = true, ["cymbal_books"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {chips = 0, bonus = 5, current_ante =  1}},
        loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.bonus, card.ability.extra.current_ante }  }
    end, 
    
       calculate = function(self, card, context)
    if context.joker_main then 
    return {chips = card.ability.extra.chips}
    end
    
    if context.end_of_round and context.main_eval and not context.blueprint then
    card.ability.extra.current_ante = G.GAME.round_resets.ante 
    card.ability.extra.chips  = card.ability.extra.chips + card.ability.extra.bonus
    card.ability.extra.bonus  = 5 * card.ability.extra.current_ante
    return { message = localize('k_upgrade_ex') }
    end
    end
    
}


SMODS.Joker {
    key = "deal_with_loss", --in works
        loc_txt= {
        name = "Dealing with Loss", 
        text = {
            "If your {C:attention}last hand{}",
            " doesn't win this round",
            "destroy this Joker and",
            "{C:attention}halve{} the blind’s score requirement"
    },},
    atlas = 'locations',
    pos = { x = 2, y = 3 },
    rarity = 3,
    cost = 7,
    pools = {["pseudoregamod"] = true, ["cymbal_books"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    
    config = { extra = {}},
        loc_vars = function(self, info_queue, card)
		return { vars = { }  }
    end, 
    
       calculate = function(self, card, context)
   if context.after and not context.bleuprint and G.GAME.current_round.hands_left == 0 and G.GAME.blind.chips > G.GAME.chips then
    SMODS.destroy_cards(card, nil, nil, true)
       G.GAME.blind.chips = G.GAME.blind.chips/2
   G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
    end
    
}
-- For Musical Theory
local oldenegativegetweight = G.P_CENTERS.e_negative.get_weight
SMODS.Edition:take_ownership('e_negative', {
    get_weight = function(self)
        local weight = oldenegativegetweight(self)
        for k, v in pairs(SMODS.find_card('j_cymbal_mus_theory')) do
            weight = weight * v.ability.negative_rate
        end
        return weight
    end
}, true)

SMODS.Joker {
    key = "mus_theory", 
        loc_txt= {
        name = "Musical Theory", 
        text = {
            "{C:dark_edition}Negative{} Jokers appear",
            "{C:attention}#1#X{} more often,",
            "{C:attention}X#2#{} required chips",
            "for boss blinds",

    },},
    atlas = 'locations',
    pos = { x = 1, y = 4 },
    rarity = 3,
    cost = 10,
    pools = {["pseudoregamod"] = true, ["cymbal_books"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { negative_rate = 10, extra = {boss_scale = 2 }},
        loc_vars = function(self, info_queue, card)
		return {  vars = {self.config.negative_rate,card.ability.extra.boss_scale  }  }
    end, 
    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.blind.boss and context.main_eval then
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.boss_scale
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		        G.hand_text_area.blind_chips:juice_up()
                return true
            end
        }))
        end
    end,
}   

    --[[  --old musical theory way to work, since the one up ahead is easier (smh i struggle with simple take_ownership code)

    add_to_deck = function(self, card, from_debuff)
    		G.GAME.modifiers.cymbal_negative_rate = self.config.negative_rate
		SMODS.Edition:take_ownership("negative", {
			get_weight = function(self)
				return self.weight * (G.GAME.modifiers.cymbal_negative_rate or 1)
			end,
		}, true)
      end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.modifiers.cymbal_negative_rate = self.config.negative_rate
		SMODS.Edition:take_ownership("negative", {
			get_weight = function(self)
				return self.weight / (G.GAME.modifiers.cymbal_negative_rate or 1)
			end,
		}, true)
      end,
      ]]
    



SMODS.Joker {
    key = "revenge_book",
        loc_txt= {
        name = 'Revengeful Book',
    text = {
        "Gives {X:mult,C:white}X#1#{} Mult",
        "during a {C:attention}Boss Blind{},",
        "gain {X:mult,C:white}X#2#{} Mult",
        "by {C:attention}destroyed{} cards"
    },},
    atlas = 'locations',
    pos = { x = 3, y = 2 },
    rarity = 3,
    cost = 8,
    pools = {["pseudoregamod"] = true, ["cymbal_books"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {xmult = 1, xmult_gain = 0.15}},
        loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain }  }
    end, 
    
       calculate = function(self, card, context)
 if context.joker_main  and G.GAME.blind.boss then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
            
    if context.remove_playing_cards and not context.blueprint then
        local venge_cards = 0
        for _, removed_card in ipairs(context.removed) do
            venge_cards = venge_cards + 1
        end

        card.ability.extra.xmult = card.ability.extra.xmult + venge_cards * card.ability.extra.xmult_gain
        return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
    end
end

    
}

local dessert    = {"j_ice_cream", "j_cavendish", "j_gros_michel"}
local appetitizer = {"j_turtle_bean", "j_egg"}
local meal       = {"j_popcorn", "j_ramen"}
local drink      = {"j_selzer", "j_diet_cola"}

SMODS.Joker {
    key = "restaurant_book",
        loc_txt= {
        name = 'Restaurant Book',
    text = {
        "Sell this joker for {C:money}-25${}",
        "to get a {C:dark_edition}Negative Menu{}",
    },},
    atlas = 'locations',
    pos = { x = 0, y = 4 },
    rarity = 2,
    cost = -1,
    pools = {["pseudoregamod"] = true, ["cymbal_books"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {}},
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = { key = "negative_menu_desc", set = "Other", specific_vars = { aaa, bbb } }
		return { vars = { }  }
    end, 
    
       calculate = function(self, card, context)
        if context.selling_self then    
            local beforefood = pseudorandom_element(appetitizer, "cymbal_restaurant_book")
            local mainfood = pseudorandom_element(meal, "cymbal_restaurant_book")
            local sidefood = pseudorandom_element(drink, "cymbal_restaurant_book")
            local finafood = pseudorandom_element(dessert, "cymbal_restaurant_book")
            SMODS.add_card { set = "Joker", key = beforefood, edition = "e_negative", skip_materialize = false }
            SMODS.add_card { set = "Joker", key = mainfood, edition = "e_negative",   skip_materialize = false }
            SMODS.add_card { set = "Joker", key = sidefood, edition = "e_negative",   skip_materialize = false }
            SMODS.add_card { set = "Joker", key = finafood, edition = "e_negative",   skip_materialize = false }
            
        end

end,

    add_to_deck = function(self, card, from_debuff)
    card.ability.extra_value = (-card.sell_cost) + (-25)
    card:set_cost()
    end
    
}

