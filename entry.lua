self_ID = "F-22A by GrinnelliDesigns"

declare_plugin(self_ID, 
{
	image     	 = "FC3.bmp",
	installed 	 = true, -- if false that will be place holder , or advertising
	dirName	  	 = current_mod_path,
	developerName	 = _("GrinnelliDesigns"),
	developerLink      = _("https://grinnellidesigns.com/"),
	fileMenuName       = _("F-22A"),
	displayName        = _("F-22A"),
	shortName   	 = _("F-22A"),
	version	 	 = "MK II",
	state		 = "installed",
	update_id       	 = "F-22A",
	info		 = _("F-22A Raptor Mod by GrinnelliDesigns"),
	encyclopedia_path  = current_mod_path..'/Encyclopedia',
	rules = { ["F-15C"] = {required = true},},

	Skins	=
	{
		{
		    name	= _("F-22A"),
			dir		= "Theme"
		},
	},
	Missions =
	{
		{
			name		    = _("F-22A"),
			dir			    = "Missions",
  		},
	},
	LogBook =
	{
		{
			name		= _("F-22A"),
			type		= "F-22A",
		},
	},	
	InputProfiles =
	{
		["F-22A"] = current_mod_path .. '/Input/F-22A',
	}
})
----------------------------------------------------------------------------------------
mount_vfs_model_path(current_mod_path.."/Shapes")
mount_vfs_model_path(current_mod_path.."/Cockpit/Shape") 
mount_vfs_liveries_path(current_mod_path.."/Liveries")
mount_vfs_texture_path(current_mod_path.."/Textures")
mount_vfs_texture_path(current_mod_path.."/Textures/F-22A.zip")
mount_vfs_texture_path(current_mod_path.."/Textures/F-22A_Cockpit.zip")
mount_vfs_texture_path(current_mod_path.."/Textures/Clipboards")
mount_vfs_texture_path(current_mod_path.."/Textures/Cockpit Photo")
----------------------------------------------------------------------------------------
dofile(current_mod_path.."/Weapons.lua")
dofile(current_mod_path.."/Views.lua")
make_view_settings('F-22A', ViewSettings, SnapViews)
----------------------------------------------------------------------------------------
F15FM.old = 6
MAC_flyable('F-22A', current_mod_path..'/Cockpit/Scripts/', F15FM, current_mod_path..'/comm.lua')

dofile(current_mod_path..'/F-22A.lua')

plugin_done()