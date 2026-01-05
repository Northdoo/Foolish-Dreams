--[[ SMODS.PokerHand {
key = 'Sol Flush',
	loc_txt = {
	name = 'Sol Flush',
	description =  {"Five sol cards"
},},
mult = 2,
chips = 20,
l_mult = 3,
l_chips = 10,
visible = false,
above_hand = 'Flush',
example = {
        { 'H_Q', true, enhancement = 'm_cymbal_sol'},
        { 'H_J', true, enhancement = 'm_cymbal_sol' }, 
        { 'D_9', true, enhancement = 'm_cymbal_sol' }, 
        { 'H_6', true, enhancement = 'm_cymbal_sol' },
        { 'D_3', true, enhancement = 'm_cymbal_sol'} 
    },
    evaluate = function(parts, hand)
        if #hand == 5  then
            local soleil = true
            for _, card in ipairs(hand) do
                if not SMODS.has_enhancement(card, 'm_cymbal_sol') then
                    soleil = false
                    break
                end
            end
            if soleil then
                return { hand }
            end
        end
        return {}
    end
}
]]

SMODS.PokerHand {
key = 'sunstone_house',  --Makemake plannet
	loc_txt = {
	name = 'Sunstone',
	description =  {"Three stone cards and Two sol cards"
},},
mult = 5,
chips = 50,
l_mult = 2,
l_chips = 50,
visible = false,
above_hand = 'Full House',
example = {
        { 'H_Q', true, enhancement = 'm_stone'},
        { 'H_J', true, enhancement = 'm_stone' }, 
        { 'D_9', true, enhancement = 'm_stone' }, 
        { 'H_6', true, enhancement = 'm_cymbal_sol' },
        { 'D_3', true, enhancement = 'm_cymbal_sol'} 
    },
    evaluate = function(parts, hand)
        if #hand == 5 then
            local stone_count = 0
            local sol_count = 0

            for _, card in ipairs(hand) do
                if SMODS.has_enhancement(card, 'm_stone') then
                    stone_count = stone_count + 1
                elseif SMODS.has_enhancement(card, 'm_cymbal_sol') then
                    sol_count = sol_count + 1
                end
            end

            if stone_count == 3 and sol_count == 2 then
                return { hand }
            end
        end
        return {}
    end
}














--[[
SMODS.PokerHand {
key = '15898',
	loc_txt = {
	description =  {"(NON-UPGRADABLE)"
},},
mult = 98,
chips = 158,
l_mult = 0,
l_chips = 0,
visible = false,
above_hand = 'Royal Flush',
example = {
        { 'S_A', true,},
        { 'H_5', true,}, 
        { 'D_8', true, }, 
        { 'C_9', true, },
        { 'D_8', true,} 
    },
    evaluate = function(parts, hand)
        if #hand == 5 then
            local ace_count = 0
            local eight_count = 0
            local five_found = false
            local nine_found = false

            for i = 1, #hand do
                local card_id = hand[i]:get_id()
                if card_id == 14 then
                    ace_count = ace_count + 1
                elseif card_id == 8 then
                    eight_count = eight_count + 1
                elseif card_id == 5 then
                    five_found = true
                elseif card_id == 9 then
                    nine_found = true
                end
            end

            if ace_count == 1 and eight_count == 2 and five_found and nine_found then
                return {hand}
            end
        end
        return {}
    end
}

--]]
