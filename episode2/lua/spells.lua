function wesnoth.wml_actions.aryel_spell_setup()
    wesnoth.set_variable("aryel_spell_params.aryel_spell_radius",0)
    wesnoth.set_variable("aryel_spell_params.aryel_spell_power",2)
    wesnoth.set_variable("aryel_spell_params.aryel_intelligence",3)
    wesnoth.set_variable("aryel_spell_params.aryel_insight",2)
	
    wesnoth.set_variable("aryel_spell_params.aryel_mana_gain",2)
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
    wesnoth.set_variable("esther_spell_params.esther_spell_power",2)
    wesnoth.set_variable("esther_spell_params.esther_intelligence",2)
    wesnoth.set_variable("esther_spell_params.esther_insight",1)
	
    wesnoth.set_variable("esther_spell_params.esther_mana_gain",1)
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
    wesnoth.set_variable("kyoko_spell_params.kyoko_intelligence",1)
    wesnoth.set_variable("kyoko_spell_params.kyoko_insight",1)
	
    wesnoth.set_variable("kyoko_spell_params.kyoko_mana_gain",2)
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
    wesnoth.set_variable("talya_spell_params.talya_intelligence",1)
    wesnoth.set_variable("talya_spell_params.talya_insight",1)
	
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
    wesnoth.set_variable("yumi_spell_params.yumi_spell_power",3)
    wesnoth.set_variable("yumi_spell_params.yumi_intelligence",3)
    wesnoth.set_variable("yumi_spell_params.yumi_insight",3)
	
    wesnoth.set_variable("yumi_spell_params.yumi_mana_gain",2)
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
            local aryel_mana_gain = math.floor(wesnoth.get_variable("aryel_spell_params.aryel_mana_gain")*(1+wesnoth.get_variable("aryel_spell_params.aryel_intelligence")/10))
			
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
            local esther_mana_gain = math.floor(wesnoth.get_variable("esther_spell_params.esther_mana_gain")*(1+wesnoth.get_variable("esther_spell_params.esther_intelligence")/10))

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
            local kyoko_mana_gain = math.floor(wesnoth.get_variable("kyoko_spell_params.kyoko_mana_gain")*(1+wesnoth.get_variable("kyoko_spell_params.kyoko_intelligence")/10))

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
            local talya_mana_gain = math.floor(wesnoth.get_variable("talya_spell_params.talya_mana_gain")*(1+wesnoth.get_variable("talya_spell_params.talya_intelligence")/10))

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
            local yumi_mana_gain = math.floor(wesnoth.get_variable("yumi_spell_params.yumi_mana_gain")*(1+wesnoth.get_variable("yumi_spell_params.yumi_intelligence")/10))

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
    local aryel = wesnoth.get_unit("Aryel")
    local a = true
    if spell_name=="Infuse" or spell_name=="Malefice" or spell_name=="Eldritch Bolt" or spell_name=="Harvest Soul" or spell_name=="Blood Bind" then
        a = wesnoth.match_location(x,y,{
                {"filter_adjacent_location", {radius=radi,
                    {"filter",{id="Aryel"}}
                }}
            })
    end
    local b = true
    if spell_name=="Malefice" or spell_name=="Eldritch Bolt" or spell_name=="Blood Bind" then
        b = wesnoth.match_location(x,y,{
                {"filter",{
                    {"filter_side",{
                        {"enemy_of",{side = aryel.side}}
                    }}
                }}
            })
    elseif spell_name=="Infuse" then
        b = wesnoth.match_location(x,y,{
                {"filter",{
                    {"filter_side",{
                        {"allied_with",{side = aryel.side}}
                    }}
                }}
            })
    elseif spell_name=="Harvest Soul" then
        local aryel = wesnoth.get_unit("Aryel")
        b = wesnoth.match_location(x,y,{
                {"filter",{type="Ghost,Wraith,Shadow,Spectre,Nightgaunt,Eldritch Form",
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

    local d = true
    if spell_name=="Blood Bind" then
        d = (aryel.hitpoints > 6)
    end
    
    return a and b and c and d
end

function check_spell_castable_esther(x,y,radi,cost,spell_name)
    local a = true
    if spell_name == "Firebolt" or spell_name=="Ember Spear" or spell_name=="Lightning Bolt" then
        a = wesnoth.match_location(x,y,{
                {"filter_adjacent_location", {radius=radi,
                    {"filter",{id="Esther"}}
                }}
            })
    end
    local b = true
    if spell_name=="Firebolt" or spell_name=="Ember Spear" or spell_name=="Lightning Bolt" then
        local esther = wesnoth.get_unit("Esther")
        b = wesnoth.match_location(x,y,{
                {"filter",{
                    {"filter_side",{
                        {"enemy_of",{side = esther.side}}
                    }}
                }}
            })
	elseif spell_name=="Sunlight Spark" then
        local tod = wesnoth.get_time_of_day({x,y,true})
        b = tod.lawful_bonus > 0
    end
    local c = true
    if cost > wesnoth.get_variable("esther_spell_params.esther_mana") then
        c = false
    end
    return a and b and c
end

function check_spell_castable_yumi(x,y,radi,cost,spell_name)
    
    local yumi = wesnoth.get_unit("Yumi")
    local a = true
    
    if spell_name=="Siphon" or spell_name=="Void Blast" or spell_name== "Null Flare" then
        a = wesnoth.match_location(x,y,{
                {"filter_adjacent_location", {radius=radi,
                    {"filter",{id="Yumi"}}
                }}
            })
    end
    local b = true
    if spell_name=="Siphon" or spell_name=="Void Blast" or spell_name== "Null Flare" then
        
        b = wesnoth.match_location(x,y,{
                {"filter",{
                    {"filter_side",{
                        {"enemy_of",{side = yumi.side}}
                    }}
                }}
            })
    elseif spell_name=="Ethereal Form" or spell_name=="Shadow Walk" then
        local tod = wesnoth.get_time_of_day({x,y,true})
        b = tod.lawful_bonus < 0
    end
    local c = true
    if cost > wesnoth.get_variable("yumi_spell_params.yumi_mana") then
        c = false
    end

    local d = true
    if spell_name=="Astral Blood" then
        d = (yumi.hitpoints > 6)
    elseif spell_name=="Shadow Walk" then
        d = (yumi.moves==yumi.max_moves and yumi.attacks_left==yumi.max_attacks)
    end
    
    return a and b and c and d
end

------------------------------------------- SPELL IMPLEMENTATIONS -------------------------------------------------------
-------------- ARYEL ----------------
function wesnoth.wml_actions.malefice_spell()
    local aryel_spell_power = wesnoth.get_variable("aryel_spell_params.aryel_spell_power")
    local malefice_bonus = wesnoth.get_variable("aryel_spell_params.malefice_bonus")
    local insight = wesnoth.get_variable("aryel_spell_params.aryel_insight")

    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount=math.floor((3 + malefice_bonus)*(1+aryel_spell_power/10)),delay="50",experience="yes",damage_type="arcane",variable="damage",
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

    if not wesnoth.wml_conditionals.have_unit { x = "$x1", y = "$y1" } then
        wesnoth.set_variable("aryel_spell_params.malefice_bonus", malefice_bonus + 0.2*(1+insight/10))
    end
end

function wesnoth.wml_actions.infuse_spell()
    local aryel_spell_power = wesnoth.get_variable("aryel_spell_params.aryel_spell_power")
    local infuse_bonus = wesnoth.get_variable("aryel_spell_params.infuse_bonus")
	local insight = wesnoth.get_variable("aryel_spell_params.aryel_insight")
	local intelligence = wesnoth.get_variable("aryel_spell_params.aryel_intelligence")

    wesnoth.wml_actions.heal_unit {
        animate="yes",amount=math.floor((3 + infuse_bonus)*(1+aryel_spell_power/10)),
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Aryel"}}
    }

    wesnoth.set_variable("aryel_spell_params.aryel_mana", wesnoth.get_variable("aryel_spell_params.aryel_mana") - 3)

    if infuse_bonus < math.floor(wesnoth.get_variable("aryel_spell_params.infuse_max_bonus")*(1+intelligence/20)) then
        wesnoth.set_variable("aryel_spell_params.infuse_bonus", infuse_bonus + 0.1*(1+insight/10))
    end
end

function wesnoth.wml_actions.blood_bind_spell()
    local aryel_spell_power = wesnoth.get_variable("aryel_spell_params.aryel_spell_power")
    local aryel = wesnoth.get_unit("Aryel")
    local insight = wesnoth.get_variable("aryel_spell_params.aryel_insight")
	local intelligence = wesnoth.get_variable("aryel_spell_params.aryel_intelligence")

    local blood_bind_factor = wesnoth.get_variable("aryel_spell_params.blood_bind_factor")

    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount=math.floor(6*blood_bind_factor*(1+aryel_spell_power/10)),delay="50",experience="yes",
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Aryel"}},
        {"primary_attack",{name="blood boil"}},
        {"secondary_attack",{name="blood boil"}}
    }
    
    wesnoth.wml_actions.modify_unit {hitpoints=aryel.hitpoints-6,
        {"filter",{id="Aryel"}}
    }
    
    wesnoth.float_label(aryel.x,aryel.y,string.format("<span color='#ff0000'>-%d HP</span>",6))
    
    wesnoth.set_variable("aryel_spell_params.aryel_mana", wesnoth.get_variable("aryel_spell_params.aryel_mana") - 1)
    
    if blood_bind_factor < math.floor(wesnoth.get_variable("aryel_spell_params.blood_bind_max_factor")*(1+intelligence/20)) then
        wesnoth.set_variable("aryel_spell_params.blood_bind_factor", blood_bind_factor + 0.1*(1+insight/10))
    end
end

function wesnoth.wml_actions.harvest_soul_spell()
    local aryel_spell_power = wesnoth.get_variable("aryel_spell_params.aryel_spell_power")

    local x = wesnoth.get_variable("x1")
    local y = wesnoth.get_variable("y1")
    
    local aryel = wesnoth.get_unit("Aryel")
    local soul = wesnoth.get_unit(x,y)
    
    local HP = 0
    local mana = 0
    
    if soul.type == "Eldritch Form" then
        HP = 0
        mana = 2
    elseif soul.type == "Ghost" then
        HP = 8
        mana = 0
    elseif soul.type == "Shadow" or soul.type == "Wraith" then
        HP = 16
        mana = 1
    elseif soul.type == "Nightgaunt" or soul.type == "Spectre" then
        HP = 24
        mana = 2
    end

    wesnoth.wml_actions.heal_unit {
        animate="yes",amount=math.floor(HP*(1+aryel_spell_power/10)),
        {"filter",{id="Aryel"}}
    }
    
    wesnoth.float_label(aryel.x,aryel.y,string.format("<span color='#00ff00'>+%d HP</span>",math.floor(HP*(1+aryel_spell_power/10))))
    wesnoth.float_label(aryel.x,aryel.y,string.format("<span color='#0000ff'>%d mana</span>",mana))
    
    wesnoth.wml_actions.kill { x=x,y=y,animate="yes" }
    
    wesnoth.set_variable("aryel_spell_params.aryel_mana", wesnoth.get_variable("aryel_spell_params.aryel_mana") + mana)
end

function wesnoth.wml_actions.eldritch_bolt_spell()
    local aryel_spell_power = wesnoth.get_variable("aryel_spell_params.aryel_spell_power")
    local eldritch_bonus = wesnoth.get_variable("aryel_spell_params.eldritch_bonus")
	local intelligence = wesnoth.get_variable("aryel_spell_params.aryel_intelligence")

    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount=math.floor(7*(1+aryel_spell_power/10)),delay="50",experience="yes",damage_type="arcane",
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Aryel"}},
        {"primary_attack",{name="blood boil"}},
        {"secondary_attack",{name="blood boil"}}
    }

    wesnoth.set_variable("aryel_spell_params.aryel_mana", wesnoth.get_variable("aryel_spell_params.aryel_mana") - 6)

    if not wesnoth.wml_conditionals.have_unit { x = "$x1", y = "$y1" } and eldritch_bonus < math.floor(wesnoth.get_variable("aryel_spell_params.eldritch_max_bonus")*(1+intelligence/20)) then
        wesnoth.set_variable("aryel_spell_params.eldritch_bonus", eldritch_bonus + 1*(1+insight/10))
        local unit = wesnoth.create_unit { type = "Eldritch Form", hitpoints=math.floor(10+eldritch_bonus), max_hitpoints=math.floor(10+eldritch_bonus)}
        local x = wesnoth.get_variable("x1")
        local y = wesnoth.get_variable("y1")
        wesnoth.put_unit(x,y,unit)
    end
end

------------- ESTHER ----------------
function wesnoth.wml_actions.firebolt_spell()
    local esther_spell_power = wesnoth.get_variable("esther_spell_params.esther_spell_power")
    local firebolt_bonus = wesnoth.get_variable("esther_spell_params.firebolt_bonus")
	local insight = wesnoth.get_variable("esther_spell_params.esther_insight")
	local intelligence = wesnoth.get_variable("esther_spell_params.esther_intelligence")

    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount=math.floor((4 + firebolt_bonus)*(1+esther_spell_power/10)),delay="50",experience="yes",damage_type="fire",
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Esther"}},
        {"primary_attack",{name="infernal blast"}},
        {"secondary_attack",{name="infernal blast"}}
    }

    wesnoth.set_variable("esther_spell_params.esther_mana", wesnoth.get_variable("esther_spell_params.esther_mana") - 4)
    if firebolt_bonus < math.floor(wesnoth.get_variable("esther_spell_params.firebolt_max_bonus")*(1+intelligence/20)) then
        wesnoth.set_variable("esther_spell_params.firebolt_bonus", firebolt_bonus + 0.1*(1+insight/10))
    end
    
    local u = wesnoth.get_unit("Esther")
    local x1 = wesnoth.get_variable("x1")
    local y1 = wesnoth.get_variable("y1")
    wesnoth.set_variable("spell_target.x", x1)
    wesnoth.set_variable("spell_target.y", y1)
    wesnoth.set_variable("spell_caster.x", u.x)
    wesnoth.set_variable("spell_caster.y", u.y)
    wesnoth.wml_actions.fire_event {name="firebolt spell"}
end

function wesnoth.wml_actions.sunlight_spark_spell()
    local esther_spell_power = wesnoth.get_variable("esther_spell_params.esther_spell_power")
    local sunlight_spark_bonus = wesnoth.get_variable("esther_spell_params.sunlight_spark_bonus")
	local insight = wesnoth.get_variable("esther_spell_params.esther_insight")
	local intelligence = wesnoth.get_variable("esther_spell_params.esther_intelligence")

    wesnoth.wml_actions.heal_unit {
        animate="yes",amount=math.floor((7 + sunlight_spark_bonus)*(1+esther_spell_power/10)),
        {"filter",{id="Esther"}}
    }

    wesnoth.set_variable("esther_spell_params.esther_mana", wesnoth.get_variable("esther_spell_params.esther_mana") - 4)

    if sunlight_spark_bonus < math.floor(wesnoth.get_variable("esther_spell_params.sunlight_spark_max_bonus")*(1+intelligence/20)) then
        wesnoth.set_variable("esther_spell_params.sunlight_spark_bonus", sunlight_spark_bonus + 0.5*(1+insight/10))
    end
end

function wesnoth.wml_actions.ember_spear_spell()
    local esther_spell_power = wesnoth.get_variable("esther_spell_params.esther_spell_power")
    local ember_bonus = wesnoth.get_variable("esther_spell_params.ember_bonus")
	local insight = wesnoth.get_variable("esther_spell_params.esther_insight")
	local intelligence = wesnoth.get_variable("esther_spell_params.esther_intelligence")

    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount=math.floor((2 + ember_bonus)*(1+esther_spell_power/10)),delay="50",experience="yes",damage_type="fire",slowed="yes",
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Esther"}},
        {"primary_attack",{name="infernal blast"}},
        {"secondary_attack",{name="infernal blast"}}
    }

    wesnoth.set_variable("esther_spell_params.esther_mana", wesnoth.get_variable("esther_spell_params.esther_mana") - 3)

    if ember_bonus < math.floor(wesnoth.get_variable("esther_spell_params.ember_max_bonus")*(1+intelligence/20)) then
        wesnoth.set_variable("esther_spell_params.ember_bonus", ember_bonus + 0.1*(1+insight/10))
    end
