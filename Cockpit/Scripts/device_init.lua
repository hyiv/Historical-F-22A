mount_vfs_texture_archives("Bazar/Textures/AvionicsCommon")

dofile(LockOn_Options.common_script_path.."tools.lua")
dofile(LockOn_Options.script_path.."devices.lua")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
layoutGeometry = {}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
MainPanel = {"ccMainPanel",LockOn_Options.script_path.."mainpanel_init.lua"}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
attributes = {
	"support_for_cws",
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
creators = {}
creators[devices.AVIONICS]			 	 = {"avLuaDevice"		    ,LockOn_Options.script_path.."Systems/Avionics.lua"}
creators[devices.ELECTRICAL_SYSTEM]		 = {"avLuaDevice"		    ,LockOn_Options.script_path.."Systems/Electrical_System.lua"}
creators[devices.ENGINE_SYSTEM]			 = {"avLuaDevice"		    ,LockOn_Options.script_path.."Systems/Engine_System.lua"}
creators[devices.WEAPON_SYSTEM]			 = {"avLuaDevice"		    ,LockOn_Options.script_path.."Systems/Weapon_System.lua"}
creators[devices.MFD_SYSTEM]			 = {"avLuaDevice"		    ,LockOn_Options.script_path.."Systems/MFD_System.lua"}
creators[devices.PMFD_SYSTEM]			 = {"avLuaDevice"		    ,LockOn_Options.script_path.."Systems/PMFD_System.lua"}
creators[devices.ICP_SYSTEM]			 = {"avLuaDevice"		    ,LockOn_Options.script_path.."Systems/ICP_System.lua"}
creators[devices.FCS]					 = {"avLuaDevice"			,LockOn_Options.script_path.."Systems/FCS.lua"}

--creators[devices.KNEEBOARD] = {"avKneeboard",LockOn_Options.common_script_path.."KNEEBOARD/device/init.lua"}

indicators = {}
--PFD LEFT
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."UFD_LEFT/init.lua",
	nil,
	{
		{"LEFT-PFD-CENTER", "LEFT-PFD-DOWN", "LEFT-PFD-RIGHT"}
	}
}
--PFD RIGHT
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."UFD_RIGHT/init.lua",
	nil,
	{
		{"RIGHT-PFD-CENTER", "RIGHT-PFD-DOWN", "RIGHT-PFD-RIGHT"}
	}
}
--ICP
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."ICP/init.lua",
	nil,
	{
		{"ICP_DISPLAY_CENTER", "ICP_DISPLAY_BOTTOM", "ICP_DISPLAY_RIGHT"}
	}
}
--MFD CENTER
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."MFD_CENTER/init.lua",
	nil,
	{
		{"MFD-CENTER", "MFD-DOWN", "MFD-RIGHT"}
	}
}
--MFD RIGHT
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."MFD_RIGHT/init.lua",
	nil,
	{
		{"RIGHT-MFD-CENTER", "RIGHT-MFD-DOWN", "RIGHT-MFD-RIGHT"}
	}
}
--MFD LEFT
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."MFD_LEFT/init.lua",
	nil,
	{
		{"LEFT-MFD-CENTER", "LEFT-MFD-DOWN", "LEFT-MFD-RIGHT"}
	}
}
--PMFD CENTER
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."PMFD_CENTER/init.lua",
	nil,
	{
		{"PMFD-CENTER", "PMFD-DOWN", "PMFD-RIGHT"}
	}
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------