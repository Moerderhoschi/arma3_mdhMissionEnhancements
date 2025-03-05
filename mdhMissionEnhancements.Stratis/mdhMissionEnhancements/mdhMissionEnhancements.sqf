/////////////////////////////////////////////////////////////////////////////////////
// scripts for Arma missions, made by moerderhoschi
/////////////////////////////////////////////////////////////////////////////////////
pRandomTime                  = ["pRandomTime",                  1] call BIS_fnc_getParamValue; // RANDOM MISSION STARTTIME
pDisableFatigue              = ["pDisableFatigue",              1] call BIS_fnc_getParamValue; // DISABLE FATIGUE SYSTEM (LOOP)
pCustomAimCoef               = ["pCustomAimCoef",               1] call BIS_fnc_getParamValue; // SET PLAYER CUSTOM AIM COEF (LOOP)
pPlayerMapMarkers            = ["pPlayerMapMarkers",            1] call BIS_fnc_getParamValue; // MAP MARKERS FOR PLAYERS (LOOP)
pFoggyBreath                 = ["pFoggyBreath",                 1] call BIS_fnc_getParamValue; // FOGGY BREATH FOR ALL UNITS (LOOP)
pFoggyBreathTimeDependency   = ["pFoggyBreathTimeDependency",   1] call BIS_fnc_getParamValue; // FOGGY BREATH WITH TIME DEPENDENCY 18 TO 7 O CLOCK (LOOP)
pDisableRadioMessages        = ["pDisableRadioMessages",        1] call BIS_fnc_getParamValue; // DISABLE RADIO MESSAGES TO BE HEARD AND SHOWN IN THE LEFT LOWER CORNER
pDisableConversation         = ["pDisableConversation",         1] call BIS_fnc_getParamValue; // SCRIPT TO DISABLE ALL CONVERSATIONS (LOOP)
pAvoidAiFleeing              = ["pAvoidAiFleeing",              1] call BIS_fnc_getParamValue; // AVOID AI FLEEING (LOOP)
pAvoidAiLayingDown           = ["pAvoidAiLayingDown",           1] call BIS_fnc_getParamValue; // AVOID AI LAYING DOWN (LOOP)
pAiRagdollAtHit              = ["pAiRagdollAtHit",              1] call BIS_fnc_getParamValue; // AI UNITS GET RAGDOLL EFFECT AT HIT (LOOP)
pAiGetMoreDamageAtHit        = ["pAiGetMoreDamageAtHit",        0] call BIS_fnc_getParamValue; // AI UNITS GET MORE DAMAGE AT HIT (LOOP)
pReplaceAiMagsWithTracer     = ["pReplaceAiMagsWithTracer",     1] call BIS_fnc_getParamValue; // REPLACE AI MAGS WITH TRACER (LOOP)
pReplaceRPG18                = ["pReplaceRPG18",                1] call BIS_fnc_getParamValue; // REPLACE RPG18 WITH RPG-7 (LOOP)
pFunBarrles                  = ["pFunBarrles",                  1] call BIS_fnc_getParamValue; // FUN BARRELS WITH EXPLOSIONS AND FLYING AROUND (LOOP)
pVehiclesBigExplosions       = ["pVehiclesBigExplosions",       1] call BIS_fnc_getParamValue; // VEHICLES BIG EXPLOSIONS (LOOP)
pFuelTanksBigExplosions      = ["pFuelTanksBigExplosions",      1] call BIS_fnc_getParamValue; // FUELTANKS BIG EXPLOSIONS (LOOP)
pInflameFiresAtNight         = ["pInflameFiresAtNight",         0] call BIS_fnc_getParamValue; // INFLAME FIREPLACES AT NIGHTTIME
pMdhRevive                   = ["pMdhRevive",                   1] call BIS_fnc_getParamValue; // MDH REVIVE FOR ALL PLAYERS (LOOP)
pMdhReviveBleedoutTime       = ["pMdhReviveBleedoutTime",     4^9] call BIS_fnc_getParamValue; // MDH REVIVE BLEEDOUT TIME FOR ALL PLAYERS (LOOP)
pMdhReviveAutoReviveTime     = ["pMdhReviveAutoReviveTime",   240] call BIS_fnc_getParamValue; // MDH AUTO REVIVE TIME FOR ALL PLAYERS (LOOP)
pMdhReviveSpectator          = ["pMdhReviveSpectator",          1] call BIS_fnc_getParamValue; // MDH REVIVE SPECTATOR FOR INCAPACITATED PLAYERS (LOOP)
pCheckAllPlayerIncapacitated = ["pCheckAllPlayerIncapacitated", 0] call BIS_fnc_getParamValue; // CHECK IF ALL PLAYERS ARE INCAPACITATED AND END MISSION (LOOP)

