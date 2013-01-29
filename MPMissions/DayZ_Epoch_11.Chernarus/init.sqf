/*	
	INITILIZATION
*/
startLoadingScreen ["","RscDisplayLoadCustom"];
cutText ["","BLACK OUT"];
enableSaving [false, false];

//REALLY IMPORTANT VALUES
dayZ_hivePipe1 = 	"\\.\pipe\dayz";	//The named pipe
dayZ_instance = 11;	//The instance
hiveInUse	=	true;
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0;

//disable greeting menu 
player setVariable ["BIS_noCoreConversations", true];
//disable radio messages to be heard and shown in the left lower corner of the screen
enableRadio false;

// DayZ Epoch config
spawnShoremode = 1; // Default = 1 (on shore)
spawnArea= 1500; // Default = 1500
MaxHeliCrashes= 5; // Default = 5
MaxVehicleLimit = 200; // Default = 50
MaxDynamicDebris = 500; // Default = 100
dayz_MapArea = 14000; // Default = 10000
dayz_maxLocalZombies = 40; // Default = 40

// DayZ Epoch TRADERS
serverTraders = [
	"TK_CIV_Takistani04_EP1",
	"CIV_EuroMan01_EP1",
	"Rocker4",
	"Woodlander3",
	"Woodlander1",
	"RU_WorkWoman1",
	"RU_WorkWoman5",
	"CIV_EuroMan02_EP1",
	"RU_Citizen3",
	"Worker3",
	"Profiteer4",
	"Dr_Hladik_EP1",
	"Doctor",
	"RU_Functionary1",
	"RU_Villager3"
];

// Weapons Traders
menu_CIV_EuroMan01_EP1 = [
	[["Sidearm",11],["Rifle",12],["Shotgun",13],["Assault Rifle",14],["Machine Gun",15],["Sniper Rifle",16]],
	[],
	"friendly"
];
menu_Rocker4 = [
	[["Sidearm",1111],["Rifle",1212],["Shotgun",1313],["Assault Rifle",1414],["Machine Gun",1515],["Sniper Rifle",1616]],
	[],
	"friendly"
];

// Parts Traders
menu_Woodlander3 = [
	[["Car Parts",21],["Building Supplies",22]],
	[],
	"friendly"
];
menu_Woodlander1 = [
	[["Car Parts",2121],["Building Supplies",2222]],
	[],
	"friendly"
];

// Can Traders
menu_RU_WorkWoman1 = [
	[["Food and Drinks",51],["Backpacks",52],["Toolbelt",53],["Clothes",54]],
	[
		["ItemCopperBar","ItemSodaEmpty",1,3,"buy","Empty Soda Cans","Copper Bar",103],
		["ItemCopperBar","TrashTinCan",1,3,"buy","Empty Tin Cans","Copper Bar",102],
		["ItemCopperBar","TrashJackDaniels",1,1,"buy","Empty Wiskey Bottle","Copper Bar",101]
	],
	"friendly"
];
menu_RU_WorkWoman5 = [
	[["Food and Drinks",5151],["Backpacks",5252],["Toolbelt",5353],["Clothes",5454]],
	[
		["ItemCopperBar","ItemSodaEmpty",1,3,"buy","Empty Soda Cans","Copper Bar",103],
		["ItemCopperBar","TrashTinCan",1,3,"buy","Empty Tin Cans","Copper Bar",102],
		["ItemCopperBar","TrashJackDaniels",1,1,"buy","Empty Wiskey Bottle","Copper Bar",101]
	],
	"friendly"
];
// Ammo Traders
menu_CIV_EuroMan02_EP1 = [
	[["Sidearm Ammo",1],["Rifle Ammo",2],["Shotgun and Crossbow Ammo",3],["Assault Rifle Ammo",4],["Machine Gun Ammo",5],["Sniper Rifle Ammo",6]],
	[],
	"friendly"
];
menu_RU_Citizen3 = [
	[["Sidearm Ammo",1001],["Rifle Ammo",2002],["Shotgun and Crossbow Ammo",3003],["Assault Rifle Ammo",4004],["Machine Gun Ammo",5005],["Sniper Rifle Ammo",6006]],
	[],
	"friendly"
];
// Auto Traders
menu_Worker3 = [
	[["Cars",41],["Trucks Unarmed",42],["SUV",466],["Buses and Vans",467],["Offroad",43],["Helicopter Unarmed",44],["Military Unarmed",45]],
	[],
	"friendly"
];
menu_Profiteer4 = [
	[["Trucks Armed",422],["Utility",46],["Helicopter Armed",444],["Military Armed",455],["Fuel Trucks",47],["Heavy Armor Unarmed",48]],
	[],
	"friendly"
];

