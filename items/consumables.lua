SMODS.Atlas{
   key = 'regalia_spectral',
    path = 'regalia_spectral.png',
    px = 71,
    py = 95,
}

--TAROT

SMODS.Consumable {
key = 'topenta',
set = "Tarot",
effect = "Enhance",
atlas = 'regalia_spectral',
pos = { x = 2, y = 1 },
cost = 4,

config = {
        -- How many cards can be selected.
        max_highlighted = 2,
        mod_conv = 'm_cymbal_sol',
},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_cymbal_sol
--["m_cymbal_sol".. card.ability.mod_conv]
        return {vars = {max_highlighted}}
    end,
    loc_txt = {
        name = 'Two of Pentacles',
        text = {
	"Select up to 2 cards to", 
	"turn them into {C:attention}Sol Cards{}"
        },
    },
}

--SPECTRALS

SMODS.Consumable {
key = 'goodgraces',
set = "Spectral",
atlas = 'regalia_spectral',
pos = { x = 1, y = 1 },
cost = 4,
    config = { max_highlighted = 2, perma_bonus = 0, extra = {chips = 25} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.max_highlighted, perma_bonus, card.ability.extra.chips } }
    end,
    
     loc_txt = {
        name = 'Good Graces',
        text = {
	"Select up to {C:attention}#1#{} cards to", 
	"give permantly {C:chips}+#3#{} Chips"
        },
    },
    
     use = function(self, card, area, copier)

            G.E_MANAGER:add_event(Event({
            func = function()
               play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true 
                end 
                }))
            
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
             for i = 1, #G.hand.highlighted do
   		G.hand.highlighted[i].ability.perma_bonus = (G.hand.highlighted[i].ability.perma_bonus or 0) +card.ability.extra.chips
   		G.hand.highlighted[i]:juice_up(0.3, 0.5)
   		end
                return true 
                end
                 }))
            
            delay(0.5)
            
        G.E_MANAGER:add_event(Event({
        trigger = 'after', 
        delay = 0.2,
        func = function()
         G.hand:unhighlight_all()
          return true
           end 
           }))
    end
}

SMODS.Consumable {
key = 'empathy',
set = "Spectral",
atlas = 'regalia_spectral',
pos = { x = 2, y = 0 },
cost = 4,
    config = { max_highlighted = 2,min_highlighted = 2,  perma_mult = 0, extra = {mult = 5} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.max_highlighted, perma_mult, card.ability.extra.mult } }
    end,
    
     loc_txt = {
        name = 'Empathy',
        text = {
	"Select {C:attention}#1#{} cards", 
	"give permantly {C:mult}+#3#{} Mult",
    "to the {C:attention}left{} card and",
    "destroy the {C:attention}right{} one",
    "{C:inactive}(Drag to rearrange){}",
        },
    },
    
     use = function(self, card, area, copier)

            G.E_MANAGER:add_event(Event({
            func = function()
               play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true 
                end 
                }))

        local rightmost = G.hand.highlighted[1]
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i].T.x > rightmost.T.x then
                rightmost = G.hand.highlighted[i]
            end
        end

        
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
            for i = 1, #G.hand.highlighted do
            SMODS.destroy_cards(rightmost)
            G.hand.highlighted[i]:juice_up(0.3, 0.5)
   		    G.hand.highlighted[i].ability.perma_mult = (G.hand.highlighted[i].ability.perma_mult or 0) +card.ability.extra.mult
            end
                return true 
                end
                 }))
            
            
            delay(0.5)
            
        G.E_MANAGER:add_event(Event({
        trigger = 'after', 
        delay = 0.2,
        func = function()
         G.hand:unhighlight_all()
          return true
           end 
           }))
    end
}

SMODS.Consumable {
key = 'martial_prowess',
set = "Spectral",
atlas = 'regalia_spectral',
pos = { x = 3, y = 0 },
cost = 4,
    config = { max_highlighted = 1, perma_x_mult = 0, extra = {xmult = 0.5, destroy = 3} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.max_highlighted, perma_x_mult, card.ability.extra.xmult,card.ability.extra.destroy  } }
    end,
    
     loc_txt = {
        name = 'Martial Prowess',
        text = {
	"Destroy {C:attention}#4#{} random ",
    "cards in hand,",
    "but give permnantly give {X:mult,C:white}X0.5{} Mult",
    "to {C:attention}#1#{} selected card",
        },
    },
    
     use = function(self, card, area, copier)

    -- From Vanilla remade about random destroying cards :
        local destroyed_cards = {}
        local temp_hand = {}
        


        for _, playing_card in ipairs(G.hand.cards) do
            local highlight_card = false
            for _, h in ipairs(G.hand.highlighted) do
                if h == playing_card then
                    highlight_card = true
                end
            end
            if not highlight_card then
                temp_hand[#temp_hand + 1] = playing_card
            end
        end


        table.sort(temp_hand,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card 
            end
        )

        pseudoshuffle(temp_hand, pseudoseed('martial_prowess'))

        for i = 1, card.ability.extra.destroy do 
        destroyed_cards[#destroyed_cards + 1] = temp_hand[i] 
        end
    --
            G.E_MANAGER:add_event(Event({
            func = function()
               play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true 
                end 
                }))

        
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
            for i = 1, #G.hand.highlighted do
            SMODS.destroy_cards(destroyed_cards)
            G.hand.highlighted[i]:juice_up(0.3, 0.5)
   		    G.hand.highlighted[i].ability.perma_x_mult = (G.hand.highlighted[i].ability.perma_x_mult or 0) +card.ability.extra.xmult
            end
                return true 
                end
                 }))
    end
}

