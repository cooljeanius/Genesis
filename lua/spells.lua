yumi_spell_radius=0

yumi_spells = {"Ethereal Blast","Void Blast", "Cancel"}
yumi_spell_images = {"attacks/faerie-fire.png","attacks/dark-missile.png","attacks/blank-attack.png"}
yumi_spell_radii = {1,1,1}

function wesnoth.wml_actions.void_blast_spell()
    wesnoth.play_sound("shaxthal-energy-prelude.ogg")
    wesnoth.delay(100)
    wesnoth.play_sound("shaxthal-energy-fire.ogg")
    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount="10",delay="50",experience="yes",
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Yumi"}}
    }
end

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
        
        if wesnoth.match_location("$x1","$y1",{"filter_adjacent_location", {radius=yumi_spell_radius,
                    {"filter",{id="Yumi"}}
                }}) then
                
                
        end
        for i,v in ipairs(yumi_spells) do
            wesnoth.set_dialog_value(v, "list", i, "label")
        end
        for i,v in ipairs(yumi_spell_images) do
            wesnoth.set_dialog_value(v, "list", i, "icon")
        end
        wesnoth.set_dialog_value(2, "list")
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
    
    --wesnoth.message(string.format("Button %d pressed. Item %d selected.", r, li))
end

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

function wesnoth.wml_actions.add_void_blast_yumi(cfg)
    yumi_spell_radius=5
    wesnoth.wml_actions.refresh_spell_menu_yumi(cfg)
end