end

function wesnoth.wml_actions.ardent_flare_spell()
    local esther_spell_power = wesnoth.get_variable("esther_spell_params.esther_spell_power")

    wesnoth.wml_actions.object {take_only_once="no",duration="turn",silent="yes",
        {"filter",{id="Esther"}},
        {"effect",{apply_to="new_ability",
            {"abilities",{
                {"leadership",{affect_self="yes",affect_allies="no",affect_enemies="no",
                    name="ardent flare",description="This unit has increased damage.",value=math.floor(25*(1+esther_spell_power/10))
                }}
            }}
        }}
    }

    wesnoth.set_variable("esther_spell_params.esther_mana", wesnoth.get_variable("esther_spell_params.esther_mana") - 6)
end

function wesnoth.wml_actions.blazing_star_spell()
    local esther_spell_power = wesnoth.get_variable("esther_spell_params.esther_spell_power")

    wesnoth.wml_actions.object {take_only_once="no",duration="turn",silent="yes",
        {"filter",{id="Esther"}},
        {"effect",{apply_to="new_ability",
            {"abilities",{
                {"leadership",{affect_self="no",affect_allies="no",affect_enemies="yes",
                    name="blazing star",description="Nearby enemies have decreased damage.",value=math.floor(-50*(1+esther_spell_power/10)),
                    {"affect_adjacent",{adjacent="n,ne,se,s,sw,nw"}}
                }}
            }}
        }}
    }

    wesnoth.set_variable("esther_spell_params.esther_mana", wesnoth.get_variable("esther_spell_params.esther_mana") - 6)
