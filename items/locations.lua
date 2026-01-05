SMODS.Atlas{
    key = 'locations',
    path = 'locations.png',
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "dilated_dungon",
        loc_txt= {
        name = 'Dilapidated Dungeon',
        text = { 
        '{C:attention}Non-Scorring{} played cards gives {C:chips}+#2#{} Chips',
        '{C:inactive}(Currently at {}{C:chips}+#1#{} {C:inactive}Chips){}'
        }
    },
    atlas = 'locations',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 3,
    pools = {["pseudoregamod"] = true,["pr_locations"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {chips = 0, additional = 7}},
        loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.chips,  card.ability.extra.additional } }
    end,

    calculate = function(self, card, context)
    if context.joker_main then
                    return {
                    chips = card.ability.extra.chips
                }
            end
            
        if context.cardarea == "unscored" or  context.cardarea == "debuffed" and context.main_scoring and not context.blueprint then
         if context.individual then
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.additional
            return {
                message = "Upgrade!"
            }
        end
        end
        end
}

--Castle Sansa

--[[        'give either {C:spades}The World{}, {C:clubs}The Moon{},',
         '{C:diamonds}The Star{} or {C:hearts}The Sun{}',
        'depending on what {C:attention}suit{} you played',
        'the most in the last round',
        ]]
