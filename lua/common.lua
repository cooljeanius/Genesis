---
-- General-purpose Lua WML actions.
---

---
-- Assigns a given variable (presumed to be a direction value)
-- the opposite of its current contents. If the variable doesn't
-- seem to be a direction value, SE is used, setting it to NW.
--
-- [invert_direction]
--     variable="direction"
-- [/invert_direction]
---
function wesnoth.wml_actions.invert_direction(cfg)
    local variable = cfg.variable or "direction"

    local dir = wesnoth.get_variable(variable)

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

    wesnoth.set_variable(variable, dir)
end

---
-- Gets the relative direction of a source hex to a target hex.
-- Useful to determine in which direction a unit should be facing
-- (from the source) to look at another unit (at the target).
--
-- [store_direction]
--     from_x,from_y= ...
--     to_x,to_y= ...
--     variable="direction"
-- [/store_direction]
--
-- Or:
--
-- [store_direction]
--     [from]
--         ... SLF ...
--     [/from]
--     [to]
--         ... SLF ...
--     [/to]
--     variable="direction"
-- [/store_direction]
---
function wesnoth.wml_actions.store_direction(cfg)
    local from_slf = wml.get_child(cfg, "from")
    local to_slf = wml.get_child(cfg, "to")

    local a = { x = cfg.from_x, y = cfg.from_y }
    local b = { x = cfg.to_x  , y = cfg.to_y   }

    if from_slf then
        a.x = wesnoth.get_locations(from_slf)[1][1]
        a.y = wesnoth.get_locations(from_slf)[1][2]
    end
    if to_slf then
        b.x = wesnoth.get_locations(to_slf)[1][1]
        b.y = wesnoth.get_locations(to_slf)[1][2]
    end

    if not a.x or not a.y or not b.x or not b.y then
        helper.wml_error "[store_direction] missing coordinate!"
    end

    local variable = cfg.variable or "direction"

    wesnoth.set_variable(variable, hex_facing(a, b))
end

---
-- Changes one or more units' facing to follow the specified location, unit,
-- or direction.
--
-- [set_facing]
--     [filter]
--         ... SUF ...
--     [/filter]
--     [filter_location]
--         ... SLF ...
--     [/filter_location]
-- [/set_facing]
--
-- Or:
--
-- [set_facing]
--     [filter]
--         ... SUF ...
--     [/filter]
--     [filter_second]
--         ... SUF ...
--     [/filter_second]
-- [/set_facing]
--
-- Or:
--
-- [set_facing]
--     [filter]
--         ... SUF ...
--     [/filter]
--     facing= ... direction ...
-- [/set_facing]
---
function wesnoth.wml_actions.set_facing(cfg)
    local suf = wml.get_child(cfg, "filter") or
        helper.wml_error("[set_facing] Missing unit filter")

    local facing = cfg.facing
    local target_suf = wml.get_child(cfg, "filter_second")
    local target_slf = wml.get_child(cfg, "filter_location")

    local target_loc, target_u

    if not facing then
        if target_suf then
            target_u = wesnoth.units.find_on_map(target_suf)[1] or
                helper.wml_error("[set_facing] Could not match the specified [filter_second] unit")
        elseif target_slf then
            target_loc = wesnoth.get_locations(target_slf)[1] or
                helper.wml_error("[set_facing] Could not match the specified [filter_location] location")
        end
    end

    local units = wesnoth.units.find_on_map(suf) or
        helper.wml_error("[set_facing] Could not match any on-map units with [filter]")

    for i, u in ipairs(units) do
        local new_facing

        if facing then
            new_facing = facing
        elseif target_u then
            new_facing = hex_facing(
                { x = u.x, y = u.y },
                { x = target_u.x, y = target_u.y }
            )
        elseif target_loc then
            new_facing = hex_facing(
                { x = u.x, y = u.y },
                { x = target_loc[1], y = target_loc[2] }
            )
        else
            helper.wml_error("[set_facing] Missing facing or [filter_second] or [filter_location]")
        end

        if new_facing ~= u.facing then
            u.facing = new_facing

            -- HACK:
            -- Force Wesnoth to re-read the unit's current facing and update the game
            -- display accordingly. Against what one would normally expect, calling
            -- [redraw] does *not* work as an alternative.

            wesnoth.units.extract(u)
            wesnoth.units.to_map(u)
        end
    end
end

