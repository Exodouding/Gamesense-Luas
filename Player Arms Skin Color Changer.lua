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
local player_skin_color = ui.new_checkbox("Skins", "Model Options", "Player Skin Color")
local skins = ui.new_combobox("Skins", "Model Options", "\n", skin_colors)

ui.set_visible(skins, false)

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
end

local function Skins()

	for i, v in pairs(skin_colors) do
		
		local SelectedSkin = ui.get(skins, skin_colors)
		
		if SelectedSkin == skin_colors[i] then

			client.set_cvar("r_skin", i - 1)
			-- print("Name : " .. v .. " | Skin ID : " .. i)
		end
	end
end

local function PlayerSkinColor()

	local result = ui.get(player_skin_color)
	
	ui.set_visible(skins, result)
	
	if not result then
		client.set_cvar("r_skin", 0)
    else 
        Skins()
	end
end

ui.set_callback(no_sleeve, NoSleeve)
ui.set_callback(player_skin_color, PlayerSkinColor)
ui.set_callback(skins, Skins)
