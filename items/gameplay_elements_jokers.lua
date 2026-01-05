-- Pip
SMODS.Atlas{
    key = 'pipjoker',
    path = 'pipjoker.png',
    px = 71,
    py = 95,
}
SMODS.Joker {
    key = "pipjoker",
        loc_txt= {
        name = 'Pip',
        text = {     "Gain {C:blue}+#1#{} hand and {C:red}+#1#{} discard",
    "if played hand scores less than",
    "{C:attention}15%{} of required chips",
    "Has {C:attention}2{} {C:inactive}(#2#){} uses",
    "Restore by {C:attention}1{} at the end of the shop",
    "if you have at least {C:money}$10{}",
    },},
    atlas = 'pipjoker',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 3,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {all = 1, pip = 2 }},
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.all, card.ability.extra.pip}  }
    end,
    
calculate = function(self, card, context)
    if context.final_scoring_step and SMODS.calculate_round_score() < (G.GAME.blind.chips * 0.15) and card.ability.extra.pip ~= 0 then
        
        ease_discard(card.ability.extra.all)
        ease_hands_played(card.ability.extra.all)

        card.ability.extra.pip = math.max(0, card.ability.extra.pip - 1)
        
        if card.ability.extra.pip == 1 then
            card.children.center:set_sprite_pos({ x = 1, y = 0 })
        elseif card.ability.extra.pip == 0 then
            card.children.center:set_sprite_pos({ x = 2, y = 0 })
            end
          return { message = "-1 Use"}
    end
    
    if context.ending_shop and card.ability.extra.pip ~= 2 and G.GAME.dollars >= 10 then
    card.ability.extra.pip = math.max(0, card.ability.extra.pip + 1)
    
            if card.ability.extra.pip == 1 then
            card.children.center:set_sprite_pos({ x = 1, y = 0 })
        elseif card.ability.extra.pip == 2 then
            card.children.center:set_sprite_pos({ x = 0, y = 0 })
            end
    return {ease_dollars(-10), message = "+1 Use",}
    end
end
}

-- Small Key
SMODS.Atlas{
    key = 'key',
    path = 'smol_key.png',
    px = 71,
    py = 95,
}
SMODS.Joker {
    key = "key",
        loc_txt= {
        name = 'Small Key',
        text = {
            "Sell it to earn {C:attention}triple{} its cost value",
            "or wait {C:attention}3{} rounds to create",
            "3 {C:attention}Coupon Tags{} and 2 {C:attention}D6 Tag{}",
            "{C:inactive}(Currently {}{C:attention}#1#{}{C:inactive}/#2#)",
            "{C:inactive}(Sell value drops to 0$ once active)"
    },},
    atlas = 'key',
    pos = { x = 0, y = 0 },
    rarity = 2,
    pools = {["pseudoregamod"] = true},
    cost = 8,
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    
    config = { extra = { key_rounds = 0, total_rounds = 3, price = 8, yes = false } },
    loc_vars = function(self, info_queue, card)
     info_queue[#info_queue+1] = { key = 'tag_coupon', set = 'Tag' }
     info_queue[#info_queue+1] = { key = 'tag_d_six', set = 'Tag' }
		return { vars = { card.ability.extra.key_rounds, card.ability.extra.total_rounds, card.ability.extra.price, card.ability.extra.yes }  }
    end,
    
    calculate = function(self, card, context)
local RoundSet = card.ability.extra.key_rounds + 1

    if context.end_of_round and context.game_over == false and not context.blueprint then
    if card.ability.extra.key_rounds ~= card.ability.extra.total_rounds and RoundSet ~= 3 then
        card.ability.extra.key_rounds = card.ability.extra.key_rounds + 1
            return {
                message = card.ability.extra.key_rounds .. '/' .. card.ability.extra.total_rounds
            }
        else
            card.ability.extra.key_rounds = 3
            card.ability.extra.yes = true
            local eval = function(card) return not card.REMOVED end
            juice_card_until(card, eval, true)
            card.ability.extra_value = -4
            card:set_cost()
            return {
                message = localize('k_active_ex')
            }
        end
    end

    if context.selling_self and  card.ability.extra.yes == true then
        for _, t in ipairs({'tag_coupon', 'tag_d_six', 'tag_coupon',  'tag_d_six', 'tag_coupon'}) do
            add_tag(Tag(t))
            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
        end
    end
end,

    add_to_deck = function(self, card, from_debuff)
            card.ability.extra_value = (card.sell_cost * 2) * 3
            card:set_cost()
    end
}
               --[[
                G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                blockable = false,
                func = function()
                    card:start_dissolve()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Used !"})
                    return true
                end
        }))
]]--


