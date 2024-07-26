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
    local suf = wml.get_child(cfg, "filter") or
        wml.error("[multi_turn_unit] Missing unit filter")

    local facing = cfg.facing

    local units = wesnoth.units.find_on_map(suf) or
        wml.error("[multi_turn_unit] Could not match any on-map units with [filter]")

    facing=units[1].facing

    local times = cfg.times

    for i = 1,times,1
        do
            facing = invert_direction(facing)
            units[1].facing = facing
            wesnoth.units.extract(units[1])
            wesnoth.units.to_map(units[1])
            wesnoth.interface.delay(350)
    end
end


function wesnoth.wml_actions.fade_screen(cfg)

    wesnoth.wml_actions.color_adjust {red=-25,green=-25,blue=-25}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-50,green=-50,blue=-50}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-75,green=-75,blue=-75}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-100,green=-100,blue=-100}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-125,green=-125,blue=-125}
    wesnoth.interface.delay(60)

    wesnoth.wml_actions.hide_unit {{"filter",{}}}

    wesnoth.wml_actions.color_adjust {red=-150,green=-150,blue=-150}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-175,green=-175,blue=-175}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-200,green=-200,blue=-200}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-225,green=-225,blue=-225}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-255,green=-255,blue=-255}
end

function wesnoth.wml_actions.unfade_screen(cfg)

    wesnoth.wml_actions.color_adjust {red=-225,green=-225,blue=-225}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-200,green=-200,blue=-200}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-175,green=-175,blue=-175}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-150,green=-150,blue=-150}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-125,green=-125,blue=-125}
    wesnoth.interface.delay(60)

    wesnoth.wml_actions.unhide_unit {{"filter",{}}}

    wesnoth.wml_actions.color_adjust {red=-100,green=-100,blue=-100}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-75,green=-75,blue=-75}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-50,green=-50,blue=-50}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=-25,green=-25,blue=-25}
    wesnoth.interface.delay(60)
    wesnoth.wml_actions.color_adjust {red=0,green=0,blue=0}
end

function alpha_print(text, size, alpha, duration)

    local c = mathx.round(255 * alpha)

    wesnoth.wml_actions.print({
        text = text,
        size = size,
        red = c, green = c, blue = c,
        duration=duration
    })

    wesnoth.interface.delay(20)
end

-- Arguments:
--   text:          Text displayed
--   duration:      Duration of the text after fade-in and before fade-out animations, in milliseconds
function wesnoth.wml_actions.credits_text(cfg)

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
        alpha_print(text, 24, alpha, 1000)
    end

    alpha_print(text, 24, 1.0, duration)
    wesnoth.interface.delay(duration)

    for alpha = 1.0, 0.0, -0.1 do
        alpha_print(text, 24, alpha, 1000)
    end

    wesnoth.interface.delay(1000)
end