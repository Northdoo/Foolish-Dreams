local jd_def = JokerDisplay.Definitions -- You can assign it to a variable to use as shorthand

jd_def["j_cymbal_goatling"] = {
	text = {
	{text = "x"},
	{ref_table = "card.joker_display_values", ref_value = "x_chips", retrigger_type = "exp"}
	},
	text_config = { colour = G.C.CHIPS},
	
	        reminder_text = {
            { text = "(" },
            { text = "Not "},
            { ref_table = "card.joker_display_values", ref_value = "localized_text_king" },
            { text = "," },
            { ref_table = "card.joker_display_values", ref_value = "localized_text_queen" },
            { text = " or " },
            { ref_table = "card.joker_display_values", ref_value = "localized_text_jack" },
            { text = ")" },
        },
	
        calc_function = function(card)
            local chipo = 0
            local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            if text ~= 'Unknown' then
                for _, scoring_card in pairs(scoring_hand) do
                    if scoring_card:get_id()  and  (scoring_card:get_id() <= 10 or scoring_card:get_id() == 14) then
                        chipo = chipo +
                            JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    end
                end
            end
            card.joker_display_values.x_chips = card.ability.extra.x_chips ^ chipo
            card.joker_display_values.localized_text_king = localize("King", "ranks")
            card.joker_display_values.localized_text_queen = localize("Queen", "ranks")
            card.joker_display_values.localized_text_jack = localize("Jack", "ranks")
        end
}
