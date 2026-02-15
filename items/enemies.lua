SMODS.Atlas{
  key = 'heg',
    path = 'halfegg.png',
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "heg",
        loc_txt= {
        name = 'Half-Hatched Egg',
        text = { "{C:blue} +35{} Chips",
    },},
    atlas = 'heg',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 1,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {chips = 35}},
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips}  }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
			return {
				message = "+".. card.ability.extra.chips,
				chip_mod = card.ability.extra.chips
			}
        end
    end
}

--wheel_of_fortune
--the reason why 'Oops ! All 6's won't work is because i didn't coded correctly for Balatro to actualy take the chance value as a changable variable, or whatever that means, i consider fixing that in a future update but that's not my priority for now.
--Hey me from when i created the spikedwheel, nu uh
SMODS.Atlas{
  key = 'spiwheel',
    path = 'spikewheel.png',
    px = 69,
    py = 93,
}

SMODS.Joker {
    key = "spiwheel",
        loc_txt= {
        name = 'Spiked Wheel',
        text = { "{C:chips}+#3#{} Chips",
        		"{C:green}#1# in #2#{} chance to create",
        		"{C:tarot,T:c_wheel_of_fortune} The Wheel of Fortune{}"
    },},
    atlas = 'spiwheel',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    
    
    
    config = { extra = {numerator = 1, odds = 5, chips = 100}},
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.c_wheel_of_fortune
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.odds, 'spikedluck')
		return { vars = { new_numerator, new_denominator, card.ability.extra.chips}  }
    end,
      calculate = function(self, card, context)
        if context.joker_main then
            if  SMODS.pseudorandom_probability(card, 'cymbal_solSister', card.ability.extra.numerator, card.ability.extra.odds, 'spikedluck')  and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                SMODS.add_card{
                    set = 'Tarot',
                    key = 'c_wheel_of_fortune',
                    skip_materialize = false,
                }
            end

            return {
	  chips = card.ability.extra.chips
            }
        end
    end
}

-- Lil' Jeri
SMODS.Atlas{
    key = 'jeri',
    path = 'jeri.png',
    px = 69,
    py = 93,
}

SMODS.Joker {
    key = "jeri",
        loc_txt= {
        name = "Lil' Jeri",
        text = {"{X:mult,C:white}x0.35{} Mult after",
    "played hand but gain",
    "{C:money}3${} for the end of round cashout",
    "{C:inactive}(Resets each round){}",
        "{C:inactive}(Currently at{C:money} #1#${}{C:inactive}) "
        },},
    atlas = 'jeri',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {dollar = 0,additional = 3, xmult = 0.35}},
    
    	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollar, card.ability.extra.additional, card.ability.extra.mult}  }
	end,
    
    
    calculate = function(self, card, context)

        if context.joker_main then
    card.ability.extra.dollar = (card.ability.extra.dollar + card.ability.extra.additional)
            return {
                xmult = card.ability.extra.xmult,
                extra = {
                    message = "+3$",
                    color = G.C.MONEY
                    
                }
            }
        end
    end,

    calc_dollar_bonus = function(self, card)
        local result = (card.ability.extra.dollar)
        card.ability.extra.dollar = 0
        return result
    end
}

--Heaven Ward
SMODS.Atlas{
  key = 'regaliahand',
    path = 'HeavenHand.png',
    px = 69,
    py = 93,
}

SMODS.Joker {
    key = "regaliahand",
        loc_txt= {
        name = 'Heaven Ward',
        text = {
            "Gain {C:money}#2#${} when",
            "scoring a {C:attention}High Card{}",
            "Resets when the scoring hand contains a",
            "{C:attention}Straight, Flush, or Full House{}",
            "{C:inactive}(Currently at{} {C:money}#1#${}{C:inactive}){}"
        }
    },
    atlas = 'regaliahand',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    
    config = { extra = {dollar = 0,additional = 1}},
    	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollar, card.ability.extra.additional}  }
	end,
	
    calculate = function(self, card, context)

        if context.before then
        if next(context.poker_hands['Straight']) or next(context.poker_hands['Flush']) or next(context.poker_hands['Full House']) then
	card.ability.extra.dollar = 0
        return {
        message = "Reset..",
        }
	elseif context.scoring_name == "High Card" then
	card.ability.extra.dollar = card.ability.extra.dollar + card.ability.extra.additional
	return {
        dollars = card.ability.extra.dollar
			}
		end
	end
end
}
	
--Worthy Blade

SMODS.Atlas{
    key = 'worthyblade_regalia',
    path = 'WorthyBlade.png',
    px = 69,
    py = 93,
}

