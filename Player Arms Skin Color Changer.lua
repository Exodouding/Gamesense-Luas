-- Player Arms Skin Color Changer, Made By Exodouding for skeet.cc/gamesense.pub

local skin_colors =
{
    "White",
    "Black",
    "Brown",
    "Asian",
    "Mexican",
    "Tattoo"
}

local no_sleeve = ui.new_checkbox("Skins", "Model Options", "No Sleeve")
--local no_sleeve_oppacity = ui.new_slider("Skins", "Model Options", "No Sleeve Oppcatiy", 0, 100, 100, true, "%", 1)
local player_skin_color = ui.new_checkbox("Skins", "Model Options", "Player Skin Color")
local skins_t = ui.new_combobox("Skins", "Model Options", "T Skin", skin_colors)
local skins_ct = ui.new_combobox("Skins", "Model Options", "CT Skin", skin_colors)

ui.set(player_skin_color, true)

local function IsInGame()

	local local_player = entity.get_local_player()

	local team = entity.get_prop(local_player, "m_iTeamNum")

	if team == 0 or team == 1 or team == 2 or team == 3 then 
		return 1 -- Player Is In Game
	else 
		return 0 -- Player Is In Main Menu
	end
end

local function NoSleeve()

    local materials = materialsystem.find_materials("sleeve")
	
	if materials == nil then
        return
    end
    
    for _, material in pairs(materials) do

        if material ~= nil then

            material:set_material_var_flag(2, ui.get(no_sleeve))
        end
    end

	if ui.get(no_sleeve) then

        return
    end
end

local function Skins()

	local result = ui.get(player_skin_color)

	for i, v in pairs(skin_colors) do

		local local_player = entity.get_local_player()
	
		local team = entity.get_prop(local_player, "m_iTeamNum")
	
		if team == 2 and result then -- Player is in the terrorist team and checkbox is on

			ui.set_visible(skins_t, true)
			ui.set_visible(skins_ct, false)

			local SelectedSkinT = ui.get(skins_t, skin_colors)

			if SelectedSkinT == skin_colors[i] then
				client.set_cvar("r_skin", i - 1)
				-- print("Name : " .. v .. " | Skin ID : " .. i)
			end

		elseif team == 2 and not result then -- Player is in the terrorist team and checkbox isn't on

			ui.set_visible(skins_t, false)
			return

		elseif team == 3 and result then -- Player is in the counter-terrorist team and checkbox is on

			ui.set_visible(skins_ct, true)
			ui.set_visible(skins_t, false)

			local SelectedSkinCT = ui.get(skins_ct, skin_colors)

			if SelectedSkinCT == skin_colors[i] then
				client.set_cvar("r_skin", i - 1)
				-- print("Name : " .. v .. " | Skin ID : " .. i)
			end

		elseif team == 3 and not result then -- Player is in the counter-terrorist team and checkbox isn't on
		
			ui.set_visible(skins_ct, false)
			return
			
		elseif IsInGame() == 0 and result then -- Player is in main menu and checkbox is on
		
			ui.set_visible(skins_t, true)
			ui.set_visible(skins_ct, true)
			return
			
		elseif IsInGame() == 0 and not result then -- Player is in main menu and checkbox isn't on
		
			ui.set_visible(skins_t, false)
			ui.set_visible(skins_ct, false)
			return
			
		elseif (team == 0 or team == 1) and result then -- Player is spectating or didn't chose a team and checkbox is on
		
			ui.set_visible(skins_t, true)
			ui.set_visible(skins_ct, true)
			return
			
		elseif (team == 0 or team == 1) and not result then -- Player is spectating or didn't chose a team and checkbox isn't on
		
			ui.set_visible(skins_t, false)
			ui.set_visible(skins_ct, false)
			return
		end
	end
end

local function PlayerSkinColor()

	local result = ui.get(player_skin_color)
	
	if not result then
		client.set_cvar("r_skin", 0)
    else 
        Skins()
	end
end

client.set_event_callback("paint", NoSleeve)
ui.set_callback(player_skin_color, PlayerSkinColor)
client.set_event_callback("paint_ui", Skins)
