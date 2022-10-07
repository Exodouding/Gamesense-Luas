-- Made By Exodouding for skeet.cc/gamesense.pub

local skin_colors = {
    "White",
    "Black",
    "Brown",
    "Asian",
    "Mexican",
    "Tattoo"
}

local LastSelectedIndex = -1

local PlayerSkinColor = ui.new_checkbox("Skins", "Model Options", "Player Skin Color")
local Skins = ui.new_combobox("Skins", "Model Options", "\n", skin_colors)
ui.set_visible(Skins, false)

ui.set_callback(PlayerSkinColor, function()
	ui.set_visible(Skins, ui.get(PlayerSkinColor))
end)

local function PlayerSkinColorChanger()
	
	if not ui.get(PlayerSkinColor) then return end
	
	for i = 1, #skin_colors do
		
		local SelectedSkin = ui.get(Skins, skin_colors)
		
		if SelectedSkin == skin_colors[i] and i ~= lastselectedindex then
			client.set_cvar("r_skin", i-1)
			-- print("Skin ID :" .. i)
			lastselectedindex = i
		end
	end
end

client.set_event_callback("paint", PlayerSkinColorChanger)