local helper = wesnoth.require "lua/helper.lua"

function wesnoth.wml_actions.init_puzzles(cfg)
    wesnoth.set_variable("lake.water_puzzle",0)
    wesnoth.set_variable("lake.fire_puzzle",0)
    wesnoth.set_variable("lake.ice_puzzle",0)
end
-------------------------- WATER PUZZLE -------------------------------
function wesnoth.wml_actions.water_puzzle_hex(cfg)
    if wesnoth.get_variable("lake.water_puzzle") == 1 then
        wesnoth.play_sound("fire.wav")
        wesnoth.set_terrain(7,26,"Qlf")
        wesnoth.fire("redraw")
        wesnoth.set_variable("lake.water_puzzle",2)
    elseif wesnoth.get_variable("lake.water_puzzle") == 3 then
        wesnoth.play_sound("water-blast.wav")
        wesnoth.set_terrain(7,26,"Fypd")
        wesnoth.fire("redraw")
        wesnoth.delay(1000)
        wesnoth.play_sound("magic-faeriefire.ogg")
        wesnoth.delay(500)
        wesnoth.wml_actions.item {x=7,y=26,image="items/crystal-glyph-message.png"}
        wesnoth.wml_actions.remove_item {x=4,y=27}
        
        local experience=wesnoth.get_variable("puzzle_exp")
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Aryel"}}}
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Esther"}}}
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}
        
        wesnoth.set_variable("lake.water_puzzle",4)
    elseif wesnoth.get_variable("lake.water_puzzle") == 4 then
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>Water and fire together, like the push and pull of the mighty tide. The deep current and the searing flame - we are mortal enemies persisting on one plane, locked in a dance of eternal combat.</i>")}
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>Relish the terror, relish the blood! Don thy macabre masque and lock thy arms with mine! The steel that drives our bellicose dance demands the presence of both; water and fire, without one, the other is lost.</i>")}
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>Opposed, but kindred spirits, we bear that hatred which is a second instinct to necessity. It is an antipathy that binds us, whether you like it or not.</i>")}
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>Shardia...</i>")}
    end
end
function wesnoth.wml_actions.water_puzzle_fire_hex(cfg)
    if wesnoth.get_variable("lake.water_puzzle") == 0 then
        wesnoth.play_sound("flame-big.ogg")
        wesnoth.set_terrain(3,29,"Re")
        wesnoth.fire("redraw")
        wesnoth.set_variable("lake.water_puzzle",1)
    end
end
function wesnoth.wml_actions.water_puzzle_water_hex(cfg)
    if wesnoth.get_variable("lake.water_puzzle") == 2 then
        wesnoth.play_sound("wail.wav")
        wesnoth.set_terrain(2,26,"Rd")
        wesnoth.fire("redraw")
        wesnoth.set_variable("lake.water_puzzle",3)
    end
end
-------------------------- FIRE PUZZLE -------------------------------
function wesnoth.wml_actions.fire_puzzle_hex(cfg)
    if wesnoth.get_variable("lake.fire_puzzle") == 1 then
        wesnoth.play_sound("wose-die.ogg")
        wesnoth.set_terrain(47,2,"Qxv^Fdy")
        wesnoth.fire("redraw")
        wesnoth.set_variable("lake.fire_puzzle",2)
    elseif wesnoth.get_variable("lake.fire_puzzle") == 3 then
        wesnoth.play_sound("flame-big.ogg")
        wesnoth.set_terrain(47,2,"Qxv^Ecf")
        wesnoth.fire("redraw")
        wesnoth.set_variable("lake.fire_puzzle",4)
    elseif wesnoth.get_variable("lake.fire_puzzle") == 5 then
        wesnoth.play_sound("petrified.ogg")
        wesnoth.set_terrain(47,2,"Bryd")
        wesnoth.fire("redraw")
        wesnoth.delay(500)
        wesnoth.play_sound("magic-3.ogg")
        wesnoth.delay(500)
        wesnoth.set_terrain(47,2,"Urb")
        wesnoth.fire("redraw")
        wesnoth.delay(1000)
        wesnoth.play_sound("magic-faeriefire.ogg")
        wesnoth.delay(500)
        wesnoth.wml_actions.item {x=47,y=2,image="items/crystal-glyph-message.png"}
        wesnoth.wml_actions.remove_item {x=42,y=2}
        
        local experience=wesnoth.get_variable("puzzle_exp")+10
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Aryel"}}}
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Esther"}}}
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}
        
        wesnoth.set_variable("lake.fire_puzzle",6)
    elseif wesnoth.get_variable("lake.fire_puzzle") == 6 then
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>Water and fire together, like the push and pull of the mighty tide. The deep current and the searing flame - we are mortal enemies persisting on one plane, locked in a dance of eternal combat.</i>")}
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>Relish the terror, relish the blood! Don thy macabre masque and lock thy arms with mine! The steel that drives our bellicose dance demands the presence of both; water and fire, without one, the other is lost.</i>")}
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>Opposed, but kindred spirits, we bear that hatred which is a second instinct to necessity. It is an antipathy that binds us, whether you like it or not.</i>")}
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>Shardia...</i>")}
    end
end
function wesnoth.wml_actions.fire_puzzle_tree_hex(cfg)
    if wesnoth.get_variable("lake.fire_puzzle") == 0 then
        wesnoth.play_sound("wose-attack.ogg")
        wesnoth.set_terrain(44,2,"Gd")
        wesnoth.fire("redraw")
        wesnoth.set_variable("lake.fire_puzzle",1)
    end
end
function wesnoth.wml_actions.fire_puzzle_lava_hex(cfg)
    if wesnoth.get_variable("lake.fire_puzzle") == 2 then
        wesnoth.play_sound("fire.wav")
        wesnoth.set_variable("lake.fire_puzzle",3)
    end
end
function wesnoth.wml_actions.fire_puzzle_brick_hex(cfg)
    if wesnoth.get_variable("lake.fire_puzzle") == 4 then
        wesnoth.play_sound("petrified.ogg")
        wesnoth.set_terrain(45,5,"Ds")
        wesnoth.fire("redraw")
        wesnoth.set_variable("lake.fire_puzzle",5)
    end
end
-------------------------- ICE PUZZLE -------------------------------
function wesnoth.wml_actions.temple_puzzle_hex(cfg)
    local t = wesnoth.get_terrain(45,9)
    if t == "Bryd^Ii" and wesnoth.get_variable("ethea.temple") == 0 then
        wesnoth.delay(200)
        wesnoth.play_sound("rumble.ogg")
        wesnoth.play_sound("rumble.ogg")
        wesnoth.delay(500)
        wesnoth.set_terrain(48,5,"Dd")
        wesnoth.set_terrain(48,6,"Drt")
        wesnoth.fire("redraw")
        wesnoth.delay(500)
        wesnoth.wml_actions.message {speaker="Esther", message="Whoa. Those mountains just... disappeared. Looks like there's some kind of temple inside?"}
        wesnoth.wml_actions.message {speaker="Aryel", message="Might be worth checking out."}
        wesnoth.set_variable("ethea.temple",1)
    end
end
