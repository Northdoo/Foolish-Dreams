--Hurry Sleeve

CardSleeves.Sleeve{
    key = "jumper",
    atlas = 'Sleeves',
    pos = { x = 0, y = 0 },
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
        name = "Hurry Sleeve",
        text = {
	"Reduce the winning Ante by {C:attention}2",
	"Shop's prices increase by {X:attention,C:white}+75%{}",
	"Start run with {C:money}$25{},",
	"{C:attention,T:v_seed_money}Seed Money{}",
	"and {C:attention,T:v_money_tree}Money Tree{}"
        }
    },
}


