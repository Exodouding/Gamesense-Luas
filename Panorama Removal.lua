-- Panorama Removal, Made By Exodouding for skeet.cc/gamesense.pub

local panorama_buttons_names = {}

local panorama_elements_names = {}

local panorama_buttons = 
{
	{ name = "Dashboard", value = "MainMenuNavBarHome" },
	{ name = "Play", value = "MainMenuNavBarPlay" },
	{ name = "Inventory", value = "MainMenuNavBarInventory" },
	{ name = "Watch", value = "MainMenuNavBarWatch" },
	{ name = "Stats Panel", value = "MainMenuNavBarStats" },
	{ name = "Overwatch", value = "MainMenuNavBarOverwatch" },
	{ name = "Overwatch Notification", value = "MainMenuOverwatchAlert" },
	{ name = "Settings", value = "MainMenuNavBarSettings" },
	{ name = "Settings Notification", value = "MainMenuSettingsAlert" }
	--[[
	{ name = "Quit", value = "MainMenuNavBarQuit" },
	{ name = "Disconnect Server", value = "MainMenuNavBarExitGame" },
	{ name = "Banner Remover", value = "NotificationsContainer" },

	{ name = "Resume Game", value = "MainMenuNavBarResumeGame" },
	{ name = "Switch Teams", value = "MainMenuNavBarSwitchTeams" },
	{ name = "Vote", value = "MainMenuNavBarVote" },
	{ name = "Report Server", value = "MainMenuNavBarReportServer" },
	{ name = "Community Server Browser", value = "MainMenuNavBarShowCommunityServerBrowser" }
	]]
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

for _, element in pairs(panorama_buttons) do
	table.insert(panorama_buttons_names, element.name)
end

for _, element in pairs(panorama_background) do
	table.insert(panorama_elements_names, element.name)
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

local panorama_blur = ui.new_checkbox("MISC", "Miscellaneous", "Panorama Blur")

local panorama_multiselect = ui.new_multiselect("MISC", "Miscellaneous", "Panorama Buttons", panorama_buttons_names)

local panorama_multiselect_v2 = ui.new_multiselect("MISC", "Miscellaneous", "Panorama Background", panorama_elements_names)

local function Contains(_table, _element)

	for _, value in pairs(_table) do
	
		if value == _element then
			return true
		end
	end
	
	return false
end

local function PanoramaButtons()

	local SelectedPanoramas = ui.get(panorama_multiselect)
	
	for _, element in pairs(panorama_buttons) do
	
		if Contains(SelectedPanoramas, element.name) then
			mainmenueditor.set(element.value, false)
		else
			mainmenueditor.set(element.value, true)
		end
	end
end

local function PanoramaBackground()

	local SelectedPanoramas = ui.get(panorama_multiselect_v2)
	
	for _, element in pairs(panorama_background) do
	
		if Contains(SelectedPanoramas, element.name) then
			mainmenueditor.set(element.value, false)
		else
			mainmenueditor.set(element.value, true)
		end
	end
end

local function PanoramaBlur()
	client.set_cvar("@panorama_disable_blur", ui.get(panorama_blur))
end

ui.set_callback(panorama_multiselect_v2, PanoramaBackground)
ui.set_callback(panorama_multiselect, PanoramaButtons)
ui.set_callback(panorama_blur, PanoramaBlur)
