function wesnoth.wml_actions.aryel_spell_setup()
    wesnoth.set_variable("aryel_spell_params.aryel_spell_radius",0)
    wesnoth.set_variable("aryel_spell_params.aryel_spell_power",1)
    wesnoth.set_variable("aryel_spell_params.aryel_mana_gain",3)
    wesnoth.set_variable("aryel_spell_params.aryel_max_mana",9)
    wesnoth.set_variable("aryel_spell_params.aryel_mana",9)

    wesnoth.set_variable("aryel_spell_params.aryel_spells","Cancel")
    wesnoth.set_variable("aryel_spell_params.aryel_spell_images","attacks/blank-attack.png")
    wesnoth.set_variable("aryel_spell_params.aryel_spell_radii",100)
    wesnoth.set_variable("aryel_spell_params.aryel_spell_costs",0)
    wesnoth.set_variable("spell_params.enable_aryel",1)
end

function wesnoth.wml_actions.esther_spell_setup()
    wesnoth.set_variable("esther_spell_params.esther_spell_radius",0)
    wesnoth.set_variable("esther_spell_params.esther_spell_power",1)
    wesnoth.set_variable("esther_spell_params.esther_mana_gain",2)
    wesnoth.set_variable("esther_spell_params.esther_max_mana",7)
    wesnoth.set_variable("esther_spell_params.esther_mana",7)

    wesnoth.set_variable("esther_spell_params.esther_spells","Cancel")
    wesnoth.set_variable("esther_spell_params.esther_spell_images","attacks/blank-attack.png")
    wesnoth.set_variable("esther_spell_params.esther_spell_radii",100)
    wesnoth.set_variable("esther_spell_params.esther_spell_costs",0)
    wesnoth.set_variable("spell_params.enable_esther",1)
end

function wesnoth.wml_actions.kyoko_spell_setup()
    wesnoth.set_variable("kyoko_spell_params.kyoko_spell_radius",0)
    wesnoth.set_variable("kyoko_spell_params.kyoko_spell_power",1)
    wesnoth.set_variable("kyoko_spell_params.kyoko_mana_gain",3)
    wesnoth.set_variable("kyoko_spell_params.kyoko_max_mana",10)
    wesnoth.set_variable("kyoko_spell_params.kyoko_mana",10)

    wesnoth.set_variable("kyoko_spell_params.kyoko_spells","Cancel")
    wesnoth.set_variable("kyoko_spell_params.kyoko_spell_images","attacks/blank-attack.png")
    wesnoth.set_variable("kyoko_spell_params.kyoko_spell_radii",100)
    wesnoth.set_variable("kyoko_spell_params.kyoko_spell_costs",0)
    wesnoth.set_variable("spell_params.enable_kyoko",1)
end

function wesnoth.wml_actions.talya_spell_setup()
    wesnoth.set_variable("talya_spell_params.talya_spell_radius",0)
    wesnoth.set_variable("talya_spell_params.talya_spell_power",1)
    wesnoth.set_variable("talya_spell_params.talya_mana_gain",1)
    wesnoth.set_variable("talya_spell_params.talya_max_mana",5)
    wesnoth.set_variable("talya_spell_params.talya_mana",5)

    wesnoth.set_variable("talya_spell_params.talya_spells","Cancel")
    wesnoth.set_variable("talya_spell_params.talya_spell_images","attacks/blank-attack.png")
    wesnoth.set_variable("talya_spell_params.talya_spell_radii",100)
    wesnoth.set_variable("talya_spell_params.talya_spell_costs",0)
    wesnoth.set_variable("spell_params.enable_talya",1)
end

function wesnoth.wml_actions.yumi_spell_setup()
    wesnoth.set_variable("yumi_spell_params.yumi_spell_radius",0)
    wesnoth.set_variable("yumi_spell_params.yumi_spell_power",1)
    wesnoth.set_variable("yumi_spell_params.yumi_mana_gain",3)
    wesnoth.set_variable("yumi_spell_params.yumi_max_mana",11)
    wesnoth.set_variable("yumi_spell_params.yumi_mana",11)

    wesnoth.set_variable("yumi_spell_params.yumi_spells","Cancel")
    wesnoth.set_variable("yumi_spell_params.yumi_spell_images","attacks/blank-attack.png")
    wesnoth.set_variable("yumi_spell_params.yumi_spell_radii",100)
    wesnoth.set_variable("yumi_spell_params.yumi_spell_costs",0)
    wesnoth.set_variable("spell_params.enable_yumi",1)
end


