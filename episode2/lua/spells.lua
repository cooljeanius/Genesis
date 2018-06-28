function wesnoth.wml_actions.esther_spell_setup()
    wesnoth.set_variable("esther_spell_params.esther_spell_radius",0)
    wesnoth.set_variable("esther_spell_params.esther_spell_power",1)
    wesnoth.set_variable("esther_spell_params.esther_mana_gain",1)
    wesnoth.set_variable("esther_spell_params.esther_max_mana",6)
    wesnoth.set_variable("esther_spell_params.esther_mana",6)
    
    wesnoth.set_variable("esther_spell_params.esther_spells","Cancel")
    wesnoth.set_variable("esther_spell_params.esther_spell_images","attacks/blank-attack.png")
    wesnoth.set_variable("esther_spell_params.esther_spell_radii",100)
    wesnoth.set_variable("esther_spell_params.esther_spell_costs",0) 
end

function wesnoth.wml_actions.yumi_spell_setup()
    wesnoth.set_variable("yumi_spell_params.yumi_spell_radius",0)
    wesnoth.set_variable("yumi_spell_params.yumi_spell_power",1)
    wesnoth.set_variable("yumi_spell_params.yumi_mana_gain",1)
    wesnoth.set_variable("yumi_spell_params.yumi_max_mana",11)
    wesnoth.set_variable("yumi_spell_params.yumi_mana",11)
    
    wesnoth.set_variable("yumi_spell_params.yumi_spells","Cancel")
    wesnoth.set_variable("yumi_spell_params.yumi_spell_images","attacks/blank-attack.png")
    wesnoth.set_variable("yumi_spell_params.yumi_spell_radii",100)
    wesnoth.set_variable("yumi_spell_params.yumi_spell_costs",0) 
end


---------------------------------------------------- UTILITIES -----------------------------------------------------
-- mana gain
local on_event = wesnoth.require("lua/on_event.lua")
on_event("new turn", function(context)

    --local yumi_mana = wesnoth.get_variable("yumi_spell_params.yumi_mana")
    --local yumi_mana_gain = wesnoth.get_variable("yumi_spell_params.yumi_mana_gain")

    --if yumi_mana < wesnoth.get_variable("yumi_spell_params.yumi_max_mana") then
    --    wesnoth.set_variable("yumi_spell_params.yumi_mana", yumi_mana + yumi_mana_gain)
    --    local yumi = wesnoth.get_unit("Yumi")
    
    --    wesnoth.float_label(yumi.x,yumi.y,string.format("<span color='#0000ff'>+%d mana</span>",yumi_mana_gain))
    --end  
end)

-- check whether a spell is castable
-- includes location checks, whether a unit exists there, and whether you have found the spell yet
function check_spell_castable_esther(x,y,radi,cost,spell_name)
    local a = wesnoth.match_location(x,y,{
                {"filter_adjacent_location", {radius=radi,
                    {"filter",{id="Esther"}}
                }}
            })
    local b = true
    if spell_name=="Firebolt" then
        local esther = wesnoth.get_unit("Esther")
        b = wesnoth.match_location(x,y,{
                {"filter",{
                    {"filter_side",{
                        {"enemy_of",{side = esther.side}}
                    }}
                }}
            })
    end
    local c = true
    if cost > wesnoth.get_variable("esther_spell_params.esther_mana") then
        c = false
    end

    return a and b and c
end

function check_spell_castable_yumi(x,y,radi,cost,spell_name)
    local a = wesnoth.match_location(x,y,{
                {"filter_adjacent_location", {radius=radi,
                    {"filter",{id="Yumi"}}
                }}
            })
    local b = true
    if spell_name=="Siphon" or spell_name=="Void Blast" then
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
    if cost > wesnoth.get_variable("yumi_spell_params.yumi_mana") then
        c = false
    end

    return a and b and c
end