--[[
        if context.joker_main then
			return {
				message = "+".. card.ability.extra.chips,
				chip_mod = card.ability.extra.chips
			}
        end
		if context.setting_blind and not (G.GAME.blind.boss) and context.main_eval and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.additional
            return {
                message = "Upgrade!",
            }

--]]




SMODS.Atlas{
    key = 'regalia_Gkey',
    path = 'GoldKey.png',
    px = 69,
    py = 93,
}

SMODS.Joker {
    key = "goldkey",
        loc_txt= {
        name = 'Gold Key',
        text = { "{X:mult,C:white}x5{} during a {C:attention}Boss Blind{}",
        "When entering in {C:attention}Showodwn Boss Blind{}",
        "destroy itself and {X:attention,C:white}-10%{} to the score requirement{}",
    },},
    atlas = 'regalia_Gkey',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 5,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = { extra = {xmult = 5}},
        loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult }  }
    end, 
    calculate = function(self, card, context)
        local isBossBlind = G.GAME.blind.boss
        local isShowdown = type(G.GAME.blind.config.blind.boss) == 'table' and G.GAME.blind.config.blind.boss.showdown or nil  -- G.GAME.blind.config.blind.boss.showdown wouldn't work like can someone explain to me why it didn't ? had to struggling and thanks to @/somethingcom515 for finding the solution

        if context.joker_main  and isBossBlind then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
            
        if context.setting_blind and isShowdown then
            G.GAME.blind.chips = G.GAME.blind.chips * 0.90
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                card:start_dissolve({ G.C.RED })              
        end
    end
}
	
SMODS.Joker {
    key = "boostPower",
        loc_txt= {
        name = 'Indignation',
        text = {    "The {C:attention}Dream Breaker{}'s mult ",
        "increase by {C:attention}75%{}",
        "{C:inactive}(Will destroy itself if the Dream Breaker is gone){}"
    },},
    atlas = 'regaliadeck',
    pos = { x = 3, y = 0 },
    rarity = 3,
    cost = 10,
    pools = {["pseudoregamod"] = true},
    
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    --- the function
    config = {},
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.j_cymbal_dbreaker
		return { vars = { }  }
    end,

    in_pool = function() 
    --if not SMODS.find_card("j_cymbal_boostPower")
    return not not next(SMODS.find_card("j_cymbal_dbreaker")) 
        and  not next(SMODS.find_card("j_cymbal_boostPower"))
    end,

    calculate = function(self, card, context)
    if (context.selling_card or context.joker_type_destroyed) and not context.blueprint then
   if context.card.config.center.key == 'j_cymbal_dbreaker' then
     SMODS.destroy_cards(card, nil, nil, true)
    end
    end
    end,
    
       add_to_deck = function(self, card, from_debuff)
     for _, c in ipairs(SMODS.find_card("j_cymbal_dbreaker")) do
     c.ability.extra.xmult = math.floor(c.ability.extra.xmult * 1.75)

      end
        end,
    remove_from_deck = function(self, card, from_debuff)
     for _, c in ipairs(SMODS.find_card("j_cymbal_dbreaker")) do
     c.ability.extra.xmult = math.max(15,c.ability.extra.xmult / 1.75)
        end
    end,
}