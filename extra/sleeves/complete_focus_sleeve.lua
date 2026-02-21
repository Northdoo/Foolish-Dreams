--complete focus seeve

CardSleeves.Sleeve{
    key = "completefocus",
    atlas = 'Sleeves',
    pos = { x = 0, y = 0 },
    config = { vouchers = { 'v_cymbal_solarwind', 'v_cymbal_slide' }},
    


    loc_vars = function(self, info_queue, back)
        return { vars = { localize { type = 'name_text', key = self.config.vouchers[1], set = 'Voucher' },
        localize { type = 'name_text', key = self.config.vouchers[2], set = 'Voucher'}
         }
        }
    end,

    apply = function(self, card)
       G.GAME.win_ante = G.GAME.win_ante + 2
       local nostandard = {'p_standard_normal_1', 'p_standard_normal_2', 'p_standard_normal_3', 'p_standard_normal_4',  'p_standard_jumbo_1', 'p_standard_jumbo_2', 'p_standard_mega_1', 'p_standard_mega_2', 'tag_standard'}
       
for i, b in pairs(nostandard) do
G.GAME.banned_keys[b] = true
end
	end,

    loc_txt = {
        name = "Complete Focus Sleeve ",
        text = {
	"Increase Winning Ante by {C:attention}2",
	"Standard Packs are banned",
	"Start with the {C:attention,T:v_cymbal_slide}Slide{}",
	"and {C:attention,T:v_cymbal_solarwind} Solar Wind{}"
        }
    },
}
