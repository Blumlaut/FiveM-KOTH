resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
resource_type 'gametype' { name = 'koth' }


server_scripts {
	"config.lua",
	"server/util_s.lua",
	"shared/util_shared.lua",
	"server/system/inventory_s.lua",
	"server/gameplay/teams_s.lua",
	"server/gameplay/zone_s.lua",
	"server/system/maps_s.lua",
} 

client_scripts {
	"config.lua",
	"client/util_c.lua",
	"shared/util_shared.lua",
	"client/gameplay/basics_c.lua",
	"client/system/inventory_c.lua",
	"client/ui/hud.lua",
	"client/gameplay/teams_c.lua",
	"client/gameplay/zone_c.lua",
	"client/system/maps_c.lua",
}