// Doctors
menu_Dr_Hladik_EP1 = [
	[["Medical Supplies",31],["Chem-lites/Flares",32],["Smoke Grenades",33]],
	[["FoodBioMeat","ItemZombieParts",1,1,"buy","Zombie Parts","Bio Meat",101]],
	"friendly"
];
menu_Doctor = [
	[["Medical Supplies",3131],["Chem-lites/Flares",3232],["Smoke Grenades",3333]],
	[["FoodBioMeat","ItemZombieParts",1,1,"buy","Zombie Parts","Bio Meat",101]],
	"friendly"
];

// Metals Traders
menu_RU_Functionary1 = [
	[["Vaults",411]],
	[
		["ItemSilverBar","ItemCopperBar",1,6,"buy","Copper","Silver",99],
		["ItemCopperBar","ItemSilverBar",6,1,"buy","Silver","Copper",98],
		["ItemGoldBar","ItemSilverBar",1,6,"buy","Silver","Gold",97],
		["ItemSilverBar","ItemGoldBar",6,1,"buy","Gold","Silver",96]
	],
	"neutral"
];

// Boat Traders
menu_RU_Villager3 = [
	[["Boats Unarmed",49],["Boats Armed",499]], 
	[
		["ItemJerrycanEmpty","ItemCopperBar",1,1,"buy","Copper Bar","Empty Jerrycan",101],
		["ItemGenerator","ItemGoldBar",1,3,"buy","Gold Bars","Portable Generator",100]
	],
	"neutral"
];

menu_TK_CIV_Takistani04_EP1 = [
	[["Explosives",23]], 
	[],
	"neutral"
];

// ["friendly"] must have more than -2000 humanity,
// ["neutral"] can have any ammount of humanity
// ["hostile"] must have lower than -2000
// OLD ["Wholesale",999]

//Load in compiled functions
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";				//Initilize the Variables (IMPORTANT: Must happen very early)
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";				//Initilize the publicVariable event handlers
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";	//Functions used by CLIENT for medical
progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";				//Compile regular functions
progressLoadingScreen 1.0;

"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

if ((!isServer) && (isNull player) ) then
{
waitUntil {!isNull player};
waitUntil {time > 3};
};

if ((!isServer) && (player != player)) then
{
  waitUntil {player == player}; 
  waitUntil {time > 3};
};