SMODS.Joker {
    key = "castle_sansa",
        loc_txt= {
        name = 'Castle Sansa',
        text = { 
        'At the end of the shop',
        "give the {C:attention}suit's tarot",
        "of the most played suit last round",
        '{C:inactive}(Does not need room){}',
        }
    },
    atlas = 'locations',
    pos = { x = 1, y = 0 },
    rarity = 1,
    cost = 8,
    pools = {["pseudoregamod"] = true,["pr_locations"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {hearts = 0, spades = 0, clubs = 0, diamonds = 0, highest = 0}},
        loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_world
        info_queue[#info_queue+1] = G.P_CENTERS.c_moon
        info_queue[#info_queue+1] = G.P_CENTERS.c_star
        info_queue[#info_queue+1] = G.P_CENTERS.c_sun
        return { vars = { card.ability.extra.hearts, card.ability.extra.spades, card.ability.extra.clubs, card.ability.extra.diamonds, card.ability.extra.highest } }
    end,

    calculate = function(self, card, context)
    
    if context.setting_blind and not context.blueprint then
    card.ability.extra.hearts = 0
    card.ability.extra.spades = 0
    card.ability.extra.clubs = 0
    card.ability.extra.diamonds = 0
    card.ability.extra.highest = 0
     return { message = localize("k_reset")}
    end
    
    if context.individual  and context.cardarea == G.play and not context.blueprint  then 
    if context.other_card:is_suit("Hearts") then
    card.ability.extra.hearts = card.ability.extra.hearts + 1
    elseif context.other_card:is_suit("Spades") then
    card.ability.extra.spades = card.ability.extra.spades + 1
    elseif context.other_card:is_suit("Clubs") then
    card.ability.extra.clubs = card.ability.extra.clubs + 1
    elseif context.other_card:is_suit("Diamonds") then
    card.ability.extra.diamonds = card.ability.extra.diamonds + 1
            end
        end
   
    local h, s, c, d = card.ability.extra.hearts, card.ability.extra.spades, card.ability.extra.clubs, card.ability.extra.diamonds
       
    if context.end_of_round and not context.blueprint  then  
	if h > s and h > c and h > d then card.ability.extra.highest = 1
	elseif c > h and c > s and c > d then card.ability.extra.highest  = 2
	elseif s > h and s > c and s > d then card.ability.extra.highest  = 3
	elseif d > h and d > s and d > c then card.ability.extra.highest  = 4
    end
end
   
if context.ending_shop  then
    if card.ability.extra.highest  == 1 then
     SMODS.add_card{ set = 'Tarot',key = 'c_sun', skip_materialize = false,}
        return { message = "Heart", colour = G.C.SUITS.Hearts	 }
    elseif card.ability.extra.highest  == 2 then
    SMODS.add_card{ set = 'Tarot',key = 'c_moon', skip_materialize = false,}
        return { message = "Club",colour = G.C.SUITS.Clubs  }
    elseif card.ability.extra.highest  == 3 then
     SMODS.add_card{ set = 'Tarot',key = 'c_world', skip_materialize = false,}
        return { message = "Spade", colour = G.C.SUITS.Spades }
    elseif card.ability.extra.highest  == 4 then
    SMODS.add_card{ set = 'Tarot',key = 'c_star', skip_materialize = false,}
        return { message = "Diamond", colour = G.C.SUITS.Diamonds }
    		end
	end
  end
}

--the underbelly
SMODS.Joker {
    key = "underbelly",
        loc_txt= {
        name = 'The Underbelly',
        text = { 
	"{C:green}#1# in #2#{} chance for each card of your deck to be enhanced",
	"into a {C:tarot}hazed card{} at the start of the round",
	"Gain {X:enhanced,C:white}X#4#{} Chips and Mult by Hazed Card in your deck",
	"{C:inactive}(Currently at {X:chips,C:white}X#3#{} Chips and {X:mult,C:white}X#3#{} Mult){}",
        }
    },
    atlas = 'locations',
    pos = { x = 1, y = 1 },
    rarity = 3,
    cost = 7,
    pools = {["pseudoregamod"] = true,["pr_locations"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    	config = { mod_conv = 'm_cymbal_haze', extra = { numerator = 1, odds = 6, xevery = 0.25, xmult = 1 , xchips = 1} },

loc_vars = function(self, info_queue, card)
    local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.odds, 'debluck')
    info_queue[#info_queue + 1] = G.P_CENTERS.m_cymbal_haze
    
    local hazed = 0
    if G.playing_cards then
        for _, playing_card in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(playing_card, 'm_cymbal_haze') then
                hazed = hazed + 1
            end
        end
    end
    return { vars = { new_numerator, new_denominator, 1  + card.ability.extra.xevery * hazed, card.ability.extra.xevery } }
end,


    calculate = function(self, card, context)
    for i = 1, #G.deck.cards do
    local c = G.deck.cards[i]
    if context.setting_blind and not context.blueprint and SMODS.pseudorandom_probability(card, 'cymbal_underbelly', card.ability.extra.numerator, card.ability.extra.odds, 'debluck')  then
    c:set_ability(card.ability.mod_conv)
    --c:set_debuff(true)

        end
        end
        
    if context.joker_main then
        local hazed = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_cymbal_haze') then
                    hazed = hazed + 1
                end
            end
        end

        return {
            xmult  = 1  + card.ability.extra.xevery * hazed,
            x_chips = 1 + card.ability.extra.xevery * hazed,
        }
    end
end,
      
}

--emty bailey
SMODS.Joker {
    key = "empty_bailey",
        loc_txt= {
        name = 'Empty Bailey',
        text = { 
        '{C:attention}+1{} hand size for every',
        'stack of {C:attention}#2#{} cards in your deck',
        '{C:inactive}({}{C:attention}+#1#{} {C:inactive}hand size)'
        }
    },
    atlas = 'locations',
    pos = { x = 2, y = 0 },
    rarity = 1,
    cost = 5,
    pools = {["pseudoregamod"] = true,["pr_locations"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {hand = 0, cards_ned = 15, hand_max = 10}},
        loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.hand,  card.ability.extra.cards_ned, card.ability.extra.hand_max  } }
    end,

    calculate = function(self, card, context)
    if context.setting_blind or context.playing_card_added or context.remove_playing_cards and not context.blueprint then
G.hand:change_size(-card.ability.extra.hand)
card.ability.extra.hand = math.floor(#G.playing_cards / card.ability.extra.cards_ned)
card.ability.extra.hand = math.min(card.ability.extra.hand, card.ability.extra.hand_max)
G.hand:change_size(card.ability.extra.hand)
            end
       end,
       
       add_to_deck = function(self, card, from_debuff)
G.hand:change_size(card.ability.extra.hand)
        end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand)
    end
}

--Listless Library
SMODS.Joker {
    key = "listless_library",
        loc_txt= {
        name = 'Listless Library',
        text = { 
        'Create a random {C:attention}Book Joker{}',
        'at the end of the shop',
        '{C:inactive}(Must have room){}',
        }
    },
    atlas = 'locations',
    pos = { x = 2, y = 1 },
    rarity = 1,
    cost = 5,
    pools = {["pseudoregamod"] = true,["pr_locations"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { },
        loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,

    calculate = function(self, card, context)
    if context.ending_shop and  #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
   SMODS.add_card { set = "cymbal_books"}
            end
        end
}

--Sansa Keep
SMODS.Joker {
    key = "sansa_keep",
        loc_txt= {
        name = 'Sansa Keep',
        text = { 
        'Earn the {C:attention}sell value{} of the Joker',
        'on the left and right of this Joker',
        'at the end of the round',
        }
    },
    atlas = 'locations',
    pos = { x = 0, y = 1 },
    rarity = 2,
    cost = 6,
    pools = {["pseudoregamod"] = true,["pr_locations"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {dollar = 0} },
        loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.dollar} }
    end,

    calculate = function(self, card, context)
            local my_pos = nil
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then
            my_pos = i
            break
        end
    end
    --(sell_minus or {}).sell_cost or 0
                
  if context.end_of_round and not context.blueprint and context.game_over == false and context.main_eval then
  if my_pos then 							
  local sell_minus = G.jokers.cards[my_pos - 1] or nil
  local sell_plus = G.jokers.cards[my_pos + 1] or nil
card.ability.extra.dollar = card.ability.extra.dollar + ((sell_minus or {}).sell_cost or 0) + ((sell_plus or {}).sell_cost or 0)
  	end
  	end
        end,
        
    calc_dollar_bonus = function(self, card)
        local result = (card.ability.extra.dollar)
        card.ability.extra.dollar = 0
        return result
    end

}

--Twilight Theatre
SMODS.Joker {
    key = "twilight_theatre",
        loc_txt= {
        name = 'Twilight Theatre',
        text = { 
        'Rettriger all played cards {C:attention}#1#{} times',
        'Increase by {C:attention}#2#{} every time you play',
        'your most played hand ({C:attention}#3#{})',
        '{s:0.9}Reset at the end of the Ante{}'
        }
    },
    atlas = 'locations',
    pos = { x = 3, y = 1 },
    rarity = 1,
    cost = 6,
    pools = {["pseudoregamod"] = true,["pr_locations"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {retriggers = 0, encore = 1, played_most = 'None', rideau = false}},
        loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.retriggers,  card.ability.extra.encore,card.ability.extra.played_most  } }
    end,

    calculate = function(self, card, context)

local _handname, _played = 'High Card', -1
for hand_key, hand in pairs(G.GAME.hands) do
    if hand.played > _played then
        _played = hand.played
        _handname = hand_key
    end
end
local most_played = _handname

if context.setting_blind or context.end_of_round and context.game_over == false or context.after and context.main_eval   then
rideau = false
card.ability.extra.played_most = most_played

end
        if context.before and context.scoring_name == card.ability.extra.played_most  then
        card.ability.extra.retriggers = card.ability.extra.retriggers + card.ability.extra.encore
            return {
                message = "Encore !",
                colour = G.C.DARK_EDITION
            }
        end

    if context.repetition and context.cardarea == G.play then
	return { message = localize("k_again_ex"), repetitions = card.ability.extra.retriggers}
            end

            if context.ante_end and not rideau then
            rideau = true
            card.ability.extra.retriggers = 0
              return {
                message = localize('k_reset')
            }
            end
            end
}

--tower remains 
SMODS.Joker {
    key = "tower_remains",
        loc_txt= {
        name = 'Tower Remains',
        text = { 
        '{X:mult,C:white}X#2#{} Mult',
        'If your hand score less than',
        ' the score of your first hand ({C:chips}#1#{} chips)',
        'this joker gain {X:mult,C:white}X#3#{} Mult',
        }
    },
    atlas = 'locations',
    pos = { x = 3, y = 0 },
    rarity = 3,
    cost = 8,
    pools = {["pseudoregamod"] = true,["pr_locations"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {first_hand_score = 0, mult = 1, mult_gain = 2, check = false}},
        loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.first_hand_score,  card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,

    calculate = function(self, card, context)
local current_score = G.GAME.chips
    if not check and context.main_eval and not SMODS.last_hand_oneshot and not context.blueprint and G.GAME.current_round.hands_played == 1 or not  G.GAME.current_round.hands_played == 0 then
    card.ability.extra.first_hand_score = current_score
    check = true
    return { message = "Requirement Set"}
            end
            
       if context.joker_main then
       return {
       xmult = card.ability.extra.mult
       }
       end
            

  if context.main_eval and SMODS.calculate_round_score() < card.ability.extra.first_hand_score then
   if context.final_scoring_step then
   card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
   return {message = "Upgrade !"}
   end
   end   
   
 if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
 check = false
  card.ability.extra.first_hand_score = 0
  end
   end
}