------------------------------------------- SPELL IMPLEMENTATIONS -------------------------------------------------------
-- firebolt spell 
function wesnoth.wml_actions.firebolt_spell()
    local esther_spell_power = wesnoth.get_variable("esther_spell_params.esther_spell_power")
    local firebolt_bonus = wesnoth.get_variable("esther_spell_params.firebolt_bonus")

    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount=4 + firebolt_bonus*esther_spell_power,delay="50",experience="yes",damage_type="fire",
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Esther"}},
        {"primary_attack",{name="infernal blast"}},
        {"secondary_attack",{name="infernal blast"}}
    }

    wesnoth.set_variable("esther_spell_params.esther_mana", wesnoth.get_variable("esther_spell_params.esther_mana") - 3)
    
    if firebolt_bonus < wesnoth.get_variable("esther_spell_params.firebolt_max_bonus") then
        wesnoth.set_variable("esther_spell_params.firebolt_bonus", firebolt_bonus + 0.1)
    end
end

-- siphon spell
function wesnoth.wml_actions.siphon_spell()
    local yumi_spell_power = wesnoth.get_variable("yumi_spell_params.yumi_spell_power")
    
    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount=5*yumi_spell_power,delay="50",experience="yes",damage_type="arcane",variable="damage",
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Yumi"}},
        {"primary_attack",{name="faerie fire"}},
        {"secondary_attack",{name="faerie fire"}}
    }
    
    local healing = wesnoth.get_variable("damage.harm_amount")
    
    local siphon_spell_healing = wesnoth.get_variable("yumi_spell_params.siphon_spell_healing")
    
    healing = healing * siphon_spell_healing
    
    wesnoth.wml_actions.clear_variable {name="damage"}
    
    wesnoth.wml_actions.heal_unit {
        animate="yes",amount=healing,delay="50",
        {"filter",{id="Yumi"}}
    }
    
    wesnoth.set_variable("yumi_spell_params.yumi_mana", wesnoth.get_variable("yumi_spell_params.yumi_mana") - 3)

    if siphon_spell_healing < 1.00 then
        wesnoth.set_variable("yumi_spell_params.siphon_spell_healing", siphon_spell_healing + 0.01)
    end
end

-- void blast spell function
function wesnoth.wml_actions.void_blast_spell()
    local yumi_spell_power = wesnoth.get_variable("yumi_spell_params.yumi_spell_power")
    local void_damage_bonus = wesnoth.get_variable("yumi_spell_params.void_damage_bonus")

    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount=(5 + void_damage_bonus)*yumi_spell_power,delay="50",experience="yes",
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Yumi"}},
        {"primary_attack",{name="void assault"}},
        {"secondary_attack",{name="void assault"}}
    }
    
    wesnoth.set_variable("yumi_spell_params.yumi_mana", wesnoth.get_variable("yumi_spell_params.yumi_mana") - 2)
    
    if void_damage_bonus < wesnoth.get_variable("yumi_spell_params.yumi_void_max_bonus") then
        wesnoth.set_variable("yumi_spell_params.void_damage_bonus", void_damage_bonus + 0.1)
    end
end

