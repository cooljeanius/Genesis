local helper = wesnoth.require "lua/helper.lua"

function wesnoth.wml_actions.initialize_puzzles(cfg)
	if wesnoth.get_variable("bat.complete") == 0 then
	
	else
	
	end
	if wesnoth.get_variable("river.complete") == 0 then
	
	else
	
	end
	if wesnoth.get_variable("scorpion.complete") == 0 then
	
	else
	end
	if wesnoth.get_variable("fishing.complete") == 0 then
	else
	end
	if wesnoth.get_variable("mushroom.complete") == 0 then
	else
	end
end

function wesnoth.wml_actions.bat_dialogue_hex(cfg)
	if wesnoth.get_variable("bat.bat") == 0 then
		wesnoth.wml_actions.message {speaker="Esther", message="Whoa, what are all of these bats doing here?"}
		wesnoth.wml_actions.message {speaker="Battie", message="They're my pets! Aren't they cute?"}
		wesnoth.wml_actions.message {speaker="Esther", message="Erm... yes. I suppose they're cute. How do you keep them from biting you, though?"}
		wesnoth.wml_actions.message {speaker="Battie", message="Oh, are you worried about that? There's no need. They're really all very well behaved. Well, except for Eksi. She likes to run off on her own."}
		wesnoth.wml_actions.message {speaker="Aryel", message="Where is she now?"}
		wesnoth.wml_actions.message {speaker="Battie", message="Hmm. I'm not really sure. Would you mind helping me look for her?"}
		wesnoth.wml_actions.message {speaker="Aryel", message="Meh, why not."}
	elseif wesnoth.get_variable("bat.bat") == 1 then
		wesnoth.wml_actions.message {speaker="Battie", message="Oh, you found my cute little Eksi! Come here girl, mommy's got a little treat for you!"}
		wesnoth.wml_actions.message {speaker="Eksi", message="Eep! Eep!"}
		
		local experience=wesnoth.get_variable("puzzle_exp")
		wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Aryel"}}}
		wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Esther"}}}
		wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}
		
		wesnoth.set_variable("bat.bat",2)
	elseif wesnoth.get_variable("bat.bat") == 2 then
		wesnoth.wml_actions.message {speaker="Battie", message="Thanks again for helping me find Eksi!"}
	end
end
function wesnoth.wml_actions.bat_puzzle_hex(cfg)
	if wesnoth.get_variable("bat.bat") == 0 then
	
	end
end

function wesnoth.wml_actions.river_dialogue_hex(cfg)
	if wesnoth.get_variable("river.river") == 0 then
		wesnoth.wml_actions.message {speaker="Esther", message="Yikes. What happened here?"}
		wesnoth.wml_actions.message {speaker="Villager", message="We dunna kno. Just a coupla days ago, I tells mah boy to goes fetch some water from tha pond. He comes aback 'n it's all mucky and poison-looking, like dat sewer water 'n tha cities. We been livin' on tha well water fo' now. Dun suppose yew faeries kinna help us, no?"}
		wesnoth.wml_actions.message {speaker="Esther", message=string.format("(<i>glances at Aryel</i>)")}
		wesnoth.wml_actions.message {speaker="Aryel", message=string.format("(<i>shrugs</i>) Might as well take a look.")}
		wesnoth.wml_actions.message {speaker="Villager", message="Thank ye, kind faeries!"}
	elseif wesnoth.get_variable("river.river") == 1 then
		wesnoth.wml_actions.message {speaker="Villager", message="Tha water be clean again! Many thanks and blessings for ye faeries!"}
		wesnoth.wml_actions.message {speaker="Aryel", message="Yup, yup, no problem."}
		
		local experience=wesnoth.get_variable("puzzle_exp")
		wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Aryel"}}}
		wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Esther"}}}
		wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}
		
		wesnoth.set_variable("river.river",2)
	elseif wesnoth.get_variable("river.river") == 2 then
		wesnoth.wml_actions.message {speaker="Villager", message="Tha water be crystal clear!"}
	end
end
function wesnoth.wml_actions.river_puzzle_hex(cfg)
	if wesnoth.get_variable("river.river") == 0 then
	
	end
end

function wesnoth.wml_actions.scorpion_dialogue_hex(cfg)
	if wesnoth.get_variable("river.river") == 0 then
		wesnoth.wml_actions.message {speaker="", message="Yikes. What happened here?"}
		wesnoth.wml_actions.message {speaker="Villager", message="We dunna kno. Just a coupla days ago, I tells mah boy to goes fetch some water from tha pond. He comes aback 'n it's all mucky and poison-looking, like dat sewer water 'n tha cities. We been livin' on tha well water fo' now. Dun suppose yew faeries kinna help us, no?"}
		wesnoth.wml_actions.message {speaker="Esther", message=string.format("(<i>glances at Aryel</i>)")}
		wesnoth.wml_actions.message {speaker="Aryel", message=string.format("(<i>shrugs</i>) Might as well take a look.")}
		wesnoth.wml_actions.message {speaker="Villager", message="Thank ye, kind faeries!"}
	elseif wesnoth.get_variable("river.river") == 1 then
		wesnoth.wml_actions.message {speaker="Villager", message="Tha water be clean again! Many thanks and blessings for ye faeries!"}
		wesnoth.wml_actions.message {speaker="Aryel", message="Yup, yup, no problem."}
		
		local experience=wesnoth.get_variable("puzzle_exp")
		wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Aryel"}}}
		wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Esther"}}}
		wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}
		
		wesnoth.set_variable("river.river",2)
	elseif wesnoth.get_variable("river.river") == 2 then
		wesnoth.wml_actions.message {speaker="Villager", message="Tha water be crystal clear!"}
	end