end

function wesnoth.wml_actions.lightning_bolt_spell()
    local esther_spell_power = wesnoth.get_variable("esther_spell_params.esther_spell_power")
    local lightning_bonus = wesnoth.get_variable("esther_spell_params.lightning_bonus")
    local lightning_shred = wesnoth.get_variable("esther_spell_params.lightning_shred")
	local insight = wesnoth.get_variable("esther_spell_params.esther_insight")
	local intelligence = wesnoth.get_variable("esther_spell_params.esther_intelligence")

    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount=math.floor((9 + lightning_bonus)*(1+esther_spell_power/10)),delay="50",experience="yes",damage_type="fire",
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Esther"}},
        {"primary_attack",{name="tempest"}},
        {"secondary_attack",{name="tempest"}}
    }
    
    wesnoth.wml_actions.object {take_only_once="no",duration="turn",silent="yes",
        {"filter",{x="$x1",y="$y1"}},
            {"effect",{apply_to="resistance",replace="no",
                {"resistance",{fire=lightning_shred,cold=lightning_shred,arcane=lightning_shred}}
            }}
    }

    wesnoth.set_variable("esther_spell_params.esther_mana", wesnoth.get_variable("esther_spell_params.esther_mana") - 7)

    if lightning_bonus < math.floor(wesnoth.get_variable("esther_spell_params.lightning_max_bonus")*(1+intelligence/20)) then
        wesnoth.set_variable("esther_spell_params.lightning_bonus", lightning_bonus + 0.3*(1+insight/10))
    end
    
    if lightning_shred < 50 then
        wesnoth.set_variable("esther_spell_params.lightning_shred", lightning_shred + 1*(1+insight/10))
    end
end

-- phoenix: defies all regular damage for one turn (except for fatal hits)

------------- YUMI ------------
function wesnoth.wml_actions.siphon_spell()
    local yumi_spell_power = wesnoth.get_variable("yumi_spell_params.yumi_spell_power")
	local insight = wesnoth.get_variable("yumi_spell_params.yumi_insight")
	local intelligence = wesnoth.get_variable("yumi_spell_params.yumi_intelligence")

    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount=math.floor(5*(1+yumi_spell_power/10)),delay="50",experience="yes",damage_type="arcane",variable="damage",
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

    if siphon_spell_healing < math.floor(1.00*(1+intelligence/20)) then
        wesnoth.set_variable("yumi_spell_params.siphon_spell_healing", siphon_spell_healing + 0.01*(1+insight/10))
    end
end

function wesnoth.wml_actions.void_blast_spell()
    local yumi_spell_power = wesnoth.get_variable("yumi_spell_params.yumi_spell_power")
    local void_damage_bonus = wesnoth.get_variable("yumi_spell_params.void_damage_bonus")
	local insight = wesnoth.get_variable("yumi_spell_params.yumi_insight")
	local intelligence = wesnoth.get_variable("yumi_spell_params.yumi_intelligence")

    local damage = math.floor((5 + void_damage_bonus)*(1+yumi_spell_power/10))
    
    if wesnoth.wml_conditionals.have_unit { id="Yumi", ability = "shadowwalk"} then
        damage = damage * 2
    end
    
    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount=damage,delay="50",experience="yes",
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Yumi"}},
        {"primary_attack",{name="void assault"}},
        {"secondary_attack",{name="void assault"}}
    }

    wesnoth.set_variable("yumi_spell_params.yumi_mana", wesnoth.get_variable("yumi_spell_params.yumi_mana") - 4)

    if void_damage_bonus < math.floor(wesnoth.get_variable("yumi_spell_params.yumi_void_max_bonus")*(1+intelligence/20)) then
        wesnoth.set_variable("yumi_spell_params.void_damage_bonus", void_damage_bonus + 0.1*(1+insight/10))
    end
end

function wesnoth.wml_actions.ethereal_form_spell()
    wesnoth.wml_actions.object {take_only_once="no",duration="turn",silent="yes",
        {"filter",{id="Yumi"}},
        {"effect",{apply_to="new_ability",
            {"abilities",{
                {"hides",{affect_self="yes"}}
            }}
        }}
    }

    wesnoth.set_variable("yumi_spell_params.yumi_mana", wesnoth.get_variable("yumi_spell_params.yumi_mana") - 2)
end

function wesnoth.wml_actions.astral_blood_spell()
    local yumi = wesnoth.get_unit("Yumi")
    
    local cost = 6
    if wesnoth.wml_conditionals.have_unit { id="Yumi", ability = "shadowwalk"} then
        cost = 4
    end
    
    wesnoth.wml_actions.modify_unit {hitpoints=yumi.hitpoints-cost,
        {"filter",{id="Yumi"}}
    }
    
    wesnoth.float_label(yumi.x,yumi.y,string.format("<span color='#ff0000'>-6 HP</span>"))
    wesnoth.float_label(yumi.x,yumi.y,string.format("<span color='#0000ff'>+1 mana</span>"))
    
    wesnoth.set_variable("yumi_spell_params.yumi_mana", wesnoth.get_variable("yumi_spell_params.yumi_mana") + 1)
end

function wesnoth.wml_actions.null_flare_spell()
    local yumi_spell_power = wesnoth.get_variable("yumi_spell_params.yumi_spell_power")
    local null_damage_bonus = wesnoth.get_variable("yumi_spell_params.null_damage_bonus")
	local insight = wesnoth.get_variable("yumi_spell_params.yumi_insight")
	local intelligence = wesnoth.get_variable("yumi_spell_params.yumi_intelligence")

    local damage = math.floor((4 + null_damage_bonus)*(1+yumi_spell_power/10))
    
    if wesnoth.wml_conditionals.have_unit { id="Yumi", ability = "shadowwalk"} then
        damage = damage * 2
    end
    
    wesnoth.wml_actions.harm_unit {fire_event="yes",
        animate="yes",amount=damage,delay="50",experience="yes",damage_type="cold",
        {"filter",{x="$x1",y="$y1"}},
        {"filter_second",{id="Yumi"}},
        {"primary_attack",{name="void assault"}},
        {"secondary_attack",{name="void assault"}}
    }

    wesnoth.wml_actions.object {take_only_once="no",duration="turn",silent="yes",
        {"filter",{x="$x1",y="$y1"}},
            {"effect",{apply_to="movement",set="0"}},
            {"effect",{apply_to="max_attacks",increase="-1"}}
    }
    
    wesnoth.set_variable("yumi_spell_params.yumi_mana", wesnoth.get_variable("yumi_spell_params.yumi_mana") - 5)

    if null_damage_bonus < math.floor(wesnoth.get_variable("yumi_spell_params.yumi_null_max_bonus")*(1+intelligence/20)) then
        wesnoth.set_variable("yumi_spell_params.null_damage_bonus", null_damage_bonus + 0.2*(1+insight/10))
    end
end

