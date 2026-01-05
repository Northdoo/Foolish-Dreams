
--OPTIONAL PANTS

SMODS.Atlas{
    key = 'optionalpants',
    path = 'op_pants.png',
    px = 71,
    py = 95,
}

SMODS.Atlas{
    key = 'attires',
    path = 'attires.png',
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "optional_pants",
        loc_txt= {
        name = '(Optional) Big Pants',
        text = { 
        '{C:chips}+#1#{} Chips',
        '{C:chips}-20{} Chips for each {C:attention}discard{}',
        'left at the end of the round',
        '{C:inactive}(Does not destroy itself once at 0 Chips){}'
        }
    },
    atlas = 'optionalpants',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 3,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
	config = { extra = { chips = 200, additional = 20 } },
        loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.additional } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end

    
    if context.end_of_round and context.game_over == false and not G.GAME.current_round.discards_left ~= 0  and not context.blueprint then
        local Chippy = card.ability.extra.chips - (card.ability.extra.additional * G.GAME.current_round.discards_left)
        if Chippy > 0 then  -- Only subtract if result stays above 0
            card.ability.extra.chips = card.ability.extra.chips - (card.ability.extra.additional * G.GAME.current_round.discards_left)
                        return {
            message = "Chips lost !",
            colour = G.C.CHIPS
            }
    else
        card.ability.extra.chips = 0
        return {
        message = "Emptied Pockets !",
        colour = G.C.CHIPS
        }
    end
    end
 end

}

--PROFESSIONAL

SMODS.Joker {
    key = "regalia_pro",
        loc_txt= {
        name = 'Professional',
    	text = {
        "{C:chips}+#1#{} chips and {C:mult}+#2#{} mult",
        "When at least {C:attention}1{} discard and {C:attention}1{} hand left at the end of the round",
        "gain {C:mult}+1{} mult by each discard left",
        "gain {C:chips}+10{} chips by each hand left"
    }
},
    --atlas = 'Maidenregalia',
    atlas = 'attires',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    	config = { extra = { chips = 40, mult = 3, mult_gain = 1, additional = 10} },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.additional }  }
    end,

    calculate = function(self, card, context)

        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end

 if context.end_of_round and context.main_eval and not context.blueprint then
     if G.GAME.current_round.discards_left > 0 and G.GAME.current_round.hands_left > 0 then
         card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_gain * G.GAME.current_round.discards_left)
         card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.additional * G.GAME.current_round.hands_left)
         return {
         message = 'Upgrade!'
         --colour = G.C.PURPLE
         }
    end
 end
end
}


SMODS.Joker {
    key = "regalia_solider",
        loc_txt= {
        name = 'Solider',
    	text = {
        "First played hand {C:attention}rank up{}",
        "{C:attention}by 1{} all scored cards"
    }
},
    --atlas = 'Maidenregalia',
    atlas = 'attires',
    pos = { x = 2, y = 0 },
    rarity = 2,
    cost = 6,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    	config = { extra = { h_size = - 3 } },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.h_size }  }
    end,
    
    calculate = function(self, card, context)
    
      if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
    
    if context.joker_main and not context.blueprint then
    if  G.GAME.current_round.hands_played == 0  then
    --[[ context.cardarea == G.play and context.other_card == context.scoring_hand[1] and  not (context.other_card:get_id() == 14)and  --]] 
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
            	text = "Rank Up!"
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        for i = 1, #context.scoring_hand do
            local percent = 1.15 - (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    context.scoring_hand[i]:flip()
                    play_sound('card1', percent)
                    context.scoring_hand[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end

        delay(0.2)

        for i = 1, #context.scoring_hand do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    assert(SMODS.modify_rank(context.scoring_hand[i], 1))
                    return true
                end
            }))
        end

    
    for i = 1, #context.scoring_hand do
        local percent = 0.85 + (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                context.scoring_hand[i]:flip()
                play_sound('tarot2', percent, 0.6)
                context.scoring_hand[i]:juice_up(0.3, 0.3)
                return true
            end
        }))
        
        delay(0.2)
    end
    end
    end
end,
}
--GUARDIAN

