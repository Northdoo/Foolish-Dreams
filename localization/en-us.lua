return {
    descriptions = {
        Joker = {
            j_cymbal_untextured = {
                name = "Untextured Joker",
                text = { "{C:inactive, E:2} (Does something different each round.){}",
                "{s:0.8,C:inactive, E:2}(And also is immune to editions.)"
                },
            },
            j_cymbal_untextured_alt = { 
                name = "Un..tex...ture..d J...ok..er",
                text = { "{C:dark_edition,E:1}+100{} Chips"
                },
            },
            j_cymbal_untextured_alt2 = { 
                name = "Un..d......j.k..r.",
                text = { "{C:dark_edition,E:1}+20{} Mult"
                },
            },
            j_cymbal_untextured_alt3 = { 
                name = "U.n.t...e.x.t.u.r.e.d..J.o.k.e.r",
                text = { "{X:dark_edition,C:white,E:1}x3{} Mult"
                },
            },
            
            j_cymbal_untextured_alt4 = { 
                name = "U..ntextu..red..J.k..er..",
                text = { "Gain {C:dark_edition,E:1}#1#${} at the end of the round"
                },
            },
          },
	Sleeve = {
	sleeve_cymbal_sybilian = { 
                name = "Regalia Sleeve",
                text = { "{C:red}+2{} Discards and",
            "{C:blue}-1{} Hand",
            "every round",
            "{s:0.85}Required score{} {C:attention}scales slghtly faster{}",
             "{s:0.85}each{} {C:attention}Ante{}"
        }
    },
	sleeve_cymbal_sybilian_alt = { 
                name = "Regalia Sleeve",
                text = { "{C:red}+#1#{} Discard",
            "Start round with",
	  "Telescope"
        }
    },
	sleeve_cymbal_princessdeck_alt= { 
                name = "The Princess' Sleeve",
                text = { "x10 Negative Rate",
                "Start with Teh Soul"
        }
    },
	sleeve_cymbal_princessdeck= { 
                name = "The Princess' Sleeve",
                text = { "Winning Ante is increased by {C:attention}4",
	"Start run with",
	"{C:attention,T:v_overstock_norm}Overstock{},",
	"{C:attention,T:v_omen_globe} Omen Globe{},",
	"And {C:dark_edition}+2{} Joker Slots",
        },
     },
   },
Blind = {
            bl_cymbal_bos_prestige = {
                name = "The Prestige",
    	    text = {
            "Regain your $#1#",
            "If blind is defeated without",
            "using all your hands",
                }
            },
            bl_cymbal_bos_prestige_alt = {
                name = "The Prestige",
    	    text = {
            "Removes your debt ($#1#)",
            "If blind is defeated without",
            "using all your hands",
                }
            },
           },
misc = {
        dictionary = {
            ["j_cymbal_solSister"] = "Saved by Sol Sister"
          }
        },
Other = {
            negative_menu_desc = {
                name = "Negative Menu",
                text = {
                    "An apetizer ({C:attention}Turtle Bean{} or {C:attention}Egg{})",
                    "A main meal ({C:attention}Popcorn{} or {C:attention}Ramen{})",
                    "A drink ({C:attention}Selzer{} or {C:attention}Diet Cola{})",
                    "And a dessert ({C:attention}Ice Cream{},",
                    "{C:attention}Gros Michel{} or {C:attention}Cavendish{})",
                }
            },
            showman_proof = {
                name = "Showman-Proof",
                text = {"This card {C:attention}can't reappear{}",
            "if already acquired",
                        }
            }
}
  }
}
