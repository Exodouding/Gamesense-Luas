-- Panorama Removal, Made By Exodouding for skeet.cc/gamesense.pub

local panorama_table_buttons_game = {}

local panorama_table_buttons_menu = {}

local panorama_elements = {}

local panorama_buttons_menu = 
{
	{ name = "Dashboard", value = "MainMenuNavBarHome" },
	{ name = "Play", value = "MainMenuNavBarPlay" },
	{ name = "Inventory", value = "MainMenuNavBarInventory" },
	{ name = "Watch", value = "MainMenuNavBarWatch" },
	{ name = "Stats Panel", value = "MainMenuNavBarStats" },
	{ name = "Overwatch", value = "MainMenuNavBarOverwatch" },
	{ name = "Overwatch Notification", value = "MainMenuOverwatchAlert" },
	{ name = "Settings", value = "MainMenuNavBarSettings" },
	{ name = "Settings Notification", value = "MainMenuSettingsAlert" },
	{ name = "Quit", value = "MainMenuNavBarQuit" },
	{ name = "Disconnect Server", value = "MainMenuNavBarExitGame" },
	{ name = "Banner Remover", value = "NotificationsContainer" },
	{ name = "Resume Game", value = "MainMenuNavBarResumeGame" },
	{ name = "Switch Teams", value = "MainMenuNavBarSwitchTeams" },
	{ name = "Vote", value = "MainMenuNavBarVote" },
	{ name = "Report Server", value = "MainMenuNavBarReportServer" },
	{ name = "Community Server Browser", value = "MainMenuNavBarShowCommunityServerBrowser" }
}

local panorama_buttons_game = 
{
	{ name = "Dashboard", value = "MainMenuNavBarHome" },
	{ name = "Play", value = "MainMenuNavBarPlay" },
	{ name = "Inventory", value = "MainMenuNavBarInventory" },
	{ name = "Watch", value = "MainMenuNavBarWatch" },
	{ name = "Stats Panel", value = "MainMenuNavBarStats" },
	{ name = "Overwatch", value = "MainMenuNavBarOverwatch" },
	{ name = "Overwatch Notification", value = "MainMenuOverwatchAlert" },
	{ name = "Settings", value = "MainMenuNavBarSettings" },
	{ name = "Settings Notification", value = "MainMenuSettingsAlert" },
	{ name = "Quit", value = "MainMenuNavBarQuit" },
	{ name = "Disconnect Server", value = "MainMenuNavBarExitGame" },
	{ name = "Banner Remover", value = "NotificationsContainer" },
	{ name = "Resume Game", value = "MainMenuNavBarResumeGame" },
	{ name = "Switch Teams", value = "MainMenuNavBarSwitchTeams" },
	{ name = "Vote", value = "MainMenuNavBarVote" },
	{ name = "Report Server", value = "MainMenuNavBarReportServer" },
	{ name = "Community Server Browser", value = "MainMenuNavBarShowCommunityServerBrowser" }
}

local panorama_background = 
{
	{ name = "Hide News Panel", value = "JsNewsContainer" },
    	{ name = "Hide News Panel Content", value = "NewsPanelLister" },
	{ name = "Hide Player Model", value = "JsMainmenu_Vanity" },
    	{ name = "Hide Player Model + Wheel", value = "JsMainmenu_Vanity-Container" },
	{ name = "Dark Panorama", value = "MainMenuBackground" },
	{ name = "Dark Panorama With Player", value = "MainMenuMovie" },
	{ name = "Hide Right Panel", value = "MainMenuFriendsAndParty" },
	{ name = "Hide Left Panel", value = "MainMenuNavBarLeft" }
}

for _, element in pairs(panorama_buttons_game) do
	table.insert(panorama_table_buttons_game, element.name)
end

for _, element in pairs(panorama_buttons_menu) do
	table.insert(panorama_table_buttons_menu, element.name)
end

for _, element in pairs(panorama_background) do
	table.insert(panorama_elements, element.name)
end