---------------------------------------------------- UTILITIES -----------------------------------------------------
-- mana gain
local on_event = wesnoth.require("lua/on_event.lua")
on_event("new turn", function(context)
    if wesnoth.get_variable("spell_params.enable_spells")==1 then
        if wesnoth.get_variable("spell_params.enable_aryel")==1 then
            local aryel_mana = wesnoth.get_variable("aryel_spell_params.aryel_mana")
            local aryel_max_mana = wesnoth.get_variable("aryel_spell_params.aryel_max_mana")
            local aryel_mana_gain = wesnoth.get_variable("aryel_spell_params.aryel_mana_gain")

            if aryel_mana == aryel_max_mana then
                wesnoth.set_variable("aryel_spell_params.aryel_mana", aryel_mana)
            elseif aryel_mana < aryel_max_mana-aryel_mana_gain then
                wesnoth.set_variable("aryel_spell_params.aryel_mana", aryel_mana + aryel_mana_gain)
                local aryel = wesnoth.get_unit("Aryel")

                wesnoth.float_label(aryel.x,aryel.y,string.format("<span color='#0000ff'>+%d mana</span>",aryel_mana_gain))
            else
                wesnoth.set_variable("aryel_spell_params.aryel_mana", aryel_max_mana)
                local aryel = wesnoth.get_unit("Aryel")

                wesnoth.float_label(aryel.x,aryel.y,string.format("<span color='#0000ff'>+%d mana</span>",aryel_max_mana-aryel_mana))
            end
        end
        if wesnoth.get_variable("spell_params.enable_esther")==1 then
            local esther_mana = wesnoth.get_variable("esther_spell_params.esther_mana")
            local esther_max_mana = wesnoth.get_variable("esther_spell_params.esther_max_mana")
            local esther_mana_gain = wesnoth.get_variable("esther_spell_params.esther_mana_gain")

            if esther_mana == esther_max_mana then
                wesnoth.set_variable("esther_spell_params.esther_mana", esther_mana)
            elseif esther_mana < esther_max_mana-esther_mana_gain then
                wesnoth.set_variable("esther_spell_params.esther_mana", esther_mana + esther_mana_gain)
                local esther = wesnoth.get_unit("Esther")

                wesnoth.float_label(esther.x,esther.y,string.format("<span color='#0000ff'>+%d mana</span>",esther_mana_gain))
            else
                wesnoth.set_variable("esther_spell_params.esther_mana", esther_max_mana)
                local esther = wesnoth.get_unit("Esther")

                wesnoth.float_label(esther.x,esther.y,string.format("<span color='#0000ff'>+%d mana</span>",esther_max_mana-esther_mana))
            end
        end
		if wesnoth.get_variable("spell_params.enable_kyoko")==1 then
            local kyoko_mana = wesnoth.get_variable("kyoko_spell_params.kyoko_mana")
            local kyoko_max_mana = wesnoth.get_variable("kyoko_spell_params.kyoko_max_mana")
            local kyoko_mana_gain = wesnoth.get_variable("kyoko_spell_params.kyoko_mana_gain")

            if kyoko_mana == kyoko_max_mana then
                wesnoth.set_variable("kyoko_spell_params.kyoko_mana", kyoko_mana)
            elseif kyoko_mana < kyoko_max_mana-kyoko_mana_gain then
                wesnoth.set_variable("kyoko_spell_params.kyoko_mana", kyoko_mana + kyoko_mana_gain)
                local kyoko = wesnoth.get_unit("Kyoko")

                wesnoth.float_label(kyoko.x,kyoko.y,string.format("<span color='#0000ff'>+%d mana</span>",kyoko_mana_gain))
            else
                wesnoth.set_variable("kyoko_spell_params.kyoko_mana", kyoko_max_mana)
                local kyoko = wesnoth.get_unit("Kyoko")

                wesnoth.float_label(kyoko.x,kyoko.y,string.format("<span color='#0000ff'>+%d mana</span>",kyoko_max_mana-kyoko_mana))
            end
        end
		if wesnoth.get_variable("spell_params.enable_talya")==1 then
            local talya_mana = wesnoth.get_variable("talya_spell_params.talya_mana")
            local talya_max_mana = wesnoth.get_variable("talya_spell_params.talya_max_mana")
            local talya_mana_gain = wesnoth.get_variable("talya_spell_params.talya_mana_gain")

            if talya_mana == talya_max_mana then
                wesnoth.set_variable("talya_spell_params.talya_mana", talya_mana)
            elseif talya_mana < talya_max_mana-talya_mana_gain then
                wesnoth.set_variable("talya_spell_params.talya_mana", talya_mana + talya_mana_gain)
                local talya = wesnoth.get_unit("Talya")

                wesnoth.float_label(talya.x,talya.y,string.format("<span color='#0000ff'>+%d mana</span>",talya_mana_gain))
            else
                wesnoth.set_variable("talya_spell_params.talya_mana", talya_max_mana)
                local talya = wesnoth.get_unit("Talya")

                wesnoth.float_label(talya.x,talya.y,string.format("<span color='#0000ff'>+%d mana</span>",talya_max_mana-talya_mana))
            end
        end
        if wesnoth.get_variable("spell_params.enable_yumi")==1 then
            local yumi_mana = wesnoth.get_variable("yumi_spell_params.yumi_mana")
            local yumi_max_mana = wesnoth.get_variable("yumi_spell_params.yumi_max_mana")
            local yumi_mana_gain = wesnoth.get_variable("yumi_spell_params.yumi_mana_gain")

            if yumi_mana == yumi_max_mana then
                wesnoth.set_variable("yumi_spell_params.yumi_mana", yumi_mana)
            elseif yumi_mana < yumi_max_mana-yumi_mana_gain then
                wesnoth.set_variable("yumi_spell_params.yumi_mana", yumi_mana + yumi_mana_gain)
                local yumi = wesnoth.get_unit("Yumi")

                wesnoth.float_label(yumi.x,yumi.y,string.format("<span color='#0000ff'>+%d mana</span>",yumi_mana_gain))
            else
                wesnoth.set_variable("yumi_spell_params.yumi_mana", yumi_max_mana)
                local yumi = wesnoth.get_unit("Yumi")

                wesnoth.float_label(yumi.x,yumi.y,string.format("<span color='#0000ff'>+%d mana</span>",yumi_max_mana-yumi_mana))
            end
        end
    end
end)