SMODS.Joker {
    key = "regalia_guardian",
        loc_txt= {
        name = 'Guardian',
    	text = {
        "{C:mult}+#2#{} mult",
        "{C:mult}-#3#{} mult whenever a card is a destroyed"
    }
},
    --atlas = 'Maidenregalia',
    atlas = 'attires',
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 6,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    	config = { extra = { chips = 20, mult = 100, mult_loss = 10} },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.mult_loss }  }
    end,
    
    calculate = function(self, card, context)
        
    if context.joker_main then
    return {
    mult = card.ability.extra.mult
    }
    end
    
    if context.remove_playing_cards  and not context.blueprint then
    if card.ability.extra.mult - card.ability.extra.mult_loss < 0 or card.ability.extra.mult - card.ability.extra.mult_loss == 0 then
                G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                blockable = false,
                func = function()
                    card:start_dissolve()
                    return true
                end
            }))
            return {
                message = "Eliminated.",
                colour = G.C.FILTER
            }
     else
     card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_loss
     return {
     message =  localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_loss}},
     colour = G.C.MULT
                }
            end
        end
    end
}
    
    
        

--SOL SISTER

SMODS.Joker {
    key = "solSister",
        loc_txt= {
        name = 'Sol Sister',
    	text = {
        "{C:green}#1# in #2# chance{} to prevent death",
        "Used {C:tarot}Tarot{} Cards increase  the chance by {C:green}#4#{}",
        "Used {C:spectral}Spectral{} Cards increase  the chance by {C:green}#5#{}",
        "Resets once it has been {C:attention}triggered{}"
    }
},
    --atlas = 'Maidenregalia',
    atlas = 'attires',
    pos = { x = 1, y = 1 },
    rarity = 2,
    cost = 6,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    	config = { extra = { numerator = 0, odds = 70, praylucktarot = 2, prayluckspectral = 5} },

    loc_vars = function(self, info_queue, card)
    local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.odds, 'luckpray')
return {vars = {new_numerator, new_denominator, other_value, card.ability.extra.praylucktarot, card.ability.extra.prayluckspectral}}

    end,

    calculate = function(self, card, context)
 	if context.using_consumeable  and not context.blueprint then
 	if context.consumeable.ability.set == "Tarot" then
	card.ability.extra.numerator  = card.ability.extra.numerator+ card.ability.extra.praylucktarot
	elseif context.consumeable.ability.set == "Spectral" then
	card.ability.extra.numerator  = card.ability.extra.numerator + card.ability.extra.prayluckspectral
        end
        end
        
        if context.end_of_round and context.game_over and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'cymbal_solSister', card.ability.extra.numerator, card.ability.extra.odds, 'luckpray')  then
            card.ability.extra.numerator  = card.ability.extra.numerator * 0
                return {
                    message = "Prayers answered.",
                    saved = 'j_cymbal_solSister'
                }
            end
        end
    end
}

--[[
        return { vars = { G.GAME and (G.GAME.probabilities.normal + card.ability.extra.prayluck or 1 + card.ability.extra.prayluck), card.ability.extra.odds } }
        --]]

--[[
    calculate = function(self, card, context)
 	if context.using_consumeable and not context.blueprint then
 	if context.consumeable.ability.set == "Tarot" then
	card.ability.extra.prayluck = card.ability.extra.prayluck + 1
	elseif context.consumeable.ability.set == "Spectral" then
	card.ability.extra.prayluck = card.ability.extra.prayluck + 2
        end
        end
        
        if context.end_of_round and context.game_over and context.main_eval and not context.blueprint then
            if pseudorandom('cymbal_solSister') < (G.GAME.probabilities.normal + card.ability.extra.prayluck) / card.ability.extra.odds then
            card.ability.extra.prayluck = 0
                return {
                    message = "Prayers answered.",
                    saved = 'j_cymbal_solSister'
                    --]]
--CLASSY

SMODS.Joker {
    key = "classy",
        loc_txt= {
        name = 'Classy',
        text = { " {C:chips}#4#{} Chips and {C:mult}#1#{} Mult",
        "Gain {C:mult}+5 mult{}",
        "When you play a {C:attention}#2#{}",
        "And {C:chips}+5{} Chip by played cards afterwards",
        "Change the poker hand",
        "after the end of round."
        }
    },
    atlas = 'attires',
    pos = { x = 0, y = 1 },
    rarity = 2,
    cost = 7,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
	config = { extra = { mult = 0, poker_hand = 'High Card', mult_gain = 5, chips = 0, additional = 5, encore = 0 } },
        loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, localize(card.ability.extra.poker_hand, 'poker_hands'), card.ability.extra.mult_gain, card.ability.extra.chips, card.ability.extra.additional, card.ability.extra.encore } }
    end,

    calculate = function(self, card, context)
    
    if context.joker_main then
    return {
    chips = card.ability.extra.chips,
    extra = {
    mult = card.ability.extra.mult
     }
    }
    end
    
    	if context.before then
        if context.scoring_name == card.ability.extra.poker_hand and not context.blueprint then
        card.ability.extra.mult = card.ability.extra.mult +card.ability.extra.mult_gain
        card.ability.extra.encore = 1
        return {
        message = "+5",
        colour = G.C.MULT
	}
	end
	end
	
	
        if context.individual and context.cardarea == G.play then
        if card.ability.extra.encore == 1 then
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.additional
                return {
                  	  message = "+5",
                  	  colour = G.C.CHIPS
                  }
        end
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible and k ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = k
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed('cymbal_classy'))
            card.ability.extra.encore = 0
            return {
                message = "New Hand !"
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.visible and k ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = k
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(
            _poker_hands,
            pseudoseed(
                (card.area and card.area.config.type == 'title') 
                and 'cymbal_false_classy' 
                or 'cymbal_classy'
            )
        )
    end,
}


