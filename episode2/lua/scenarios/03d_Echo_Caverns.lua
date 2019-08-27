local helper = wesnoth.require "lua/helper.lua"

function wesnoth.wml_actions.init_puzzles(cfg)
    wesnoth.set_variable("echo.ice_shard",0)
    wesnoth.set_variable("echo.mirror",0)
    wesnoth.set_variable("echo.nightmare",0)
end

function wesnoth.wml_actions.fishing_puzzle_hex(cfg)
    local u = wesnoth.get_unit("Esther")
    if wesnoth.get_variable("ethea.fishing") == 1 and u.x == 55 and u.y ==32 then
        wesnoth.wml_actions.message {speaker="Esther", message="Hmm. I suppose I could melt the ice for that crabby old dog."}
        wesnoth.wml_actions.message {speaker="Aryel", message="If you want."}
        wesnoth.wml_actions.message {speaker="Esther", message="Well, why not?"}
        wesnoth.delay(500)
        wesnoth.play_sound("fire.wav")
        wesnoth.set_terrain(55,32,"Wwt")
        wesnoth.fire("redraw")
        wesnoth.wml_actions.message {speaker="Esther", message="All done."}
        wesnoth.set_variable("ethea.fishing",2)
    elseif wesnoth.get_variable("ethea.fishing") == 1 then
        wesnoth.wml_actions.message {speaker="Aryel", message="Guess we need Esther for this."}
    elseif wesnoth.get_variable("ethea.fishing") == 3 then
        wesnoth.wml_actions.message {speaker="Aryel", message="Should be easy to catch some fish, if you gals are hungry."}
        wesnoth.wml_actions.message {speaker="Esther", message="Not me. Yumi?"}
        wesnoth.wml_actions.message {speaker="Yumi", message="It stinks..."}
        wesnoth.wml_actions.message {speaker="Aryel", message="Alright. All for me, then."}
        wesnoth.wml_actions.add_hp {hp=1,{"filter",{id="Aryel"}}}
        wesnoth.set_variable("ethea.fishing",4)
    end
end

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