-- check whether a spell is castable
-- includes location checks, whether a unit exists there, and whether you have found the spell yet
function check_spell_castable_aryel(x,y,radi,cost,spell_name)
    local a = wesnoth.match_location(x,y,{
                {"filter_adjacent_location", {radius=radi,
                    {"filter",{id="Aryel"}}
                }}
            })
    local b = true
    if spell_name=="Malefice" then
        local aryel = wesnoth.get_unit("Aryel")
        b = wesnoth.match_location(x,y,{
                {"filter",{
                    {"filter_side",{
                        {"enemy_of",{side = aryel.side}}
                    }}
                }}
            })
    elseif spell_name=="Infuse" then
        local aryel = wesnoth.get_unit("Aryel")
        b = wesnoth.match_location(x,y,{
                {"filter",{
                    {"filter_side",{
                        {"allied_with",{side = aryel.side}}
                    }}
                }}
            })
    end
    local c = true
    if cost > wesnoth.get_variable("aryel_spell_params.aryel_mana") then
        c = false
    end

    return a and b and c
end

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
-------------- ARYEL ----------------
function wesnoth.wml_actions.malefice_spell()
    local aryel_spell_power = wesnoth.get_variable("aryel_spell_params.aryel_spell_power")
    local malefice_bonus = wesnoth.get_variable("aryel_spell_params.malefice_bonus")

    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount=3 + malefice_bonus*aryel_spell_power,delay="50",experience="yes",damage_type="arcane",variable="damage",
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Aryel"}},
        {"primary_attack",{name="eviscerate"}},
        {"secondary_attack",{name="eviscerate"}}
    }
    local healing = wesnoth.get_variable("damage.harm_amount")
    wesnoth.wml_actions.clear_variable {name="damage"}

    wesnoth.wml_actions.heal_unit {
        animate="yes",amount=healing,delay="50",
        {"filter",{id="Aryel"}}
    }
    
    wesnoth.set_variable("aryel_spell_params.aryel_mana", wesnoth.get_variable("aryel_spell_params.aryel_mana") - 5)

    if not wesnoth.match_unit(unit, {x="$x1",y="$y1"}) then
        wesnoth.set_variable("aryel_spell_params.malefice_bonus", malefice_bonus + 0.5)
    end
end

function wesnoth.wml_actions.infuse_spell()
    local aryel_spell_power = wesnoth.get_variable("aryel_spell_params.aryel_spell_power")
    local infuse_bonus = wesnoth.get_variable("aryel_spell_params.infuse_bonus")

    wesnoth.wml_actions.heal_unit {
        animate="yes",amount=3 + infuse_bonus*aryel_spell_power,
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Aryel"}}
    }

    wesnoth.set_variable("aryel_spell_params.aryel_mana", wesnoth.get_variable("aryel_spell_params.aryel_mana") - 4)

    if infuse_bonus < wesnoth.get_variable("aryel_spell_params.infuse_max_bonus") then
        wesnoth.set_variable("aryel_spell_params.infuse_bonus", infuse_bonus + 0.1)
    end
end

------------- ESTHER ----------------
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

    wesnoth.set_variable("esther_spell_params.esther_mana", wesnoth.get_variable("esther_spell_params.esther_mana") - 4)

    if firebolt_bonus < wesnoth.get_variable("esther_spell_params.firebolt_max_bonus") then
        wesnoth.set_variable("esther_spell_params.firebolt_bonus", firebolt_bonus + 0.1)
    end