--XIX
SMODS.Joker {
    key = "xix_pseudoregalia",
        loc_txt= {
        name = 'XIX',
    	text = {
        "When hand scored has exactly two",
        "{C:attention}10s{} and one {C:attention}Ace{}",
        "destroy itself and {C:attention}-1{} Ante"
    }
},
    atlas = 'attires',
    pos = { x = 3, y = 1 },
    rarity = 3,
    cost = 9,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    
    	config = { extra = { } },
        loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    
    
    calculate = function(self, card, context)

    if context.cardarea == G.jokers and context.before then
        if ((function()
            local rankCount = 0
            for i, c in ipairs(context.scoring_hand) do
                if c:get_id() == 10 then
                    rankCount = rankCount + 1
                end
            end
            return rankCount == 2
        end)()) and ((function()
            local rankCount = 0
            for i, c in ipairs(context.scoring_hand) do
                if c:get_id() == 14 then
                    rankCount = rankCount + 1
                end
            end
            return rankCount == 1
        end)()) then
            return {
                func = function()
                    card:start_dissolve()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Vanished."})
                    ease_ante(-1)

                    return true
                end,
            }
        end
    end
end
}



--SLEEPYTIME
SMODS.Joker {
    key = "sleepysybil",
        loc_txt= {
        name = 'Sleepytime',
        text = { "{C:attention}Halves{} the current blind's score requirement",
        "after {C:attention}#2#{} rounds",
        "{C:inactive}(Currently {}{C:attention}#1#{}{C:inactive}/#2#)"
        }
    },
    atlas = 'attires',
    pos = { x = 2, y = 1 },
    rarity = 2,
    cost = 5,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    	config = { extra = { current_round = 0, total_rounds = 3, round_max = 8 } },
        loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.current_round, card.ability.extra.total_rounds,card.ability.extra.round_max } }
    end,

    calculate = function(self, card, context)
    
    if context.setting_blind then
    if card.ability.extra.current_round == card.ability.extra.total_rounds then
    G.GAME.blind.chips = G.GAME.blind.chips/2
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    return {
    message = "Well rested !"
    }
    end
    end
    
if context.end_of_round and context.game_over == false and not context.blueprint then
if card.ability.extra.current_round == card.ability.extra.total_rounds and card.ability.extra.total_rounds ~= card.ability.extra.round_max then

        card.ability.extra.current_round = 0
        card.ability.extra.total_rounds = card.ability.extra.total_rounds + 1
	return {
    	message = localize('k_reset') .. "..?"
	}

    elseif card.ability.extra.current_round == card.ability.extra.total_rounds and card.ability.extra.total_rounds == card.ability.extra.round_max then
        card.ability.extra.current_round = 0
        return {
            message = localize('k_reset')
        }

    else
        card.ability.extra.current_round = card.ability.extra.current_round + 1
    end
end
end
}
    
--BLEEDNG HEART
SMODS.Joker {
    key = "bleedingheart",
        loc_txt= {
        name = 'Bleeding Heart',
        text = { "{C:white,X:mult}X#1#{} Mult",
        "loses {C:white,X:mult}X0.25{} Mult",
        "by each {C:hearts}Hearts{} card discarded"
        }
    },
    atlas = 'attires',
    pos = { x = 3, y = 0 },
    rarity = 3,
    cost = 7,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    	config = { extra = { xmult = 10, xmult_loss = 0.25 } },
        loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_loss } }
    end,

    calculate = function(self, card, context)
     if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end

        -- Heart scoring
        if context.before and (card.ability.extra.xmult - card.ability.extra.xmult_loss) <= 1 and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                blockable = false,
                func = function()
                    card:start_dissolve()
                    return true
                end
            }))
            return {
                message = "Heart Emptied.",
                colour = G.C.FILTER
            }
        end

        -- On Heart card score
        if context.discard and context.other_card:is_suit("Hearts") and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_loss
            return {
                message = "-0.25",
                colour = G.C.MULT
            }
        end
    end
}

