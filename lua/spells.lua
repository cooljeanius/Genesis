yumi_spell_radius=5
yumi_mana=0
yumi_mana_gain = 1
yumi_max_mana = 10

yumi_spells = {"Ethereal Blast","Void Blast", "Cancel"}
yumi_spell_images = {"attacks/faerie-fire.png","attacks/dark-missile.png","attacks/blank-attack.png"}
yumi_spell_radii = {1,10,100}
yumi_spell_costs = {2,2,0}
yumi_spell_discovered = {0,0,1}

-- mana gain
local on_event = wesnoth.require("lua/on_event.lua")
on_event("new turn", function(context)
    if yumi_mana < yumi_max_mana then
        yumi_mana = yumi_mana + yumi_mana_gain
    end
end)

function wesnoth.wml_actions.void_blast_spell()
    wesnoth.play_sound("shaxthal-energy-prelude.ogg")
    wesnoth.delay(100)
    wesnoth.play_sound("shaxthal-energy-fire.ogg")
    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount="10",delay="50",experience="yes",
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Yumi"}}
    }

    yumi_mana = yumi_mana - yumi_spell_costs[2]
end

-- check whether a spell is castable
-- includes location checks, whether a unit exists there, and whether you have found the spell yet
function check_spell_castable_yumi(x,y,radi,cost,spell_name,discov)
    local a = wesnoth.match_location(x,y,{
                {"filter_adjacent_location", {radius=radi,
                    {"filter",{id="Yumi"}}
                }}
            })
    local b = true
    if spell_name=="Ethereal Blast" or spell_name=="Void Blast" then
        local yumi = wesnoth.get_unit("Yumi")
        b = wesnoth.match_location(x,y,{
                {"filter",{
                    {"filter_side",{
                        {"enemy_of",{side = yumi.side}}
                    }}
                }}
            })
    end
    local c = true
    if cost > yumi_mana then
        c = false
    end

    local d = true

    if discov == 0 then
        d = false
    end

    return a and b and c and d
end

-- main spell menu dialog setup
function wesnoth.wml_actions.yumi_spell_menu()

    local helper = wesnoth.require "lua/helper.lua"
    local T = helper.set_wml_tag_metatable {}

    local dialog = {
      T.tooltip { id = "tooltip_large" },
      T.helptip { id = "tooltip_large" },
      T.grid { T.row {
        T.column { T.grid {
          T.row { T.column { horizontal_grow = true, T.listbox { id = "list",
            T.list_definition { T.row { T.column { horizontal_grow = true,
              T.toggle_panel { return_value = -1, T.grid { T.row {
                T.column { horizontal_alignment = "left", T.label { id = "label" } },
                T.column { T.image { id = "icon" } }
              } } }
            } } }
          } } },
          T.row { T.column { T.grid { T.row {
            T.column { T.button { id = "ok", label = "OK" } },
            T.column { T.button { id = "cancel", label = "Cancel" } }
          } } } }
        } },
        T.column { T.image { id = "image" } }
      } }
    }

    local function preshow()
        local function select()
            local i = wesnoth.get_dialog_value "list"
        end
        wesnoth.set_dialog_callback(select, "list")

        local x = wesnoth.get_variable("x1")
        local y = wesnoth.get_variable("y1")
        local count = 0

        for i,v in ipairs(yumi_spell_radii) do
            local b = check_spell_castable_yumi(x,y,v,yumi_spell_costs[i],yumi_spells[i],yumi_spell_discovered[i])

            if b==true then
                wesnoth.set_dialog_value(string.format("%s (%d mana)",yumi_spells[i],yumi_spell_costs[i]), "list", i, "label")
                wesnoth.set_dialog_value(yumi_spell_images[i], "list", i, "icon")
            end
            count = count + 1
        end
        wesnoth.set_dialog_value(yumi_spells[count], "list", count, "label")
        wesnoth.set_dialog_value(count, "list")
        select()
    end

    local li
    local function postshow()
        li = wesnoth.get_dialog_value "list"
    end

    local r = wesnoth.show_dialog(dialog, preshow, postshow)

    if li==1 then
        wesnoth.wml_actions.void_blast_spell()
    elseif li==2 then
        wesnoth.wml_actions.void_blast_spell()
    end

end

-- refresh the spell menu every time you add a new spell
function wesnoth.wml_actions.refresh_spell_menu_yumi(cfg)
    local yumi = wesnoth.get_unit("Yumi")

    wesnoth.wml_actions.set_menu_item { id="yumi_spells",
        description="Cast Spell (Yumi)",
        {"filter_location",{
            {"filter",{id="Yumi"}},
            {"or",{
                {"filter_adjacent_location", {radius=yumi_spell_radius,
                    {"filter",{id="Yumi"}}
                }}
            }}
        }},
        {"command",{
            {"yumi_spell_menu"}
        }}
    }
end

-- discover the void_blast spell
function wesnoth.wml_actions.add_void_blast_yumi(cfg)
    yumi_spell_discovered[2] = 1
    if yumi_spell_radii[2] > yumi_spell_radius then
        yumi_spell_radius = yumi_spell_radii[2]
    end
    wesnoth.wml_actions.refresh_spell_menu_yumi(cfg)
end