end
------------- YUMI ------------
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

    wesnoth.set_variable("yumi_spell_params.yumi_mana", wesnoth.get_variable("yumi_spell_params.yumi_mana") - 5)

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

    wesnoth.set_variable("yumi_spell_params.yumi_mana", wesnoth.get_variable("yumi_spell_params.yumi_mana") - 4)

    if void_damage_bonus < wesnoth.get_variable("yumi_spell_params.yumi_void_max_bonus") then
        wesnoth.set_variable("yumi_spell_params.void_damage_bonus", void_damage_bonus + 0.1)
    end
end

----------------------------------------------- SPELL MENUS ----------------------------------------------------
--aryel spell menu
function wesnoth.wml_actions.aryel_spell_menu()

    local helper = wesnoth.require "lua/helper.lua"
    local T = helper.set_wml_tag_metatable {}

    local dialog = {
      T.tooltip { id = "tooltip_large" },
      T.helptip { id = "tooltip_large" },
      T.linked_group { id = "icon", fixed_width = true },
      T.linked_group { id = "label", fixed_width = true },
      T.grid {
        T.row {
            T.column {
                border = "all",
                border_size = 5,
                horizontal_alignment = "left",
                T.label {
                    definition = "title",
                    id = "title",
                    label = "Spellcasting - Aryel"
                }
            }
        },
        T.row {
            T.column {
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 1,
                            horizontal_grow = true,
                            vertical_alignment = "top",
                            T.listbox { id = "list",
                                T.list_definition { T.row { T.column { horizontal_grow = true,
                                  T.toggle_panel { return_value = -1, T.grid { T.row {
                                    T.column { horizontal_alignment = "left", T.image { id = "icon" } },
                                    T.column { horizontal_alignment = "left", T.label { id = "label" } },

                                  } } }
                                } } }
                              }
                        }
                    }
                }
            }
        },
        T.row {
            T.column {
                horizontal_alignment = "right",
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "cast_button",
                                return_value = -1,
                                label = "Cast"
                            }
                        },
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "ok_button",
                                return_value = 1,
                                label = "Cancel"
                            }
                        }
                    }
                }
            }
        }
      }
    }

    local function preshow()
        local function select()
            local i = wesnoth.get_dialog_value "list"
        end
        wesnoth.set_dialog_callback(select, "list")

        local x = wesnoth.get_variable("x1")
        local y = wesnoth.get_variable("y1")
        local count = 1

        wesnoth.set_dialog_value(string.format("<span color='#0000ff'>Current Mana: %d</span>",wesnoth.get_variable("aryel_spell_params.aryel_mana")), "list", 1, "label")
        wesnoth.set_dialog_markup(true,"list", 1, "label")
        wesnoth.set_dialog_value("attacks/staff-elven-star.png", "list", 1, "icon")

        local aryel_spell_params = helper.get_variable_array("aryel_spell_params")

        for i,v in ipairs(aryel_spell_params) do
            local b = check_spell_castable_aryel(x,y,aryel_spell_params[i].aryel_spell_radii,aryel_spell_params[i].aryel_spell_costs,aryel_spell_params[i].aryel_spells)

            if i == 1 then
            elseif b==true then
                wesnoth.set_dialog_value(string.format("%s (%d mana)",aryel_spell_params[i].aryel_spells,aryel_spell_params[i].aryel_spell_costs), "list", i, "label")
                wesnoth.set_dialog_value(aryel_spell_params[i].aryel_spell_images, "list", i, "icon")
            end
            count = count + 1
        end

        wesnoth.set_dialog_value("<span color='#ff0000'>Cancel</span>", "list", count, "label")
        wesnoth.set_dialog_markup(true,"list", count, "label")
        wesnoth.set_dialog_value("attacks/blank-attack.png", "list", count, "icon")
        wesnoth.set_dialog_value(1, "list")
        select()
    end

    local li
    local function postshow()
        li = wesnoth.get_dialog_value "list"
    end


    local r = wesnoth.show_dialog(dialog, preshow, postshow)
    local aryel_spell_params = helper.get_variable_array("aryel_spell_params")
    local count = 1
    for i,v in ipairs(aryel_spell_params) do
        count = count + 1
    end

    if r == -1 and li < count then
        if aryel_spell_params[li].aryel_spells=="Infuse" then
            wesnoth.wml_actions.infuse_spell()
        elseif aryel_spell_params[li].aryel_spells=="Malefice" then
            wesnoth.wml_actions.malefice_spell()
        end
    end
end
--aryel spell help

