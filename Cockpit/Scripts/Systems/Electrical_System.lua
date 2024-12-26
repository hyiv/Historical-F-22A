--[[
    Grinnelli Designs F-22A Raptor
    Copyright (C) 2024, Joseph Grinnelli
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see https://www.gnu.org/licenses.
--]]


dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()
local sensor_data		= get_base_data()

local update_time_step = 0.02 --0.006
make_default_activity(update_time_step)
--Param
    local parameters =
        {
        	-- Engine
        	APU_POWER			 = get_param_handle("APU_POWER"),
        	APU_RPM_STATE		 = get_param_handle("APU_RPM_STATE"),
        	BATTERY_POWER		 = get_param_handle("BATTERY_POWER"),
            MAIN_POWER		     = get_param_handle("MAIN_POWER"),
            WoW			         = get_param_handle("WoW"),
            AAR			         = get_param_handle("AAR"),
            -- PARK			     = get_param_handle("PARK"),
            N_GEAR_LIGHT         = get_param_handle("N_GEAR_LIGHT"),
            R_GEAR_LIGHT         = get_param_handle("R_GEAR_LIGHT"),
            L_GEAR_LIGHT         = get_param_handle("L_GEAR_LIGHT"),
}

local PlaneAirRefuel 			   = Keys.PlaneAirRefuel
local AAR_SWITCH                   = device_commands.Button_1
local AAR_LIGHT                    = device_commands.Button_2
local NAV_SWITCH                   = device_commands.Button_3
local TAXI_LIGHT                   = device_commands.Button_4
-- local PARK_BRAKE                   = device_commands.Button_5
dev:listen_command(PlaneAirRefuel)
dev:listen_command(AAR_SWITCH)
dev:listen_command(AAR_LIGHT)
dev:listen_command(NAV_SWITCH)
dev:listen_command(TAXI_LIGHT)
-- dev:listen_command(PARK_BRAKE)
dev:listen_command(74)--Brakes on
dev:listen_command(75)--Brakes off
dev:listen_command(10015)
dev:listen_command(10016)
dev:listen_command(10151)
dev:listen_command(10152)
dev:listen_command(10153)
dev:listen_command(10154)

local aar_state         = 0
local light_state       = 0 -- 0 off -1 = down 1 up?
local flash_timer       = 0
-- local park_state        = 0 
------------------------------------------------------------------FUNCTION-POST-INIT---------------------------------------------------------------------------------------------------
function post_initialize()
    --print_message_to_user("ELECTRICAL POST INIT")
end
------------------------------------------------------------------FUNCTION-SETCOMMAND---------------------------------------------------------------------------------------------------
function SetCommand(command,value)
--AAR Switch
    if (command == AAR_SWITCH or command == 10015 or command == 10016) and aar_state == 0 then
        aar_state = 1
        dispatch_action(nil,PlaneAirRefuel)
    elseif (command == AAR_SWITCH or command == 10015 or command == 10016) and aar_state == 1 then
        aar_state = 0
        dispatch_action(nil,PlaneAirRefuel)
    end
-- --Parking Brakes
--     if (command == PARK_BRAKE or command == 10019 or command == 10020) and park_state == 0 then
--         park_state = 1
--     elseif (command == PARK_BRAKE or command == 10019 or command == 10020) and park_state == 1 then
--         park_state = 0
--         dispatch_action(nil,75)
--     end   

    if (command == 10151 or command == 10152) and light_state == 0 then --taxi light
        light_state = -1
        dev:performClickableAction(TAXI_LIGHT, -1, false)
    elseif (command == 10151 or command == 10152) and light_state == -1 then --taxi light
        light_state = 0
        dev:performClickableAction(TAXI_LIGHT, 0, false)
    elseif (command == 10151 or command == 10152) and light_state == 1 then --taxi light
        light_state = 0
        dev:performClickableAction(TAXI_LIGHT, 0, false)
    elseif (command == 10153 or command == 10154) and light_state == 0 then --land light
        light_state = 1
        dev:performClickableAction(TAXI_LIGHT, 1, false)
    elseif (command == 10153 or command == 10154) and light_state == 1 then --land light
        light_state = 0
        dev:performClickableAction(TAXI_LIGHT, 0, false)
    elseif (command == 10153 or command == 10154) and light_state == -1 then --land light
        light_state = 0
        dev:performClickableAction(TAXI_LIGHT, 0, false)
    end

