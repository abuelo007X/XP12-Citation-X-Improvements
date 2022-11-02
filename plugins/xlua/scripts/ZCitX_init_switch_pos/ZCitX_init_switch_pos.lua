---------------------------------------------------------------------------------------------------
-- Script to Initialize Switches to the expected position
-- Devloped by @Abuelo007X with guidance from Citation X Pilot @GuruPilot
---------------------------------------------------------------------------------------------------

-------------------------------------------- Change Log -------------------------------------------

-- 2022-10-19: Added PFD Selector to be n OFF instead of VOR (1/2) for Pilot and Copilot

--------------------------- locate Datarefs abd Commands ------------------------------------------

-- APU generator

cmd_apu_gen_switch_dwn = find_command("laminar/CitX/APU/gen_switch_dwn")
cmd_apu_gen_switch_up = find_command("laminar/CitX/APU/gen_switch_up")

dr_apu_gen_switch_term = find_dataref("laminar/CitX/APU/gen_switch_term")

-- Left Engine Bleed Air

cmd_engine_left_dwn = find_command("laminar/CitX/bleedair/cmd_engine_left_dwn")
cmd_engine_left_up = find_command("laminar/CitX/bleedair/cmd_engine_left_up")

dr_engine_left_term = find_dataref("laminar/CitX/bleedair/engine_left_term")

-- Right Engine Bleed Air

cmd_engine_right_dwn = find_command("laminar/CitX/bleedair/cmd_engine_right_dwn")
cmd_engine_right_up = find_command("laminar/CitX/bleedair/cmd_engine_right_up")

dr_engine_right_term = find_dataref("laminar/CitX/bleedair/engine_right_term")

-- Cabin PAC

cmd_air_cond_cabin_dwn = find_command("laminar/CitX/bleedair/cmd_air_cond_cabin_dwn")
cmd_air_cond_cabin_up = find_command("laminar/CitX/bleedair/cmd_air_cond_cabin_up")

dr_air_cond_cabin_term = find_dataref("laminar/CitX/bleedair/air_cond_cabin_term")

-- Cockpit PAC

cmd_air_cond_cockpit_dwn = find_command("laminar/CitX/bleedair/cmd_air_cond_cockpit_dwn")
cmd_air_cond_cockpit_up = find_command("laminar/CitX/bleedair/cmd_air_cond_cockpit_up")

dr_air_cond_cockpit_term = find_dataref("laminar/CitX/bleedair/air_cond_cockpit_term")

-- Navigation Toogle

cmd_lights_navigation_toggle = find_command("laminar/CitX/lights/cmd_navigation_toggle")

dr_lights_navigation = find_dataref("laminar/CitX/lights/navigation")

-- DC power Generator

cmd_generator_left_up = find_command("laminar/CitX/electrical/cmd_generator_left_up")
cmd_generator_right_up = find_command("laminar/CitX/electrical/cmd_generator_right_up")

dr_generator_left_term = find_dataref("laminar/CitX/electrical/generator_left_term")
dr_generator_right_term = find_dataref("laminar/CitX/electrical/generator_right_term")

-- Fuel Boost

cmd_fuel_boost_left_dwn = find_command("laminar/CitX/fuel/cmd_boost_left_dwn")
cmd_fuel_boost_right_dwn = find_command("laminar/CitX/fuel/cmd_boost_right_dwn")

dr_fuel_boost_left_term = find_dataref("laminar/CitX/fuel/boost_left_term")
dr_fuel_boost_right_term = find_dataref("laminar/CitX/fuel/boost_right_term")

-- Center Wing transfer

cmd_fuel_transfer_left_dwn = find_command("laminar/CitX/fuel/cmd_transfer_left_dwn")
cmd_fuel_transfer_right_dwn = find_command("laminar/CitX/fuel/cmd_transfer_right_dwn")

dr_fuel_transfer_left_term = find_dataref("laminar/CitX/fuel/transfer_left_term")
dr_fuel_transfer_right_term = find_dataref("laminar/CitX/fuel/transfer_right_term")

-- Primary Flight Display Source selector

cmd_efis_source1_pilot_dwn = find_command("laminar/CitX/primus/cmd_source1_pilot_dwn")
cmd_efis_source1_pilot_up = find_command("laminar/CitX/primus/cmd_source1_pilot_up")

cmd_efis_source2_pilot_dwn = find_command("laminar/CitX/primus/cmd_source2_pilot_dwn")
cmd_efis_source2_pilot_up = find_command("laminar/CitX/primus/cmd_source2_pilot_up")

cmd_efis_source1_copilot_dwn = find_command("laminar/CitX/primus/cmd_source1_copilot_dwn")
cmd_efis_source1_copilot_up = find_command("laminar/CitX/primus/cmd_source1_copilot_up")

cmd_efis_source2_copilot_dwn = find_command("laminar/CitX/primus/cmd_source2_copilot_dwn")
cmd_efis_source2_copilot_up = find_command("laminar/CitX/primus/cmd_source2_copilot_up")

dr_EFIS_1_selection_pilot = find_dataref("sim/cockpit2/EFIS/EFIS_1_selection_pilot")
dr_EFIS_2_selection_pilot = find_dataref("sim/cockpit2/EFIS/EFIS_2_selection_pilot")

dr_EFIS_1_selection_copilot = find_dataref("sim/cockpit2/EFIS/EFIS_1_selection_copilot")
dr_EFIS_2_selection_copilot = find_dataref("sim/cockpit2/EFIS/EFIS_2_selection_copilot")


--------------------------------- DO THIS EACH FLIGHT START ---------------------------------------

function flight_start()
    if dr_apu_gen_switch_term <=0 then cmd_apu_gen_switch_up:once() end
    if dr_engine_left_term == 0 then cmd_engine_left_up:once() elseif dr_engine_left_term == 2 then cmd_engine_left_dwn:once() end
    if dr_engine_right_term == 0 then cmd_engine_right_up:once() elseif dr_engine_right_term == 2 then cmd_engine_right_dwn:once() end
    if dr_air_cond_cabin_term == 0 then cmd_air_cond_cabin_up:once() elseif dr_air_cond_cabin_term == 2 then cmd_air_cond_cabin_dwn:once() end
    if dr_air_cond_cockpit_term == 0 then cmd_air_cond_cockpit_up:once() elseif dr_air_cond_cockpit_term == 2 then cmd_air_cond_cockpit_dwn:once() end
    if dr_lights_navigation == 0 then cmd_lights_navigation_toggle:once() end
    if dr_generator_left_term <= 0 then cmd_generator_left_up:once() end
    if dr_generator_right_term <= 0 then cmd_generator_right_up:once() end
    if dr_fuel_boost_left_term >= 0 then cmd_fuel_boost_left_dwn:once() cmd_fuel_boost_left_dwn:once() end
    if dr_fuel_boost_right_term >= 0 then cmd_fuel_boost_right_dwn:once() cmd_fuel_boost_right_dwn:once() end
    if dr_fuel_boost_left_term <= 1 then cmd_fuel_transfer_left_dwn:once() cmd_fuel_transfer_left_dwn:once() end
    if dr_fuel_boost_right_term <= 1 then cmd_fuel_transfer_right_dwn:once() cmd_fuel_transfer_right_dwn:once() end
    dr_EFIS_1_selection_pilot = 1
    dr_EFIS_2_selection_pilot = 1
    dr_EFIS_1_selection_copilot = 1
    dr_EFIS_2_selection_copilot = 1
end
