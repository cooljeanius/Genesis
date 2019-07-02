function wesnoth.wml_actions.add_exp(cfg)
    local suf = helper.get_child(cfg, "filter") or
        helper.wml_error("[add_exp] Missing unit filter")

    local units = wesnoth.get_units(suf) or
        helper.wml_error("[add_exp] Could not match any on-map units with [filter]")

	local experience = cfg.experience
	
	if units[1].id == "Aryel" then
		experience = math.floor(experience * (1 + wesnoth.get_variable("aryel_spell_params.aryel_insight")/10))
	elseif units[1].id == "Esther" then
		experience = math.floor(experience * (1 + wesnoth.get_variable("esther_spell_params.esther_insight")/10))
	elseif units[1].id == "Kyoko" then
		experience = math.floor(experience * (1 + wesnoth.get_variable("kyoko_spell_params.kyoko_insight")/10))
	elseif units[1].id == "Talya" then
		experience = math.floor(experience * (1 + wesnoth.get_variable("talya_spell_params.talya_insight")/10))
	elseif units[1].id == "Yumi" then
		experience = math.floor(experience * (1 + wesnoth.get_variable("yumi_spell_params.yumi_insight")/10))
	end
	
    units[1].experience = units[1].experience + experience
    wesnoth.extract_unit(units[1])
    wesnoth.put_unit(units[1])
	wesnoth.float_label(units[1].x,units[1].y, string.format("<span color='#ff00ff'>+%d XP</span>",experience))
end

function wesnoth.wml_actions.add_hp(cfg)
    local suf = helper.get_child(cfg, "filter") or
        helper.wml_error("[add_exp] Missing unit filter")

    local units = wesnoth.get_units(suf) or
        helper.wml_error("[add_exp] Could not match any on-map units with [filter]")

	local hp = cfg.hp
	local ev = wesnoth.current.event_context
	local u = wesnoth.get_units{x=ev.x1, y=ev.y1}[1]
    u.hitpoints = u.hitpoints + hp
	u.max_hitpoints = u.max_hitpoints + hp
    wesnoth.extract_unit(units[1])
    wesnoth.put_unit(units[1])
	wesnoth.float_label(units[1].x,units[1].y, string.format("<span color='#008000'>+%d XP</span>",hp))
end

local on_event = wesnoth.require("lua/on_event.lua")
on_event("die", function(context)
	
	local unit = wesnoth.get_units({x=context.x1,y=context.y1})
	local second_unit = wesnoth.get_units({x=context.x2,y=context.y2})
	
	local experience = unit[1].level*8
	
	if experience == 0 then experience = 4 end
	
	if second_unit[1].id == "Aryel" then
		experience = math.floor(experience * (wesnoth.get_variable("aryel_spell_params.aryel_insight")/10))
	elseif second_unit[1].id == "Esther" then
		experience = math.floor(experience * (wesnoth.get_variable("esther_spell_params.esther_insight")/10))
	elseif second_unit[1].id == "Kyoko" then
		experience = math.floor(experience * (wesnoth.get_variable("kyoko_spell_params.kyoko_insight")/10))
	elseif second_unit[1].id == "Talya" then
		experience = math.floor(experience * (wesnoth.get_variable("talya_spell_params.talya_insight")/10))
	elseif second_unit[1].id == "Yumi" then
		experience = math.floor(experience * (wesnoth.get_variable("yumi_spell_params.yumi_insight")/10))
	end

	second_unit[1].experience = second_unit[1].experience + experience
    wesnoth.extract_unit(second_unit[1])
    wesnoth.put_unit(second_unit[1])
end)