function wesnoth.wml_actions.shadow_walk_spell()
    local yumi = wesnoth.get_unit("Yumi")

    wesnoth.wml_actions.object {take_only_once="no",duration="turn",silent="yes",
        {"filter",{id="Yumi"}},
        {"effect",{apply_to="new_ability",
            {"abilities",{
                {"hides",{id="shadowwalk",name="shadow walk",description="This unit is invisible and has increased movement.",affect_self="yes"}}
            }}
        }}
    }
    
    wesnoth.wml_actions.modify_unit {moves=2*yumi.max_moves,attacks_left=0,
        {"filter",{id="Yumi"}}
    }

    wesnoth.set_variable("yumi_spell_params.yumi_mana", wesnoth.get_variable("yumi_spell_params.yumi_mana") - 4)
end
----------------------------------------------- SPELL MENUS ----------------------------------------------------
local T = helper.set_wml_tag_metatable {}

local dialog = {
    T.tooltip { id = "tooltip_large" },
    T.helptip { id = "tooltip_large" },
    T.linked_group { id = "icon", fixed_width = true },
    maximum_height=600,
    T.grid {
        T.row {
            grow_factor = 0,
            T.column {
                border = "all",
                border_size = 5,
                horizontal_alignment = "left",
                T.label {
                    definition = "title",
                    id = "title"
                }
            }
        },
        T.row {
            grow_factor = 1,
            T.column {
                border = "all",
                border_size = 5,
                horizontal_grow = true,
                vertical_alignment = "top",
                T.listbox {
                    id = "list",
                    T.list_definition {
                        T.row {
                            T.column {
                                horizontal_grow = true,
                                T.toggle_panel {
                                    return_value = -1,
                                    T.grid {
                                        T.row {
                                            T.column {
                                                grow_factor = 0,
                                                border = "all",
                                                border_size = 5,
                                                horizontal_alignment = "left",
                                                T.image {
                                                    id = "icon",
                                                    linked_group = "icon"
                                                }
                                            },
                                            T.column {
                                                grow_factor = 1,
                                                border = "all",
                                                border_size = 5,
                                                horizontal_alignment = "left",
                                                T.label {
                                                    id = "label"
                                                }
                                            },
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        },
        T.row {
            grow_factor = 0,
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

local function select()
    local i = wesnoth.get_dialog_value "list"
end

local helper = wesnoth.require "lua/helper.lua"
local title = ""
local header_label = ""
local header_icon = ""
local spell_names = {"Cancel"}
local spell_mana = {0}
local spell_images = {"attacks/blank-attack.png"}
local spell_menu = 0

local function preshow()
    wesnoth.set_dialog_callback(select, "list")
    wesnoth.set_dialog_value(title, "title")
    wesnoth.set_dialog_value(header_label, "list", 1, "label")
    wesnoth.set_dialog_markup(true,"list", 1, "label")
    wesnoth.set_dialog_value(header_icon, "list", 1, "icon")
    
    for i,v in ipairs(spell_names) do
        if i == 1 then
        else
            if spell_menu==1 then
                wesnoth.set_dialog_value(string.format("%s <span color='#0000ff'>(%d mana)</span>",spell_names[i],spell_mana[i]), "list", i, "label")
            else
                wesnoth.set_dialog_value(string.format("%s",spell_names[i]), "list", i, "label")
            end
            wesnoth.set_dialog_value(spell_images[i], "list", i, "icon")
            wesnoth.set_dialog_markup(true,"list", i, "label")
        end
    end
    wesnoth.set_dialog_value(1, "list")
    select()
end

local li
local function postshow()
    li = wesnoth.get_dialog_value "list"
end

local function dialog_var_cleanup()
    li = 0
    title = ""
    header_label = ""
    header_icon = ""
    spell_names = {"Cancel"}
    spell_mana = {0}
    spell_images = {"attacks/blank-attack.png"}
    spell_menu = 0
end

--aryel spell menu
function wesnoth.wml_actions.aryel_spell_menu()
    local x = wesnoth.get_variable("x1")
    local y = wesnoth.get_variable("y1")
    local aryel_spell_params = helper.get_variable_array("aryel_spell_params")
    for i,v in ipairs(aryel_spell_params) do
        local b = check_spell_castable_aryel(x,y,aryel_spell_params[i].aryel_spell_radii,aryel_spell_params[i].aryel_spell_costs,aryel_spell_params[i].aryel_spells)
        if i == 1 then
        elseif b==true then
            table.insert(spell_names,aryel_spell_params[i].aryel_spells)
            table.insert(spell_mana,aryel_spell_params[i].aryel_spell_costs)
            table.insert(spell_images,aryel_spell_params[i].aryel_spell_images)
        end
    end
    
    title = "Spellcasting - Aryel"
    header_label = string.format("<span color='#0000ff'>Current Mana: %d</span>",wesnoth.get_variable("aryel_spell_params.aryel_mana"))
    header_icon = "attacks/staff-elven-star.png"
    spell_menu = 1

    local r = wesnoth.show_dialog(dialog, preshow, postshow)

    if r == -1 then
        if spell_names[li]=="Infuse" then
            wesnoth.wml_actions.infuse_spell()
        elseif spell_names[li]=="Malefice" then
            wesnoth.wml_actions.malefice_spell()
        elseif spell_names[li]=="Blood Bind" then
            wesnoth.wml_actions.blood_bind_spell()
        elseif spell_names[li]=="Harvest Soul" then
            wesnoth.wml_actions.harvest_soul_spell()   
        elseif spell_names[li]=="Eldritch Bolt" then
            wesnoth.wml_actions.eldritch_bolt_spell()
        end
    end
    
    dialog_var_cleanup()
end

--aryel spell help
function wesnoth.wml_actions.aryel_spell_help()
    local aryel_spell_params = helper.get_variable_array("aryel_spell_params")
    
    for i,v in ipairs(aryel_spell_params) do
        if i == 1 then
        else
            table.insert(spell_names,aryel_spell_params[i].aryel_spells)
            table.insert(spell_mana,aryel_spell_params[i].aryel_spell_costs)
            table.insert(spell_images,aryel_spell_params[i].aryel_spell_images)
        end
    end
    
    title = "Spell Help — Aryel"
    header_label = "<span color='#f08080'>Stats (Aryel)</span>"
    header_icon = "units/fae/aryel.png~SCALE(60,60)"
    spell_menu = 0

    local r = wesnoth.show_dialog(dialog, preshow, postshow)
    
    --wesnoth.message(string.format("Button %d pressed. Item %d selected.", r, li))

	local insight = wesnoth.get_variable("aryel_spell_params.aryel_insight")
	local intelligence = wesnoth.get_variable("aryel_spell_params.aryel_intelligence")	
	local aryel_spell_power = wesnoth.get_variable("aryel_spell_params.aryel_spell_power")
	
    if r == -1 then
        if li == 1 then
            wesnoth.show_message_dialog({
                 title = "Character Statistics",
                 message = string.format("<span color='#0000ff'>Current Mana: %d</span> \n<span color='#00ffff'>Maximum Mana: %d</span>\n<span color='#85C1E9'>Mana Regen: %d</span>\n<span color='#DC143C'>Spell Power: %d</span>\n<span color='#1E90FF'>Intelligence: %d</span>\n<span color='#DA70D6'>Insight: %d</span>",wesnoth.get_variable("aryel_spell_params.aryel_mana"),wesnoth.get_variable("aryel_spell_params.aryel_max_mana"),math.floor(wesnoth.get_variable("aryel_spell_params.aryel_mana_gain")*(1+wesnoth.get_variable("aryel_spell_params.aryel_intelligence")/10)),wesnoth.get_variable("aryel_spell_params.aryel_spell_power"),wesnoth.get_variable("aryel_spell_params.aryel_intelligence"),wesnoth.get_variable("aryel_spell_params.aryel_insight")),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(units/fae/aryel.png~SCALE(144,144), 144, 200)",
            })
        elseif spell_names[li]=="Infuse" then
            wesnoth.show_message_dialog({
                 title = "Infuse",
                 message = string.format("<span color='#0000ff'>Mana cost: 3</span> \n<span color='#008000'>Cast radius: 3</span> \nHeals <span color='#00ff00'>%d</span> hitpoints to target ally. Each cast increases the healing of this spell by <span color='#00ff00'>%f</span>, up to a maximum of <span color='#00ff00'>%d</span>.",math.floor((3 + wesnoth.get_variable("aryel_spell_params.infuse_bonus"))*(1+aryel_spell_power/10)),0.1*(1+insight/10),math.floor((3+wesnoth.get_variable("aryel_spell_params.infuse_max_bonus")*(1+intelligence/20))*(1+aryel_spell_power/10))),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/touch-faerie.png~SCALE(120,120), 168, 212)",
            })
        elseif spell_names[li]=="Malefice" then
            wesnoth.show_message_dialog({
                 title = "Malefice",
                 message = string.format("<span color='#0000ff'>Mana cost: 5</span> \n<span color='#008000'>Cast radius: 1</span> \nDeals <span color='#ff0000'>%d</span> <span color='#00f2ff'>arcane</span> damage to target enemy. Killing an enemy unit with this spell increases its damage by <span color='#ff0000'>%f</span>.",math.floor((3 + wesnoth.get_variable("aryel_spell_params.malefice_bonus"))*(1+aryel_spell_power/10)),0.2*(1+insight/10)),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/wail.png~SCALE(120,120), 168, 212)",
            })
        elseif spell_names[li]=="Blood Bind" then
            wesnoth.show_message_dialog({
                 title = "Blood Bind",
                 message = string.format("<span color='#0000ff'>Mana cost: 1</span> \n<span color='#008000'>Cast radius: 5</span> \nDrains <span color='#ff0000'>6</span> health from Aryel to deal <span color='#ff0000'>%d</span> damage to target enemy. Each cast increases the amount of damage dealt, up to <span color='#ff0000'>%d</span>.",math.floor(6*wesnoth.get_variable("aryel_spell_params.blood_bind_factor")*(1+aryel_spell_power/10)),math.floor(wesnoth.get_variable("aryel_spell_params.blood_bind_max_factor")*(1+intelligence/20)*6*(1+aryel_spell_power/10))),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/curse.png~SCALE(120,120), 168, 212)",
            })
        elseif spell_names[li]=="Harvest Soul" then
            wesnoth.show_message_dialog({
                 title = "Harvest Soul",
                 message = string.format("<span color='#0000ff'>Mana cost: -</span> \n<span color='#008000'>Cast radius: 3</span> \nConsumes an allied spirit, regaining health and mana.\nEldritch Form: <span color='#0000ff'>2 mana</span>\nLevel 1: <span color='#00ff00'>%d health</span>\nLevel 2: <span color='#00ff00'>%d health</span> and <span color='#0000ff'>1 mana</span>\nLevel 3: <span color='#00ff00'>%d health</span> and <span color='#0000ff'>2 mana</span>\n",math.floor(8*(1+aryel_spell_power/10)),math.floor(16*(1+aryel_spell_power/10)),math.floor(24*(1+aryel_spell_power/10))),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/wail.png~SCALE(120,120), 168, 148)",
            })
        elseif spell_names[li]=="Eldritch Bolt" then
            wesnoth.show_message_dialog({
                 title = "Eldritch Bolt",
                 message = string.format("<span color='#0000ff'>Mana cost: 6</span> \n<span color='#008000'>Cast radius: 1</span> \nDeals <span color='#ff0000'>%d</span> <span color='#00f2ff'>arcane</span> damage to target enemy. Killing an enemy unit with this spell spawns an Eldritch Form with <span color='#00ff00'>%d</span> hitpoints. Each subsequent Eldritch Form will have <span color='#00ff00'>%f</span> additional hitpoints, up to a maximum of <span color='#00ff00'>%d</span> hitpoints.",math.floor(7*(1+aryel_spell_power/10)),math.floor(10+wesnoth.get_variable("aryel_spell_params.eldritch_bonus")),1*(1+insight/10),math.floor(wesnoth.get_variable("aryel_spell_params.eldritch_max_bonus")*(1+intelligence/20)+10)),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/nightmare-bite.png~SCALE(120,120), 168, 212)",
            })
        end
    end
    
    dialog_var_cleanup()
end

-- spell menu esther
function wesnoth.wml_actions.esther_spell_menu()
    
    local x = wesnoth.get_variable("x1")
    local y = wesnoth.get_variable("y1")
    local esther_spell_params = helper.get_variable_array("esther_spell_params")
    for i,v in ipairs(esther_spell_params) do
        local b = check_spell_castable_esther(x,y,esther_spell_params[i].esther_spell_radii,esther_spell_params[i].esther_spell_costs,esther_spell_params[i].esther_spells)
        if i == 1 then
        elseif b==true then
            table.insert(spell_names,esther_spell_params[i].esther_spells)
            table.insert(spell_mana,esther_spell_params[i].esther_spell_costs)
            table.insert(spell_images,esther_spell_params[i].esther_spell_images)
        end
    end
    
    title = "Spellcasting - Esther"
    header_label = string.format("<span color='#0000ff'>Current Mana: %d</span>",wesnoth.get_variable("esther_spell_params.esther_mana"))
    header_icon = "attacks/staff-elven-star.png"
    spell_menu = 1
    
    local r = wesnoth.show_dialog(dialog, preshow, postshow)

    --wesnoth.message(string.format("Button %d pressed. Item %s selected.", r, spell_names[li-1]))

    if r == -1 then
        if spell_names[li]=="Firebolt" then
            wesnoth.wml_actions.firebolt_spell()
		elseif spell_names[li]=="Sunlight Spark" then
            wesnoth.wml_actions.sunlight_spark_spell()
        elseif spell_names[li]=="Ember Spear" then
            wesnoth.wml_actions.ember_spear_spell()
        elseif spell_names[li]=="Ardent Flare" then
            wesnoth.wml_actions.ardent_flare_spell()
        elseif spell_names[li]=="Blazing Star" then
            wesnoth.wml_actions.blazing_star_spell()
        elseif spell_names[li]=="Lightning Bolt" then
            wesnoth.wml_actions.lightning_bolt_spell()
        end
    end
    
    dialog_var_cleanup()
end

-- spell help for Esther
function wesnoth.wml_actions.esther_spell_help()
    local esther_spell_params = helper.get_variable_array("esther_spell_params")
    
    for i,v in ipairs(esther_spell_params) do
        if i == 1 then
        else
            table.insert(spell_names,esther_spell_params[i].esther_spells)
            table.insert(spell_mana,esther_spell_params[i].esther_spell_costs)
            table.insert(spell_images,esther_spell_params[i].esther_spell_images)
        end
    end
    
    title = "Spell Help — Esther"
    header_label = "<span color='#ff5500'>Stats (Esther)</span>"
    header_icon = "units/fae/esther.png~SCALE(60,60)"
    spell_menu = 0
    
    local r = wesnoth.show_dialog(dialog, preshow, postshow)
    
    --wesnoth.message(string.format("Button %d pressed. Item %d selected.", r, li))
	
	local esther_spell_power = wesnoth.get_variable("esther_spell_params.esther_spell_power")
	local insight = wesnoth.get_variable("esther_spell_params.esther_insight")
	local intelligence = wesnoth.get_variable("esther_spell_params.esther_intelligence")
    if r == -1 then
        if li == 1 then
            wesnoth.show_message_dialog({
                 title = "Character Statistics",
                 message = string.format("<span color='#0000ff'>Current Mana: %d</span> \n<span color='#00ffff'>Maximum Mana: %d</span>\n<span color='#85C1E9'>Mana Regen: %d</span>\n<span color='#DC143C'>Spell Power: %d</span>\n<span color='#1E90FF'>Intelligence %d</span>\n<span color='#DA70D6'>Insight: %d</span>",wesnoth.get_variable("esther_spell_params.esther_mana"),wesnoth.get_variable("esther_spell_params.esther_max_mana"),math.floor(wesnoth.get_variable("esther_spell_params.esther_mana_gain")*(1+wesnoth.get_variable("esther_spell_params.esther_intelligence")/10)),wesnoth.get_variable("esther_spell_params.esther_spell_power"),wesnoth.get_variable("esther_spell_params.esther_intelligence"),wesnoth.get_variable("esther_spell_params.esther_insight")),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(units/fae/esther.png~SCALE(144,144), 144, 200)",
            })
        elseif spell_names[li]=="Firebolt" then
            wesnoth.show_message_dialog({
                 title = "Firebolt",
                 message = string.format("<span color='#0000ff'>Mana cost: 4</span> \n<span color='#008000'>Cast radius: 3</span> \nDeals <span color='#ff0000'>%d</span> <span color='#ff5500'>fire</span> damage to target enemy. Each cast increases the damage of this spell by <span color='#ff0000'>%f</span>, up to a maximum of <span color='#ff0000'>%d</span>.",math.floor((4 + wesnoth.get_variable("esther_spell_params.firebolt_bonus"))*(1+esther_spell_power/10)),0.1*(1+insight/10),math.floor((wesnoth.get_variable("esther_spell_params.firebolt_max_bonus")*(1+intelligence/20)+4)*(1+esther_spell_power/10))),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/fireball.png~SCALE(120,120), 168, 212)",
            })
		elseif spell_names[li]=="Sunlight Spark" then
            wesnoth.show_message_dialog({
                 title = "Sunlight Spark",
                 message = string.format("<span color='#0000ff'>Mana cost: 4</span> \n<span color='#008000'>Cast radius: -</span> \nEsther heals <span color='#00ff00'>%d</span> hitpoints. Each cast increases the healing from this spell by <span color='#00ff00'>%f</span>, up to a maximum of <span color='#00ff00'>%d</span>. Can only be cast during the day.",math.floor((7 + wesnoth.get_variable("esther_spell_params.sunlight_spark_bonus"))*(1+esther_spell_power/10)),0.5*(1+insight/10),math.floor((wesnoth.get_variable("esther_spell_params.sunlight_spark_max_bonus")*(1+intelligence/20)+7)*(1+esther_spell_power/10))),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/magic-missile.png~SCALE(120,120), 168, 212)",
            })
        elseif spell_names[li]=="Ember Spear" then
            wesnoth.show_message_dialog({
                 title = "Ember Spear",
                 message = string.format("<span color='#0000ff'>Mana cost: 3</span> \n<span color='#008000'>Cast radius: 2</span> \nDeals <span color='#ff0000'>%d</span> <span color='#ff5500'>fire</span> damage to target enemy and slows it. Each cast increases the damage of this spell by <span color='#ff0000'>%f</span>, up to a maximum of <span color='#ff0000'>%d</span>.",math.floor((2 + wesnoth.get_variable("esther_spell_params.ember_bonus"))*(1+esther_spell_power/10)),0.1*(1+insight/10),math.floor((wesnoth.get_variable("esther_spell_params.ember_max_bonus")*(1+intelligence/20)+2)*(1+esther_spell_power/10))),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/thunderstick.png~SCALE(120,120), 168, 212)",
            })
        elseif spell_names[li]=="Ardent Flare" then
            wesnoth.show_message_dialog({
                 title = "Sunlight Spark",
                 message = string.format("<span color='#0000ff'>Mana cost: 6</span> \n<span color='#008000'>Cast radius: -</span> \nEsther gains <span color='#ff0000'>+%d%%</span> damage for one turn.",math.floor(25*(1+esther_spell_power/10))),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/flash-cannon.png~SCALE(120,120), 168, 224)",
            })
        elseif spell_names[li]=="Blazing Star" then
            wesnoth.show_message_dialog({
                 title = "Blazing Star",
                 message = string.format("<span color='#0000ff'>Mana cost: 6</span> \n<span color='#008000'>Cast radius: -</span> \nDecreases the damage of adjacent enemies by <span color='#ff0000'>-%d%%</span> for one turn.",math.floor(50*(1+esther_spell_power/10))),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/blazing-star.png~SCALE(120,120), 168, 224)",
            })
        elseif spell_names[li]=="Lightning Bolt" then
            wesnoth.show_message_dialog({
                 title = "Lightning Bolt",
                 message = string.format("<span color='#0000ff'>Mana cost: 7</span> \n<span color='#008000'>Cast radius: 4</span> \nDeals <span color='#ff0000'>%d</span> <span color='#ff5500'>fire</span> damage to target enemy and shocks it, reducing its resistances to magical attacks by <span color='#ff0000'>%d%%</span>. Each cast increases the damage of this spell by <span color='#ff0000'>%f</span> and the resistance shredded by <span color='#ff0000'>%f%%</span>, up to a maximum of <span color='#ff0000'>%d</span> damage and <span color='#ff0000'>50%%</span> resistance reduction.",math.floor((9 + wesnoth.get_variable("esther_spell_params.lightning_bonus"))*(1+esther_spell_power/10)),wesnoth.get_variable("esther_spell_params.lightning_shred"),0.3*(1+insight/10),1*(1+insight/10),math.floor((wesnoth.get_variable("esther_spell_params.lightning_max_bonus")*(1+intelligence/20)+9)*(1+esther_spell_power/10))),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/lightning.png~SCALE(120,120), 168, 200)",
            })
        end
    end

    dialog_var_cleanup()