if (isServer) then {
	
	// TODO: Still Needs major overhaul current method is not ideal	
	AllowedVehiclesList = [ "Old_moto_TK_Civ_EP1",
							"MMT_Civ",
							"Old_bike_TK_INS_EP1",
							"ATV_US_EP1",
							"hilux1_civil_3_open_EP1",
							"datsun1_civil_3_open",
							"Pickup_PK_TK_GUE_EP1",
							"Octavia_ACR",
							"VWGolf",
							"Lada1",
							"Skoda",
							"car_sedan",
							"Volha_1_TK_CIV_EP1",
							"VolhaLimo_TK_CIV_EP1",
							"UAZ_Unarmed_TK_EP1",
							"Ikarus",
							"SUV_TK_CIV_EP1",
							"SUV_Green",
							"SUV_Yellow",
							"SUV_White",
							"SUV_Silver",
							"SUV_Red",
							"SUV_Pink",
							"SUV_Orange",
							"SUV_Charcoal",
							"SUV_Blue",
							"UH1H_DZ",
							"Mi17_Civilian",
							"LandRover_CZ_EP1",
							"HMMWV_Ambulance",
							"ArmoredSUV_PMC",
							"PBX",
							"RHIB",
							"Fishing_Boat",
							"M113Ambul_UN_EP1",
							"KamazRefuel",
							"UralRefuel_TK_EP1",
							"tractor",
							"CSJ_GyroP"];
	
	AllowedVehiclesChance = [ 0.25, // "Old_moto_TK_Civ_EP1",
							  0.55, // "MMT_Civ"
							  0.55, // Old_bike_TK_INS_EP1
							  0.45, // "ATV_US_EP1",
							  0.55, // "hilux1_civil_3_open_EP1", 
							  0.25, // "datsun1_civil_3_open",
							  0.20, // "Pickup_PK_TK_GUE_EP1",
							  0.20, // Octavia_ACR
							  0.20, // VWGolf
							  0.25, // "Lada1",
							  0.25, // "Skoda",
							  0.2,  // "car_sedan",
							  0.2,  // "Volha_1_TK_CIV_EP1",
							  0.05, // "VolhaLimo_TK_CIV_EP1"
							  0.15, // "UAZ_Unarmed_TK_EP1"
							  0.01, // "Ikarus"
							  0.1,  // "SUV_TK_CIV_EP1"
							  0.1,  // "SUV_Green",
  							  0.1,  // "SUV_Yellow",
							  0.1,  // "SUV_White",
							  0.1,  // "SUV_Silver",
							  0.1,  // "SUV_Red",
							  0.1,  // "SUV_Pink",
							  0.1,  // "SUV_Orange",
							  0.1,  // "SUV_Charcoal",
							  0.1,  // "SUV_Blue",
							  0.05, // "UH1H_DZ"
							  0.09, // "Mi17_Civilian"
							  0.11, // "LandRover_CZ_EP1"
							  0.11, // "HMMWV_Ambulance"
							  0.05, // "ArmoredSUV_PMC"
							  0.15, // "PBX"
							  0.01, // "RHIB"
							  0.1,  // "Fishing_Boat",
							  0.01, // "M113Ambul_UN_EP1"
							  0.01, // "KamazRefuel"
							  0.01, // UralRefuel_TK_EP1
							  0.1,  // "tractor"
							  0.1]; // "CSJ_GyroP"
	
	AllowedVehiclesLimit =  [ 5,  // "Old_moto_TK_Civ_EP1",
							  10, // "MMT_Civ"
							  10, // Old_bike_TK_INS_EP1
							  5, // "ATV_US_EP1",
							  5, // "hilux1_civil_3_open_EP1",
							  5, // "datsun1_civil_3_open",
							  3, // "Pickup_PK_TK_GUE_EP1",
							  2, // "Octavia_ACR"
							  2, // "VWGolf"
							  3, // "Lada1",
							  3, // "Skoda",
							  3, // "car_sedan",
							  3, // "Volha_1_TK_CIV_EP1",
							  1, // "VolhaLimo_TK_CIV_EP1"
							  3, // "UAZ_Unarmed_TK_EP1"
							  2, // "Ikarus"
							  4, // "SUV_TK_CIV_EP1"
							  2, // "SUV_Green",
							  1, // "SUV_Yellow",
							  1, // "SUV_White",
							  1, // "SUV_Silver",
							  1, // "SUV_Red",
							  1, // "SUV_Pink",
							  1, // "SUV_Orange",
							  1, // "SUV_Charcoal",
							  1, // "SUV_Blue",
							  2, // "UH1H_DZ"
							  2, // "Mi17_Civilian"
							  2, // "LandRover_CZ_EP1"
							  3, // "HMMWV_Ambulance"
							  2, // "ArmoredSUV_PMC"
							  5, // "PBX"
							  2, // "RHIB"
							  4, // "Fishing_Boat",
							  3, // "M113Ambul_UN_EP1"
							  2, // "KamazRefuel"
							  2, // UralRefuel_TK_EP1
							  1, // "tractor"
							  5]; // "CSJ_GyroP"						
	
	hiveInUse = true;
	
	// Add trader citys
	_nil = [] execVM "mission.sqf";
	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf";
};

if (!isDedicated) then {
	//Conduct map operations
	0 fadeSound 0;
	waitUntil {!isNil "dayz_loadScreenMsg"};
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");
	
	//Run the player monitor
	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";	
};