local function IsInGame()

	local local_player = entity.get_local_player()

	local team = entity.get_prop(local_player, "m_iTeamNum")
	
	if team ~= nil then	
		return true -- Player Is In Game
	else 
		return false -- Player Is In Main Menu
	end
end

local function Contains(table, value)
	if table == nil then
		return false
	end
    
    if type(table) == "number" then
        table = ui.get(table)
    end

    for i=0, #table do
        if table[i] == value then
            return true
        end
    end

    return false
end

local mainmenueditor = panorama.loadstring(
[[
return {
	set: (str, toggle) => {
		var element = $.GetContextPanel().FindChildTraverse(str);

		if (element != null){
			element.visible = toggle;
		}
	}
}
]], "MainMenu")()

local panorama_blur = ui.new_checkbox("Misc", "Miscellaneous", "Panorama Blur")

local panorama_box_shadow = ui.new_checkbox("Misc", "Miscellaneous", "Panorama Box Shadow")

local panorama_multiselect_game = ui.new_multiselect("Misc", "Miscellaneous", "In Game Panorama Buttons", panorama_table_buttons_game)

local panorama_multiselect_menu = ui.new_multiselect("Misc", "Miscellaneous", "Main Menu Panorama Buttons", panorama_table_buttons_menu)

local panorama_multiselect_panorama = ui.new_multiselect("Misc", "Miscellaneous", "Panorama Background", panorama_elements)

ui.set(panorama_multiselect_menu, {panorama_table_buttons_menu[7], panorama_table_buttons_menu[9], panorama_table_buttons_menu[11], panorama_table_buttons_menu[12], panorama_table_buttons_menu[13], panorama_table_buttons_menu[14], panorama_table_buttons_menu[15], panorama_table_buttons_menu[16],panorama_table_buttons_menu[17]})
ui.set(panorama_multiselect_game, {panorama_table_buttons_game[1], panorama_table_buttons_game[2], panorama_table_buttons_game[4], panorama_table_buttons_game[5], panorama_table_buttons_game[6], panorama_table_buttons_game[7], panorama_table_buttons_game[9], panorama_table_buttons_game[10], panorama_table_buttons_game[12],})

local function PanoramaButtons()

	local SelectedPanoramasGame = ui.get(panorama_multiselect_game)
	
	local SelectedPanoramasMenu = ui.get(panorama_multiselect_menu)
	
	if IsInGame() then 
	
		ui.set_visible(panorama_multiselect_game, true)
		ui.set_visible(panorama_multiselect_menu, false)
	
		for _, element in pairs(panorama_buttons_menu) do
		
			if Contains(SelectedPanoramasGame, element.name) then
				mainmenueditor.set(element.value, false)
			else
				mainmenueditor.set(element.value, true)
			end
		end
		
	else
	
		ui.set_visible(panorama_multiselect_game, false)
		ui.set_visible(panorama_multiselect_menu, true)

		for _, element in pairs(panorama_buttons_game) do
		
			if Contains(SelectedPanoramasMenu, element.name) then
				mainmenueditor.set(element.value, false)
			else
				mainmenueditor.set(element.value, true)
			end
		end
	end
end

local function PanoramaBackground()

	local SelectedPanoramas = ui.get(panorama_multiselect_panorama)
	
	if not IsInGame() then
	
		ui.set_visible(panorama_multiselect_panorama, true)
	
		for _, element in pairs(panorama_background) do
		
			if Contains(SelectedPanoramas, element.name) then
				mainmenueditor.set(element.value, false)
			else
				mainmenueditor.set(element.value, true)
			end
		end
		
	else
		ui.set_visible(panorama_multiselect_panorama, false)
		return
	end
end

local function PanoramaBlur()
	client.set_cvar("@panorama_disable_blur", ui.get(panorama_blur))
end

local function PanoramaBoxShadow()
	client.set_cvar("@panorama_disable_box_shadow", ui.get(panorama_box_shadow))
end

client.set_event_callback("paint_ui", PanoramaBackground)
client.set_event_callback("paint_ui", PanoramaButtons)
ui.set_callback(panorama_blur, PanoramaBlur)
ui.set_callback(panorama_box_shadow, PanoramaBoxShadow)