---
-- Spawns mechanical "Door" units on gate terrain hexes.
--
-- [setup_doors]
--     side=(side number)
--     terrain=(optional terrain filter string, default "*^Z\,*^Z/")
--     ... optional SLF ...
-- [/setup_doors]
---
function wesnoth.wml_actions.setup_doors(cfg)
    local owner_side = cfg.side or
        helper.wml_error("[setup_doors] No owner side= specified")

    cfg = wml.parsed(cfg)

    if cfg.terrain == nil then
        cfg["terrain"] = "*^Z\\,*^Z/"
    end

    cfg.side = nil
    local locs = wesnoth.get_locations(cfg)

    for k, loc in ipairs(locs) do
        wesnoth.units.to_map(loc[1], loc[2], {
            type = "Door",
            side = owner_side,
            id = ("__door_X%dY%d"):format(loc[1], loc[2]),
        })
    end
end

---
-- Stores a list of unit ids matching a certain filter.
--
-- To store ids from recall lists, x and y must be either absent
-- or set to "recall" in the base filter (not subfilters!).
--
-- [store_unit_ids]
--     [filter]
--         ...
--     [/filter]
--     variable=ids_store
-- [/store_unit_ids]
---
function wesnoth.wml_actions.store_unit_ids(cfg)
    local filter = wml.get_child(cfg, "filter") or
        helper.wml_error "[store_unit_ids] missing required [filter] tag"
    local var = cfg.variable or "units"
    local idx = 0
    if cfg.mode == "append" then
        idx = wesnoth.get_variable(var .. ".length")
    else
        wesnoth.set_variable(var)
    end

    for i, u in ipairs(wesnoth.units.find_on_map(filter)) do
        wesnoth.set_variable(string.format("%s[%d].id", var, idx), u.id)
        idx = idx + 1
    end

    if (not filter.x or filter.x == "recall") and (not filter.y or filter.y == "recall") then
        for i, u in ipairs(wesnoth.get_recall_units(filter)) do
            wesnoth.set_variable(string.format("%s[%d].id", var, idx), u.id)
            idx = idx + 1
        end
    end
end

---
-- Removes the terrain overlay from every hex matching a given SLF.
--
-- [remove_terrain_overlays]
--     ... SLF ...
-- [/remove_terrain_overlays]
---
function wesnoth.wml_actions.remove_terrain_overlays(cfg)
    local locs = wesnoth.get_locations(cfg)

    for i, loc in ipairs(locs) do
        local locstr = wesnoth.get_terrain(loc[1], loc[2])
        wesnoth.set_terrain(loc[1], loc[2], string.gsub(locstr, "%^.*$", ""))
    end
end

---
-- Matches a standard location filter and stores the resultant coordinates
-- list in a container with two attributes that are comma-separated lists, .x and .y.
--
-- [simplify_location_filter]
--     ... SLF ...
--     variable="location"
-- [/simplify_location_filter]
---
function wesnoth.wml_actions.simplify_location_filter(cfg)
    local var = cfg.variable or "location"
    local locs = wesnoth.get_locations(cfg)
    local xstr, ystr = "", ""

    wesnoth.set_variable(var)

    for i, loc in ipairs(locs) do
        if i > 1 then
            xstr = xstr .. string.format(",%d", loc[1])
            ystr = ystr .. string.format(",%d", loc[2])
        else
            xstr = string.format("%d", loc[1])
            ystr = string.format("%d", loc[2])
        end
    end

    wesnoth.set_variable(var .. ".x", xstr)
    wesnoth.set_variable(var .. ".y", ystr)
end

---
-- Creates a unit that's initially hidden from view as if [hide_unit]
-- was used on it.
--
-- This is necessary since [unit] followed by [hide_unit] allows the unit
-- to be displayed for an instant.
--
-- The syntax is identical to [unit].
---

function wesnoth.wml_actions.hidden_unit(cfg)
    local u = wesnoth.create_unit(cfg)
    -- Don't clobber existing units. We don't check for passability
    -- because we occasionally use this with units that have infinite
    -- movement costs on all terrains, and there's no need to make
    -- this smarter than [unit].
    u.x, u.y = wesnoth.find_vacant_tile(u.x, u.y)
    u.hidden = true
    wesnoth.units.to_map(u)
end

---
-- Counts the amount of matching units.
--
-- [count_units]
--     ... SUF ...
--     variable=unit_count
-- [/count_units]
---