SMODS.Consumable {
key = 'hellical',
set = "Spectral",
atlas = 'regalia_spectral',
pos = { x = 0, y = 1 },
cost = 4,
    config = { max_highlighted = 1, extra = { seal = 'cymbal_hellicalseal' } },
    loc_vars = function(self, info_queue, card)
     info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = {card.ability.max_highlighted, card.ability.extra.seal } }
    end,
    
    use = function(self, card, area, copier)
    local damncard = G.hand.highlighted[1]
            G.E_MANAGER:add_event(Event({
            func = function()
               play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true 
                end 
                }))
            
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                damncard:set_seal(card.ability.extra.seal, nil, true)
                return true 
                end
                 }))
            
            delay(0.5)
            
        G.E_MANAGER:add_event(Event({
        trigger = 'after', 
        delay = 0.2,
        func = function()
         G.hand:unhighlight_all()
          return true
           end 
           }))
    end,
    
    loc_txt = {
        name = 'Heliacal Power',
        text = {
	"Select {C:attention}#1#{} card",
	"to apply a {C:attention}Heliacal Seal{}"
        },
    },
}

SMODS.Consumable {
key = 'clearmind',
set = "Spectral",
atlas = 'regalia_spectral',
pos = { x = 0, y = 0 },
cost = 4,
hidden = true,
soul_rate = 0.0053,

config = { extra = { slots = 3 } },  -- kept as-is

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots } }
    end,

    use = function(self, card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.jokers then
                    G.jokers.config.card_limit = G.jokers.config.card_limit + 3
                                attention_text({
		        play_sound('timpani'),
                        text = "+3 Slots !",
                        scale = 1.3,
                        hold = 1.4,
		        major = card,
		        card:juice_up(0.3, 0.5),
                        backdrop_colour = G.C.SECONDARY_SET.Spectral,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                end
                return true
            end,
        }))
        delay(0.6)
    end,

    can_use = function(self, card)
        return true
    end,

    loc_txt = {
        name = 'Clear Mind',
        text = {
            "{C:dark_edition,E:1}+3{} {E:1}Joker slots{}"
        },
    },
}
--PLANET

SMODS.Consumable {
key = 'makemake',
set = "Planet",
atlas = 'regalia_spectral',
pos = { x = 1, y = 0 },
cost = 4,
config = { hand_type = 'cymbal_sunstone_house', softlock = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.hands[card.ability.hand_type].level,
                localize(card.ability.hand_type, 'poker_hands'),
                G.GAME.hands[card.ability.hand_type].l_mult,
                G.GAME.hands[card.ability.hand_type].l_chips,
                colours = {
                    (G.GAME.hands[card.ability.hand_type].level == 1
                        and G.C.UI.TEXT_DARK
                        or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)])
                }
            }
        }
    end,

    loc_txt = {
        name = "Makemake",
                text = {
                    "({V:1}lvl.#1#{}) Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
                },
            },

    use = function(self, card, area, copier)
        SMODS.smart_level_up_hand(card, "cymbal_sunstone_house")
    end,

    can_use = function(self, card)
        return true
	end,
	
    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_dwarf_planet'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Planet.text_colour,
            1.2)
    end,
}

--[[
SMODS.Consumable {
key = 'testo',
set = "Planet",
atlas = 'regalia_spectral',
pos = { x = 1, y = 0 },
cost = 4,
config = { },

    loc_txt = {
        name = "NO ERROR",
                text = {
                    "TEST",
                },
            },

    use = function(self, card, area, copier)
        SMODS.smart_level_up_hand(card, "cymbal_sunstone_house")
    end,

    can_use = function(self, card)
        return true
	end,
	
in_pool = function(self, args)
if next(SMODS.find_card("j_splash")) then
    return true
else
  return false
end
end,
}
]]
