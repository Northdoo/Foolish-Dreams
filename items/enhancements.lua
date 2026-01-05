SMODS.Atlas{
   key = 'sol',
    path = 'EnhancersPseudo.png',
    px = 71,
    py = 95,
}

SMODS.Enhancement {
key = 'sol',
	loc_txt = {
	name = "Sol Card",
	text =  {"{C:money}$#1#{} when scoring",
	"Has no rank",
	"Is considered as any suit"
},},

    atlas = 'sol',
    pos = { x = 0, y = 0 },
    --pools = {["pseudoregamod"] = true},

--unlocked = true,
--discovered = true,

config = { extra = { dollar = 10}},
        loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.dollar  } }
    end,

    calculate = function(self, card, context)
    local krabs = 0
    if context.main_scoring and context.cardarea == G.play then
    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0)+card.ability.extra.dollar

return {dollars = card.ability.extra.dollar,
                func = function() 
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
end,
	replace_base_card = true,
	no_rank = true,
	no_suit = false,
	any_suit = true,
	always_scores = true,
}

--math.floor((G.GAME.dollars+(G.GAME.dollar_buffer or 0))*(card.ability.extra.dollar-1))
--Hey you.
--Here, the old code for the sol card, do what  you want with it, doesn't work properly anyway.
--[[
    G.GAME.dollar_buffer = math.floor((G.GAME.dollar_buffer or 0)+(G.GAME.dollars*(card.ability.extra.dollar-1)))
--math.floor((G.GAME.dollars+(G.GAME.dollar_buffer or 0))*(card.ability.extra.dollar-1))
return {dollars = math.floor((G.GAME.dollars+(G.GAME.dollar_buffer or 0))*(card.ability.extra.dollar-1)), 
remove_default_message = true, 
message = 'X'..card.ability.extra.dollar..localize('$'), 
colour = G.C.MONEY,
                func = function() 
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
 --]]


SMODS.Enhancement {
key = 'haze',
	loc_txt = {
	name = "Hazed Card",
	text =  {"{X:chips,C:white}X#1#{} Chips and {X:mult,C:white}X#1#{} Mult",
	"No rank or suit",
	"Destroy itself after scoring {C:attention}#3#{} times",
	"{C:inactive}(#2#/#3#)",
	
},},

    atlas = 'sol',
    pos = { x = 2, y = 0 },


config = { extra = { xall =  2, scored = 0, maxscore = 3}},
        loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xall, card.ability.extra.scored, card.ability.extra.maxscore} }
    end,

calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play then
       card.ability.extra.scored = math.min((card.ability.extra.scored + 1), card.ability.extra.maxscore)
        return
        {
            x_chips = card.ability.extra.xall,
            xmult   = card.ability.extra.xall,
        }
    end
    
     if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and card.ability.extra.scored == card.ability.extra.maxscore then
    return { remove = true }
    end
end,
	replace_base_card = true,
	no_rank = true,
	no_suit = true,
	any_suit = false,
	always_scores = true,
}

