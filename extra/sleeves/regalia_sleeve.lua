CardSleeves.Sleeve {
    key = "sybilian",
    atlas = 'Sleeves',
    pos = { x = 0, y = 0 },

    loc_vars = function(self, info_queue, back)
    local key, vars
    if self.get_current_deck_key() == 'b_cymbal_sybilian' then
    key = self.key .. '_alt'
    self.config = { discards = 1,voucher = { 'v_telescope' } }
    vars = { self.config.discards, localize{type = 'name_text', key = self.config.voucher, set = 'Voucher' }}
    else
    key = self.key
    self.config = { hands = -1, discards = 2 }
   vars = { self.config.hands, self.config.discards }
    end
        return { key = key, vars = vars }
    end,

    apply = function(self, sleeve)
    if not self.get_current_deck_key() == 'b_cymbal_sybilian' then
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 0.5
        else
        G.GAME.used_vouchers['v_telescope'] = true
    end
    end
}
