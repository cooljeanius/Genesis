function wesnoth.wml_actions.add_exp(cfg)
    local suf = wml.get_child(cfg, "filter") or
        wml.error("[add_exp] Missing unit filter")

    local units = wesnoth.units.find_on_map(suf) or
        wml.error("[add_exp] Could not match any on-map units with [filter]")

	local experience = cfg.experience
	
    units[1].experience = units[1].experience + experience
    wesnoth.units.extract(units[1])
    wesnoth.units.to_map(units[1])
	wesnoth.interface.float_label(units[1].x,units[1].y, string.format("<span color='#ff00ff'>+%d XP</span>",experience))
end