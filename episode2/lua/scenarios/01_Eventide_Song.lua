local helper = wesnoth.require "lua/helper.lua"

function wesnoth.wml_actions.swap_starting_terrain(cfg)
	wesnoth.wml_actions.terrain {{"and",{terrain="Xu,Woby"}},terrain="Ss"}
	wesnoth.wml_actions.store_locations {terrain="Ss",variable="hexes"}
	hexes = helper.get_variable_array("hexes")
	
	for i,v in ipairs(hexes) do
		wesnoth.set_terrain(hexes[i].x,hexes[i].y,"Gg")
	end
	
	--wesnoth.set_variable("hexes",nil)
end

function wesnoth.wml_actions.initialize_puzzles(cfg)
    wesnoth.wml_actions.set_variable("puzzle_earth.complete",0)
    wesnoth.wml_actions.set_variable("puzzle_ice.complete",0)
    wesnoth.wml_actions.set_variable("puzzle_water_fire.complete",0)
    wesnoth.wml_actions.set_variable("puzzle_life.complete",0)
	
    wesnoth.wml_actions.set_variable("puzzle_earth.sunlight",0)
    wesnoth.wml_actions.set_variable("puzzle_earth.flower",0)
    wesnoth.wml_actions.set_variable("puzzle_earth.hotwater",0)
end

function wesnoth.wml_actions.puzzle_earth_flower_hex(cfg)
    if wesnoth.get_variable("puzzle_earth.sunlight") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="There are some flower seeds on the ground."}
		wesnoth.set_terrain(10,9,"Gll")
		wesnoth.set_variable("puzzle_earth.flower",1)
	end
end

function wesnoth.wml_actions.puzzle_earth_sunlight_hex(cfg)
    if wesnoth.get_variable("puzzle_earth.sunlight") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="There are some flower seeds on the ground."}
		wesnoth.set_terrain(10,9,"Gll")
		wesnoth.set_variable("puzzle_earth.flower",1)
	end
end

function wesnoth.wml_actions.puzzle_earth_water_hex(cfg)
    
end

function wesnoth.wml_actions.clear_all_vars(cfg)

end