function wesnoth.wml_actions.aryel_spell_help()

    local helper = wesnoth.require "lua/helper.lua"
    local T = helper.set_wml_tag_metatable {}

    local dialog = {
      T.tooltip { id = "tooltip_large" },
      T.helptip { id = "tooltip_large" },
      T.linked_group { id = "icon", fixed_width = true },
      T.linked_group { id = "label", fixed_width = true },
      T.grid {
        T.row {
            T.column {
                border = "all",
                border_size = 5,
                horizontal_alignment = "left",
                T.label {
                    definition = "title",
                    id = "title",
                    label = "Spell Help - Aryel"
                }
            }
        },
        T.row {
            T.column {
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 1,
                            horizontal_grow = true,
                            vertical_alignment = "top",
                            T.listbox { id = "list",
                                T.list_definition { T.row { T.column { horizontal_grow = true,
                                  T.toggle_panel { return_value = -1, T.grid { T.row {
                                    T.column { horizontal_alignment = "left", T.image { id = "icon" } },
                                    T.column { horizontal_alignment = "left", T.label { id = "label" } },

                                  } } }
                                } } }
                              }
                        }
                    }
                }
            }
        },
        T.row {
            T.column {
                horizontal_alignment = "right",
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "cast_button",
                                return_value = -1,
                                label = "OK"
                            }
                        },
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "ok_button",
                                return_value = 1,
                                label = "Cancel"
                            }
                        }
                    }
                }
            }
        }
      }
    }

    local function preshow()
        local function select()
            local i = wesnoth.get_dialog_value "list"
        end
        wesnoth.set_dialog_callback(select, "list")

        local x = wesnoth.get_variable("x1")
        local y = wesnoth.get_variable("y1")
        local count = 1

        wesnoth.set_dialog_value("Stats (Aryel)", "list", 1, "label")
        wesnoth.set_dialog_value("units/fae/aryel.png", "list", 1, "icon")

        local aryel_spell_params = helper.get_variable_array("aryel_spell_params")

        for i,v in ipairs(aryel_spell_params) do
            if i == 1 then
            else
                wesnoth.set_dialog_value(string.format("%s",aryel_spell_params[i].aryel_spells), "list", i, "label")
                wesnoth.set_dialog_value(aryel_spell_params[i].aryel_spell_images, "list", i, "icon")
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
    local aryel_spell_params = helper.get_variable_array("aryel_spell_params")
    local count = 1
    for i,v in ipairs(aryel_spell_params) do
        count = count + 1
    end

    --wesnoth.message(string.format("Button %d pressed. Item %d selected.", r, li))

    if r == -1 and li < count then
        if li == 1 then
            wesnoth.show_message_dialog({
                 title = "Character Statistics",
                 message = string.format("<span color='#0000ff'>Current Mana: %d</span> \n<span color='#00ffff'>Maximum Mana: %d</span> \n<span color='#85C1E9'>Mana Regen: %d</span>\n<span color='#F000FF'>Spell Power: %d</span>",wesnoth.get_variable("aryel_spell_params.aryel_mana"),wesnoth.get_variable("aryel_spell_params.aryel_max_mana"),wesnoth.get_variable("aryel_spell_params.aryel_mana_gain"),wesnoth.get_variable("aryel_spell_params.aryel_spell_power")),
                 portrait = "units/fae/aryel.png",
            })
        elseif aryel_spell_params[li].aryel_spells=="Infuse" then
            wesnoth.show_message_dialog({
                 title = "Infuse",
                 message = string.format("<span color='#0000ff'>Mana cost: 3</span> \n<span color='#008000'>Cast radius: 3</span> \nHeals <span color='#ff0000'>%d</span> hitpoints to target ally. Each cast increases the healing of this spell by <span color='#ff0000'>0.1</span>, up to a maximum of <span color='#ff0000'>%d</span>.",math.floor(wesnoth.get_variable("aryel_spell_params.infuse_bonus")+3.4),math.floor(wesnoth.get_variable("aryel_spell_params.infuse_max_bonus")+3)),
                 portrait = "attacks/touch-faerie.png",
            })
        elseif aryel_spell_params[li].aryel_spells=="Malefice" then
            wesnoth.show_message_dialog({
                 title = "Malefice",
                 message = string.format("<span color='#0000ff'>Mana cost: 5</span> \n<span color='#008000'>Cast radius: 1</span> \nDeals <span color='#ff0000'>%d</span> <span color='#00f2ff'>arcane</span> damage to target enemy. Killing an enemy unit with this spell increases its damage by <span color='#ff0000'>0.2</span>.",math.floor(wesnoth.get_variable("aryel_spell_params.malefice_bonus")+3.4)),
                 portrait = "attacks/wail.png",
            })
        end
    end
end


