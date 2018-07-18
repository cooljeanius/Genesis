function wesnoth.wml_actions.add_exp(cfg)
    local suf = helper.get_child(cfg, "filter") or
        helper.wml_error("[add_exp] Missing unit filter")

    local units = wesnoth.get_units(suf) or
        helper.wml_error("[add_exp] Could not match any on-map units with [filter]")

	local experience = cfg.experience
	
    units[1].experience = units[1].experience + experience
    wesnoth.extract_unit(units[1])
    wesnoth.put_unit(units[1])
	wesnoth.float_label(units[1].x,units[1].y, string.format("<span color='#ff00ff'>+%d XP</span>",experience))
end