----------------------------------------------- SPELL MENUS ----------------------------------------------------
-- spell menu dialog setup for esther
function wesnoth.wml_actions.esther_spell_menu()

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
        local count = 1

        wesnoth.set_dialog_value(string.format("Current Mana: %d",wesnoth.get_variable("esther_spell_params.esther_mana")), "list", 1, "label")
        wesnoth.set_dialog_value("attacks/staff-elven-star.png", "list", 1, "icon")
        
        local esther_spell_params = helper.get_variable_array("esther_spell_params")
        
        for i,v in ipairs(esther_spell_params) do
            local b = check_spell_castable_esther(x,y,esther_spell_params[i].esther_spell_radii,esther_spell_params[i].esther_spell_costs,esther_spell_params[i].esther_spells)
            if i == 1 then
            elseif b==true then
                wesnoth.set_dialog_value(string.format("%s (%d mana)",esther_spell_params[i].esther_spells,esther_spell_params[i].esther_spell_costs), "list", i, "label")
                wesnoth.set_dialog_value(esther_spell_params[i].esther_spell_images, "list", i, "icon")
            end
            count = count + 1
        end
        
        wesnoth.set_dialog_value("Cancel", "list", count, "label")
        wesnoth.set_dialog_value("attacks/blank-attack.png", "list", count, "icon")
        wesnoth.set_dialog_value(1, "list")
        select()
    end

    local li
    local function postshow()
        li = wesnoth.get_dialog_value "list"
    end

    
    local r = wesnoth.show_dialog(dialog, preshow, postshow)
    local esther_spell_params = helper.get_variable_array("esther_spell_params")
    local count = 1
    for i,v in ipairs(esther_spell_params) do
        count = count + 1
    end
    
    --wesnoth.message(string.format("Button %d pressed. Item %d selected.", r, li))
    
    if r == -1 and li < count then
        if esther_spell_params[li].esther_spells=="Firebolt" then
            wesnoth.wml_actions.firebolt_spell()
        end
    end
end

-- spell help for Esther
function wesnoth.wml_actions.esther_spell_help()

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
        local count = 1

        wesnoth.set_dialog_value("Stats (Esther)", "list", 1, "label")
        wesnoth.set_dialog_value("units/fae/esther.png", "list", 1, "icon")
        
        local esther_spell_params = helper.get_variable_array("esther_spell_params")
        
        for i,v in ipairs(esther_spell_params) do
            if i == 1 then
            else
                wesnoth.set_dialog_value(string.format("%s",esther_spell_params[i].esther_spells), "list", i, "label")
                wesnoth.set_dialog_value(esther_spell_params[i].esther_spell_images, "list", i, "icon")
            end
            count = count + 1
        end
        
        wesnoth.set_dialog_value("Cancel", "list", count, "label")
        wesnoth.set_dialog_value("attacks/blank-attack.png", "list", count, "icon")
        wesnoth.set_dialog_value(1, "list")
        select()
    end

    local li
    local function postshow()
        li = wesnoth.get_dialog_value "list"
    end

    
    local r = wesnoth.show_dialog(dialog, preshow, postshow)
    local esther_spell_params = helper.get_variable_array("esther_spell_params")
    local count = 1
    for i,v in ipairs(esther_spell_params) do
        count = count + 1
    end
    
    --wesnoth.message(string.format("Button %d pressed. Item %d selected.", r, li))
    
    if r == -1 and li < count then
        if li == 1 then
            wesnoth.show_message_dialog({
                 title = "Character Statistics",
                 message = string.format("<span color='#0000ff'>Current Mana: %d</span> \n<span color='#00ffff'>Maximum Mana: %d</span> \n<span color='#85C1E9'>Mana Regen: %d</span>\n<span color='#F000FF'>Spell Power: %d</span>",wesnoth.get_variable("esther_spell_params.esther_mana"),wesnoth.get_variable("esther_spell_params.esther_max_mana"),wesnoth.get_variable("esther_spell_params.esther_mana_gain"),wesnoth.get_variable("esther_spell_params.esther_spell_power")),
                 portrait = "units/fae/esther.png",
            })
        elseif esther_spell_params[li].esther_spells=="Firebolt" then
            wesnoth.show_message_dialog({
                 title = "Firebolt",
                 message = string.format("<span color='#0000ff'>Mana cost: 3</span> \n<span color='#008000'>Cast radius: 3</span> \nDeals <span color='#ff0000'>%d</span> <span color='#ff5500'>fire</span> damage to target enemy. Each cast increases the damage of this spell by <span color='#ff0000'>0.1</span>, up to a maximum of <span color='#ff0000'>%d</span>.",math.floor(wesnoth.get_variable("esther_spell_params.firebolt_bonus")+4.4),math.floor(wesnoth.get_variable("esther_spell_params.firebolt_max_bonus")+4)),
                 portrait = "attacks/fireball.png",
            })
        end
    end