end

--[[

function wesnoth.wml_actions.clear_sound_puzzle(cfg)
	wesnoth.set_variable("puzzle_sound.counter",nil)
	wesnoth.wml_actions.remove_item {x=10,y=7}
	wesnoth.wml_actions.remove_item {x=8,y=3}
	wesnoth.wml_actions.remove_item {x=10,y=3}
	wesnoth.wml_actions.remove_item {x=12,y=3}
end

function wesnoth.wml_actions.puzzle_earth_flower_hex(cfg)
    if wesnoth.get_variable("puzzle_earth.flower") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="There are some flower seeds on the ground."}
		wesnoth.set_terrain(10,9,"Gll^Fp")
		wesnoth.set_variable("puzzle_earth.flower",1)
	end
end

function wesnoth.wml_actions.puzzle_earth_sunlight_hex(cfg)
    if wesnoth.get_variable("puzzle_earth.flower") == 1 and wesnoth.get_variable("puzzle_earth.sunlight") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="The seeds blossom into a flower."}
		wesnoth.set_terrain(13,9,"Gll")
		wesnoth.wml_actions.item {x=13,y=9,image="items/flower2.png"}
		wesnoth.set_variable("puzzle_earth.flower",2)
		wesnoth.set_variable("puzzle_earth.sunlight",1)
	elseif wesnoth.get_variable("puzzle_earth.sunlight") == 1 then
		wesnoth.wml_actions.message {speaker="narrator", message="A sprig of lavender has grown here."}
		wesnoth.wml_actions.remove_item {x=13,y=9}
		wesnoth.set_variable("puzzle_earth.flower",3)
		wesnoth.set_variable("puzzle_earth.sunlight",2)
	elseif wesnoth.get_variable("puzzle_earth.flower") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
	end
end

function wesnoth.wml_actions.puzzle_earth_water_hex(cfg)
    if wesnoth.get_variable("puzzle_earth.water") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You picked up a glass of water."}
		wesnoth.set_terrain(14,6,"Gll^Fp")
		wesnoth.wml_actions.remove_item {x=14,y=6}
		wesnoth.set_variable("puzzle_earth.water",1)
	end
end

function wesnoth.wml_actions.puzzle_earth_fire_hex(cfg)
    if wesnoth.get_variable("puzzle_earth.water") == 1 and wesnoth.get_variable("puzzle_earth.hotwater") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="The fire heats the water."}
		wesnoth.set_terrain(18,9,"Gs^Fms")
		wesnoth.wml_actions.item {x=18,y=9,image="items/holy-water.png"}
		wesnoth.set_variable("puzzle_earth.water",2)
		wesnoth.set_variable("puzzle_earth.hotwater",1)
	elseif wesnoth.get_variable("puzzle_earth.flower") == 3 and wesnoth.get_variable("puzzle_earth.hotwater") == 1 then
		wesnoth.wml_actions.message {speaker="narrator", message="You made some tea!"}
		wesnoth.wml_actions.message {speaker="Yumi", message=string.format("(<i>sips</i>)")}
		wesnoth.set_terrain(15,10,"Gll^Fp")
		wesnoth.wml_actions.remove_item {x=18,y=9}
		wesnoth.wml_actions.remove_item {x=15,y=10}
		
		local experience=wesnoth.get_variable("large_puzzle_exp")
		wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}

		wesnoth.set_variable("puzzle_earth.hotwater",2)
		wesnoth.set_variable("puzzle_earth.complete",1)
	elseif wesnoth.get_variable("puzzle_earth.complete") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
	end
end


function wesnoth.wml_actions.puzzle_ice_fruit_hex(cfg)
	if wesnoth.get_variable("puzzle_ice.fruit") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="There are some strawberries growing here."}
		wesnoth.set_terrain(46,12,"Ai")
		wesnoth.set_variable("puzzle_ice.fruit",1)
	end
end

function wesnoth.wml_actions.puzzle_ice_blender_hex(cfg)
	if wesnoth.get_variable("puzzle_ice.fruit") == 1 then
		wesnoth.wml_actions.message {speaker="narrator", message="You blended some strawberries."}
		wesnoth.set_terrain(44,3,"Ai")
		wesnoth.set_variable("puzzle_ice.fruit",2)
	elseif wesnoth.get_variable("puzzle_ice.fruit")==2 then
		wesnoth.wml_actions.message {speaker="narrator", message="You picked up the blended strawberries."}
		wesnoth.set_variable("puzzle_ice.fruit",3)
	elseif wesnoth.get_variable("puzzle_ice.fruit") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
	end
