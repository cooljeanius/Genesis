local helper = wesnoth.require "lua/helper.lua"

function wesnoth.wml_actions.init_puzzles(cfg)
    wesnoth.set_variable("echo.ice_shard",0)
    wesnoth.set_variable("echo.mirror",0)
    wesnoth.set_variable("echo.nightmare",0)
end

function wesnoth.wml_actions.firebolt_mirror(cfg)
    local u = wesnoth.get_unit("Esther")
    local t = wesnoth.get_terrain(14,11)
    local x1 = wesnoth.get_variable("spell_target.x")
    local y1 = wesnoth.get_variable("spell_target.y")
    if wesnoth.get_variable("echo.mirror") == 1 and t == "Wwby" and x1==14 and y1==11 then
        --wesnoth.play_sound("fire.wav")
        --wesnoth.set_terrain(55,32,"Wwt")
        --wesnoth.fire("redraw")
        wesnoth.wml_actions.message {speaker="Esther", message="All done."}
        wesnoth.set_variable("echo.mirror",2)
    end
end