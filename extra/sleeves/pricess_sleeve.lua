CardSleeves.Sleeve {
    key = "princessdeck",
    atlas = 'Sleeves',
    pos = { x = 0, y = 0 },
    
   loc_vars = function(self, info_queue, back)
        local key, vars
        if  self.get_current_deck_key() == 'b_cymbal_princessdeck' then
            key = self.key .. '_alt'
            self.config = {consumables = { 'c_soul'}}
            vars = {}
           if self.config.consumables then
            vars[#vars+1] = localize{type = 'name_text', key = self.config.consumables[1], set = 'Spectral'}
            end
        else
           key = self.key
            self.config = { joker_slot = 2, vouchers = { 'v_overstock_norm', 'v_omen_globe' } }
            vars = {
                localize { type = 'name_text', key = self.config.vouchers[1], set = 'Voucher' },
                localize { type = 'name_text', key = self.config.vouchers[2], set = 'Voucher' }
            }
        end

        return { key = key, vars = vars }
    end,

  --[[ 
    apply = function(self, card, area)
        if not self.get_current_deck_key() == 'b_cymbal_princessdeck' then
            G.GAME.win_ante = G.GAME.win_ante + 4
            G.GAME.used_vouchers['v_overstock_norm'] = true
            G.GAME.used_vouchers['v_omen_globe'] = true
        else
            SMODS.add_card {
                set = 'Spectral',
                key = 'c_soul',
                skip_materialize = false,
            }
        end

        SMODS.Edition:take_ownership('e_negative', {
            get_weight = function(self)
                local weight = (self.weight) * (G.GAME and G.GAME.edition_rate or 1)
                weight = weight * 100000000
                return weight
            end
        }, true)
    end,
    ]]
}




--rejected princess code
--[[       
       local nopack = { 'tag_standard', 'tag_charm','tag_meteor','tag_buffoon','tag_ethereal'}
       
for i, b in pairs(nopack) do
G.GAME.banned_keys[b] = true
end
]]