end

-- spell menu yumi
function wesnoth.wml_actions.yumi_spell_menu()
    local yumi_spell_params = helper.get_variable_array("yumi_spell_params")

    local x = wesnoth.get_variable("x1")
    local y = wesnoth.get_variable("y1")
    
    for i,v in ipairs(yumi_spell_params) do
        local b = check_spell_castable_yumi(x,y,yumi_spell_params[i].yumi_spell_radii,yumi_spell_params[i].yumi_spell_costs,yumi_spell_params[i].yumi_spells)
        if i == 1 then
        elseif b==true then
            table.insert(spell_names,yumi_spell_params[i].yumi_spells)
            table.insert(spell_mana,yumi_spell_params[i].yumi_spell_costs)
            table.insert(spell_images,yumi_spell_params[i].yumi_spell_images)
        end
    end
    
    title = "Spellcasting - Yumi"
    header_label = string.format("<span color='#0000ff'>Current Mana: %d</span>",wesnoth.get_variable("yumi_spell_params.yumi_mana"))
    header_icon = "attacks/staff-elven-star.png"
    spell_menu = 1

    local r = wesnoth.show_dialog(dialog, preshow, postshow)

    if r == -1 then
        if spell_names[li]=="Siphon" then
            wesnoth.wml_actions.siphon_spell()
        elseif spell_names[li]=="Void Blast" then
            wesnoth.wml_actions.void_blast_spell()
        elseif spell_names[li]=="Ethereal Form" then
            wesnoth.wml_actions.ethereal_form_spell()
        elseif spell_names[li]=="Astral Blood" then
            wesnoth.wml_actions.astral_blood_spell()
        elseif spell_names[li]=="Null Flare" then
            wesnoth.wml_actions.null_flare_spell()
        elseif spell_names[li]=="Shadow Walk" then
            wesnoth.wml_actions.shadow_walk_spell()
        end
    end
    
    dialog_var_cleanup()
