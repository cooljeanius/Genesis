
---
-- Turns a unit four times
-- Only affects the first unit matching the filter
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
function wesnoth.wml_actions.turn_unit_four(cfg)
    local suf = helper.get_child(cfg, "filter") or
        helper.wml_error("[set_facing] Missing unit filter")

    local facing = cfg.facing

    local units = wesnoth.get_units(suf) or
        helper.wml_error("[set_facing] Could not match any on-map units with [filter]")

    facing=units[1].facing

    for i = 0,3,1
        do
            facing = invert_direction(facing)
            units[1].facing = facing
            wesnoth.extract_unit(units[1])
            wesnoth.put_unit(units[1])
            wesnoth.delay(350)
    end

end