-- spell menu dialog setup for esther
function wesnoth.wml_actions.esther_spell_menu()

    local helper = wesnoth.require "lua/helper.lua"
    local T = helper.set_wml_tag_metatable {}

    local dialog = {
      T.tooltip { id = "tooltip_large" },
      T.helptip { id = "tooltip_large" },
      T.linked_group { id = "icon", fixed_width = true },
      T.linked_group { id = "label", fixed_width = true },
      T.grid {
        T.row {
            T.column {
                border = "all",
                border_size = 5,
                horizontal_alignment = "left",
                T.label {
                    definition = "title",
                    id = "title",
                    label = "Spellcasting - Esther"
                }
            }
        },
        T.row {
            T.column {
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 1,
                            horizontal_grow = true,
                            vertical_alignment = "top",
                            T.listbox { id = "list",
                                T.list_definition { T.row { T.column { horizontal_grow = true,
                                  T.toggle_panel { return_value = -1, T.grid { T.row {
                                    T.column { horizontal_alignment = "left", T.image { id = "icon" } },
                                    T.column { horizontal_alignment = "left", T.label { id = "label" } },

                                  } } }
                                } } }
                              }
                        }
                    }
                }
            }
        },
        T.row {
            T.column {
                horizontal_alignment = "right",
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "cast_button",
                                return_value = -1,
                                label = "Cast"
                            }
                        },
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "ok_button",
                                return_value = 1,
                                label = "Cancel"
                            }
                        }
                    }
                }
            }
        }
      }
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
      T.linked_group { id = "icon", fixed_width = true },
      T.linked_group { id = "label", fixed_width = true },
      T.grid {
        T.row {
            T.column {
                border = "all",
                border_size = 5,
                horizontal_alignment = "left",
                T.label {
                    definition = "title",
                    id = "title",
                    label = "Spell Help - Esther"
                }
            }
        },
        T.row {
            T.column {
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 1,
                            horizontal_grow = true,
                            vertical_alignment = "top",
                            T.listbox { id = "list",
                                T.list_definition { T.row { T.column { horizontal_grow = true,
                                  T.toggle_panel { return_value = -1, T.grid { T.row {
                                    T.column { horizontal_alignment = "left", T.image { id = "icon" } },
                                    T.column { horizontal_alignment = "left", T.label { id = "label" } },

                                  } } }
                                } } }
                              }
                        }
                    }
                }
            }
        },
        T.row {
            T.column {
                horizontal_alignment = "right",
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "cast_button",
                                return_value = -1,
                                label = "OK"
                            }
                        },
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "ok_button",
                                return_value = 1,
                                label = "Cancel"
                            }
                        }
                    }
                }
            }
        }
      }
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
                 message = string.format("<span color='#0000ff'>Mana cost: 4</span> \n<span color='#008000'>Cast radius: 3</span> \nDeals <span color='#ff0000'>%d</span> <span color='#ff5500'>fire</span> damage to target enemy. Each cast increases the damage of this spell by <span color='#ff0000'>0.1</span>, up to a maximum of <span color='#ff0000'>%d</span>.",math.floor(wesnoth.get_variable("esther_spell_params.firebolt_bonus")+4.4),math.floor(wesnoth.get_variable("esther_spell_params.firebolt_max_bonus")+4)),
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
      T.linked_group { id = "icon", fixed_width = true },
      T.linked_group { id = "label", fixed_width = true },
      T.grid {
        T.row {
            T.column {
                border = "all",
                border_size = 5,
                horizontal_alignment = "left",
                T.label {
                    definition = "title",
                    id = "title",
                    label = "Spellcasting - Yumi"
                }
            }
        },
        T.row {
            T.column {
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 1,
                            horizontal_grow = true,
                            vertical_alignment = "top",
                            T.listbox { id = "list",
                                T.list_definition { T.row { T.column { horizontal_grow = true,
                                  T.toggle_panel { return_value = -1, T.grid { T.row {
                                    T.column { horizontal_alignment = "left", T.image { id = "icon" } },
                                    T.column { horizontal_alignment = "left", T.label { id = "label" } },

                                  } } }
                                } } }
                              }
                        }
                    }
                }
            }
        },
        T.row {
            T.column {
                horizontal_alignment = "right",
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "cast_button",
                                return_value = -1,
                                label = "Cast"
                            }
                        },
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "ok_button",
                                return_value = 1,
                                label = "Cancel"
                            }
                        }
                    }
                }
            }
        }
      }
    }

    local function preshow()
        local function select()
            local i = wesnoth.get_dialog_value "list"
        end
        wesnoth.set_dialog_callback(select, "list")

        local x = wesnoth.get_variable("x1")
        local y = wesnoth.get_variable("y1")
        local count = 1

        wesnoth.set_dialog_value(string.format("<span color='#0000ff'>Current Mana: %d</span>",wesnoth.get_variable("yumi_spell_params.yumi_mana")), "list", 1, "label")
        wesnoth.set_dialog_markup(true,"list", 1, "label")
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

        wesnoth.set_dialog_value("<span color='#ff0000'>Cancel</span>", "list", count, "label")
        wesnoth.set_dialog_markup(true,"list", count, "label")
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
      T.linked_group { id = "icon", fixed_width = true },
      T.linked_group { id = "label", fixed_width = true },
      T.grid {
        T.row {
            T.column {
                border = "all",
                border_size = 5,
                horizontal_alignment = "left",
                T.label {
                    definition = "title",
                    id = "title",
                    label = "Spell Help - Yumi"
                }
            }
        },
        T.row {
            T.column {
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 1,
                            horizontal_grow = true,
                            vertical_alignment = "top",
                            T.listbox { id = "list",
                                T.list_definition { T.row { T.column { horizontal_grow = true,
                                  T.toggle_panel { return_value = -1, T.grid { T.row {
                                    T.column { horizontal_alignment = "left", T.image { id = "icon" } },
                                    T.column { horizontal_alignment = "left", T.label { id = "label" } },

                                  } } }
                                } } }
                              }
                        }
                    }
                }
            }
        },
        T.row {
            T.column {
                horizontal_alignment = "right",
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "cast_button",
                                return_value = -1,
                                label = "OK"
                            }
                        },
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "ok_button",
                                return_value = 1,
                                label = "Cancel"
                            }
                        }
                    }
                }
            }
        }
      }
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
                 message = string.format("<span color='#0000ff'>Mana cost: 5</span> \n<span color='#008000'>Cast radius: 2</span> \nDeals <span color='#ff0000'>5</span> <span color='#00bfff'>arcane</span> damage to target enemy and heals for <span color='#008000'>%d%%</span> of the damage dealt. Each cast increases healing proportion by <span color='#008000'>1%%</span>, up to <span color='#008000'>100%%</span>.",wesnoth.get_variable("yumi_spell_params.siphon_spell_healing")*100),
                 portrait = "attacks/faerie-fire.png",
            })
        elseif yumi_spell_params[li].yumi_spells=="Void Blast" then
            wesnoth.show_message_dialog({
                 title = "Void Blast",
                 message = string.format("<span color='#0000ff'>Mana cost: 4</span> \n<span color='#008000'>Cast radius: 4</span> \nDeals <span color='#ff0000'>%d</span> damage to target enemy. Each cast increases the damage of this spell by <span color='#ff0000'>0.1</span>, up to a maximum of <span color='#ff0000'>%d</span>.",math.floor(wesnoth.get_variable("yumi_spell_params.void_damage_bonus")+5.4),math.floor(wesnoth.get_variable("yumi_spell_params.yumi_void_max_bonus")+5)),
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
      T.linked_group { id = "icon", fixed_width = true },
      T.linked_group { id = "label", fixed_width = true },
      T.grid {
        T.row {
            T.column {
                border = "all",
                border_size = 5,
                horizontal_alignment = "left",
                T.label {
                    definition = "title",
                    id = "title",
                    label = "Spellcasting"
                }
            }
        },
        T.row {
            T.column {
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 1,
                            horizontal_grow = true,
                            vertical_alignment = "top",
                            T.listbox { id = "list",
                                T.list_definition { T.row { T.column { horizontal_grow = true,
                                  T.toggle_panel { return_value = -1, T.grid { T.row {
                                    T.column { horizontal_alignment = "left", T.image { id = "icon" } },
                                    T.column { horizontal_alignment = "left", T.label { id = "label" } },

                                  } } }
                                } } }
                              }
                        }
                    }
                }
            }
        },
        T.row {
            T.column {
                horizontal_alignment = "right",
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "cast_button",
                                return_value = -1,
                                label = "OK"
                            }
                        },
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "ok_button",
                                return_value = 1,
                                label = "Cancel"
                            }
                        }
                    }
                }
            }
        }
      }
    }

    local function preshow()
        local function select()
            local i = wesnoth.get_dialog_value "list"
        end
        wesnoth.set_dialog_callback(select, "list")

        local x = wesnoth.get_variable("x1")
        local y = wesnoth.get_variable("y1")

        wesnoth.set_dialog_value("<span color='#008000'>Spell Help</span>", "list", 1, "label")
        wesnoth.set_dialog_markup(true,"list", 1, "label")
        wesnoth.set_dialog_value("attacks/staff-elven-star.png~SCALE(72,72)", "list", 1, "icon")

        -- check if any spell is castable by aryel
        local a = wesnoth.match_location(x,y,{
            {"filter",{id="Aryel"}},
            {"or",{
                {"filter_adjacent_location", {radius=wesnoth.get_variable("aryel_spell_params.aryel_spell_radius"),
                    {"filter",{id="Aryel"}}
                }}
            }}
        })
        
        -- make menu items for Aryel available
        if a == true then
            wesnoth.set_dialog_value("Cast Spell (Aryel)", "list", 2, "label")
            wesnoth.set_dialog_value("units/fae/aryel.png", "list", 2, "icon")
            wesnoth.set_dialog_markup(true,"list", 2, "label")
            wesnoth.set_dialog_value("Spell Help (Aryel)", "list", 3, "label")
            wesnoth.set_dialog_value("units/fae/aryel.png", "list", 3, "icon")
            wesnoth.set_dialog_markup(true,"list", 3, "label")
        end
        
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
            wesnoth.set_dialog_markup(true,"list", 4, "label")
            wesnoth.set_dialog_value("Spell Help (Esther)", "list", 5, "label")
            wesnoth.set_dialog_value("units/fae/esther.png", "list", 5, "icon")
            wesnoth.set_dialog_markup(true,"list", 5, "label")
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
            wesnoth.set_dialog_markup(true,"list", 10, "label")
            wesnoth.set_dialog_value("Spell Help (Yumi)", "list", 11, "label")
            wesnoth.set_dialog_value("units/fae/yumi.png", "list", 11, "icon")
            wesnoth.set_dialog_markup(true,"list", 11, "label")
        end

        wesnoth.set_dialog_value("<span color='#ff0000'>Cancel</span>", "list", 12, "label")
        wesnoth.set_dialog_markup(true,"list", 12, "label")
        wesnoth.set_dialog_value("attacks/blank-attack.png~SCALE(72,72)", "list", 12, "icon")
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
        elseif li==2 then
            wesnoth.wml_actions.aryel_spell_menu()
        elseif li==3 then
            wesnoth.wml_actions.aryel_spell_help()
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
        wesnoth.set_variable("spell_params.enable_spells", 1)
    elseif enable == 0 then
        wesnoth.wml_actions.clear_menu_item { id = "spells"}
        wesnoth.set_variable("spell_params.enable_spells", 0)
    end