end

-- spell help for Yumi
function wesnoth.wml_actions.yumi_spell_help()
   local yumi_spell_params = helper.get_variable_array("yumi_spell_params")
    
    for i,v in ipairs(yumi_spell_params) do
        if i == 1 then
        else
            table.insert(spell_names,yumi_spell_params[i].yumi_spells)
            table.insert(spell_mana,yumi_spell_params[i].yumi_spell_costs)
            table.insert(spell_images,yumi_spell_params[i].yumi_spell_images)
        end
    end
    
    title = "Spell Help — Yumi"
    header_label = "<span color='#8e44ad'>Stats (Yumi)</span>"
    header_icon = "units/fae/yumi.png~SCALE(60,60)"
    spell_menu = 0

    local r = wesnoth.show_dialog(dialog, preshow, postshow)
    
    --wesnoth.message(string.format("Button %d pressed. Item %d selected.", r, li))
    local yumi_spell_power = wesnoth.get_variable("yumi_spell_params.yumi_spell_power")
	local insight = wesnoth.get_variable("yumi_spell_params.yumi_insight")
	local intelligence = wesnoth.get_variable("yumi_spell_params.yumi_intelligence")
    if r == -1 then
        if li == 1 then
            wesnoth.show_message_dialog({
                 title = "Character Statistics",
                 message = string.format("<span color='#0000ff'>Current Mana: %d</span> \n<span color='#00ffff'>Maximum Mana: %d</span>\n<span color='#85C1E9'>Mana Regen: %d</span>\n<span color='#DC143C'>Spell Power: %d</span>\n<span color='#1E90FF'>Intelligence: %d</span>\n<span color='#DA70D6'>Insight: %d</span>",wesnoth.get_variable("yumi_spell_params.yumi_mana"),wesnoth.get_variable("yumi_spell_params.yumi_max_mana"),math.floor(wesnoth.get_variable("yumi_spell_params.yumi_mana_gain")*(1+wesnoth.get_variable("yumi_spell_params.yumi_intelligence")/10)),wesnoth.get_variable("yumi_spell_params.yumi_spell_power"),wesnoth.get_variable("yumi_spell_params.yumi_intelligence"),wesnoth.get_variable("yumi_spell_params.yumi_insight")),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(units/fae/yumi.png~SCALE(144,144), 144, 200)",
            })
        elseif spell_names[li]=="Siphon" then
            wesnoth.show_message_dialog({
                 title = "Siphon",
                 message = string.format("<span color='#0000ff'>Mana cost: 5</span> \n<span color='#008000'>Cast radius: 2</span> \nDeals <span color='#ff0000'>%d</span> <span color='#00bfff'>arcane</span> damage to target enemy and heals for <span color='#008000'>%d%%</span> of the damage dealt. Each cast increases healing proportion by <span color='#008000'>%f%%</span>, up to <span color='#008000'>%f%%</span>.",math.floor(5*(1+yumi_spell_power/10)),wesnoth.get_variable("yumi_spell_params.siphon_spell_healing")*100,1*(1+insight/10),100*(1+intelligence/20)),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/faerie-fire.png~SCALE(120,120), 168, 212)",
            })
        elseif spell_names[li]=="Void Blast" then
            wesnoth.show_message_dialog({
                 title = "Void Blast",
                 message = string.format("<span color='#0000ff'>Mana cost: 4</span> \n<span color='#008000'>Cast radius: 4</span> \nDeals <span color='#ff0000'>%d</span> damage to target enemy. Each cast increases the damage of this spell by <span color='#ff0000'>%f</span>, up to a maximum of <span color='#ff0000'>%d</span>. Damage doubled by Shadow Walk.",math.floor((5 + wesnoth.get_variable("yumi_spell_params.void_damage_bonus"))*(1+yumi_spell_power/10)),0.1*(1+insight/10),math.floor((5+wesnoth.get_variable("yumi_spell_params.yumi_void_max_bonus")*(1+intelligence/20))*(1+yumi_spell_power/10))),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/dark-missile.png~SCALE(120,120), 168, 212)",
            })
        elseif spell_names[li]=="Ethereal Form" then
            wesnoth.show_message_dialog({
                 title = "Ethereal Form",
                 message = string.format("<span color='#0000ff'>Mana cost: 2</span> \n<span color='#008000'>Cast radius: -</span> \nTurns Yumi invisible for one turn. Can only be cast at night."),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/touch-faerie.png~SCALE(120,120), 168, 224)",
            })
        elseif spell_names[li]=="Astral Blood" then
            wesnoth.show_message_dialog({
                 title = "Astral Blood",
                 message = string.format("<span color='#0000ff'>Mana cost: -</span> \n<span color='#008000'>Cast radius: -</span> \nConverts <span color='#ff0000'>6</span> health to <span color='#0000ff'>1</span> mana. Health cost reduced to <span color='#ff0000'>4</span> by Shadow Walk."),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/thorns.png~SCALE(120,120), 168, 224)",
            })
        elseif spell_names[li]=="Null Flare" then
            wesnoth.show_message_dialog({
                 title = "Null Flare",
                 message = string.format("<span color='#0000ff'>Mana cost: 5</span> \n<span color='#008000'>Cast radius: 3</span> \nDeals <span color='#ff0000'>%d</span> <span color='#0000ff'>cold</span> damage to target enemy and prevents them from moving or attacking for one turn. Each cast increases the damage of this spell by <span color='#ff0000'>%f</span>, up to a maximum of <span color='#ff0000'>%d</span>. Damage doubled by Shadow Walk.",math.floor((4 + wesnoth.get_variable("yumi_spell_params.null_damage_bonus"))*(1+yumi_spell_power/10)),0.2*(1+insight/10),math.floor((4+wesnoth.get_variable("yumi_spell_params.yumi_null_max_bonus")*(1+intelligence/20))*(1+yumi_spell_power/10))),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/forest-chill.png~SCALE(120,120), 168, 200)",
            })
        elseif spell_names[li]=="Shadow Walk" then
            wesnoth.show_message_dialog({
                 title = "Shadow Walk",
                 message = string.format("<span color='#0000ff'>Mana cost: 4</span> \n<span color='#008000'>Cast radius: -</span> \nTurns Yumi invisible for one turn and doubles movement, but removes her ability to attack. Allows Yumi to cast special spells and modifies the effects of others. Requires full movement and attacks. Can only be cast at night."),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/heart-sight.png~SCALE(120,120), 168, 200)",
            })
        end
    end