SMODS.Joker {
    key = "regalia_worthyblade",
        loc_txt= {
        name = 'Worthy Blade',
        text = { 'If  {C:attention}first discard{} only has {C:attention}1{} card',
        "destroy it and give Mult depending on it's {C:attention}rank{}",
        "{C:inactive} (ex : Ace = 11, K/Q/J = 10, etc..)",
        '{C:inactive}(Currently at {C:mult}#1#{} {C:inactive}Mult){}',
        }
    },
    atlas = 'worthyblade_regalia',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
	config = { extra = { mult = 1, mult_gain = 0 } },
        loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,
    
        calculate = function(self, card, context)
                if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        
            if context.discard and not context.blueprint and G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 and context.full_hand[1]:get_id() >= 1 and context.full_hand[1]:get_id() <= 14  then
                 
            local discarded_card = context.full_hand[1]
            local id = discarded_card:get_id()
            local value = 0

            if id == 14 then
                value = 11 -- Ace
            elseif id >= 11 and id <= 13 then
                value = 10 -- J, Q, K
            elseif id >= 2 and id <= 10 then
                value = id
            end
        
                card.ability.extra.mult_gain  = value
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain 
		card.ability.extra.mult_gain = 0
        return {
            message = "Upgrade!",
            remove = true
        }
    end

    if context.joker_main then
        return {
            mult = card.ability.extra.mult
        }
    end
end
}

--Handmaiden
SMODS.Atlas{
  key = 'Maidenregalia',
    path = 'Handmaiden.png',
    px = 69,
    py = 93,
}

SMODS.Joker {
    key = "regaliamaiden",
        loc_txt= {
        name = 'Handmaiden',
        text = { "{C:spades}Spade{} cards played in a {C:attention}#2#{}",
        "gain {X:mult,C:white}x#1#{} Mult.",
    "Change the poker hand",
    "after end of the round"
        }
    },
    atlas = 'Maidenregalia',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 8,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    
    ---al huge part of this code down there was recopied with nh6574's 'Vanilla Remade' in order to make the change of hands work
    ---Vanilla Remade is really a huge saver tbh
	config = { extra = { xmult = 1.5, poker_hand = 'High Card' } },
        loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, localize(card.ability.extra.poker_hand, 'poker_hands') } }
    end,

    calculate = function(self, card, context)
        if context.scoring_name == card.ability.extra.poker_hand then
            if context.individual and context.cardarea == G.play and context.other_card:is_suit("Spades") then
                return {
                    xmult = card.ability.extra.xmult
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
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed('cymbal_regaliamaiden'))
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
                and 'cymbal_false_regaliamaiden' 
                or 'cymbal_regaliamaiden'
            )
        )
    end,
}

--Living Statue

SMODS.Atlas{
  key = 'statueliving',
    path = 'LivingStatue.png',
    px = 69,
    py = 93,
}


SMODS.Joker {
    key = "statuelviing",
        loc_txt= {
        name = 'Living Satue',
        text = { "{X:mult,C:white}x#1#{} Mult for each",
        "{C:attention}Stone Cards{} played in your hand"
    },},
    atlas = 'statueliving',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    enhancement_gate = "m_stone",
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
        config = { extra = {xmult = 2, chips = 25}},
        loc_vars = function(self, info_queue, card)
       info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return { vars = { card.ability.extra.xmult,card.ability.extra.mult }  }
    end, 
        
    calculate = function(self, card, context)
    if context.individual then
       --[[ if context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_stone") and not context.end_of_round then
            return {
                mult = card.ability.extra.mult
            }
        end ]]

        if context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_stone") then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
end
}

SMODS.Joker {
    key = "statuelviingbutsmol",
        loc_txt= {
        name = 'Little Living Satue',
        text = { "Gain {X:chips,C:white}x#1#{} Chips for each",
        "{C:attention}Stone Cards{} scored",
        "{C:inactive}(Currently at{}{X:chips,C:white}x#2#{} {C:inactive}Chips)"
    },},
    atlas = 'statueliving',
    pos = { x = 0, y = 0 },
    display_size = { w = 69 * 0.5, h = 93 * 0.5 },
    rarity = 3,
    cost = 8,
    enhancement_gate = "m_stone",
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
        config = { extra = {x_chips_gain = 0.25, x_chips = 1}},
        loc_vars = function(self, info_queue, card)
       info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return { vars = { card.ability.extra.x_chips_gain,card.ability.extra.x_chips }  }
    end, 
        
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_stone") then
    card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.x_chips_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
            if context.joker_main then
        return {
        x_chips = card.ability.extra.x_chips
        }
    end
end
}
--Trimask Chandelier
SMODS.Atlas{
  key = 'trichandelier',
    path = 'Chandelier.png',
    px = 69,
    py = 93,
}



SMODS.Joker {
    key = "trichandelier",
        loc_txt= {
        name = 'Trimask Chandelier',
        text = { 
        "Gain {X:mult,C:white}x#2#{} Mult everytime",
        "you play a {C:attention}Three of a Kind{}",
        "{C:inactive}(Currently at {}{X:mult,C:white}x#1#{} {C:inactive}Mult ){}",
        }
    },
    atlas = 'trichandelier',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 7,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
	config = { extra = { xmult = 1, xmult_gain = 0.3 } },
        loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
    end,

    calculate = function(self, card, context)
            if context.before and context.scoring_name == "Three of a Kind" and not context.blueprint then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    message = "Upgrade !",
                }
            end

        if context.joker_main then
            return {
          	xmult = card.ability.extra.xmult
            }
        end
    end
}


