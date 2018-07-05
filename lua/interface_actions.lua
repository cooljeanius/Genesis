
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

local wml_actions = wesnoth.wml_actions

function alpha_print(text, size, alpha)

    local c = helper.round(255 * alpha)

    wml_actions.print({
        text = text,
        size = size,
        red = c, green = c, blue = c,
        duration=1000
    })

    wesnoth.delay(20)

    wml_actions.redraw({})
end

-- Arguments:
--   text:          Text displayed
--   duration:      Duration of the text after fade-in and before fade-out animations, in milliseconds
function wml_actions.credits_text(cfg)

    local title = cfg.title
    local text = cfg.body
    local duration = cfg.duration
    --local fade_duration = cfg.fade_duration

    if text == nil then
        text = ""
    end

    if title ~= nil then
        text = "<span size='larger' weight='bold'>" .. title .. "</span>\n\n" .. text;
    end

    if duration == nil then
        duration = 5000
    end

    for alpha = 0.0, 1.0, 0.1 do
        alpha_print(text, 20, alpha)
    end

    wesnoth.delay(duration)

    for alpha = 1.0, 0.0, -0.1 do
        alpha_print(text, 20, alpha)
    end

    wml_actions.print({
        text = text,
        size = 20,
        red = 0, green = 0, blue = 0,
        duration=10
    })

    wesnoth.delay(750)
end