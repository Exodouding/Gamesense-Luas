-- Thirdperson Animations, Made By Exodouding (13429) for skeet.cc/gamesense.pub

local ThirdPerson_Ref = { ui.reference("Visuals", "Effects", "Force third person (alive)") }

local ThirdPerson = ui.new_checkbox("Visuals", "Effects", "Thirdperson Animations")
local ThirdPersonDistance = ui.new_slider("Visuals", "Effects", "Thirdperson Distance", 0, 250, 100)
local ThirdPersonZoomSpeed = ui.new_slider("Visuals", "Effects", "Thirdperson Zoom Out Speed", 0, 100, 25, true, "%", 1, {[0] = "Instant"})
local ThirdPersonPitch = ui.new_slider("Visuals", "Effects", "Thirdperson Pitch", -360, 0, 0, true, "°")
local ThirdPersonYaw = ui.new_slider("Visuals", "Effects", "Thirdperson Yaw", -360, 0, 0, true, "°")
local ThirdPersonPitchUp = ui.new_slider("Visuals", "Effects", "Thirdperson Pitch Up", 0, 360, 90, true, "°")
local ThirdPersonPitchDown = ui.new_slider("Visuals", "Effects", "Thirdperson Pitch Down", 0, 360, 90, true, "°")

ui.set_visible(ThirdPersonDistance, false)
ui.set_visible(ThirdPersonZoomSpeed, false)
ui.set_visible(ThirdPersonPitch, false)
ui.set_visible(ThirdPersonYaw, false)
ui.set_visible(ThirdPersonPitchUp, false)
ui.set_visible(ThirdPersonPitchDown, false)

local current_distance = 0

local function Main()

    ui.set_visible(ThirdPersonDistance, ui.get(ThirdPerson))
    ui.set_visible(ThirdPersonZoomSpeed, ui.get(ThirdPerson))
    ui.set_visible(ThirdPersonPitch, ui.get(ThirdPerson))
    ui.set_visible(ThirdPersonYaw, ui.get(ThirdPerson))
    ui.set_visible(ThirdPersonPitchUp, ui.get(ThirdPerson))
    ui.set_visible(ThirdPersonPitchDown, ui.get(ThirdPerson))
	
	if not entity.get_local_player() then return end
	
	if ui.get(ThirdPerson) then
	
		client.set_cvar("c_maxpitch", ui.get(ThirdPersonPitch))
		client.set_cvar("c_maxyaw", ui.get(ThirdPersonYaw))
		client.set_cvar("c_minyaw", ui.get(ThirdPersonYaw))
		client.set_cvar("cl_pitchup", ui.get(ThirdPersonPitchUp))
		client.set_cvar("cl_pitchdown", ui.get(ThirdPersonPitchDown))
		client.set_cvar("cam_idealpitch", ui.get(ThirdPersonPitchUp))
		client.set_cvar("cam_idealpitch", ui.get(ThirdPersonPitchDown))
	
		if ui.get(ThirdPerson_Ref[1]) and ui.get(ThirdPerson_Ref[2]) then
		
			local target_distance = ui.get(ThirdPersonDistance)
			local zoom_speed = ui.get(ThirdPersonZoomSpeed)
	
			-- print("Current Thirdperson Distance : ", current_distance, " Thirdperson Distance : ", target_distance)
	
			if zoom_speed == 0 then
			
				current_distance = target_distance
				
			else
			
				local delta = (target_distance - current_distance) / zoom_speed
	
				if delta > 0 and current_distance < target_distance then
					current_distance = current_distance + delta
				elseif delta < 0 and current_distance > target_distance then
					current_distance = current_distance + delta
				end
			end
			
			client.set_cvar("c_mindistance", current_distance)
			client.set_cvar("c_maxdistance", current_distance)
			
		else
		
			current_distance = 30
			
		end
		
	else
	
		client.set_cvar("c_maxpitch", 0)
		client.set_cvar("c_maxyaw", 0)
		client.set_cvar("c_minyaw", 0)
		client.set_cvar("cl_pitchup", 90)
		client.set_cvar("cl_pitchdown", 90)
		client.set_cvar("c_mindistance", 100)
		client.set_cvar("c_maxdistance", 100)
		
	end
end

local function Shutdown()

	client.set_cvar("c_maxpitch", 0)
	client.set_cvar("c_maxyaw", 0)
	client.set_cvar("c_minyaw", 0)
	client.set_cvar("cl_pitchup", 90)
	client.set_cvar("cl_pitchdown", 90)
	client.set_cvar("c_mindistance", 100)
	client.set_cvar("c_maxdistance", 100)
	
end

client.set_event_callback("paint_ui", Main)
client.set_event_callback("shutdown", Shutdown)