end

-- spell menu dialog setup for yumi
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
        local count = 1

        wesnoth.set_dialog_value(string.format("Current Mana: %d",wesnoth.get_variable("yumi_spell_params.yumi_mana")), "list", 1, "label")
        wesnoth.set_dialog_value("attacks/staff-elven-star.png", "list", 1, "icon")
        
        local yumi_spell_params = helper.get_variable_array("yumi_spell_params")
        
        for i,v in ipairs(yumi_spell_params) do
            local b = check_spell_castable_yumi(x,y,yumi_spell_params[i].yumi_spell_radii,yumi_spell_params[i].yumi_spell_costs,yumi_spell_params[i].yumi_spells)

            if i == 1 then
            elseif b==true then
                wesnoth.set_dialog_value(string.format("%s (%d mana)",yumi_spell_params[i].yumi_spells,yumi_spell_params[i].yumi_spell_costs), "list", i, "label")
                wesnoth.set_dialog_value(yumi_spell_params[i].yumi_spell_images, "list", i, "icon")
            end
            count = count + 1
        end
        
        wesnoth.set_dialog_value("Cancel", "list", count, "label")
        wesnoth.set_dialog_value("attacks/blank-attack.png", "list", count, "icon")
        wesnoth.set_dialog_value(1, "list")
        select()
    end

    local li
    local function postshow()
        li = wesnoth.get_dialog_value "list"
    end

    
    local r = wesnoth.show_dialog(dialog, preshow, postshow)
    local yumi_spell_params = helper.get_variable_array("yumi_spell_params")
    local count = 1
    for i,v in ipairs(yumi_spell_params) do
        count = count + 1
    end
    
    --wesnoth.message(string.format("Button %d pressed. Item %d selected.", r, li))
    
    if r == -1 and li < count then
        if yumi_spell_params[li].yumi_spells=="Siphon" then
            wesnoth.wml_actions.siphon_spell()
        elseif yumi_spell_params[li].yumi_spells=="Void Blast" then
            wesnoth.wml_actions.void_blast_spell()
        end
    end
end

-- spell help for Yumi
function wesnoth.wml_actions.yumi_spell_help()

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
        local count = 1

        wesnoth.set_dialog_value("Stats (Yumi)", "list", 1, "label")
        wesnoth.set_dialog_value("units/fae/yumi.png", "list", 1, "icon")
        
        local yumi_spell_params = helper.get_variable_array("yumi_spell_params")
        
        for i,v in ipairs(yumi_spell_params) do
            if i == 1 then
            else
                wesnoth.set_dialog_value(string.format("%s",yumi_spell_params[i].yumi_spells), "list", i, "label")
                wesnoth.set_dialog_value(yumi_spell_params[i].yumi_spell_images, "list", i, "icon")
            end
            count = count + 1
        end
        
        wesnoth.set_dialog_value("Cancel", "list", count, "label")
        wesnoth.set_dialog_value("attacks/blank-attack.png", "list", count, "icon")
        wesnoth.set_dialog_value(1, "list")
        select()
    end

    local li
    local function postshow()
        li = wesnoth.get_dialog_value "list"
    end

    
    local r = wesnoth.show_dialog(dialog, preshow, postshow)
    local yumi_spell_params = helper.get_variable_array("yumi_spell_params")
    local count = 1
    for i,v in ipairs(yumi_spell_params) do
        count = count + 1
    end
    
    --wesnoth.message(string.format("Button %d pressed. Item %d selected.", r, li))
    
    if r == -1 and li < count then
        if li == 1 then
            wesnoth.show_message_dialog({
                 title = "Character Statistics",
                 message = string.format("<span color='#0000ff'>Current Mana: %d</span> \n<span color='#00ffff'>Maximum Mana: %d</span> \n<span color='#85C1E9'>Mana Regen: %d</span>\n<span color='#F000FF'>Spell Power: %d</span>",wesnoth.get_variable("yumi_spell_params.yumi_mana"),wesnoth.get_variable("yumi_spell_params.yumi_max_mana"),wesnoth.get_variable("yumi_spell_params.yumi_mana_gain"),wesnoth.get_variable("yumi_spell_params.yumi_spell_power")),
                 portrait = "units/fae/yumi.png",
            })
        elseif yumi_spell_params[li].yumi_spells=="Siphon" then
            wesnoth.show_message_dialog({
                 title = "Siphon",
                 message = string.format("<span color='#0000ff'>Mana cost: 3</span> \n<span color='#008000'>Cast radius: 2</span> \nDeals <span color='#ff0000'>5</span> <span color='#00bfff'>arcane</span> damage to target enemy and heals for <span color='#008000'>%d%%</span> of the damage dealt. Each cast increases healing proportion by <span color='#008000'>1%%</span>, up to <span color='#008000'>100%%</span>.",wesnoth.get_variable("yumi_spell_params.siphon_spell_healing")*100),
                 portrait = "attacks/faerie-fire.png",
            })
        elseif yumi_spell_params[li].yumi_spells=="Void Blast" then
            wesnoth.show_message_dialog({
                 title = "Void Blast",
                 message = string.format("<span color='#0000ff'>Mana cost: 2</span> \n<span color='#008000'>Cast radius: 4</span> \nDeals <span color='#ff0000'>%d</span> damage to target enemy. Each cast increases the damage of this spell by <span color='#ff0000'>0.1</span>, up to a maximum of <span color='#ff0000'>%d</span>.",math.floor(wesnoth.get_variable("yumi_spell_params.void_damage_bonus")+5.4),math.floor(wesnoth.get_variable("yumi_spell_params.yumi_void_max_bonus")+5)),
                 portrait = "attacks/faerie-fire.png",
            })
        end
    end