end

function wesnoth.wml_actions.puzzle_ice_freezer_hexes(cfg)
	if wesnoth.get_variable("puzzle_ice.fruit") == 3 then
		wesnoth.wml_actions.message {speaker="narrator", message="You made a popsicle!"}
		wesnoth.wml_actions.message {speaker="Yumi", message=string.format("<i>It's sweet.</i>")}
		wesnoth.set_variable("puzzle_ice.fruit",4)
		wesnoth.set_variable("puzzle_ice.complete",1)
	elseif wesnoth.get_variable("puzzle_ice.complete") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
	end
end

function wesnoth.wml_actions.puzzle_water_fire_scepter_hex(cfg)
	if wesnoth.get_variable("puzzle_water_fire.scepter") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You picked up a lighter."}
		wesnoth.set_variable("puzzle_water_fire.scepter",1)
	end
end

function wesnoth.wml_actions.puzzle_water_fire_brazier_hex(cfg)
	if wesnoth.get_variable("puzzle_water_fire.scepter") == 1 then
		wesnoth.wml_actions.message {speaker="narrator", message="You lit the brazier."}
		wesnoth.set_variable("puzzle_water_fire.scepter",2)
	elseif wesnoth.get_variable("puzzle_water_fire.scepter") == 2 then
		wesnoth.wml_actions.message {speaker="narrator", message="You picked up the fire."}
		wesnoth.set_variable("puzzle_water_fire.scepter",3)	
	elseif wesnoth.get_variable("puzzle_water_fire.scepter") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
	end
end

function wesnoth.wml_actions.puzzle_water_fire_whirlpool_hex(cfg)
	if wesnoth.get_variable("puzzle_water_fire.scepter") == 3 then
		wesnoth.wml_actions.message {speaker="narrator", message="Steam rises from the water."}
		wesnoth.set_variable("puzzle_water_fire.scepter",4)
	elseif wesnoth.get_variable("puzzle_water_fire.scepter") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
	end
end

function wesnoth.wml_actions.puzzle_water_fire_grain_hex(cfg)
	if wesnoth.get_variable("puzzle_water_fire.grain") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You picked up some grain."}
		wesnoth.set_variable("puzzle_water_fire.grain",1)
	end
end

function wesnoth.wml_actions.puzzle_water_fire_windmill_hex(cfg)
	if wesnoth.get_variable("puzzle_water_fire.scepter") < 4 then
		wesnoth.wml_actions.message {speaker="narrator", message="The windmill is not running."}
	elseif wesnoth.get_variable("puzzle_water_fire.scepter") == 4 and wesnoth.get_variable("puzzle_water_fire.grain") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="The windmill is running."}
	elseif wesnoth.get_variable("puzzle_water_fire.scepter") == 4 and wesnoth.get_variable("puzzle_water_fire.grain") == 1 then
		wesnoth.wml_actions.message {speaker="narrator", message="You made some bread!"}
		wesnoth.wml_actions.message {speaker="Yumi", message=string.format("(<i>nibbles</i>)")}
		
		local experience=wesnoth.get_variable("large_puzzle_exp")
		wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}

		wesnoth.set_variable("puzzle_water_fire.scepter",5)
		wesnoth.set_variable("puzzle_water_fire.grain",2)
		wesnoth.set_variable("puzzle_water_fire.complete",1)
	end
end

function wesnoth.wml_actions.clear_all_vars(cfg)
	wesnoth.set_variable("large_puzzle_exp",nil)
	wesnoth.set_variable("small_puzzle_exp",nil)
	
	wesnoth.set_variable("puzzle_earth.complete",nil)
    wesnoth.set_variable("puzzle_ice.complete",nil)
    wesnoth.set_variable("puzzle_water_fire.complete",nil)
    wesnoth.set_variable("puzzle_life.complete",nil)
	
    wesnoth.set_variable("puzzle_earth.sunlight",nil)
    wesnoth.set_variable("puzzle_earth.flower",nil)
    wesnoth.set_variable("puzzle_earth.hotwater",nil)
    wesnoth.set_variable("puzzle_earth.water",nil)
	
	wesnoth.set_variable("puzzle_ice.fruit",nil)
	
    wesnoth.set_variable("puzzle_water_fire.scepter",nil)
    wesnoth.set_variable("puzzle_water_fire.grain",nil)
	
	wesnoth.set_variable("puzzle_life.fire",nil)
	wesnoth.set_variable("puzzle_life.milk",nil)
	wesnoth.set_variable("puzzle_life.eggs",nil)
	wesnoth.set_variable("puzzle_life.chocolate",nil)
	wesnoth.set_variable("puzzle_life.vanilla",nil)
	wesnoth.set_variable("puzzle_life.sugar",nil)
end
--]]