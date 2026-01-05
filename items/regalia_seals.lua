SMODS.Atlas{
   key = 'regaliaseals',
    path = 'EnhancersPseudo.png',
    px = 71,
    py = 95,
}

SMODS.Seal {
    key = 'hellicalseal',
    atlas = 'regaliaseals',
    pos = { x = 0, y = 1 },
    
    badge_colour = HEX('ed535e'),
     loc_txt = {
        name = 'Heliacal Seal',
        text = {
	"{C:attention}+#1#{} discard",
	"when scored"
        },
        label = { "Heliacal" },
    },
    unlocked = true,
    discovered = false,
    no_collection = false,
    
    config = { extra = { discards = 1 } },
        loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.discards  } }
    end,
    
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
	ease_discard(1)
	            return {
                message = "+1 Discard!"
            }
	end
    end
}