end

-- main spell menu dialog
function wesnoth.wml_actions.spell_menu()

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
        
        wesnoth.set_dialog_value("Spell Help", "list", 1, "label")
        wesnoth.set_dialog_value("attacks/staff-elven-star.png", "list", 1, "icon")
        
        -- check if any spell is castable by esther
        local b = wesnoth.match_location(x,y,{
            {"filter",{id="Esther"}},
            {"or",{
                {"filter_adjacent_location", {radius=wesnoth.get_variable("esther_spell_params.esther_spell_radius"),
                    {"filter",{id="Esther"}}
                }}
            }}
        })
        
        -- make menu items for Esther available
        if b == true then
            wesnoth.set_dialog_value("Cast Spell (Esther)", "list", 4, "label")
            wesnoth.set_dialog_value("units/fae/esther.png", "list", 4, "icon")
            wesnoth.set_dialog_value("Spell Help (Esther)", "list", 5, "label")
            wesnoth.set_dialog_value("units/fae/esther.png", "list", 5, "icon")
        end
        
        -- check if any spell is castable by yumi
        local e = wesnoth.match_location(x,y,{
            {"filter",{id="Yumi"}},
            {"or",{
                {"filter_adjacent_location", {radius=wesnoth.get_variable("yumi_spell_params.yumi_spell_radius"),
                    {"filter",{id="Yumi"}}
                }}
            }}
        })
        
        -- make menu items for Yumi available
        if e == true then
            wesnoth.set_dialog_value("Cast Spell (Yumi)", "list", 10, "label")
            wesnoth.set_dialog_value("units/fae/yumi.png", "list", 10, "icon")
            wesnoth.set_dialog_value("Spell Help (Yumi)", "list", 11, "label")
            wesnoth.set_dialog_value("units/fae/yumi.png", "list", 11, "icon")
        end

        wesnoth.set_dialog_value("Cancel", "list", 12, "label")
        wesnoth.set_dialog_value("attacks/blank-attack.png", "list", 12, "icon")
        wesnoth.set_dialog_value(12, "list")
        select()
    end

    local li
    local function postshow()
        li = wesnoth.get_dialog_value "list"
    end

    local r = wesnoth.show_dialog(dialog, preshow, postshow)
    --wesnoth.message(string.format("Button %d pressed. Item %d selected.", r, li))
    
    if r == -1 then
        if li==1 then
            wesnoth.show_message_dialog({
                 title = "Spell Help",
                 message = string.format("Right click on hexes close to hero units to cast spells. Each hero has a set amount of <span color='#0000ff'>mana</span> available to cast spells with, and regains some <span color='#0000ff'>mana</span> every turn. Only spells that are available to be cast on the selected location will appear. Spell effects are modified from their displayed base values by each hero's <span color='#F000FF'>spell power</span>. For more help, click on each hero's respective help menu."),
            })
        elseif li==4 then
            wesnoth.wml_actions.esther_spell_menu()
        elseif li==5 then
            wesnoth.wml_actions.esther_spell_help()
        elseif li==10 then
            wesnoth.wml_actions.yumi_spell_menu()
        elseif li==11 then
            wesnoth.wml_actions.yumi_spell_help()
        end
    end
