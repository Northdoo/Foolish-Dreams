SMODS.Atlas {
    key = "pseudoblinds",
    path = "blinds.png",
    px = 34,
    py = 34,
    frames = 1,
    atlas_table = 'ANIMATION_ATLAS'
}
-------------------------------------------------------------

SMODS.Blind {
    name = "boss_memory",
    key = "boss_memory",
    atlas = "pseudoblinds",
    mult = 2,
    pos = { y = 0 },
    dollars = 8,
    loc_txt = {
        name = 'Distored Memory',
        text = {
            'Unmodified cards are debuffed',
        },
    },
    boss = { showdown = true },
    boss_colour = HEX('521844'),
    


    recalc_debuff = function(self, card)
        for i = 1, #G.deck.cards do
            local c = G.deck.cards[i]
            if c.seal == nil and c.edition == nil and c.ability.set == "Default" then
                c:set_debuff(true)
            end
        end
    end,
    
    disable = function(self)
       for i = 1, #G.deck.cards do
            G.deck.cards[i]:set_debuff(false)
       end
    end,

    defeat = function(self)
       for i = 1, #G.jokers.cards do
            G.deck.cards[i]:set_debuff(false)
       end
    end,
}


SMODS.Blind {
    name = "boss_strong_eye",
    key = "boss_strongeyes",
    atlas = "pseudoblinds",
    mult = 2,
    pos = { y = 4 },
    dollars = 8,
    loc_txt = {
        name = 'Strong Eyes',
        text = {
            "X5 Blind Requirement if",
            "hand's score gets on fire",
        },
    },
   boss = { showdown = true },
   
    boss_colour = HEX('b58746'),
    
calculate = function(self, blind, context)

if not blind.disabled then
    if context.after and SMODS.last_hand_oneshot then
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.1,
            func = function()
                G.GAME.blind.chips = math.floor(G.GAME.blind.chips * 5)
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                blind:wiggle()
                return true
            end
        }))
    end
end
end,
        
}

SMODS.Blind {
    name = "boss_strong",
    key = "boss_strong",
    atlas = "pseudoblinds",
    mult = 2,
    pos = { y = 1 },
    dollars = 5,
    loc_txt = {
        name = 'The Strength',
        text = {
            "X2 Blind Requirement if",
            "scored hand gets on fire",
        },
    },
   boss = { min = 2 },
   
    boss_colour = HEX('cc702a'),
    
calculate = function(self, blind, context)

 if not blind.disabled then
 if  context.after and SMODS.last_hand_oneshot then
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.1,
            func = function()
                G.GAME.blind.chips = math.floor(G.GAME.blind.chips * 2)
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                blind:wiggle()
                return true
            end
        }))
    end
    end
  end
        
}

SMODS.Blind {
    name = "bos_prestige",
    key = "bos_prestige",
    atlas = "pseudoblinds",
    mult = 2,
    pos = { y = 2 },
    dollars = 5,

   boss = { min = 1, max = 3 },
   
    boss_colour = HEX('b55e9e'),
    
    config = { prestige_money = 0, moni = true },
    
    loc_vars = function(self, blind)
    local key
    if G.GAME.dollars < 0  then
    key = self.key .. '_alt'
    else
    key = self.key
    end
    
		return {key = key, vars = { G.GAME.dollars or 0,  }  }
		end,


calculate = function(self, blind, context)
    
    if not blind.disabled then
    self.moni = true
    if context.setting_blind and context.main_eval  then
    if G.GAME.dollars > 0  then
    --blind.effect.prestige_money = G.GAME.dollars
    self.prestige_money = G.GAME.dollars
    ease_dollars(-G.GAME.dollars, true)
    elseif G.GAME.dollars < 0 then
    self.prestige_money = -G.GAME.dollars
    end
    end
    end
    end,
    
     disable = function(self)
     if not G.GAME.dollars < 0 then
     ease_dollars(self.prestige_money, true)
     self.moni = false
     end
     end,
     
     defeat = function(self)
     if self.moni and G.GAME.current_round.hands_left > 0 then
     ease_dollars(self.prestige_money, true)
     end
     end,
}

SMODS.Blind {
    name = "bos_clarity",
    key = "bos_clarity",
    atlas = "pseudoblinds",
    mult = 2,
    pos = { y = 3 },
    dollars = 0,
    loc_txt = {
        name = 'The Purity',
        text = {
            "Gives no reward money",
        },
    },
   boss = { min = 3 },
   
    boss_colour = HEX('64d5e6'),
    
    
disable = function(self)
    G.GAME.blind.dollars = 5
end,
}


 --[[ 
SMODS.Blind {
    name = "boss_gate",
    key = "boss_gate",
    atlas = "pseudoblinds",
    pos = { y = 2 },
    mult = 1,
    dollars = 0,
        loc_txt = {
        name = 'The Locked Gate',
        text = {
            "No reward money.",
            "No challenge.",
            "Perhaps another time.",

        },
    },
   boss = {min =  1},
   in_pool = function(self, args)
    return false
    end,
   
    boss_colour = HEX('64d5e6'),
}

 Legacy Prestige
 
 SMODS.Blind {
    name = "bos_prestige",
    key = "bos_prestige",
    atlas = "pseudoblinds",
    mult = 2,
    pos = { y = 2 },
    dollars = 5,
    loc_txt = {
        name = 'The Prestige',
        text = {
            "Money can't change",
            "during this blind ($#1#)",
        },
    },
   boss = { min = 1, max = 3 },
   
    boss_colour = HEX('b55e9e'),
    
    config = { prestige_money = 0 },
    loc_vars = function(self, blind)
		return { vars = { G.GAME.dollars or 0 }  }
		end,


calculate = function(self, blind, context)
    
    if context.setting_blind then
    blind.effect.prestige_money = G.GAME.dollars

    end

    if context.money_altered and G.GAME.dollars ~= blind.effect.prestige_money then
        local diff = G.GAME.dollars - blind.effect.prestige_money

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                ease_dollars(-diff, true)
                blind:wiggle()
                return true
            end
        }))

        delay(0.6)
    end
end
}

]]--
