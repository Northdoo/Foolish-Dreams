SMODS.Atlas{
    key = 'slider',
    path = 'voucheringaround.png',
    px = 71,
    py = 95,
}


SMODS.Voucher {
    key = 'slide',
        loc_txt= {
        name = 'Slide',
    	text = {
    	"Gain {C:money}#1#${} per skip",
        "{s:0.8,C:inactive}(By itself, it feels incomplete.){}",
    }
},
    atlas = 'slider',
    pos = { x = 0, y = 0 },
    config = { extra = { dollar = 5 } },
     loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollar}  }
	end,
	
    redeem = function(self, card)
        check_for_unlock({ 'slide_redeemed' })
    end,
             calculate = function(self, card,context)
               if context.skip_blind and not context.blueprint then
               
               return {dollars = card.ability.extra.dollar}
                end
             end
}

--Solar Wind

SMODS.Voucher {
    key = 'solarwind',
        loc_txt= {
        name = 'Solar Wind',
    	text = {
        "Create a {C:attention}Double Tag{} for each blind skipped",
        "{s:0.8,C:inactive}(Complete itself with the Slide Voucher.){}",
    }
},
requires = { 'v_cymbal_slide' },
    atlas = 'slider',
    pos = { x = 1, y = 0 },
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = { key = 'tag_double', set = 'Tag' }
    end,
    
    redeem = function(self, card)
        check_for_unlock({ 'solarwind_redeemed' })
    end,
            calculate = function(self, card,context)
                if context.skip_blind and not context.blueprint then
                    add_tag(Tag('tag_double'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                end
            end
}
--Sun Greaves
SMODS.Voucher {
    key = 'boosterKick',
        loc_txt= {
        name = 'Sun Greaves',
    	text = {
    	"{C:attention}Refund{} the first Booster Pack",
    	"bought and {C:attention}skipped{} in the shop",
    }
},
    atlas = 'slider',
    pos = { x = 1, y = 2 },
    config = { extra = { uses = 0 } },
     loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.uses}  }
	end,
    redeem = function(self, card)
        check_for_unlock({ 'boosterKick_redeemed' })
    end,
    
    calculate = function(self, card, context)

    
        if  context.skipping_booster and card.ability.extra.uses ~= 1  and SMODS.OPENED_BOOSTER.cost ~= 0  then
            card.ability.extra.uses = math.min((card.ability.extra.uses + 1),1)
            return { dollars = SMODS.OPENED_BOOSTER.cost}
        end
        
        if context.ending_shop  then
        card.ability.extra.uses = 0
        end
    end,
}

--Sunsetter
SMODS.Voucher {
    key = 'sunsetter',
        loc_txt= {
        name = 'Sunsetter',
    	text = { 
   	 "At the end of each Ante,",
  	  "gain a random {C:attention}Booster Tag{}",
	}
},
    atlas = 'slider',
    pos = { x = 2, y = 0 },
    config = { },
     loc_vars = function(self, info_queue, card)
          info_queue[#info_queue+1] = { key = 'tag_standard', set = 'Tag' }
     info_queue[#info_queue+1] = { key = 'tag_buffoon', set = 'Tag' }
          info_queue[#info_queue+1] = { key = 'tag_meteor', set = 'Tag' }
     info_queue[#info_queue+1] = { key = 'tag_ethereal', set = 'Tag' }
		return {  }
	end,
    redeem = function(self, card)
        check_for_unlock({ 'boosterKick_redeemed' })
    end,
    
    calculate = function(self, card, context)

    
        if  context.ante_change and context.ante_end and context.main_eval then
	local choices = { 'tag_ethereal', 'tag_meteor', 'tag_standard', 'tag_buffoon' }

	local choice = choices[math.random(#choices)]

	add_tag(Tag(choice))
            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
        end
        end,
        

}

--soulcutter
SMODS.Voucher {
    key = 'soulcutter',
        loc_txt= {
        name = 'Soul Cutter',
    	text = {
    	"Played {C:attention}cards{} of the first hand",
    	"gives {C:mult}+#1#{} mult",
    }
},
    atlas = 'slider',
    pos = { x = 2, y = 1 },
    config = { extra = { mult = 3 } },
     loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult}  }
	end,
    redeem = function(self, card)
        check_for_unlock({ 'soulcutter_redeemed' })
    end,
    
    calculate = function(self, card, context)
if context.individual and context.cardarea == G.play and G.GAME.current_round.hands_played == 0  then
return {
mult = card.ability.extra.mult
}
end
    end,
}

--Strikebreak
SMODS.Voucher {
    key = 'strikebreak',
        loc_txt= {
        name = 'Strikebreak',
    	text = {
    	"Played {C:attention}cards{} of the first hand",
    	"gives {C:white,X:mult}X#1#{} Mult",
    }
},
    atlas = 'slider',
    pos = { x = 2, y = 2 },
    requires = { 'v_cymbal_soulcutter' },
    config = { extra = { xmult = 1.20 } },
     loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult}  }
	end,

    
    calculate = function(self, card, context)
if context.individual and context.cardarea == G.play and G.GAME.current_round.hands_played == 0  then
return {
xmult = card.ability.extra.xmult
}
end
    end,
}

--Cling Gem
SMODS.Voucher {
    key = 'wallRide',
        loc_txt= {
        name = 'Cling Gem',
    	text = {
    	"Played and scored {C:attention}cards{} permanently",
    	"gains {C:chips}+#1#{} Chips",
    }
},
    atlas = 'slider',
    pos = { x = 0, y = 2 },
    config = { extra = { chips = 2 } },
     loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips}  }
	end,
    redeem = function(self, card)
        check_for_unlock({ 'wallRide_redeemed' })
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) +
                card.ability.extra.chips
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
    end,
}

--Ascendant Light
SMODS.Voucher {
    key = 'light',
        loc_txt= {
        name = 'Ascendant Light',
    	text = {
    	"All played {C:attention}cards{}",
    	"permanantly rettriger",
    	 "{C:attention}#1#{} time",
    }
},
    atlas = 'slider',
    requires = { 'v_cymbal_wallRide' },
    pos = { x = 0, y = 1 },
    config = { extra = { repetitions = 1 } },
     loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions}  }
	end,
	
             calculate = function(self, card,context)
    if context.repetition and context.cardarea == G.play then
	return { 
	message = localize("k_again_ex"), 
	repetitions = card.ability.extra.repetitions
	}
            end
             end,
}

--Slide Ultra Hop

SMODS.Voucher {
    key = 'slideultrahop',
        loc_txt= {
        name = 'Slide Ultrahop',
    	text = {
        "{C:attention}+1{} Ante",
        "{X:attention,C:white}+35%{} Blind Chips Requirement",
        "{C:blue}+#1#{} hands",
        "{C:red}+#1#{} discards",
    }
},
    requires = { 'v_cymbal_solarwind' },
    atlas = 'slider',
    pos = { x = 1, y = 1 },
    
    config = { extra = { all = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.all } }
    end,
    redeem = function(self, card)
    ease_ante(1)
    G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
    G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + 1
    G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * 1.35
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.all
     G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.all
    ease_discard(card.ability.extra.all)
    ease_hands_played(card.ability.extra.all)
    end
}

