local helper = wesnoth.require "lua/helper.lua"

function wesnoth.wml_actions.init_puzzles(cfg)
    wesnoth.set_variable("lake.water_puzzle",0)
    wesnoth.set_variable("lake.fire_puzzle",0)
    wesnoth.set_variable("lake.ice_puzzle",0)
    wesnoth.set_variable("lake.scenario_stage",0)
    wesnoth.set_variable("lake.counter",0)
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
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>Water and fire flow together like the push and pull of the mighty tide. The deep current and the searing flame - we are mortal enemies persisting on a single plane, locked in a dance of eternal combat.</i>")}
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>Relish the terror, relish the blood! Don thy macabre masque and lock thy arms with mine! The steel that drives our bellicose dance demands the presence of both; water and fire, without one, the other is lost.</i>")}
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>Opposed, but kindred spirits, we bear that hatred which is a second instinct to necessity. It is an antipathy that binds us, whether you like it or not...</i>")}
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
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>A shining star in the darkness, the keeper of the sacred flame needed to spark all Life... that is Shardia. A staunch protector against the savage beast hordes that hail from the depths of Norsula's oceans. That... is Shardia.</i>")}
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>But you know as well as I do, don't you? The fire that burns the brightest is also the one that consumes the greatest. Yours is but a facade of warmth. In truth, you embrace carnage as much as I, so long as it suits your means. We are not so different. You know this, no matter how much you protest with your feeble words.</i>")}
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>Flame both is the spark of life and that which burns it to ashen cinders. Isn't that right, Shardia?</i>")}
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
function wesnoth.wml_actions.ice_puzzle_hex(cfg)
    if wesnoth.get_variable("lake.ice_puzzle") == 1 then
        wesnoth.play_sound("gate-fall.ogg")
        wesnoth.set_terrain(34,28,"Ayb^Pyg")
        wesnoth.fire("redraw")
        wesnoth.set_variable("lake.ice_puzzle",2)
    elseif wesnoth.get_variable("lake.ice_puzzle") == 3 then
        wesnoth.play_sound("mace.wav")
        wesnoth.set_terrain(34,28,"Ctym")
        wesnoth.fire("redraw")
        wesnoth.delay(1000)
        wesnoth.play_sound("magic-faeriefire.ogg")
        wesnoth.delay(500)
        wesnoth.wml_actions.item {x=34,y=28,image="items/crystal-glyph-message.png"}
        wesnoth.wml_actions.remove_item {x=37,y=26}
        
        local experience=wesnoth.get_variable("puzzle_exp")
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Aryel"}}}
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Esther"}}}
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}
        
        wesnoth.set_variable("lake.ice_puzzle",4)
    elseif wesnoth.get_variable("lake.ice_puzzle") == 4 then
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>Frozen water, mirror ice, that which may be brittle enough to shatter with a mere breath, or that which can withstand all but the mightiest of strikes. It is uncanny, is it not? Given the right density, water... merely frozen water, can be as strong as the steel forged in the depths of our great furnaces on Norsula.</i>")}
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>A marvelous substance. A pity its Guardian only uses it for meaningless mystic nonsense. If Yukiria put the same effort into harnessing the physical and magical properties of her element for battle, she could raise an army to rival even mine.</i>")}
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>Imagine. Ice, a material, when used properly, that can reflect all manner of magic and whose cutting power only grows as it shatters further. A freezing cold that can pierce through the hardest metal and a magic mirror which can reflect and distort reality itself. Combined with the physical imperveability of water, I would be unstoppable.</i>")}
        wesnoth.wml_actions.message {speaker="narrator", message=string.format("<i>She cares not for the battle in which we partake, but perhaps Yukiria can still be convinced. We shall see.</i>")}
    end
end
function wesnoth.wml_actions.ice_puzzle_grid_hex(cfg)
    if wesnoth.get_variable("lake.ice_puzzle") == 0 then
        wesnoth.play_sound("gate.ogg")
        wesnoth.set_terrain(40,28,"Ai")
        wesnoth.fire("redraw")
        wesnoth.set_variable("lake.ice_puzzle",1)
    end
end
function wesnoth.wml_actions.ice_puzzle_metal_hex(cfg)
    if wesnoth.get_variable("lake.ice_puzzle") == 2 then
        wesnoth.play_sound("mace.ogg")
        wesnoth.set_terrain(35,32,"Ai")
        wesnoth.fire("redraw")
        wesnoth.set_variable("lake.ice_puzzle",3)
    end
end