end

-- main spell menu dialog
function wesnoth.wml_actions.spell_menu()

    local x = wesnoth.get_variable("x1")
    local y = wesnoth.get_variable("y1")

    local enable_aryel = wesnoth.get_variable("spell_params.enable_aryel")
    local enable_esther = wesnoth.get_variable("spell_params.enable_esther")
    local enable_kyoko = wesnoth.get_variable("spell_params.enable_kyoko")
    local enable_talya = wesnoth.get_variable("spell_params.enable_talya")
    local enable_yumi = wesnoth.get_variable("spell_params.enable_yumi")

    local a = wesnoth.match_location(x,y,{
        {"filter",{id="Aryel"}},
        {"or",{
            {"filter_adjacent_location", {radius=wesnoth.get_variable("aryel_spell_params.aryel_spell_radius"),
                {"filter",{id="Aryel"}}
            }}
        }}
    })
    
    -- make menu items for Aryel available
    if a == true and enable_aryel == 1 then
        table.insert(spell_names,"<span color='#f08080'>Cast Spell (Aryel)</span>")
        table.insert(spell_images,"units/fae/aryel.png~SCALE(60,60)")
        table.insert(spell_names,"<span color='#f08080'>Spell Help (Aryel)</span>")
        table.insert(spell_images,"units/fae/aryel.png~SCALE(60,60)")
    end
    
    local b = wesnoth.match_location(x,y,{
        {"filter",{id="Esther"}},
        {"or",{
            {"filter_adjacent_location", {radius=wesnoth.get_variable("esther_spell_params.esther_spell_radius"),
                {"filter",{id="Esther"}}
            }}
        }}
    })

    -- make menu items for Esther available
    if b == true and enable_esther == 1 then
        table.insert(spell_names,"<span color='#ff5500'>Cast Spell (Esther)</span>")
        table.insert(spell_images,"units/fae/esther.png~SCALE(60,60)")
        table.insert(spell_names,"<span color='#ff5500'>Spell Help (Esther)</span>")
        table.insert(spell_images,"units/fae/esther.png~SCALE(60,60)")
    end
    
    local e = wesnoth.match_location(x,y,{
        {"filter",{id="Yumi"}},
        {"or",{
            {"filter_adjacent_location", {radius=wesnoth.get_variable("yumi_spell_params.yumi_spell_radius"),
                {"filter",{id="Yumi"}}
            }}
        }}
    })

    -- make menu items for Yumi available
    if e == true and enable_yumi == 1 then
        table.insert(spell_names,"<span color='#8e44ad'>Cast Spell (Yumi)</span>")
        table.insert(spell_images,"units/fae/yumi.png~SCALE(60,60)")
        table.insert(spell_names,"<span color='#8e44ad'>Spell Help (Yumi)</span>")
        table.insert(spell_images,"units/fae/yumi.png~SCALE(60,60)")
    end
    
    title = "Spellcasting"
    header_label = "<span color='#008000'>Spell Help</span>"
    header_icon = "attacks/staff-elven-star.png"
    spell_menu = 0

    local r = wesnoth.show_dialog(dialog, preshow, postshow)
    --wesnoth.message(string.format("Button %d pressed. Item %d selected.", r, li))

    if r == -1 then
        if li==1 then
            wesnoth.show_message_dialog({
                 title = "Spell Help",
                 message = string.format("Right click on hexes close to hero units to cast spells. Most spells are improved with repeated spell casts, up to an <span color='#1E90ff'>intelligence</span> dependent limit. Each hero has a set amount of <span color='#0000ff'>mana</span> available to cast spells with, and regains some <span color='#0000ff'>mana</span> every turn. Only spells that are available to be cast on the selected location will appear.\n\nSpell effects are modified from their displayed base values by each hero's <span color='#DC143C'>spell power</span>; most spells gain 100%% damage for every <span color='#DC143C'>10 spell power</span>. Every <span color='#1E90ff'>10 intelligence</span> increases mana regeneration by 100%% and every <span color='#1E90ff'>20 intelligence</span> and increases the spell mastery limit by 100%%. Every <span color='#DA70D6'>10 insight</span> increases experience gain and spell leveling rates by 100%%.\n\nFor more help, click on each hero's respective help menu."),
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/staff-elven-star.png~SCALE(120,120), 168, 200)",
            })
        elseif spell_names[li]=="<span color='#f08080'>Cast Spell (Aryel)</span>" then
            dialog_var_cleanup()
            wesnoth.wml_actions.aryel_spell_menu()
        elseif spell_names[li]=="<span color='#f08080'>Spell Help (Aryel)</span>" then
            dialog_var_cleanup()
            wesnoth.wml_actions.aryel_spell_help()
        elseif spell_names[li]=="<span color='#ff5500'>Cast Spell (Esther)</span>" then
            dialog_var_cleanup()
            wesnoth.wml_actions.esther_spell_menu()
        elseif spell_names[li]=="<span color='#ff5500'>Spell Help (Esther)</span>" then
            dialog_var_cleanup()
            wesnoth.wml_actions.esther_spell_help()
        elseif spell_names[li]=="<span color='#8e44ad'>Cast Spell (Yumi)</span>" then
            dialog_var_cleanup()
            wesnoth.wml_actions.yumi_spell_menu()
        elseif spell_names[li]=="<span color='#8e44ad'>Spell Help (Yumi)</span>" then
            dialog_var_cleanup()
            wesnoth.wml_actions.yumi_spell_help()
        end
    end
    
    dialog_var_cleanup()
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