function wesnoth.wml_actions.count_units(cfg)
    local units = wesnoth.units.find_on_map(cfg)
    local varname = cfg.variable or "unit_count"

    if units == nil then
        wesnoth.set_variable(varname, 0)
    else
        wesnoth.set_variable(varname, #units)
    end
end

---
-- Fades out the currently playing music and replaces
-- it with silence afterwards.
--
-- It is not possible at this time to know whether music is enabled in
-- the first place, so the fade out delay will always occur regardless
-- of the user's preferences.
--
-- [fade_out_music]
--     duration= (optional int, defaults to 1000 ms)
-- [/fade_out_music]
---
function wesnoth.wml_actions.fade_out_music(cfg)
    local duration = cfg.duration

    if duration == nil then
        duration = 1000
    end

    -- HACK: reserve last 10 milliseconds for the music switch workaround.
    duration = duration - 10

    local function set_music_volume(percentage)
        wesnoth.fire("volume", { music = percentage })
    end

    local delay_granularity = 10

    duration = math.max(delay_granularity, duration)
    local rem = duration % delay_granularity

    if rem ~= 0 then
        duration = duration - rem
    end

    local steps = duration / delay_granularity
    --wesnoth.message(string.format("%d steps", steps))

    for k = 1, steps do
        local v = helper.round(100 - (100*k / steps))
        --wesnoth.message(string.format("step %d, volume %d", k, v))
        set_music_volume(v)
        wesnoth.delay(delay_granularity)
    end

    wesnoth.set_music({
        name = "silence.ogg",
        immediate = true,
        append = false
    })

    -- HACK: give the new track a chance to start playing silently before
    --       resetting to full volume.
    wesnoth.delay(10)

    set_music_volume(100)
end

local function wml_sfx_volume_fade_internal(duration, is_fade_out)
    if duration == nil then
        duration = 1000
    end

    local delay_granularity = 10

    duration = math.max(delay_granularity, duration)
    duration = duration - (duration % delay_granularity)

    local steps = duration / delay_granularity
    --wesnoth.message(string.format("%d steps", steps))

    for k = 1, steps do
        local v = 0

        if is_fade_out then
            v = helper.round(100 - (100*k / steps))
        else
            v = helper.round(100*k / steps)
        end

        --wesnoth.message(string.format("step %d, volume %d", k, v))

        wesnoth.fire("volume", { sound = v })

        wesnoth.delay(delay_granularity)
    end
end

---
-- Simulates fading out all playing sound effects for the given interval of
-- time by gradually decreasing the main sound volume until it reaches zero.
--
-- [fade_out_sound]
--     duration= (optional int, defaults to 1000 ms)
-- [/fade_out_sound]
---
function wesnoth.wml_actions.fade_out_sound(cfg)
    wml_sfx_volume_fade_internal(cfg.duration, true)
end

---
-- Simulates fading in all playing sound effects for the given interval of
-- time by gradually increasing the main sound volume until it reaches 100%.
--
-- [fade_in_sound]
--     duration= (optional int, defaults to 1000 ms)
-- [/fade_in_sound]
---
function wesnoth.wml_actions.fade_in_sound(cfg)
    wml_sfx_volume_fade_internal(cfg.duration, false)
end

---
-- Sets the sound volume to zero.
---
function wesnoth.wml_actions.mute_sound_effects(cfg)
    wesnoth.fire("volume", { sound = 0 })
end

---
-- Resets the main sound volume back to normal.
---
function wesnoth.wml_actions.reset_sound_effects(cfg)
    wesnoth.fire("volume", { sound = 100 })
end

---
-- Highlights a given set of target locations at once as a hint for the
-- player.
--
-- [highlight_goal]
--     ... SLF ...
--     image=(optional path to the goal overlay)
-- [/highlight_goal]
---
function wesnoth.wml_actions.highlight_goal(cfg)
    cfg = helper.literal(cfg)

    if cfg.image == nil then
        cfg.image = "misc/goal-highlight.png"
    end

    for i = 1, 3 do
        wesnoth.wml_actions.item(cfg)
        wesnoth.delay(300)
        wesnoth.wml_actions.remove_item(cfg)
        wesnoth.wml_actions.redraw {}
        wesnoth.delay(300)
    end
end

---
-- Scatters random images from a list over a number of locations matched by the
-- specified SLF.
--
-- [scatter_images]
--     ... SLF ...
--     image=(image list)
--     limit=(number, default -1 to scatter on all matched locations)
-- [/scatter_images]
---
function wesnoth.wml_actions.scatter_images(cfg)
    local locs = wesnoth.get_locations(cfg) or
        helper.wml_error("[scatter_images] No suitable locations found.")

    local count = cfg.limit
    if count == nil or count == -1 then
        count = #locs
    end

    for i = 1, count do
        local loc = locs[helper.rand(("1..%d"):format(#locs))]
        local img = helper.rand(cfg.image)

        wesnoth.wml_actions.item {
            x = loc[1],
            y = loc[2],
            image = img,
            redraw = false,
        }
    end

    wesnoth.wml_actions.redraw {}
end

---
-- Added to mainline in 1.13.0. The implementation is somewhat different but it
-- has the same semantics.
---
if wesnoth.wml_actions.remove_event == nil then
    function wesnoth.wml_actions.remove_event(cfg)
        local id = cfg.id or helper.wml_error("[remove_event] missing required id= key")

        for w in split(id) do
            wesnoth.wml_actions.event { id = w, remove = true }
        end
    end
end
