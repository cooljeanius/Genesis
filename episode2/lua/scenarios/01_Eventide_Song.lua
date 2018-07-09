function wesnoth.wml_actions.puzzle_one(cfg)
    wesnoth.wml_actions.set_variables {name = "yumi_spell_params", mode = "append",
        {"value",{yumi_spells = "Shadow Walk",yumi_spell_images = "attacks/heart-sight.png",
        yumi_spell_radii = 0,yumi_spell_costs = 4}},
    }

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end