/////////////////////////////////////////////////////////////////////////////////////////////
// RANDOM MISSION STARTTIME - v2025-02-09
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pRandomTime",0] > 0) then
{
	if (isServer) then
	{
		_rM = 1;
		_rH = missionNameSpace getVariable["pRandomTimeHour",selectRandom[0,6,7,15,16]];
		_rMin = missionNameSpace getVariable["pRandomTimeMinute",selectRandom[50]];
		switch pRandomTime do
		{
			case 1: { 0 = [[2005,_rM,12,_rH,_rMin +ceil random 5],true] call BIS_fnc_setDate}; // Random
			case 2: { 0 = [[2005,_rM,12, 06,                  20],true] call BIS_fnc_setDate}; // Early Morning
			case 3: { 0 = [[2005,_rM,12, 06,                  50],true] call BIS_fnc_setDate}; // Morning
			case 4: { 0 = [[2005,_rM,12, 12,      ceil random 59],true] call BIS_fnc_setDate}; // Noon
			case 5: { 0 = [[2005,_rM,12, 17,                  20],true] call BIS_fnc_setDate}; // Sundown
			case 6: { 0 = [[2005,_rM,12, 00,                  00],true] call BIS_fnc_setDate}; // fullMoon
			case 7: { 0 = [[2005,_rM,20, 02,                  00],true] call BIS_fnc_setDate}; // darkNight
			default { }
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// DISABLE RADIO MESSAGES TO BE HEARD AND SHOWN IN THE LEFT LOWER CORNER - v2025-02-12
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pDisableRadioMessages",0] == 1) then {enableRadio false};

/////////////////////////////////////////////////////////////////////////////////////////////
// SCRIPT TO DISABLE ALL CONVERSATIONS - v2025-02-08
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pDisableConversation",0] == 1) then
{
	0 spawn
	{
		sleep (1 + random 3);
		while {missionNameSpace getVariable ["pDisableConversation",0] == 1} do
		{
			{
				_x disableConversation true;
				_x setvariable ["bis_nocoreconversations",true];											
				_x disableAI "RADIOPROTOCOL";
				sleep 0.1;
			} forEach allunits;
			sleep (7 + random 3);
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// CHECK IF ALL PLAYERS ARE INCAPACITATED AND END MISSION(by Moerderhoschi) - v2025-02-08
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pCheckAllPlayerIncapacitated",0] == 1) then
{
	if (isServer && {isMultiplayer}) then
	{
		0 spawn
		{
			sleep (5 + random 3);
			_c = 0;
			_l = 3;
			while {_c < _l} do
			{
				if ({(lifeState _x) == 'INCAPACITATED'} count allPlayers == count allPlayers) then
				{
					_c = _c+1
				}
				else
				{
					_c = 0
				};
				sleep 1;
			};
			["end1",false] call BIS_fnc_endMission;
			sleep 1;
			'EveryoneLost' call BIS_fnc_endMissionServer
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// FUN BARRELS WITH EXPLOSIONS AND FLYING AROUND(original .sqs script by JBOY) - v2025-02-08
// https://forums.bohemia.net/forums/topic/174218-jboy-burningexploding-barrel-script-released/
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pFunBarrles",0] == 1) then
{
	if (isServer) then
	{
		0 spawn
		{
			sleep (1 + random 3);
			while {missionNameSpace getVariable ["pFunBarrles",0] == 1} do
			{
				{
					if (typeOf _x in ["Barrel1","cwa_Barrel_Red","Barrel4","Barrel5","Barrel6"]) then
					{
						if (!(_x getVariable ["mdhFunBarrlesSet",false])) then
						{
							_x setVariable ["mdhFunBarrlesSet",true];
							_x addeventhandler
							[
								"killed",
								{
									params["_unit"];
									_unit spawn
									{
										_s = random 9;
										_d = random 359;
										_v = 20+(random 20);
										"GrenadeHand" createVehicle (getPos _this);
										sleep 4.8;
										_this setVelocity [_s*sin(_d),_s*cos(_d),_v]
									};
								}
							];
						}
					};
				} forEach vehicles;
				sleep (7 + random 3);
			};
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// VEHICLES BIG EXPLOSIONS(by Moerderhoschi) - v2025-02-08
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pVehiclesBigExplosions",0] == 1) then
{
	if (isServer) then
	{
		0 spawn
		{
			sleep (1 + random 3);
			_a = "getNumber (_x >> 'transportFuel') > 1000" configClasses (configFile >> "CfgVehicles");
			_b = [];
			{
				if (true OR {configname _x isKindOf "car"}) then
				{
					_b pushBack configname _x;
				};
			} forEach _a;

			_a = "getNumber (_x >> 'transportAmmo') > 1000" configClasses (configFile >> "CfgVehicles");
			_c = [];
			{
				if (true OR {configname _x isKindOf "car"}) then
				{
					_c pushBack configname _x;
				};
			} forEach _a;

			while {missionNameSpace getVariable ["pVehiclesBigExplosions",0] == 1} do
			{
				{
					if (typeOf _x in _b OR {typeOf _x in _c} or {_x getVariable ["mdhVehicleExplosionAdd",false]}) then
					{
						if (!(_x getVariable ["mdhVehicleExplosionSet",false])) then
						{
							_x setVariable ["mdhVehicleExplosionSet",true];
							_x addeventhandler
							[
								"killed",
								{
									params ["_unit", "_killer"];
									_unit spawn
									{
										_unit = _this;
										//_pos = getPosWorld _unit;
										_pos = getPosASL _unit;
										if (([_unit,"VIEW"] checkVisibility [[_pos#0, _pos#1, _pos#2 + 1],[_pos#0, _pos#1, _pos#2 + 100]]) > 0) then
										{
											_pos = [_pos#0, _pos#1, _pos#2 + 100];
											_bomb = "Bo_GBU12_LGB" createVehicle _pos;
											_bomb hideObjectGlobal true;
											_v = -1*5^9;
											_bomb setVectorUp [0,_v,-1];
											_bomb setVelocity[0,0,_v];
											sleep 0.1;
											//_bomb = "R_230mm_HE" createVehicle _pos;
											_bomb = "Sh_155mm_AMOS" createVehicle _pos;
											_bomb hideObjectGlobal true;
											_bomb setVectorUp [0,_v,-1];
											_bomb setVelocity[0,0,_v];
										};
									};
								}
							];
						};
					};
				} forEach vehicles;
				sleep (7 + random 3);
			};
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// FUELTANKS BIG EXPLOSIONS(by Moerderhoschi) - v2025-02-08
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pFuelTanksBigExplosions",0] == 1) then
{
	if (isServer) then
	{
		0 spawn
		{
			sleep (2 + random 3);
			_fuelTankTypes = ["Land_fuel_tank_small","Land_A_FuelStation_Shed","Land_Fuel_tank_stairs","Land_Ind_TankSmall","Land_Ind_TankSmall2"];
			_factor = 100;
			_worldSize = if (worldSize > 30000) then {30000} else {worldSize};
			for "_i1" from 0 to ceil(_worldSize/100) do
			{
				for "_i2" from 0 to ceil(_worldSize/100) do
				{
					_fuelTanks = (nearestObjects [[_i1*_factor,_i2*_factor],_fuelTankTypes,_factor]);
					//_fuelTanks = [_i1*_factor,_i2*_factor] nearObjects [_fuelTankTypes, _factor]; // should be faster
					{
						if (!(_x getVariable ["mdhVehicleExplosionSet",false])) then
						{
							_x setVariable ["mdhVehicleExplosionSet",true];
							_x addeventhandler
							[
								"killed",
								{
									params ["_unit", "_killer"];
									_unit spawn
									{
										_unit = _this;
										//_pos = getPosWorld _unit;
										_pos = getPosASL _unit;
										if (([_unit,"VIEW"] checkVisibility [[_pos#0, _pos#1, _pos#2 + 1],[_pos#0, _pos#1, _pos#2 + 100]]) > 0) then
										{
											_pos = [_pos#0, _pos#1, _pos#2 + 100];
											_bomb = "Bo_GBU12_LGB" createVehicle _pos;
											_bomb hideObjectGlobal true;
											_v = -1*5^9;
											_bomb setVectorUp [0,_v,-1];
											_bomb setVelocity[0,0,_v];
											sleep 0.1;
											//_bomb = "R_230mm_HE" createVehicle _pos;
											_bomb = "Sh_155mm_AMOS" createVehicle _pos;
											_bomb hideObjectGlobal true;
											_bomb setVectorUp [0,_v,-1];
											_bomb setVelocity[0,0,_v];
										};
									};
								}
							];
							//_m = createMarker [(str(getObjectID _x)), getPos _x];
							//_m setMarkerType "hd_dot";
							//_m setMarkerColor "colorred";
						};
					} forEach _fuelTanks;
				};
			};
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// MAP MARKERS FOR PLAYERS(by Moerderhoschi) - v2025-02-08
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pPlayerMapMarkers",0] == 1) then
{
	if (isServer) then
	{
		0 spawn
		{
			sleep (1 + random 3);
			_delMarkers = {for "_i" from 1 to 100 do {call compile format ["deleteMarker ""playerMapMarkersGlobal%1""",_i]}};
			while {sleep 0.5; missionNameSpace getVariable ["pPlayerMapMarkers",0] == 1} do
			{
				call _delMarkers;
				_v = [];
				_i = 1;
				{
					if (!(vehicle _x in _v)) then
					{
						_v pushBack (vehicle _x);
						_m = createMarker [format["playerMapMarkersGlobal%1",_i], getPosASL vehicle _x];
						_m setMarkerType "hd_dot";
						_m setMarkerColor "colorblue";
						_i = _i + 1;

						if (vehicle _x != _x) then
						{
							_s = getText(configfile >> "CfgVehicles" >> (typeof vehicle _x) >> "displayName");
							_c = count crew vehicle _x;
							if (_c > 1) then
							{
								_m setMarkerText (_s + " : " + name((crew vehicle _x)#0) + " +" + str(_c-1));
							}
							else
							{
								_m setMarkerText (_s + " : " + name((crew vehicle _x)#0));
							};
						}
						else
						{
							_m setMarkerText name _x;
						};
					};
				} forEach allPlayers;
			};
			call _delMarkers;
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// FOGGY BREATH FOR ALL UNITS(original script by tpw) - v2025-02-08
// https://forums.bohemia.net/forums/topic/109151-simple-breath-fog-script/
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pFoggyBreath",0] == 1) then
{
	if (!isDedicated) then
	{
		0 spawn
		{
			sleep (1 + random 2);
			_c = false;
			if (missionNameSpace getVariable ["pFoggyBreathTimeDependency",0] == 1) then
			{
				if (date#1 in [1,2,12]) then // Dec, Jan, Feb
				{
					_c = true;
				};
			}
			else
			{
				_c = true;
			};
			if (_c) then
			{
				while {missionNameSpace getVariable ["pFoggyBreath",0] == 1} do
				{
					_c = false;
					if (missionNameSpace getVariable ["pFoggyBreathTimeDependency",0] == 1) then
					{
						if (date#3>=18 or date#3<=7) then // 18 to 7 o clock
						{
							_c = true;
						};
					}
					else
					{
						_c = true;
					};
					
					if (_c) then
					{
						{
							if (!(_x getVariable ["foggyBreath",false])) then
							{
								_x setVariable ["foggyBreath",true];
								_x spawn 
								{
									_unit = _this;
									_source = player;
									while {sleep (2 + random 2); alive _unit && _unit getVariable ["foggyBreath",false]} do
									{
										_c = false;
										if (date#3>=18 or date#3<=7) then {_c = true};
										if (missionNameSpace getVariable ["pFoggyBreathTimeDependency",0] == 0) then {_c = true};
										if
										(
											_c // 0.0008
											&& {!underwater _unit} // 0.0003
											&& {lifeState _unit != "INCAPACITATED"} // 0.0004
											&& {vehicle _unit == _unit} // 0.0005
											&& {vehicle _unit distance vehicle player < (if(viewDistance < 1500)then{viewDistance}else{1500})} // 0.003
											//&& {player getRelDir _unit < 90 or player getRelDir _unit > 270} // 0.003
											&& {(if(_unit==player)then{1}else{[vehicle player,"VIEW",vehicle _unit]checkVisibility[eyePos player,eyepos _unit]}) > 0} // 0.005
										)
										then
										{
											//_source = "logic" createVehicleLocal (getpos _unit);
											if (_source == player) then
											{
												_source = createSimpleObject ["logic", getPosWorld _unit, true];
												_source attachto [_unit,[0,0.15,0],"neck"];
											};
											_fog = "#particlesource" createVehicleLocal getpos _source;
											_fog setParticleParams [["A3\Data_F\ParticleEffects\Universal\Universal", 16, 12, 13,0],
											"","Billboard",0.5,0.5,[0,0,0],[0,0.2,-0.2],1,1.275,1,0.2,[0,0.2,0],[[1,1,1,0.03],[1,1,1,0.01],
											[1,1,1,0]],[1000],1,0.04,"","",_source];
											_fog setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
											_fog setDropInterval 0.001;
											sleep 0.5;
											deleteVehicle _fog;
										};
									};
									deletevehicle _source;
									_unit setVariable ["foggyBreath",nil];
								};
							};
						} foreach allUnits;
					};
					sleep (30 + random 3);
				};
			};
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// DISABLE FATIGUE SYSTEM(by Moerderhoschi) - v2025-02-08
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pDisableFatigue",0] == 1) then
{
	if (!isDedicated) then
	{
		0 spawn
		{
			sleep (1 + random 1);
			while {missionNameSpace getVariable ["pDisableFatigue",0] == 1} do
			{
				player enableFatigue false;
				sleep (4 + random 1);
			};
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// SET PLAYER CUSTOM AIM COEF(by Moerderhoschi) - v2025-02-08
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pCustomAimCoef",0] == 1) then
{
	if (!isDedicated) then
	{
		0 spawn
		{
			sleep (1 + random 3);
			while {missionNameSpace getVariable ["pCustomAimCoef",0] == 1} do
			{
				if (getCustomAimCoef player > 0.15) then
				{
					player setCustomAimCoef 0.15;
				};
				sleep (4 + random 1);
			};
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// INFLAME FIREPLACES AT NIGHTTIME(by Moerderhoschi) - v2025-02-08
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pInflameFiresAtNight",0] == 1) then
{
	if (isServer) then
	{
		0 spawn
		{
			sleep (1 + random 2);
			
			_l = false;
			{if (isLightOn _x && {({_x in allPlayers} count crew _x) < 1}) then {_l = true}} forEach vehicles;
			if (dayTime > 20.5 OR {dayTime < 3.5} OR {_l}) then
			{
				{
					if (typeOf _x in ["Land_FirePlace_F","Land_Campfire_F","Land_Campfire"]) then
					{
						_x inflame true;
					};
				} forEach (allMissionObjects "all");

				//_factor = 100;
				//_worldSize = if (worldSize > 30000) then {30000} else {worldSize};
				_firePlaceTypes = ["Land_FirePlace_F","Land_Campfire_F","Land_Campfire"];
				//for "_i1" from 0 to ceil(_worldSize/100) do
				//{
				//	for "_i2" from 0 to ceil(_worldSize/100) do
				//	{
				//		_firePlaces = (nearestObjects [[_i1*_factor,_i2*_factor],_firePlaceTypes,_factor]);
				//		{
				//			_x inflame true;
				//		} forEach _firePlaces;
				//	};
				//};
			};
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// REPLACE RPG18 WITH RPG-7(by Moerderhoschi) - v2025-02-08
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pReplaceRPG18",0] == 1) then
{
	if (isServer) then
	{
		0 spawn
		{
			sleep (2 + random 2);
			while {missionNameSpace getVariable ["pReplaceRPG18",0] == 1} do
			{
				{
					if (alive _x && {"CUP_launch_RPG18_Loaded" in weapons _x} && {!(_x in allPlayers)}) then
					{
						_x removeWeapon "CUP_launch_RPG18_Loaded";
						_x addWeapon "CUP_launch_RPG7V";
						_x addWeaponItem ["CUP_launch_RPG7V", "CUP_PG7V_M", true];
					};
				} forEach allUnits;

				{
					if
					(
						(
							"CUP_launch_RPG18" in ((getWeaponCargo _x)#0)
							or "CUP_launch_RPG18_Loaded" in ((getWeaponCargo _x)#0)
						)
						&& {!("CUP_launch_RPG7V" in ((getWeaponCargo _x)#0))}
					)
					then
					{
						if (!(_x getVariable ["mdhReplaceRPG18Set",false])) then
						{
							_x setVariable ["mdhReplaceRPG18Set",true];
							_x addWeaponCargoGlobal ["CUP_launch_RPG7V", 2];
							_x addMagazineCargoGlobal ["CUP_PG7V_M", 6];
						};
					};
				} forEach vehicles;
				sleep (4 + random 2);
			};
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// REPLACE AI MAGS WITH TRACER(by Moerderhoschi) - v2025-02-08
// github: https://github.com/Moerderhoschi/arma3_mdhAiTracer
// steam mod version: https://steamcommunity.com/sharedfiles/filedetails/?id=3437872589
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pReplaceAiMagsWithTracer",0] == 1) then
{
	if (isServer) then
	{
		0 spawn
		{
			sleep (1 + random 2);
			while {missionNameSpace getVariable ["pReplaceAiMagsWithTracer",0] == 1} do
			{
				{
					if (!(_x getVariable ["mdhReplaceAiMagsWithTracerSet",false])) then
					{
						if (!(_x in allPlayers) && {primaryWeapon _x != ""}) then
						{
							_x setVariable ["mdhReplaceAiMagsWithTracerSet",true];
							_u = _x;
							_tracerMags = [];
							{
								if ("tracer" in (toLowerANSI(_x))) then {_tracerMags pushBack _x};
							} forEach compatibleMagazines [currentWeapon _u, "this"];
				
							if (count _tracerMags > 0) then
							{
								{_u removeMagazines _x} forEach compatibleMagazines [currentWeapon _u, "this"];
								_u addPrimaryWeaponItem _tracerMags#0;
								for "_i" from 1 to 6 do {_u addMagazine _tracerMags#0};
							};
						};
					};
				} forEach allUnits;
				sleep (7 + random 3);
			};
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// AVOID AI LAYING DOWN(by Moerderhoschi) - v2025-02-08
// github: https://github.com/Moerderhoschi/arma3_mdhAiAvoidLaydown
// steam mod version: https://steamcommunity.com/sharedfiles/filedetails/?id=3438379619
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pAvoidAiLayingDown",0] == 1) then
{
	if (isServer) then
	{
		0 spawn
		{
			sleep (2 + random 2);
			while {sleep 1; missionNameSpace getVariable ["pAvoidAiLayingDown",0] == 1} do
			{
				//systemChat ("start: "+str(time));
				{
					if (alive _x && {vehicle _x == _x} && {!(_x in allPlayers)}) then
					{
						if (behaviour _x == "COMBAT") then
						{
							if (speed _x < 1) then {_x setUnitPos "MIDDLE"} else {_x setUnitPos "UP"}
						}
						else
						{
							_x setUnitPos "AUTO";
						};
					};
					//sleep 0.01;
				} foreach allUnits;
				//systemChat ("end: "+str(time));
			};
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// AVOID AI FLEEING(by Moerderhoschi) - v2025-02-08
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pAvoidAiFleeing",0] == 1) then
{
	if (isServer) then
	{
		0 spawn
		{
			sleep (2 + random 3);
			while {missionNameSpace getVariable ["pAvoidAiFleeing",0] == 1} do
			{
				{_x allowFleeing 0} forEach allGroups;
				sleep (12 + random 3);
			};
		};
	};
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// AI UNITS GET MORE DAMAGE AT HIT & AI UNITS GET RAGDOLL EFFECT AT HIT(by Moerderhoschi) - v2025-02-08
// github: https://github.com/Moerderhoschi/arma3_mdhRagdoll
// steam mod version: https://steamcommunity.com/sharedfiles/filedetails/?id=3387437564
///////////////////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pAiGetMoreDamageAtHit",0] == 1 OR missionNameSpace getVariable ["pAiRagdollAtHit",0] == 1) then
{
	if (isServer) then
	{
		0 spawn
		{
			//systemChat ("Ragdoll start Timeout");
			sleep (2 + random 3);
			//systemChat ("Ragdoll start");
			while {missionNameSpace getVariable ["pAiGetMoreDamageAtHit",0] == 1 OR missionNameSpace getVariable ["pAiRagdollAtHit",0] == 1} do
			{
				{
					if (local _x && {alive _x} && {(_x getVariable ["mdhEnemyDamageEhForceSet",-1]) == -1} && {!(_x in allPlayers)}) then
					{
						//systemChat ("Ragdoll added to "+str(_x));
						_x setVariable ["mdhEnemyDamageEhForceSet",
						_x addEventHandler ["HandleDamage",
						{
							params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];
							if (missionNameSpace getVariable ["pAiRagdollAtHit",0] == 1) then
							{
								_u = _unit;
								_s = _source;
								_v = getPosASL _s vectorFromTo getPosASL _u;
								_f = [(_v#0) * 1, (_v#1) * 1, 0];
				
								if (_selection == "body" && {vehicle _u == _u} && {_directHit} && {lifeState _u != "INCAPACITATED"}) then
								{
									if (!(_u getVariable ["mdhEnemyDamageEhForceHit",false])) then
									{
										_u setVariable ["mdhEnemyDamageEhForceHit",true];
										[_u, _f, _selection] spawn
										{
											_u = _this#0;
											_f = _this#1;
											_selection = _this#2;
											sleep 0.1;
											if (alive _u) then
											{
												_u addForce [_u vectorModelToWorld _f, _u selectionPosition _selection, true];
												sleep 3;

												if (0.2 > random 1) then
												{
													sleep 10; 
													sleep random 5;
													_u setUnconscious false;
													sleep 5;
													_u setVariable ["mdhEnemyDamageEhForceHit",false];
													_u playMove "AmovPknlMstpSrasWrflDnon";
												}
												else
												{
													_u disableConversation true;
													_u setvariable ["bis_nocoreconversations",true];											
													_u disableAI "FSM";
													_u disableAI "RADIOPROTOCOL";
													sleep 120;
													sleep random 180;
													_u setDamage 1;
												};
											};
										};
									};
								};
							};
		
							if (!alive _u) then 
							{
								_u removeEventHandler ["HandleDamage", (_u getVariable ["mdhEnemyDamageEhForceSet",-1])];
								_u setVariable ["mdhEnemyDamageEhForceSet",nil];
							};
		
							if (missionNameSpace getVariable ["pAiGetMoreDamageAtHit",0] == 1) then {_damage * 2}
						}]];
						sleep 0.02;
					};
				} forEach allUnits;
				sleep (4 + random 2);
			}
			//systemChat ("Ragdoll End");
		};
	};
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// MDH REVIVE FOR ALL PLAYERS(by Moerderhoschi) - v2025-02-09
// github: https://github.com/Moerderhoschi/arm3_mdhRevive
// steam:  https://steamcommunity.com/sharedfiles/filedetails/?id=3435005893
///////////////////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pMdhRevive",0] > 0 && {isMultiplayer}) then
{
	0 spawn
	{
		sleep (1 + random 1);
		bis_reviveParam_mode = 1;
		bis_revive_unconsciousStateMode = 0;
		_p = missionNameSpace getVariable ["pMdhRevive",0];
		mdhReviveAutoReviveTime = missionNameSpace getVariable["pMdhReviveAutoReviveTime", 240];
		sleep 0.5;
		if (!isDedicated) then {call BIS_fnc_reviveInit};
		sleep 1;
		bis_revive_duration = 5;
		bis_revive_durationmedic = 2;
		bis_revive_medicspeedmultiplier = 3;
		bis_revive_bleedoutduration = missionNameSpace getVariable["pMdhReviveBleedoutTime", 4^9];
		if (_p == 2) exitWith {bis_revive_bleedoutduration = 300};
		if (!isDedicated) then 
		{
			player setVariable ["mdhRevivePlayerSide",(side group player)];
			player setVariable ["mdhRevived",false,true];
			sleep 0.5;
			if (animationState player in["acinpknlmstpsraswrfldnon","acinpknlmwlksraswrfldb","acinpknlmstpsnonwpstdnon","acinpknlmwlksnonwpstdb"]) then {player switchMove ""};
			_mdhDragging = 
			{
				if (player getVariable ["mdhReviveDraged",false]) then
				{
					_dragger = player getVariable ["mdhReviveDragedBy",objNull];
					if (player getVariable ["mdhReviveDragInit",false] && {_dragger getVariable ["mdhReviveDragging",false]}) then
					{
						player setVariable ["mdhReviveDragInit",false,true];
						player attachTo [_dragger,[0,1.5,0]];
						player setDir 180;
					};
					if
					(
						!(player getVariable ["mdhReviveDraged",false])
						OR {!(lifeState _dragger in ["HEALTHY","INJURED"])}
						OR {!(_dragger in allPlayers)}
						OR {lifeState player != "INCAPACITATED"}
						OR {player getVariable ["mdhRevived",false]}
					)
					then
					{
						player setVariable ["mdhReviveDraged",false,true];
						detach player;
					};
				};
			};
			while{sleep 0.3; true}do
			{
				waitUntil
				{
					sleep 0.01;
					{
						if (_x != player) then
						{
							_player = _x;
							{
								if (count(_player actionParams _x) > 2) then
								{
									if (typeName(_player actionParams _x select 2) == "ARRAY") then
									{
										if (count(_player actionParams _x select 2) > 12 ) then
										{
											if ("bis_reviveTextures2d_unconscious" in str(_player actionParams _x select 2 select 12)) then
											{
												_player removeAction _x;
											};
										};
									};
								}
							} forEach (actionIDs _player);
						};
					} forEach allPlayers;
	
					{
						if (_x != player) then
						{
							_player = _x;
							_f = (actionIDs _player findIf { ">Revive " in (_player actionParams _x select 0) }) != -1;
	
							if (!_f && {_x getVariable ["mdhRevivePlayerName",""] != ""}) then
							{
								[
									_x,
									("Revive " + name _x),
									//("<t color=""#FF0000"">Revive "+(name _x)+"</t>"),
									"a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
									"a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
									"lifeState _target == ""INCAPACITATED"" 
									&& {player distance _target < 3}
									&& {!(_target getVariable [""mdhReviveDraged"",false])}
									",
									"true",
									{},
									{},
									{_target setVariable ["mdhRevivedBy",player,true];_target setVariable ["mdhRevived",true,true]}
									,{}
									,[]
									,3
									,99
									,false
									,false
								] call BIS_fnc_holdActionAdd;
							};
						};
					} forEach allPlayers;
	
					{
						if (_x != player) then
						{
							_player = _x;
							_f = (actionIDs _player findIf { "Drag " in (_player actionParams _x select 0) }) != -1;
	
							if (!_f && {_x getVariable ["mdhRevivePlayerName",""] != ""}) then
							{
								_x addAction
								[
									("<t color=""#FF0000"">Drag "+(name _x)+"</t>"),
									{
										params ["_target"];
										if (currentWeapon player == handgunWeapon player) then
										{
											player playMoveNow "acinpknlmstpsnonwpstdnon"; // pistol
										}
										else
										{
											player playMoveNow "acinpknlmstpsraswrfldnon"; // rifle
										};
										player setVariable ["mdhReviveDragging",true,true];
										_target setVariable ["mdhReviveDragInit",true,true];
										_target setVariable ["mdhReviveDraged",true,true];
										_target setVariable ["mdhReviveDragedBy",player,true];
										_target spawn
										{
											sleep 2;
											waitUntil
											{
												sleep 0.2;
												!(_this getVariable ["mdhReviveDraged",false])
												OR !(lifeState player in ["HEALTHY","INJURED"])
												OR lifeState _this != "INCAPACITATED"
												OR {_x isKindOf "man"} count attachedObjects player < 1
											};
											player setVariable ["mdhReviveDragging",false,true];
											for "_i" from 1 to 9 do
											{
												if (animationState player in["acinpknlmstpsraswrfldnon","acinpknlmwlksraswrfldb","acinpknlmstpsnonwpstdnon","acinpknlmwlksnonwpstdb"]) then {player switchMove ""};
												sleep 0.3;
											};
										};
									},0,98,true,false,""
									,"lifeState _target == ""INCAPACITATED""
									&& {vehicle player == player}
									&& {!(_target getVariable [""mdhReviveDraged"",false])}
									&& {time > _target getVariable [""mdhReviveDragEnableTime"",time + 5]}
									&& {_target in allPlayers}
									"
									,3,false
								];
							};
						};
					} forEach allPlayers;
					
					_f = (actionIDs player findIf { "Stop Drag" in (player actionParams _x select 0) }) != -1;
					if (!_f) then
					{
						player addAction
						[
							("<t color=""#FF0000"">Stop Drag</t>"),
							{
								{if(_x isKindOf "man")then{detach _x;_x setVariable ["mdhReviveDraged",false,true]}}forEach attachedObjects player;
								player setVariable ["mdhReviveDragging",false,true];
								for "_i" from 1 to 4 do
								{
									if (animationState player in["acinpknlmstpsraswrfldnon","acinpknlmwlksraswrfldb","acinpknlmstpsnonwpstdnon","acinpknlmwlksnonwpstdb"]) then {player switchMove ""};
									sleep 0.5;
								};
							},0,98,true,false,""
							,"vehicle player == player && {player getVariable [""mdhReviveDragging"",false]} && {{_x isKindOf ""man""} count attachedObjects player > 0}"
							,3,false
						];
					};
	
					if (player getVariable ["mdhRevivePlayerName",""] == "") then {player setVariable ["mdhRevivePlayerName",name player,true]};
					call _mdhDragging;
	
					lifeState player == "INCAPACITATED"
				};
				player allowDamage false;
				player setVariable["mdhReviveDragEnableTime",time + 5,true];
				_endTime = time + 3 + mdhReviveAutoReviveTime;
				_side = player getVariable ["mdhRevivePlayerSide",west];
				if (missionNameSpace getVariable["pMdhReviveSpectator", 1] == 1) then
				{
					if (name player == "Moerderhoschi") then
					{
						["Initialize",[player,[]             ,true   ,true           ,true          ,false        ,true             ,false             ,true      ,true]]call BIS_fnc_EGSpectator;
					}
					else
					{
						["Initialize",[player,[_side]        ,false  ,true           ,true          ,false        ,true             ,false             ,true      ,true]]call BIS_fnc_EGSpectator;
					};
				};
				sleep 0.1;
				_cam = nearestObject [player, "CamCurator"];
				_cam setPos (_cam modelToWorld [0,-5,0]);
				if (!isNil"bis_revive_ppColor") then {bis_revive_ppColor ppEffectEnable false};
				if (!isNil"bis_revive_ppVig") then {bis_revive_ppVig ppEffectEnable false};
				if (!isNil"bis_revive_ppBlur") then {bis_revive_ppBlur ppEffectEnable false};

				sleep 1;
				waitUntil
				{
					if (!isNil"bis_revive_ppColor") then {bis_revive_ppColor ppEffectEnable false};
					if (!isNil"bis_revive_ppVig") then {bis_revive_ppVig ppEffectEnable false};
					if (!isNil"bis_revive_ppBlur") then {bis_revive_ppBlur ppEffectEnable false};
	
					if (_endTime - time < 601 && {round(_endTime - time) mod 20 == 0}) then
					{
						systemChat("Automatic Revive in "+str(round(_endTime - time))+" seconds")
					};
	
					sleep 0.1;
					{
						if (count (player actionParams _x) > 2) then
						{
							if (typeName(player actionParams _x select 2) == "ARRAY" ) then
							{
								if (count(player actionParams _x select 2) > 12 ) then
								{
									if ("bis_reviveTextures2d_unconscious" in str(player actionParams _x select 2 select 12)) then
									{
										player removeAction _x;
									};
								};
							};
						};
					} forEach actionIDs player;
					
					sleep 0.3;
					call _mdhDragging;
					sleep 0.3;
					call _mdhDragging;
					sleep 0.3;
	
					lifeState player != "INCAPACITATED" OR time > _endTime OR player getVariable ["mdhRevived",false]
				};
				player setVariable ["mdhRevived",false,true];
				if (lifeState player == "INCAPACITATED") then
				{
					if (time > _endTime) then
					{
						[objNull,[1,player], player] remoteExec ["bis_fnc_reviveOnState"];
					}
					else
					{
						[objNull,[1,player getVariable["mdhRevivedBy",player]], player] remoteExec ["bis_fnc_reviveOnState"];
					};
				};
				["Terminate"] call BIS_fnc_EGSpectator;
				player allowDamage true;
				sleep 0.2;
				player setUnconscious false;
			};
		};
	};
};


///////////////////////////////////////////////////////////////////////////////////////////////////////////
// MDH SEARCH AND DESTROY PLAYERS FUNCTION(by Moerderhoschi) - v2025-02-11
// mdhSADflares=true;0 spawn{{if(vehicle _x == _x)then{sleep 0.5;[_x,1]spawn mdhSADfunc}}forEach units east}
///////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isServer) then
{
	mdhSADfunc =
	{
		_unit = _this#0;
		_parm = _this#1;

		if (!local _unit) exitWith {};
		_g = group _unit;
		if (_g getVariable["mdhSADfuncActive",false]) exitWith {};
		_g setVariable["mdhSADfuncActive",true];
		_g setSpeedMode "LIMITED";
		_g setBehaviourStrong "SAFE";
		//systemChat ("mdhSAD "+str(_g)+" active mode "+str(_parm));
		_sleep = 6;

		if (_parm != 0) then
		{
			waitUntil{sleep 5; !isNil "mdhAlert"};
			sleep 3 + random 3;
		};

		while{(count units _g) > 0} do
		{
			_leader = leader _g;
			_target = selectRandom allPlayers;

			if (missionNameSpace getVariable ["mdhSADflares",false]) then
			{
				if (!isNil"mdhAlert") then
				{
					if
					(
						missionNameSpace getVariable ["mdhSADflareTime",0] < time 
						&& {lifeState _leader in ["HEALTHY","INJURED"]} 
						&& {date#3>18 or date#3<7} 
						&& {_leader distance _target < 300}
						&& {_leader distance _target > 150}
					)
					then
					{
						_lpos = getPosWorld _leader;
						_x = _lpos#0;
						_y = _lpos#1;
						_flare = "F_40mm_Yellow" createVehicle [_x + 50 - (random 100), _y + 50 - (random 100), 175 + random 25];
						_flare setVelocity [2 - random 4, 2 - random 4, -5];
						tmpFlare = _flare;
						missionNameSpace setVariable ["mdhSADflareTime",time+100];
					};
				};
			};

			_pos = getPosWorld vehicle _target;
			_pos = [_pos#0, _pos#1];
			_g move _pos;
			//systemChat ("mdhSAD "+str(_g)+" move to player");
			
			for "_i" from 1 to (30 + ceil(random 5)) do
			{
				sleep _sleep;
				if (!isNil"mdhAlert" && {_sleep == 6}) then
				{
					_g setSpeedMode "NORMAL";
					_g setBehaviourStrong "AWARE";
					_sleep = 2;
				};
			};
		};
	};
};