end

-- initialize spell menus
function wesnoth.wml_actions.initialize_spells(cfg)
    wesnoth.set_variable("spell_params.enable_spells", 1)
    wesnoth.set_variable("spell_params.enable_aryel", 0)
    wesnoth.set_variable("spell_params.enable_esther", 0)
    wesnoth.set_variable("spell_params.enable_kyoko", 0)
    wesnoth.set_variable("spell_params.enable_talya", 0)
    wesnoth.set_variable("spell_params.enable_yumi", 0)
    wesnoth.wml_actions.refresh_spell_menu(cfg)
end
-------------------------------------- SPELL DISCOVERY ----------------------------------------------
------------ ARYEL --------------
function wesnoth.wml_actions.add_infuse_aryel(cfg)
    wesnoth.wml_actions.set_variables {name = "aryel_spell_params", mode = "append",
        {"value",{aryel_spells = "Infuse",aryel_spell_images = "attacks/touch-faerie.png",
        aryel_spell_radii = 3,aryel_spell_costs = 3}},
    }

    if 3 > wesnoth.get_variable("aryel_spell_params.aryel_spell_radius") then
        wesnoth.set_variable("aryel_spell_params.aryel_spell_radius",3)
    end

    wesnoth.set_variable("aryel_spell_params.infuse_bonus",0.0)
    wesnoth.set_variable("aryel_spell_params.infuse_max_bonus",3.0)

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end
function wesnoth.wml_actions.add_malefice_aryel(cfg)
    wesnoth.wml_actions.set_variables {name = "aryel_spell_params", mode = "append",
        {"value",{aryel_spells = "Malefice",aryel_spell_images = "attacks/wail.png",
        aryel_spell_radii = 1,aryel_spell_costs = 5}},
    }

    if 1 > wesnoth.get_variable("aryel_spell_params.aryel_spell_radius") then
        wesnoth.set_variable("aryel_spell_params.aryel_spell_radius",1)
    end

    wesnoth.set_variable("aryel_spell_params.malefice_bonus",0.0)

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end
----------- ESTHER --------------
-- discover firebolt
function wesnoth.wml_actions.add_firebolt_esther(cfg)
    wesnoth.wml_actions.set_variables {name = "esther_spell_params", mode = "append",
        {"value",{esther_spells = "Firebolt",esther_spell_images = "attacks/fireball.png",
        esther_spell_radii = 3,esther_spell_costs = 4}},
    }

    if 3 > wesnoth.get_variable("esther_spell_params.esther_spell_radius") then
        wesnoth.set_variable("esther_spell_params.esther_spell_radius",3)
    end

    wesnoth.set_variable("esther_spell_params.firebolt_bonus",0.0)
    wesnoth.set_variable("esther_spell_params.firebolt_max_bonus",3.0)

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end

------------ YUMI ----------------
-- discover siphon
function wesnoth.wml_actions.add_siphon_yumi(cfg)
    wesnoth.wml_actions.set_variables {name = "yumi_spell_params", mode = "append",
        {"value",{yumi_spells = "Siphon",yumi_spell_images = "attacks/faerie-fire.png",
        yumi_spell_radii = 2,yumi_spell_costs = 5}}
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
        yumi_spell_radii = 4,yumi_spell_costs = 4}},
    }

    if 4 > wesnoth.get_variable("yumi_spell_params.yumi_spell_radius") then
        wesnoth.set_variable("yumi_spell_params.yumi_spell_radius",4)
    end

    wesnoth.set_variable("yumi_spell_params.void_damage_bonus",0.0)
    wesnoth.set_variable("yumi_spell_params.yumi_void_max_bonus",4.0)

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end