function wesnoth.wml_actions.add_blood_bind_aryel(cfg)
    wesnoth.wml_actions.set_variables {name = "aryel_spell_params", mode = "append",
        {"value",{aryel_spells = "Blood Bind",aryel_spell_images = "attacks/curse.png",
        aryel_spell_radii = 5,aryel_spell_costs = 1}},
    }

    if 5 > wesnoth.get_variable("aryel_spell_params.aryel_spell_radius") then
        wesnoth.set_variable("aryel_spell_params.aryel_spell_radius",5)
    end

    wesnoth.set_variable("aryel_spell_params.blood_bind_factor",0.5)
    wesnoth.set_variable("aryel_spell_params.blood_bind_max_factor",2.5)

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end

function wesnoth.wml_actions.add_harvest_soul_aryel(cfg)
    wesnoth.wml_actions.set_variables {name = "aryel_spell_params", mode = "append",
        {"value",{aryel_spells = "Harvest Soul",aryel_spell_images = "attacks/touch-undead.png",
        aryel_spell_radii = 3,aryel_spell_costs = 0}},
    }

    if 3 > wesnoth.get_variable("aryel_spell_params.aryel_spell_radius") then
        wesnoth.set_variable("aryel_spell_params.aryel_spell_radius",3)
    end
    
    wesnoth.wml_actions.refresh_spell_menu(cfg)
end

function wesnoth.wml_actions.add_eldritch_bolt_aryel(cfg)
    wesnoth.wml_actions.set_variables {name = "aryel_spell_params", mode = "append",
        {"value",{aryel_spells = "Eldritch Bolt",aryel_spell_images = "attacks/nightmare-bite.png",
        aryel_spell_radii = 1,aryel_spell_costs = 6}},
    }

    if 1 > wesnoth.get_variable("aryel_spell_params.aryel_spell_radius") then
        wesnoth.set_variable("aryel_spell_params.aryel_spell_radius",1)
    end

    wesnoth.set_variable("aryel_spell_params.eldritch_bonus",0)
    wesnoth.set_variable("aryel_spell_params.eldritch_max_bonus",17)

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end

-- todo: plague, mind control, mortal form

----------- ESTHER --------------

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

function wesnoth.wml_actions.add_sunlight_spark_esther(cfg)
    wesnoth.wml_actions.set_variables {name = "esther_spell_params", mode = "append",
        {"value",{esther_spells = "Sunlight Spark",esther_spell_images = "attacks/magic-missile.png",
        esther_spell_radii = 0,esther_spell_costs = 4}},
    }

    wesnoth.set_variable("esther_spell_params.sunlight_spark_bonus",0.0)
    wesnoth.set_variable("esther_spell_params.sunlight_spark_max_bonus",7.0)

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end

function wesnoth.wml_actions.add_ember_spear_esther(cfg)
    wesnoth.wml_actions.set_variables {name = "esther_spell_params", mode = "append",
        {"value",{esther_spells = "Ember Spear",esther_spell_images = "attacks/thunderstick.png",
        esther_spell_radii = 2,esther_spell_costs = 3}},
    }

    if 2 > wesnoth.get_variable("esther_spell_params.esther_spell_radius") then
        wesnoth.set_variable("esther_spell_params.esther_spell_radius",2)
    end

    wesnoth.set_variable("esther_spell_params.ember_bonus",0.0)
    wesnoth.set_variable("esther_spell_params.ember_max_bonus",2.0)

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end

function wesnoth.wml_actions.add_ardent_flare_esther(cfg)
    wesnoth.wml_actions.set_variables {name = "esther_spell_params", mode = "append",
        {"value",{esther_spells = "Ardent Flare",esther_spell_images = "attacks/flash-cannon.png",
        esther_spell_radii = 0,esther_spell_costs = 6}},
    }

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end

function wesnoth.wml_actions.add_lightning_bolt_esther(cfg)
    wesnoth.wml_actions.set_variables {name = "esther_spell_params", mode = "append",
        {"value",{esther_spells = "Lightning Bolt",esther_spell_images = "attacks/lightning.png",
        esther_spell_radii = 4,esther_spell_costs = 7}},
    }

    if 4 > wesnoth.get_variable("esther_spell_params.esther_spell_radius") then
        wesnoth.set_variable("esther_spell_params.esther_spell_radius",4)
    end

    wesnoth.set_variable("esther_spell_params.lightning_bonus",0.0)
    wesnoth.set_variable("esther_spell_params.lightning_max_bonus",6.0)
    wesnoth.set_variable("esther_spell_params.lightning_shred",30)

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end

function wesnoth.wml_actions.add_blazing_star_esther(cfg)
    wesnoth.wml_actions.set_variables {name = "esther_spell_params", mode = "append",
        {"value",{esther_spells = "Blazing Star",esther_spell_images = "attacks/blazing-star.png",
        esther_spell_radii = 0,esther_spell_costs = 6}},
    }

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end

-- todo: magma flow, phoenix

------------ YUMI ----------------

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

function wesnoth.wml_actions.add_ethereal_form_yumi(cfg)
    wesnoth.wml_actions.set_variables {name = "yumi_spell_params", mode = "append",
        {"value",{yumi_spells = "Ethereal Form",yumi_spell_images = "attacks/touch-faerie.png",
        yumi_spell_radii = 0,yumi_spell_costs = 2}},
    }

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end

function wesnoth.wml_actions.add_astral_blood_yumi(cfg)
    wesnoth.wml_actions.set_variables {name = "yumi_spell_params", mode = "append",
        {"value",{yumi_spells = "Astral Blood",yumi_spell_images = "attacks/thorns.png",
        yumi_spell_radii = 0,yumi_spell_costs = 0}},
    }

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end

function wesnoth.wml_actions.add_null_flare_yumi(cfg)
    wesnoth.wml_actions.set_variables {name = "yumi_spell_params", mode = "append",
        {"value",{yumi_spells = "Null Flare",yumi_spell_images = "attacks/forest-chill.png",
        yumi_spell_radii = 3,yumi_spell_costs = 5}},
    }

    if 3 > wesnoth.get_variable("yumi_spell_params.yumi_spell_radius") then
        wesnoth.set_variable("yumi_spell_params.yumi_spell_radius",3)
    end

    wesnoth.set_variable("yumi_spell_params.null_damage_bonus",0.0)
    wesnoth.set_variable("yumi_spell_params.yumi_null_max_bonus",5.0)

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end

function wesnoth.wml_actions.add_shadow_walk_yumi(cfg)
    wesnoth.wml_actions.set_variables {name = "yumi_spell_params", mode = "append",
        {"value",{yumi_spells = "Shadow Walk",yumi_spell_images = "attacks/heart-sight.png",
        yumi_spell_radii = 0,yumi_spell_costs = 4}},
    }

    wesnoth.wml_actions.refresh_spell_menu(cfg)
end