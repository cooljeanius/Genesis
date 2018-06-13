
---
-- Turns a unit X times
-- Only affects the first unit matching the filter
-- [multi_turn_unit]
--     [filter]
--         ... SUF ...
--     [/filter]
--     times={X}
-- [/multi_turn_unit]
---
function invert_direction(dir)
    if dir == "s" then
        dir = "n"
    elseif dir == "sw" then
        dir = "ne"
    elseif dir == "nw" then
        dir = "se"
    elseif dir == "n" then
        dir = "n"
    elseif dir == "ne" then
        dir = "sw"
    else -- if dir == "se" then
        dir = "nw"
    end

    return dir
end
function wesnoth.wml_actions.multi_turn_unit(cfg)
    local suf = helper.get_child(cfg, "filter") or
        helper.wml_error("[set_facing] Missing unit filter")

    local facing = cfg.facing

    local units = wesnoth.get_units(suf) or
        helper.wml_error("[set_facing] Could not match any on-map units with [filter]")

    facing=units[1].facing

	local times = cfg.times
	
    for i = 1,times,1
        do
            facing = invert_direction(facing)
            units[1].facing = facing
            wesnoth.extract_unit(units[1])
            wesnoth.put_unit(units[1])
            wesnoth.delay(350)
    end

end