SMODS.Atlas{
   key = 'regaliadeck',
    path = 'EnhancersPseudo.png',
    px = 71,
    py = 95,
}

SMODS.Back {
    key = "sybilian",
    atlas = 'regaliadeck',
    pos = { x = 1, y = 1 },
    config = { discards = 2,hands = -1 },

    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.discards, self.config.hands } }
    end,

    apply = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 0.5
    end,

    loc_txt = {
        name = "Regalia Deck",
        text = {
            "{C:red}+2{} Discards and",
            "{C:blue}-1{} Hand",
            "every round",
            "{s:0.85}Required score{} {C:attention}scales slghtly faster{}",
             "{s:0.85}each{} {C:attention}Ante{}"
        }
    },
}

SMODS.Back {
    key = "jumper",
    atlas = 'regaliadeck',
    pos = { x = 1, y = 2 },
    config = { percent = -75, dollars = 21, vouchers = { 'v_seed_money', 'v_money_tree' }},

    loc_vars = function(self, info_queue, back)
        return { vars = {self.config.percent, self.config.dollars, localize { type = 'name_text', key = self.config.vouchers[1], set = 'Voucher' },
        localize { type = 'name_text', key = self.config.vouchers[2], set = 'Voucher'}
           }
          }
    end,

    apply = function(self, card)
       G.GAME.win_ante = G.GAME.win_ante - 2
       G.GAME.discount_percent = self.config.percent
    end,

    loc_txt = {
        name = "Hurry Deck",
        text = {
	"Winning Ante is {C:attention}6",
	"Shop's prices increase by {C:attention}+75%{}",
	"Start run with {C:money}$25{},",
	"{C:attention,T:v_seed_money}Seed Money{}",
	"and {C:attention,T:v_money_tree}Money Tree{}"
        }
    },
}


SMODS.Back {
    key = "completefocus",
    atlas = 'regaliadeck',
    pos = { x = 2, y = 1 },
    config = { vouchers = { 'v_cymbal_solarwind', 'v_cymbal_slide' }},
    


    loc_vars = function(self, info_queue, back)
        return { vars = { localize { type = 'name_text', key = self.config.vouchers[1], set = 'Voucher' },
        localize { type = 'name_text', key = self.config.vouchers[2], set = 'Voucher'}
         }
        }
    end,

    apply = function(self, card)
       G.GAME.win_ante = G.GAME.win_ante + 2
       --[[local nostandard = {'p_standard_normal_1', 'p_standard_normal_2', 'p_standard_normal_3', 'p_standard_normal_4',  'p_standard_jumbo_1', 'p_standard_jumbo_2', 'p_standard_mega_1', 'p_standard_mega_2', 'tag_standard'}
       
for i, b in pairs(nostandard) do
G.GAME.banned_keys[b] = true
end]]
	end,

    loc_txt = {
        name = "Complete Focus Deck ",
        text = {
	"Winning Ante is {C:attention}10",
	--"Standard Packs are banned",
	"Start with the {C:attention,T:v_cymbal_slide}Slide{}",
	"and {C:attention,T:v_cymbal_solarwind} Solar Wind{}"
        }
    },
}

SMODS.Back {
    key = "princessdeck",
    atlas = 'regaliadeck',
    pos = { x = 3, y = 1 },
    config = { joker_slot = 3,vouchers = {  'v_overstock_norm', 'v_omen_globe'  }},
    


    loc_vars = function(self, info_queue, back)
        return { vars = { localize { type = 'name_text', key = self.config.vouchers[1], set = 'Voucher' },
        localize { type = 'name_text', key = self.config.vouchers[2], set = 'Voucher'}
        }
        }
    end,

    apply = function(self, card)
       G.GAME.win_ante = G.GAME.win_ante + 4
--[[       
       local nopack = { 'tag_standard', 'tag_charm','tag_meteor','tag_buffoon','tag_ethereal'}
       
for i, b in pairs(nopack) do
G.GAME.banned_keys[b] = true
end
]]
	end,

    loc_txt = {
        name = "The Princess' Deck ",
        text = {
	"Winning Ante is {C:attention}12",
	--"Pack Tags are banned",
	"Start  run with",
	"{C:attention,T:v_overstock_norm}Overstock{},",
	"{C:attention,T:v_omen_globe} Omen Globe{},",
	"And {C:dark_edition}+3{} Joker Slots"
        }
    },
}