end

local nose_gear_light  = 0
local right_gear_light = 0
local left_gear_light  = 0
------------------------------------------------------------------FUNCTION-UPDATE---------------------------------------------------------------------------------------------------
function update()

    local TAXI_SWITCH  = get_cockpit_draw_argument_value(709)
    local AAR_KNOB     = get_cockpit_draw_argument_value(713)
    local FORM_KNOB    = get_cockpit_draw_argument_value(714)
    local LIGHT_SWITCH = get_cockpit_draw_argument_value(715)
    local AAR_READY    = get_aircraft_draw_argument_value(22)
    local NOSE_GEAR    = get_aircraft_draw_argument_value(0)
    local RIGHT_GEAR   = get_aircraft_draw_argument_value(3)
    local LEFT_GEAR    = get_aircraft_draw_argument_value(5)

    parameters.AAR:set(aar_state)
    -- parameters.PARK:set(park_state)
    parameters.N_GEAR_LIGHT:set(nose_gear_light)
    parameters.R_GEAR_LIGHT:set(right_gear_light)
    parameters.L_GEAR_LIGHT:set(left_gear_light)

--Nose Gear Light
    if NOSE_GEAR == 1 and parameters.BATTERY_POWER:get() == 1 then
        nose_gear_light = 1
    elseif NOSE_GEAR < 0.9 and parameters.BATTERY_POWER:get() == 1 then
        nose_gear_light = 0
    end
--Right Gear Light
    if RIGHT_GEAR == 1 and parameters.BATTERY_POWER:get() == 1 then
        right_gear_light = 1
    elseif RIGHT_GEAR < 0.9 and parameters.BATTERY_POWER:get() == 1 then
        right_gear_light = 0
    end
--Left Gear Light
    if LEFT_GEAR == 1 and parameters.BATTERY_POWER:get() == 1 then
        left_gear_light = 1
    elseif LEFT_GEAR < 0.9 and parameters.BATTERY_POWER:get() == 1 then
        left_gear_light = 0
    end
--Taxi/Landing Lights
    if TAXI_SWITCH == 1 and parameters.MAIN_POWER:get() == 1 and NOSE_GEAR == 1 then
        set_aircraft_draw_argument_value(605,1)
    elseif TAXI_SWITCH == -1 and parameters.MAIN_POWER:get() == 1 and NOSE_GEAR == 1 then
        set_aircraft_draw_argument_value(604,1)
    elseif TAXI_SWITCH == 0 or NOSE_GEAR < 0.9 then
        set_aircraft_draw_argument_value(605,0)
        set_aircraft_draw_argument_value(604,0)
    end    
--AAR LIGHT
    if AAR_READY == 1 and parameters.MAIN_POWER:get() == 1 then
        set_aircraft_draw_argument_value(609,AAR_KNOB)
    elseif AAR_READY ~= 1 and parameters.MAIN_POWER:get() == 1 then
        set_aircraft_draw_argument_value(609,0)
    end
--Formation Lights
    if parameters.MAIN_POWER:get() == 1 then
        set_aircraft_draw_argument_value(606,FORM_KNOB)
    elseif parameters.MAIN_POWER:get() == 0 then
        set_aircraft_draw_argument_value(606,0)
    end
--Navigation / Anti-Col Lights  --OFF | Mode 1 ANTICOL | Mode 2 ANTI/NAV | Mode 3 NAV | Mode 4 NAV FLASH 
    if LIGHT_SWITCH == 0 then
        set_aircraft_draw_argument_value(607,0)--NAV WHITE
        set_aircraft_draw_argument_value(608,0)--NAV ANTICOL
        set_aircraft_draw_argument_value(612,0)--NAV GREEN
        set_aircraft_draw_argument_value(613,0)--NAV RED
        --print_message_to_user("OFFFF")
    end
--LIGHTS FALSH TIMER
    if parameters.MAIN_POWER:get() == 1 and flash_timer >= 0 and flash_timer < 1 then
        flash_timer = (flash_timer + update_time_step)
    elseif parameters.MAIN_POWER:get() == 1 and flash_timer > 0.5 then   
        flash_timer = 0
    elseif parameters.MAIN_POWER:get() == 0 and flash_timer ~= 0 then   
        flash_timer = 0
    end
