
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
yumi_spell_radius=0

function wesnoth.wml_actions.refresh_spell_menu_yumi(cfg)
    local yumi = wesnoth.get_unit("Yumi")

    wesnoth.wml_actions.set_menu_item { id="yumi_spells",
        description="Cast Spell (Yumi)",
        {"filter_location",{
            {"filter_adjacent_location", {radius=yumi_spell_radius,
                {"filter",{id="Yumi"}}}
            }}
        },
        {"command",{
            {"message",{speaker="narrator",
                {"option",{message="Void Blast",image="attacks/dark-missile.png",
                    {"command",{{"set_variable",{
                        name="yumi_spell_index",
                        value="1"
                    }}}}
                }} 
            }}
        }}
    }
    --local spell_ind = wesnoth.get_variable("yumi_spell_index")
    --wesnoth.wml_actions.clear_variable {name = "yumi_spell_index"}
    local spell_ind = 1
    if spell_ind==1 then
        wesnoth.wml_actions.harm_unit {fire_event="yes",
            animate="yes",amount="10",delay="50",kill="no",
            {"filter",{x="$x1",y="$y1"}}
        }
    elseif spell_ind==2 then
        spell_ind=2
    end
end

function wesnoth.wml_actions.add_spell_yumi(cfg)
    yumi_spell_radius=10

end