end

-- refresh the spell menu every time you add a new spell
function wesnoth.wml_actions.refresh_spell_menu(cfg)
    local enable = cfg.enable or 1
    if enable == 1 then
        wesnoth.wml_actions.set_menu_item { id="spells",
            description="Cast Spell",
            {"command",{
                {"spell_menu"}
            }}
        }
    elseif enable == 0 then
        wesnoth.wml_actions.clear_menu_item { id = "spells"}
    end
end

-------------------------------------- SPELL DISCOVERY ----------------------------------------------

-- discover firebolt
function wesnoth.wml_actions.add_firebolt_esther(cfg)
    wesnoth.wml_actions.set_variables {name = "esther_spell_params", mode = "append", 
        {"value",{esther_spells = "Firebolt",esther_spell_images = "attacks/fireball.png",
        esther_spell_radii = 3,esther_spell_costs = 3}},
    }
    
    if 3 > wesnoth.get_variable("esther_spell_params.esther_spell_radius") then
        wesnoth.set_variable("esther_spell_params.esther_spell_radius",3)
    end
    
    wesnoth.set_variable("esther_spell_params.firebolt_bonus",0.0)
    wesnoth.set_variable("esther_spell_params.firebolt_max_bonus",3.0)    
    
    wesnoth.wml_actions.refresh_spell_menu(cfg)
end

-- discover siphon
function wesnoth.wml_actions.add_siphon_yumi(cfg)
    wesnoth.wml_actions.set_variables {name = "yumi_spell_params", mode = "append", 
        {"value",{yumi_spells = "Siphon",yumi_spell_images = "attacks/faerie-fire.png",
        yumi_spell_radii = 2,yumi_spell_costs = 3}}
    }
    
    if 2 > wesnoth.get_variable("yumi_spell_params.yumi_spell_radius") then
        wesnoth.set_variable("yumi_spell_params.yumi_spell_radius",2)
    end
    
    wesnoth.set_variable("yumi_spell_params.siphon_spell_healing",0.20)
    
    wesnoth.wml_actions.refresh_spell_menu(cfg)
end

-- discover void_blast
function wesnoth.wml_actions.add_void_blast_yumi(cfg)
    wesnoth.wml_actions.set_variables {name = "yumi_spell_params", mode = "append", 
        {"value",{yumi_spells = "Void Blast",yumi_spell_images = "attacks/dark-missile.png",
        yumi_spell_radii = 4,yumi_spell_costs = 2}},
    }
    
    if 4 > wesnoth.get_variable("yumi_spell_params.yumi_spell_radius") then
        wesnoth.set_variable("yumi_spell_params.yumi_spell_radius",4)
    end
    
    wesnoth.set_variable("yumi_spell_params.void_damage_bonus",0.0)
    wesnoth.set_variable("yumi_spell_params.yumi_void_max_bonus",4.0)    
    
    wesnoth.wml_actions.refresh_spell_menu(cfg)
end