--5 WAY LIGHT SWITCH    
    --ANTICOL LIGHTS
    if flash_timer > 0.8 and LIGHT_SWITCH > 0 and LIGHT_SWITCH < 0.15 and parameters.MAIN_POWER:get() == 1 then
        set_aircraft_draw_argument_value(607,1)--NAV WHITE
        set_aircraft_draw_argument_value(608,1)--NAV ANTICOL
        set_aircraft_draw_argument_value(612,0)--NAV GREEN
        set_aircraft_draw_argument_value(613,0)--NAV RED
    elseif flash_timer < 0.79 and LIGHT_SWITCH > 0 and LIGHT_SWITCH < 0.15 and parameters.MAIN_POWER:get() == 1 then
        set_aircraft_draw_argument_value(607,0)--NAV WHITE
        set_aircraft_draw_argument_value(608,0)--NAV ANTICOL
        set_aircraft_draw_argument_value(612,0)--NAV GREEN
        set_aircraft_draw_argument_value(613,0)--NAV RED
    --NAV/ANTICOL LIGHTS
    elseif flash_timer > 0.8 and LIGHT_SWITCH > 0.15 and LIGHT_SWITCH < 0.25 and parameters.MAIN_POWER:get() == 1 then
        set_aircraft_draw_argument_value(607,1)--NAV WHITE
        set_aircraft_draw_argument_value(608,1)--NAV ANTICOL
        set_aircraft_draw_argument_value(612,0)--NAV GREEN
        set_aircraft_draw_argument_value(613,0)--NAV RED
    elseif flash_timer < 0.79 and LIGHT_SWITCH > 0.15 and LIGHT_SWITCH < 0.25 and parameters.MAIN_POWER:get() == 1 then
        set_aircraft_draw_argument_value(607,1)--NAV WHITE
        set_aircraft_draw_argument_value(608,0)--NAV ANTICOL
        set_aircraft_draw_argument_value(612,1)--NAV GREEN
        set_aircraft_draw_argument_value(613,1)--NAV RED
    elseif flash_timer > 0.8 and LIGHT_SWITCH > 0.25 and LIGHT_SWITCH < 0.35 and parameters.MAIN_POWER:get() == 1 then
        set_aircraft_draw_argument_value(607,1)--NAV WHITE
        set_aircraft_draw_argument_value(608,0)--NAV ANTICOL
        set_aircraft_draw_argument_value(612,1)--NAV GREEN
        set_aircraft_draw_argument_value(613,1)--NAV RED
    elseif LIGHT_SWITCH > 0.35 and LIGHT_SWITCH < 0.55 and parameters.MAIN_POWER:get() == 1 then
        set_aircraft_draw_argument_value(607,1)--NAV WHITE
        set_aircraft_draw_argument_value(608,0)--NAV ANTICOL
        set_aircraft_draw_argument_value(612,1)--NAV GREEN
        set_aircraft_draw_argument_value(613,1)--NAV RED
        flash_timer = 0
    elseif flash_timer < 0.79 and LIGHT_SWITCH > 0.13 and LIGHT_SWITCH < 0.55 and parameters.MAIN_POWER:get() == 1 then
        set_aircraft_draw_argument_value(607,0)--NAV WHITE
        set_aircraft_draw_argument_value(608,0)--NAV ANTICOL
        set_aircraft_draw_argument_value(612,0)--NAV GREEN
        set_aircraft_draw_argument_value(613,0)--NAV RED
    end
--NO POWER
    if parameters.MAIN_POWER:get() == 0 then
        set_aircraft_draw_argument_value(604,0)--TAXI 
        set_aircraft_draw_argument_value(605,0)--LANDING
        set_aircraft_draw_argument_value(607,0)--NAV WHITE
        set_aircraft_draw_argument_value(609,0)--AAR LIGHT
        set_aircraft_draw_argument_value(608,0)--NAV ANTICOL
        set_aircraft_draw_argument_value(612,0)--NAV GREEN
        set_aircraft_draw_argument_value(613,0)--NAV RED
    end
end

need_to_be_closed = false
