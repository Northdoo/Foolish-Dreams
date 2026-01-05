
    local SybilSunday = (os.date("%A") == "Sunday")
    local original_get_new_boss = get_new_boss
--[[
    function get_new_boss(self)
  --if G.GAME.always_spawn_cymbal_boss_memory == true then
  if G.GAME.always_spawn_cymbal_boss_gate then
    return 'bl_cymbal_boss_gate'
  end
  return original_get_new_boss(self)
end
]]--

SMODS.Joker {
    key = "jam_sybil",
    loc_txt = {
    name = 'Jam Sybil',
    text = {
        {
            'Gain an extra {C:money}$#1#{}',
            'by remaning {C:red}discard{}',
            'At the end of the round',
        },
        {
            '{C:attention}Boss Blinds{} gives',
            'no reward money',
        }
    },
},
    atlas = 'regaliadeck',
    pos = { x = 3, y = 2 },
    rarity = 2,
    cost = 5,
    pools = {["pseudoregamod"] = true},
 
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    --- the function
    config = { extra ={dollars = 2}},
        loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.dollars}}
    end,
    
    



add_to_deck = function(self, card, from_debuff)
    G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
   G.GAME.modifiers.no_blind_reward.Boss = true

--G.GAME.always_spawn_cymbal_boss_gate = true
    end,
    
    remove_from_deck = function(self, card, from_debuff)
    G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
   G.GAME.modifiers.no_blind_reward.Boss = false
--G.GAME.always_spawn_cymbal_boss_gate = false
    end,

    calc_dollar_bonus = function(self, card)
        local result = (card.ability.extra.dollars * G.GAME.current_round.discards_left )
        return result
    end,
}

SMODS.Joker {
    key = "sol_joker",
    enhancement_gate = "m_cymbal_sol",
        loc_txt= {
        name = 'Sol Joker',
        text = {    "{C:attention}Sol Cards{} can't be {C:attention}debuffed{}",
    },},
    atlas = 'regaliadeck',
    pos = { x = 0, y = 2 },
    rarity = 2,
    cost = 5,
    pools = {["pseudoregamod"] = true},
 
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    --- the function
    config = { extra = {}},
        loc_vars = function(self, info_queue, card)
       info_queue[#info_queue + 1] = G.P_CENTERS.m_cymbal_sol
        return {vars = {}}
    end,
    
	calculate = function(self, card, context)
        for i = 1, #G.deck.cards do
            local c = G.deck.cards[i]
            if context.setting_blind and c.config.center.key == "m_cymbal_sol" then
                c:set_debuff(false)
            end
        end
    end,
    
}

SMODS.Joker {
    key = "sleepy_princess_joker",
        loc_txt= {
        name = 'Sleepy Princess Joker',
        text = {    "Cards and packs in shop",
        "are {C:attention}#1#%{} off ",
    },},
    atlas = 'regaliadeck',
    pos = { x = 2, y = 2 },
    rarity = 1,
    cost = 5,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    --- the function
    config = { extra = {percent = 20}},
    loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.percent }  }
    end,
    
       add_to_deck = function(self, card, from_debuff)
	G.GAME.discount_percent = card.ability.extra.percent
        end,
    remove_from_deck = function(self, card, from_debuff)
       G.GAME.discount_percent = -card.ability.extra.percent
    end
}

SMODS.Atlas{
  key = 'sybsun',
    path = 'sybilsunday.png',
    px = 69,
    py = 93,
}

SMODS.Joker {
    key = "sundae",
        loc_txt= {
        name = 'Sybil Sunday',
        text = {    "If you're playing on a {s:1.2,C:attention}Sunday{}",
   			 "have a 'free' {X:mult,C:white}x7{} Mult just for you !",
   			 "{C:inactive}#2#{}",
    },},
    atlas = 'sybsun',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 7,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    --- the function
    config = { extra = {xmult = 7, active = "(Checking the day..)"}},
    loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.xmult, card.ability.extra.active }  }
    end,
    
update = function(self, card, front)
    if SybilSunday then
        card.ability.extra.active = "(And today IS Sunday !)"
    else
        card.ability.extra.active = "(Sadly, today isn't sunday..)"
    end
end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if not SybilSunday then
                return {
                    color = G.C.INACTIVE, --won't actually do anything sadly
                    message = "Not Sunday.",
                }
            elseif SybilSunday then
                return {
            	    color = G.C.GOLD, --won't actually do anything sadly
                    message = "SYBIL SUNDAY !!!",
                    extra = {
	   			  message = "x".. card.ability.extra.xmult,
          			  Xmult_mod = card.ability.extra.xmult }
                }
            end
        end
    end
}

SMODS.Joker {
    key = "sol_joker",
    enhancement_gate = "m_cymbal_sol",
        loc_txt= {
        name = 'Sol Joker',
        text = {    "{C:attention}Sol Cards{} can't be {C:attention}debuffed{}",
    },},
    atlas = 'regaliadeck',
    pos = { x = 0, y = 2 },
    rarity = 2,
    cost = 5,
    pools = {["pseudoregamod"] = true},
 
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    --- the function
    config = { extra = {}},
        loc_vars = function(self, info_queue, card)
       info_queue[#info_queue + 1] = G.P_CENTERS.m_cymbal_sol
        return {vars = {}}
    end,
    
	calculate = function(self, card, context)
        for i = 1, #G.deck.cards do
            local c = G.deck.cards[i]
            if context.setting_blind and c.config.center.key == "m_cymbal_sol" then
                c:set_debuff(false)
            end
        end
    end,
    
}

