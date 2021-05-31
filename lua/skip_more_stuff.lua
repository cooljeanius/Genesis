---
-- Extends several animation actions so that they do not trigger when the user
-- is skipping messages.
---

-- scroll, scroll_to, scroll_to_unit are not included here since they are
-- sometimes used to change the viewport position permanently after an event,
-- with the intention of aiding the player in deciding what their next course
-- of action should be. However, scroll_to and scroll_to_unit can become warp
-- actions.

-- written by Iris Morelle (ShikadiQueen)

local warp_actions = {
	"scroll_to",
	"scroll_to_unit",
	-- Special cases made to make fade_out_music and fade_out_sound_effects
	-- instantly mute either.
	"fade_out_music",
	"fade_out_sound_effects",
}

local skippable_actions = {
	"move_unit_fake",
	"animate_unit",
	"sound",
	"delay",
	-- The lack of pauses can turn [color_adjust] into a health hazard, so
	-- skip that as well.
	"color_adjust",
	"fade_screen",
	"unfade_screen",
}

local _WA_warp_actions = {}
local _WA_skip_actions = {}

for i, action_id in ipairs(warp_actions) do

	_WA_warp_actions[action_id] = wesnoth.wml_actions[action_id]
	wesnoth.wml_actions[action_id] = function(cfg)
		if wesnoth.interface.is_skipping_messages() then
			wprintf(W_INFO, "Ignoring timing or scrolling delay for [%s] while skipping [message]", action_id)

			if action_id == "fade_out_music" then
				wesnoth.set_music {
					name      = "silence.ogg",
					immediate = true,
					append    = false,
				}
				-- HACK: give the new track a chance to start playing silently before
				--       resetting to full volume.
				wesnoth.delay(10)
				wesnoth.music_list.volume = 100.0
			elseif action_id == "fade_out_sound_effects" then
				wesnoth.sound_volume(0)
			else -- scroll_to* actions
				local p = helper.parsed(cfg)
				p.immediate = true
				_WA_warp_actions[action_id](p)
			end

			return
		end

		_WA_warp_actions[action_id](cfg)
	end
end

for i, action_id in ipairs(skippable_actions) do

	_WA_skip_actions[action_id] = wesnoth.wml_actions[action_id]
	wesnoth.wml_actions[action_id] = function(cfg)
		if wesnoth.interface.is_skipping_messages() then
			wprintf(W_INFO, "Ignoring [%s] while skipping [message]", action_id)
			return
		end

		_WA_skip_actions[action_id](cfg)
	end
end