--- MOD_NAME: Foolish Dreams (A Pseudoregalia mod)
--- MOD_ID: PseudoMod
--- MOD_AUTHOR: Northdoo MIIdris
--- PREFIX: cymbal
---Thanks for the Yahimod and the Balatro server to exist, otherwise i would have probably struggled a lot just for ONE joker.


------------MOD CODE -------------------------
PRegalia = SMODS.current_mod
PRegalia_path = SMODS.current_mod.path
PRegalia_config = SMODS.current_mod.config

---Config

PRegalia.config_tab = function()
	return {
	n = G.UIT.ROOT, 
	config = { align = "m", r = 0.1, minw = 5, minh = 1, padding = 0.1, colour = G.C.BLACK}, 
	nodes = { 
	{ n = G.UIT.R, config = { align = "m", padding = 0, minh = 0.1 }, nodes = {
	{ n = G.UIT.C, config = {align = "cl", padding =0}, 
	nodes = { create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = PRegalia_config, ref_value = "pip_menu" },
			}
                    },
       { n = G.UIT.C, config = { align = "cr", padding = 0 },
                        nodes = {
                            { n = G.UIT.T, config = { text = "Custom Menu", scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
                        }
                    },
                   }
                 },
                }
             }
end 

---El Menu
G.C.PSEUDOGOLD = HEX("7082b8")
G.C.PSEUDOBLACK = HEX("111111")
G.C.mid_flash = 0
G.C.vort_time = 7
G.C.vort_speed = 0.3

-- from cryptid apparently

local oldfunc = Game.main_menu
Game.main_menu = function(self, change_context)
	local ret = oldfunc(self, change_context)
	
if PRegalia.config.pip_menu  then
	G.SPLASH_BACK:define_draw_steps({
			{
				shader = "splash",
				send = {
					{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
           			{name = 'vort_speed', val = G.C.vort_speed},
            		{name = 'colour_1', ref_table = G.C, ref_value = 'PSEUDOBLACK'},
            		{name = 'colour_2', ref_table = G.C, ref_value = 'PSEUDOGOLD'},
            		{name = 'mid_flash', ref_table = G.C, ref_value = 'mid_flash'},
				},
			},
		})
end
	return ret
end

--pseudoregamod pool
SMODS.ObjectType({
	key = "pseudoregamod",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
	end,
})

--attires pool
SMODS.ObjectType({
	key = "attires",
	default = "j_spare_troussers",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
	end,
})

--pseudoregamod pool
SMODS.ObjectType({
	key = "pr_locations",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
	end,
})

--food
SMODS.ObjectType({
	key = "pr_food",
    default = "j_ice_cream",
    cards = {
        j_gros_michel = true,
        j_egg = true,
        j_ice_cream = true,
        j_cavendish = true,
        j_turtle_bean = true,
        j_diet_cola = true,
        j_popcorn = true,
        j_ramen = true,
        j_selzer = true,
        },
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
	end,
})

--book
SMODS.ObjectType({
	key = "cymbal_books",
	default = " j_ice_cream",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
	end,
})


--[[
--Joker Defniton be like :

if next(SMODS.find_mod("JokerDisplay")) then
    SMODS.load_file("extra/joker_def.lua")()
end

--Card Sleeves be like :

if CardSleeves then
    SMODS.Atlas { -- Main Sleeve Atlas
        key = 'Sleeves',
        path = "sleevetemplate.png",
        px = 77,
        py = 79
    }

local sleeves = NFS.getDirectoryItems(SMODS.current_mod.path .. "/extra/sleeves")
for _, file in ipairs(sleeves) do
    assert(SMODS.load_file("extra/sleeves/" .. file))()
end
end


Imagine retriggering Jokers
SMODS.current_mod.optional_features = {
	retrigger_joker = true
	}
]]
	

--Load item files
local files = NFS.getDirectoryItems(SMODS.current_mod.path  .. "/items")
for _, file in ipairs(files) do
	print("[PSEUDOMOD] Loading lua file " .. file)
	local f, err = SMODS.load_file("items/" .. file)
	if err then
		error(err) 
	end
	f()
end

--Load Localization file
local files = NFS.getDirectoryItems(SMODS.current_mod.path .. "/localization")
for _, file in ipairs(files) do
	print("[PSEUDOMOD] Loading localization file " .. file)
	local f, err = SMODS.load_file("localization/" .. file)
	if err then
		error(err) 
	end
	f()
end

---------------------------------------
------------MOD CODE END----------------------
