/////////////////////////////////////////////////////////////////////////////////////
// MDH Mission Enhancements scripts for Arma missions(by Moerderhoschi) - v2025-04-21
// github: https://github.com/Moerderhoschi/arma3_mdhMissionEnhancements
// steam:  https://steamcommunity.com/sharedfiles/filedetails/?id=3439120487
/////////////////////////////////////////////////////////////////////////////////////
pParamPreset                 = ["pParamPreset",                 0] call BIS_fnc_getParamValue; // MDH MISSION PARAMETERS PRESET
pRandomTime                  = ["pRandomTime",                  1] call BIS_fnc_getParamValue; // RANDOM MISSION STARTTIME
pDisableFatigue              = ["pDisableFatigue",              1] call BIS_fnc_getParamValue; // DISABLE FATIGUE SYSTEM (LOOP)
pCustomAimCoef               = ["pCustomAimCoef",               1] call BIS_fnc_getParamValue; // SET PLAYER CUSTOM AIM COEF (LOOP)
pPlayerMapMarkers            = ["pPlayerMapMarkers",            1] call BIS_fnc_getParamValue; // MAP MARKERS FOR PLAYERS (LOOP)
pPlayerSetUnitTrait          = ["pPlayerSetUnitTrait",          1] call BIS_fnc_getParamValue; // SET PLAYER UNITTRAITS (LOOP)
pMdhFPVDroneRPG              = ["pMdhFPVDroneRPG",              1] call BIS_fnc_getParamValue; // ENABLE PLAYER TO CREATE RPG DRONES (LOOP)
pFoggyBreath                 = ["pFoggyBreath",                 1] call BIS_fnc_getParamValue; // FOGGY BREATH FOR ALL UNITS (LOOP)
pFoggyBreathTimeDependency   = ["pFoggyBreathTimeDependency",   1] call BIS_fnc_getParamValue; // FOGGY BREATH WITH TIME DEPENDENCY 18 TO 7 O CLOCK (LOOP)
pDisableRadioMessages        = ["pDisableRadioMessages",        1] call BIS_fnc_getParamValue; // DISABLE RADIO MESSAGES TO BE HEARD AND SHOWN IN THE LEFT LOWER CORNER
pDisableConversation         = ["pDisableConversation",         1] call BIS_fnc_getParamValue; // SCRIPT TO DISABLE ALL CONVERSATIONS (LOOP)
pAvoidAiFleeing              = ["pAvoidAiFleeing",              1] call BIS_fnc_getParamValue; // AVOID AI FLEEING (LOOP)
pAiStayLowInCombat           = ["pAiStayLowInCombat",           0] call BIS_fnc_getParamValue; // AI UNITS STAY LOW IN COMBAT (LOOP)
pAvoidAiLayingDown           = ["pAvoidAiLayingDown",           1] call BIS_fnc_getParamValue; // AVOID AI LAYING DOWN (LOOP)
pAiRagdollAtHit              = ["pAiRagdollAtHit",              1] call BIS_fnc_getParamValue; // AI UNITS GET RAGDOLL EFFECT AT HIT (LOOP)
pAiGetMoreDamageAtHit        = ["pAiGetMoreDamageAtHit",        0] call BIS_fnc_getParamValue; // AI UNITS GET MORE DAMAGE AT HIT (LOOP)
pReplaceAiMagsWithTracer     = ["pReplaceAiMagsWithTracer",     1] call BIS_fnc_getParamValue; // REPLACE AI MAGS WITH TRACER (LOOP)
pReplaceRPG18                = ["pReplaceRPG18",                1] call BIS_fnc_getParamValue; // REPLACE RPG18 WITH RPG-7 (LOOP)
pFunBarrles                  = ["pFunBarrles",                  1] call BIS_fnc_getParamValue; // FUN BARRELS WITH EXPLOSIONS AND FLYING AROUND (LOOP)
pVehiclesBigExplosions       = ["pVehiclesBigExplosions",       1] call BIS_fnc_getParamValue; // VEHICLES BIG EXPLOSIONS (LOOP)
pFuelTanksBigExplosions      = ["pFuelTanksBigExplosions",      1] call BIS_fnc_getParamValue; // FUELTANKS BIG EXPLOSIONS
pInflameFiresAtNight         = ["pInflameFiresAtNight",         0] call BIS_fnc_getParamValue; // INFLAME FIREPLACES AT NIGHTTIME
pMdhRevive                   = ["pMdhRevive",                   1] call BIS_fnc_getParamValue; // MDH REVIVE FOR ALL PLAYERS (LOOP)
pMdhReviveBleedoutTime       = ["pMdhReviveBleedoutTime",     4^9] call BIS_fnc_getParamValue; // MDH REVIVE BLEEDOUT TIME FOR ALL PLAYERS (LOOP)
pMdhReviveAutoReviveTime     = ["pMdhReviveAutoReviveTime",   240] call BIS_fnc_getParamValue; // MDH AUTO REVIVE TIME FOR ALL PLAYERS (LOOP)
pMdhReviveSpectator          = ["pMdhReviveSpectator",          1] call BIS_fnc_getParamValue; // MDH REVIVE SPECTATOR FOR INCAPACITATED PLAYERS (LOOP)
pMdhBRIM                     = ["pMdhBRIM",                     1] call BIS_fnc_getParamValue; // ENABLE MDH BOHEMIA REVIVE ICON MARKER (LOOP)
pCheckAllPlayerIncapacitated = ["pCheckAllPlayerIncapacitated", 0] call BIS_fnc_getParamValue; // CHECK IF ALL PLAYERS ARE INCAPACITATED AND END MISSION (LOOP)

/////////////////////////////////////////////////////////////////////////////////////////////
// RANDOM MISSION STARTTIME - v2025-04-06
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pRandomTime",0] > 0) then
{
	if (isServer) then
	{
		_rY = date#0;
		//_rM = 1;
		_rM = date#1;
		_rD = date#2;
		_e = date call BIS_fnc_sunriseSunsetTime;
		_a = floor(_e#0);
		_b = ((_e#0) - _a) * 60;
		_c = _b + 20;
		_d = floor(_e#1);
		_e = ((_e#1) - _d) * 60;
		_rH = missionNameSpace getVariable["pRandomTimeHour",selectRandom[0,_a,7,15,_d]];
		_rMin = missionNameSpace getVariable["pRandomTimeMinute",selectRandom[(random 59)]];

		switch pRandomTime do
		{
			case 1: { _p = [_rY,_rM,_rD,_rH,_rMin +ceil random 5]; [_p] remoteExec ["setDate"]}; // Random
			case 2: { _p = [_rY,_rM,_rD, _a,                  _b]; [_p] remoteExec ["setDate"]}; // Early Morning
			case 3: { _p = [_rY,_rM,_rD, _a,                  _c]; [_p] remoteExec ["setDate"]}; // Morning
			case 4: { _p = [_rY,_rM,_rD, 12,      ceil random 59]; [_p] remoteExec ["setDate"]}; // Noon
			case 5: { _p = [_rY,_rM,_rD, _d,                  _e]; [_p] remoteExec ["setDate"]}; // Sundown
			case 6: { _p = [2005,01, 12, 00,                  00]; [_p] remoteExec ["setDate"]}; // fullMoon
			case 7: { _p = [2005,01, 20, 02,                  00]; [_p] remoteExec ["setDate"]}; // darkNight
			default { }
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// DISABLE RADIO MESSAGES TO BE HEARD AND SHOWN IN THE LEFT LOWER CORNER - v2025-02-12
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pDisableRadioMessages",0] == 1 && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then {enableRadio false};

/////////////////////////////////////////////////////////////////////////////////////////////
// SCRIPT TO DISABLE ALL CONVERSATIONS - v2025-02-08
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pDisableConversation",0] == 1 && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
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
if (missionNameSpace getVariable ["pCheckAllPlayerIncapacitated",0] == 1 && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
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
if (missionNameSpace getVariable ["pFunBarrles",0] == 1 && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
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
if (missionNameSpace getVariable ["pVehiclesBigExplosions",0] == 1 && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
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
if (missionNameSpace getVariable ["pFuelTanksBigExplosions",0] == 1 && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
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
if (missionNameSpace getVariable ["pPlayerMapMarkers",0] == 1 && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
{
	if (hasInterface) then
	{
		0 spawn
		{
			sleep (1 + random 3);
			_delMarkers = {for "_i" from 1 to 100 do {call compile format ["deleteMarkerLocal ""playerMapMarkersLocal%1""",_i]}};
			while {missionNameSpace getVariable ["pPlayerMapMarkers",0] == 1} do
			{
				call _delMarkers;
				_v = [];
				_i = 1;
				{
					if (!(vehicle _x in _v)) then
					{
						_v pushBack (vehicle _x);
						_m = createMarkerLocal [format["playerMapMarkersLocal%1",_i], getPosWorld vehicle _x];
						_m setMarkerTypeLocal "hd_dot";
						_m setMarkerColorLocal "ColorBLUE";
						_i = _i + 1;

						if (vehicle _x != _x) then
						{
							_s = getText(configfile >> "CfgVehicles" >> (typeof vehicle _x) >> "displayName");
							_c = count crew vehicle _x;
							if (_c > 1) then
							{
								_m setMarkerTextLocal (_s + " : " + name((crew vehicle _x)#0) + " +" + str(_c-1));
							}
							else
							{
								_m setMarkerTextLocal (_s + " : " + name((crew vehicle _x)#0));
							};
						}
						else
						{
							_m setMarkerTextLocal name _x;
							if ((lifeState _x) == "INCAPACITATED") then
							{
								_m setMarkerTextLocal ("(Uncon) " + name _x);
							};
						};
					};
				} forEach allPlayers;
				sleep 0.5;
			};
			call _delMarkers;
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// FOGGY BREATH FOR ALL UNITS(original script by tpw) - v2025-02-08
// https://forums.bohemia.net/forums/topic/109151-simple-breath-fog-script/
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pFoggyBreath",0] == 1 && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
{
	if (hasInterface) then
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
					_sunSet = date call BIS_fnc_sunriseSunsetTime;
					_sunRise = (_sunSet#0) + 1.5;
					_sunSet = (_sunSet#1) - 0.5;
					_c = false;
					if (missionNameSpace getVariable ["pFoggyBreathTimeDependency",0] == 1) then
					{
						if (dayTime > _sunSet OR {dayTime < _sunRise}) then
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
									_sunSet = date call BIS_fnc_sunriseSunsetTime;
									_sunRise = (_sunSet#0) + 1.5;
									_sunSet = (_sunSet#1) - 0.5;									
									while {sleep (2 + random 2); alive _unit && _unit getVariable ["foggyBreath",false]} do
									{
										_c = false;
										//if (date#3>=18 or date#3<=7) then {_c = true};
										if (dayTime > _sunSet OR {dayTime < _sunRise}) then {_c = true};
										if (missionNameSpace getVariable ["pFoggyBreathTimeDependency",0] == 0) then {_c = true};
										if
										(
											_c // 0.0008
											&& {!underwater _unit} // 0.0003
											&& {insideBuilding _unit == 0} // 0.0003
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
// SET PLAYER CUSTOM AIM COEF(by Moerderhoschi) - v2025-02-08
// SET PLAYER UNITTRAITS(by Moerderhoschi) - v2025-03-09
/////////////////////////////////////////////////////////////////////////////////////////////
if
(
	(
		missionNameSpace getVariable ["pDisableFatigue",0] == 1
		OR {missionNameSpace getVariable ["pCustomAimCoef",0] == 1}
		OR {missionNameSpace getVariable ["pPlayerSetUnitTrait",0] == 1}
	)
	&& {missionNameSpace getVariable ["pParamPreset",0] == 0}
)
then
{
	if (hasInterface) then
	{
		0 spawn
		{
			sleep (1 + random 1);
			while
			{
				missionNameSpace getVariable ["pDisableFatigue",0] == 1
				OR {missionNameSpace getVariable ["pCustomAimCoef",0] == 1}
				OR {missionNameSpace getVariable ["pPlayerSetUnitTrait",0] == 1}
			}
			do
			{
				if (missionNameSpace getVariable ["pDisableFatigue",0] == 1) then
				{
					player enableFatigue false;
				};

				if (missionNameSpace getVariable ["pCustomAimCoef",0] == 1) then
				{
					if (getCustomAimCoef player > 0.15) then
					{
						player setCustomAimCoef 0.15;
					};
				};

				if (missionNameSpace getVariable ["pPlayerSetUnitTrait",0] == 1) then
				{
					player setUnitTrait ["engineer", true];            // Ability to partially repair vehicles with toolkit
					player setUnitTrait ["explosiveSpecialist", true]; // Ability to defuse mines with toolkit
					player setUnitTrait ["medic", true];               // Ability to treat self and others with medikit
					player setUnitTrait ["UAVHacker", true];           // Ability to hack enemy and friendly drones
				};

				sleep (4 + random 1);
			};
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// INFLAME FIREPLACES AT NIGHTTIME(by Moerderhoschi) - v2025-02-08
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pInflameFiresAtNight",0] == 1 && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
{
	if (isServer) then
	{
		0 spawn
		{
			sleep (1 + random 2);
			
			//_l = false;
			//{if (isLightOn _x && {({_x in allPlayers} count crew _x) < 1}) then {_l = true}} forEach vehicles;
			_sunSet = date call BIS_fnc_sunriseSunsetTime;
			_sunRise = (_sunSet#0) - 0.25;
			_sunSet = (_sunSet#1) + 0.25;
			//if (dayTime > 20.5 OR {dayTime < 3.5} OR {_l}) then
			if (dayTime > _sunSet OR {dayTime < _sunRise}) then
			{
				{
					if (typeOf _x in ["Land_FirePlace_F","Land_Campfire_F","Land_Campfire"]) then
					{
						_x inflame true;
					};
				} forEach (allMissionObjects "all");

				//_factor = 100;
				//_worldSize = if (worldSize > 30000) then {30000} else {worldSize};
				//_firePlaceTypes = ["Land_FirePlace_F","Land_Campfire_F","Land_Campfire"];
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
if (missionNameSpace getVariable ["pReplaceRPG18",0] == 1 && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
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
// MDH AI TRACER(by Moerderhoschi) - v2025-03-16
// github: https://github.com/Moerderhoschi/arma3_mdhAiTracer
// steam mod version: https://steamcommunity.com/sharedfiles/filedetails/?id=3437872589
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pReplaceAiMagsWithTracer",0] == 1 && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
{
	0 spawn
	{
		_valueCheck = 1;
		_defaultValue = 0;
		_path = 'mdhMissionEnhancements';
		_env  = isServer;

		_diary  = 0;
		_mdhFnc = 0;

		if (hasInterface) then
		{
			_diary =
			{
				waitUntil {!(isNull player)};
				_c = true;
				_t = "MDH AI Tracer";
				if (player diarySubjectExists "MDH Mods") then
				{
					{
						if (_x#1 == _t) exitWith {_c = false}
					} forEach (player allDiaryRecords "MDH Mods");
				}
				else
				{
					player createDiarySubject ["MDH Mods","MDH Mods"];
				};
			
				if(_c) then
				{
					player createDiaryRecord
					[
						"MDH Mods",
						[
							_t,
							(
							'<br/>MDH AI Tracer is a mod, created by Moerderhoschi for Arma 3.<br/>'
							+ '<br/>'
							+ 'Every AI units magazines get replaced with Tracer variants.<br/>'
							+ '<br/>'
							+ 'If you have any question you can contact me at the steam workshop page.<br/>'
							+ '<br/>'
							+ '<img image="'+_path+'\mdhAiTracer.paa"/><br/>'
							+ '<br/>'
							+ 'Credits and Thanks:<br/>'
							+ 'Armed-Assault.de Crew - For many great ArmA moments in many years<br/>'
							+ 'BIS - For ArmA3<br/>'
							)
						]
					]
				};
				true
			};
		};

		if (_env) then
		{
			_mdhFnc =
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
				
							if (count _tracerMags != 0) then
							{
								{_u removeMagazines _x} forEach compatibleMagazines [currentWeapon _u, "this"];
								_u addPrimaryWeaponItem _tracerMags#0;
								for "_i" from 1 to 6 do {_u addMagazine _tracerMags#0};
							};
						};
					};
				} forEach allUnits;
			};
		};

		if (hasInterface) then
		{
			uiSleep 2.1;;
			call _diary;
		};

		sleep (2 + random 2);
		while {missionNameSpace getVariable ["pReplaceAiMagsWithTracer",_defaultValue] == _valueCheck} do
		{
			if (_env) then {call _mdhFnc};
			sleep (5 + random 3);
			if (hasInterface) then {call _diary};
		};			
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// MDH AI AVOID LAYDOWN(by Moerderhoschi) - v2025-03-16
// github: https://github.com/Moerderhoschi/arma3_mdhAiAvoidLaydown
// steam mod version: https://steamcommunity.com/sharedfiles/filedetails/?id=3438379619
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pAvoidAiLayingDown",0] == 1 && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
{
	0 spawn
	{
		_valueCheck = 1;
		_defaultValue = 0;
		_path = 'mdhMissionEnhancements';
		_env  = isServer;

		_diary  = 0;
		_mdhFnc = 0;		
		
		if (hasInterface) then
		{
			_diary =
			{
				waitUntil {!(isNull player)};
				_c = true;
				_t = "MDH AI Avoid Laydown";
				if (player diarySubjectExists "MDH Mods") then
				{
					{
						if (_x#1 == _t) exitWith {_c = false}
					} forEach (player allDiaryRecords "MDH Mods");
				}
				else
				{
					player createDiarySubject ["MDH Mods","MDH Mods"];
				};
		
				if(_c) then
				{
					player createDiaryRecord
					[
						"MDH Mods",
						[
							_t,
							(
							  '<br/>MDH AI Avoid Laydown is a mod, created by Moerderhoschi for Arma 3.<br/>'
							+ '<br/>'
							+ 'This addon let AI units avoid to laydown on the ground.<br/>'
							+ '<br/>'
							+ 'If you have any question you can contact me at the steam workshop page.<br/>'
							+ '<br/>'
							+ '<img image="'+_path+'\mdhAiAvoidLayDown.paa"/><br/>'
							+ '<br/>'
							+ 'Credits and Thanks:<br/>'
							+ 'Armed-Assault.de Crew - For many great ArmA moments in many years<br/>'
							+ 'BIS - For ArmA3<br/>'
							)
						]
					]
				};
				true
			};
		};

		if (_env) then
		{
			_mdhFnc =
			{
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
				} foreach allUnits;
			};
		};

		if (hasInterface) then
		{
			uiSleep 2.4;
			call _diary;
		};

		_diaryTimer = 10;
		pAiStayLowInCombat = 0; // deact MDH AI Stay low in Combat Mod/script
		sleep (3 + random 2);
		while {missionNameSpace getVariable ["pAvoidAiLayingDown",_defaultValue] == _valueCheck} do
		{
			if (_env) then {call _mdhFnc};
			sleep 1;
			if (time > _diaryTimer && {hasInterface}) then {call _diary; _diaryTimer = time + 10};
			if (time > _diaryTimer) then {pAiStayLowInCombat = 0};
		};					
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// MDH AI STAY LOW IN COMBAT(by Moerderhoschi) - v2025-03-19
// github: https://github.com/Moerderhoschi/arma3_mdhAiStayLowInCombat
// steam mod version: https://steamcommunity.com/sharedfiles/filedetails/?id=3447902000
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pAiStayLowInCombat",0] == 1 && {missionNameSpace getVariable ["pAvoidAiLayingDown",0] == 0} && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
{
	0 spawn
	{
		_valueCheck = 1;
		_defaultValue = 0;
		_path = 'mdhMissionEnhancements';
		_env  = isServer;

		_diary  = 0;
		_mdhFnc = 0;		
		
		if (hasInterface) then
		{
			_diary =
			{
				waitUntil {!(isNull player)};
				_c = true;
				_t = "MDH AI Stay Low in Combat";
				if (player diarySubjectExists "MDH Mods") then
				{
					{
						if (_x#1 == _t) exitWith {_c = false}
					} forEach (player allDiaryRecords "MDH Mods");
				}
				else
				{
					player createDiarySubject ["MDH Mods","MDH Mods"];
				};
		
				if(_c) then
				{
					player createDiaryRecord
					[
						"MDH Mods",
						[
							_t,
							(
							  '<br/>MDH AI Stay Low in Combat is a mod, created by Moerderhoschi for Arma 3.<br/>'
							+ '<br/>'
							+ 'This addon let AI units stay low in combat situations.<br/>'
							+ '<br/>'
							+ 'If you have any question you can contact me at the steam workshop page.<br/>'
							+ '<br/>'
							+ '<img image="'+_path+'\mdhAiStayLowInCombat.paa"/><br/>'
							+ '<br/>'
							+ 'Credits and Thanks:<br/>'
							+ 'Armed-Assault.de Crew - For many great ArmA moments in many years<br/>'
							+ 'BIS - For ArmA3<br/>'
							)
						]
					]
				};
				true
			};
		};

		if (_env) then
		{
			_mdhFnc =
			{
				{
					if (alive _x && {vehicle _x == _x} && {!(_x in allPlayers)}) then
					{
						if (behaviour _x == "COMBAT") then
						{
							if (speed _x > 2) then {_x setUnitPos "MIDDLE"} else {_x setUnitPos "DOWN"}
						}
						else
						{
							_x setUnitPos "AUTO";
						};
					};
				} foreach allUnits;
			};
		};

		if (hasInterface) then
		{
			uiSleep 2.25;
			call _diary;
		};

		_diaryTimer = 10;
		sleep (3 + random 2);
		while {missionNameSpace getVariable ["pAiStayLowInCombat",_defaultValue] == _valueCheck && {missionNameSpace getVariable ["pAvoidAiLayingDown",0] == 0}} do
		{
			if (_env) then {call _mdhFnc};
			sleep (4 + random 2);
			if (time > _diaryTimer && {hasInterface}) then {call _diary; _diaryTimer = time + 10};
		};					
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// AVOID AI FLEEING(by Moerderhoschi) - v2025-02-08
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pAvoidAiFleeing",0] == 1 && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
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

///////////////////////////////////////////////////////////////////////////////////////////////////
// MDH BOHEMIA REVIVE ICON MARKER MOD(by Moerderhoschi) - v2025-04-03
// github: https://github.com/Moerderhoschi/arma3_mdhBRIM
// steam mod version: https://steamcommunity.com/sharedfiles/filedetails/?id=753249732
///////////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pMdhBRIM",0] == 1 && {isMultiplayer} && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
{
	0 spawn
	{
		_valueCheck = 1;
		_defaultValue = 0;
		_env  = hasInterface;

		_diary  = 0;
		_mdhFnc = 0;
		//_icon = "\a3\ui_f\data\Map\MarkerBrushes\cross_ca.paa";
		//_icon = "\a3\ui_f\data\GUI\Cfg\Cursors\add_gs.paa";
		//_icon = "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\icon_cross_ca.paa";
		_icon = "\a3\3den\Data\CfgWaypoints\support_ca.paa";

		if (hasInterface) then
		{
			_diary =
			{
				waitUntil {!(isNull player)};
				_c = true;
				_t = "Bohemia Revive Icon Marker";
				if (player diarySubjectExists "MDH Mods") then
				{
					{
						if (_x#1 == _t) exitWith {_c = false}
					} forEach (player allDiaryRecords "MDH Mods");
				}
				else
				{
					player createDiarySubject ["MDH Mods","MDH Mods"];
				};
		
				if(_c) then
				{
					mdhBRIMbriefingFnc =
					{
						missionNameSpace setVariable[_this#0,_this#1];
						systemChat (_this#2);
					};

					player createDiaryRecord
					[
						"MDH Mods",
						[
							_t,
							(
							  '<br/>Bohemia Revive Icon Marker is a mod, created by Moerderhoschi for Arma 3, to add an icon and Mapmarker to unconscious players. '
							+ '<br/><br/>'
							+ 'set MDH BRIM Unconscious Map Markers: '
							+    '<font color="#33CC33"><execute expression = "[''pBRIMMapMarkers'',1,''MDH BRIM Unconscious Map Markers ON''] call mdhBRIMbriefingFnc">ON</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''pBRIMMapMarkers'',0,''MDH BRIM Unconscious Map Markers OFF''] call mdhBRIMbriefingFnc">OFF</execute></font color>'
							+ '<br/><br/>'
							+ 'If you have any question you can contact me at the steam workshop page.<br/>'
							+ '<br/>'
							+ '<img image="'+_icon+'"/>'
							+ '<br/>'
							+ '<br/>'
							+ 'Credits and Thanks:<br/>'
							+ 'Xeno - sharing his code and knowledge to realize this addon<br/>'
							+ 'Armed-Assault.de Crew - For many great ArmA moments in many years<br/>'
							+ 'BIS - For ArmA3<br/>'
							)
						]
					]
				};
				true
			};
		};

		if (_env) then
		{
			_mdhFnc =
			{
				///////////////////////////////////////////////////////
				// addMissionEventHandler
				///////////////////////////////////////////////////////
				if (isNil"mdhBRIMmissionEH") then
				{
					mdhBRIMmissionEH = addMissionEventHandler
					[
						"Draw3D",
						{
							{
								if (_x != player && {alive _x} && {side group player getFriend side group _x > 0.5} && {(lifeState _x) == "INCAPACITATED"} ) then
								{
									_dist = player distance _x;
									if (_dist < 200) then
									{
										_pos = getPosATLVisual _x;
										_pos set [2, (_pos select 2) + 1 + (_dist * 0.05)];
										//_icon = "\a3\ui_f\data\Map\MarkerBrushes\cross_ca.paa";
										//_icon = "\a3\ui_f\data\GUI\Cfg\Cursors\add_gs.paa";
										//_icon = "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\icon_cross_ca.paa";
										_icon = "\a3\3den\Data\CfgWaypoints\support_ca.paa";
										drawIcon3D [_icon, [1,0,0,1 - (_dist / 200)], _pos, 1, 1, 0, "(Uncon) " + name _x, 1, 0.032 - (_dist / 9000), "RobotoCondensed"];										
									}
								}
							} forEach allPlayers;
						}
					];
				};

				{deleteMarkerLocal _x} forEach _markers;
				if (missionNameSpace getVariable ["pPlayerMapMarkers",0] == 0 && {missionNameSpace getVariable ["pBRIMMapMarkers",1] == 1}) then
				{
					{
						if (side group player getFriend side group _x > 0.5 && {alive _x} && {(lifeState _x) == "INCAPACITATED"}) then
						{
							_marker = createMarkerLocal ["mdhBRIMmarker_" + format["%1",_forEachIndex], position _x];
							_markers pushBack _marker;
							_marker setMarkerShapeLocal "ICON";
							_marker setMarkerTypeLocal "hd_dot";
							_marker setMarkerTextLocal ("(Uncon) " + name _x);
							_marker setMarkerColorLocal "ColorBLUE";
						};
					} forEach allPlayers;
				};
			};
		};

		if (hasInterface) then
		{
			uiSleep 1.8;
			call _diary;
		};

		_markers = [];
		sleep (10 + random 2);
		while {missionNameSpace getVariable ["pMdhBRIM",_defaultValue] == _valueCheck} do
		{
			if (_env && {[player] call BIS_fnc_reviveEnabled}) then {call _mdhFnc};
			sleep (4 + random 2);
			if (hasInterface && {[player] call BIS_fnc_reviveEnabled}) then {call _diary};
		};
		{deleteMarkerLocal _x} forEach _markers;
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////
// MDH FPV DRONE RPG(by Moerderhoschi) - v2025-04-05
// github: https://github.com/Moerderhoschi/arma3_mdhFPVDroneRPG
// steam mod version: https://steamcommunity.com/sharedfiles/filedetails/?id=3361183268
/////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pMdhFPVDroneRPG",0] == 1 && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
{
	0 spawn
	{
		_valueCheck = 1;
		_defaultValue = 0;
		_path = 'mdhMissionEnhancements';
		_env  = hasInterface;

		_diary  = 0;
		_mdhFnc = 0;

		if (hasInterface) then
		{
			_diary =
			{
				waitUntil {!(isNull player)};
				_c = true;
				_t = "FPV Drone RPG";
				if (player diarySubjectExists "MDH Mods") then
				{
					{
						if (_x#1 == _t) exitWith {_c = false}
					} forEach (player allDiaryRecords "MDH Mods");
				}
				else
				{
					player createDiarySubject ["MDH Mods","MDH Mods"];
				};
		
				if(_c) then
				{
					player createDiaryRecord
					[
						"MDH Mods",
						[
							_t,
							(
							  '<br/>FPV Drone RPG is a mod, created by Moerderhoschi for Arma 3.<br/>'
							+ '<br/>'
							+ 'You can assemble a Drone by having an <br/>'
							+ 'Drone Terminal equipped and also a Backpack with RPGs.<br/>'
							+ 'You can also use RPGs of other Units Backpacks to assemble Drones.<br/>'
							+ '<br/>'
							+ 'If you have any question you can contact me at the steam workshop page.<br/>'
							+ '<br/>'
							+ '<img image="'+_path+'\mdhFPVDroneRPG.paa"/>'					  
							+ '<br/>'
							+ 'Credits and Thanks:<br/>'
							+ 'Armed-Assault.de Crew - For many great ArmA moments in many years<br/>'
							+ 'BIS - For ArmA3<br/>'
							)
						]
					]
				};
				true
			};
		};

		if (_env) then
		{
			_mdhFnc =
			{
				player setUnitTrait ['UAVHacker', true];
				_text = "Assemble FPV Drone RPG";
				{
					if ((((_x actionParams(_x getVariable["mdhFpvDroneRPGBackpackActionID",-1]))select 0)find _text) == -1)then
					{
						_code =
						{
							_u = _this select 0;
							_p = _this select 3 select 0;
							_g = "";
							{if (_g == "" && {_x in (compatibleMagazines "launch_RPG7_F" + compatibleMagazines "launch_RPG32_F")}) then {_g = _x}} forEach backpackItems _u;
							_u removeItemFromBackpack _g;
							if (vehicle player == player) then
							{
								if (stance player == "PRONE") then
								{
									player playActionNow "MedicOther";
									sleep 8;
								}
								else
								{
									player playActionNow "Medic";
									sleep 6;
								};
							};
	
							_ct = "B_UAV_01_F" createVehicle (player getRelPos [1,0]);
							_ct setDir getDir player;
							(side group player) createVehicleCrew _ct;
							//_w = createSimpleObject ["\A3\Weapons_F_Exp\Launchers\RPG7\rocket_rpg7_item.p3d", getPos _ct];
							_w = createSimpleObject [(getText(configfile >> "CfgMagazines" >> _g >> "model")), getPos _ct];																									  
							_w attachTo [_ct, [0, 0.15, 0.1]];
							_w setdir 90;
							if (_g == "CUP_OG7_M") then
							{
								_w attachTo [_ct, [0, 0.30, 0.1]];
								_w setdir 180;
							};
							_g = getText(configfile >> "CfgMagazines" >> _g >> "ammo");
							player connectTerminalToUAV _ct;
							_w lockInventory true;
							0 = [_ct, _w, _g] spawn
							{
								params["_ct","_w","_g"];
								_a = [];
								waitUntil {sleep 0.2;_a pushBack (speed _ct);if(count _a > 5)then{_a deleteAt 0}; !alive _ct};
								if (alive _w) then
								{
									deleteVehicle _w;
									if ((selectMax _a) > 20) then
									{
										//_t = "R_PG32V_F";
										_t = _g;
										_b = _t createVehicle getPos _ct;
										_b attachTo [_ct, [0, 0, 0.5]];
										_b setdir 270;
										detach _b;
										_b setVelocityModelSpace [0,100,0];
									};
								};
							};
						};
	
						_mdhTmpActionID =
						[
							_x
							,_text
							,(_path+"\mdhFPVDroneRPG.paa")
							,(_path+"\mdhFPVDroneRPG.paa")
							,"
								player distance _target < 5
								&& {vehicle player == player}
								&& {backPack _target != """"}
								&& {_e=false;{if(toLower""UavTerminal"" in toLower _x)exitWith{_e=true}}foreach assignedItems player;_e} 
								&& {_g="""";{if(_g==""""&&{_x in (compatibleMagazines ""launch_RPG7_F"" + compatibleMagazines ""launch_RPG32_F"")})exitWith{_g = _x}} forEach backpackItems _target;_g != """"} 
							"
							,"true"
							,{}
							,{}
							,_code
							,{}
							,[1]
							,1
							,-1
							,false
							,false
							,false
						//] call BIS_fnc_holdActionAdd;
						] call mdhHoldActionAdd;
	
						_x setVariable ["mdhFpvDroneRPGBackpackActionID",_mdhTmpActionID];
					};
				} forEach allUnits;
			};
		};

		if (hasInterface) then
		{
			uiSleep 1.2;;
			call _diary;
		};

		sleep (1 + random 2);
		while {missionNameSpace getVariable ["pMdhFPVDroneRPG",_defaultValue] == _valueCheck} do
		{
			if (_env) then {call _mdhFnc};
			sleep (7 + random 3);
			if (hasInterface) then {call _diary};
		};
	};
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MDH RAGDOLL AI UNITS GET MORE DAMAGE AT HIT & AI UNITS GET RAGDOLL EFFECT AT HIT(by Moerderhoschi) - v2025-04-14
// github: https://github.com/Moerderhoschi/arma3_mdhRagdoll
// steam mod version: https://steamcommunity.com/sharedfiles/filedetails/?id=3387437564
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if ((missionNameSpace getVariable ["pAiGetMoreDamageAtHit",0] == 1 OR missionNameSpace getVariable ["pAiRagdollAtHit",0] == 1) && {missionNameSpace getVariable ["pParamPreset",0] == 0}) then
{
	0 spawn
	{
		_valueCheck = 1;
		_defaultValue = 0;
		_path = 'mdhMissionEnhancements';
		_env  = isServer;

		_diary  = 0;
		_mdhFnc = 0;

		if (hasInterface) then
		{
			_diary =
			{
				waitUntil {!(isNull player)};
				_c = true;
				_t = "MDH Ragdoll";
				if (player diarySubjectExists "MDH Mods") then
				{
					{
						if (_x#1 == _t) exitWith {_c = false}
					} forEach (player allDiaryRecords "MDH Mods");
				}
				else
				{
					player createDiarySubject ["MDH Mods","MDH Mods"];
				};
		
				if(_c) then
				{
					player createDiaryRecord
					[
						"MDH Mods",
						[
							_t,
							(
							  '<br/>MDH Ragdoll is a mod, created by Moerderhoschi for Arma 3.<br/>'
							+ '<br/>'
							+ 'All AI units hit by weapons will start ragdolling<br/>'
							+ '<br/>'
							+ 'If you have any question you can contact me at the steam workshop page.<br/>'
							+ '<br/>'
							+ '<img image="'+_path+'\mdhRagdoll.paa"/>'					  
							+ '<br/>'
							+ 'Credits and Thanks:<br/>'
							+ 'Armed-Assault.de Crew - For many great ArmA moments in many years<br/>'
							+ 'BIS - For ArmA3<br/>'
							)
						]
					]
				};
				true
			};
		};

		if (_env) then
		{
			_mdhFnc =
			{
				{
					if (local _x && {alive _x} && {(_x getVariable ["mdhEnemyDamageEhForceSet",-1]) == -1} && {!(_x in allPlayers)}) then
					{
						_x setVariable ["mdhEnemyDamageEhForceSet",
						_x addEventHandler ["HandleDamage",
						{
							params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];
							if (missionNameSpace getVariable ["pAiRagdollAtHit",0] == 1) then
							{
								_u = _unit;
								if (_selection == "body" && {vehicle _u == _u} && {_directHit} && {lifeState _u != "INCAPACITATED"} && {alive _u}) then
								{
									if (!(_u getVariable ["mdhEnemyDamageEhForceHit",false])) then
									{
										_u setVariable ["mdhEnemyDamageEhForceHit",true];
										[_u, _selection, _source] spawn
										{
											params ["_u", "_selection", "_source"];
											if (!alive _u) exitWith {};
											if (1>0) then
											{
												_u addForce [[0,0,0], [0,0,0], false]; // reduce warping on ground
											}
											else
											{
												_v = getposWorld _source vectorFromTo getPosWorld _u;
												_v = [(_v#0) * 100, (_v#1) * 100, 0];
												_u addForce [_v, _u selectionPosition _selection, false]; // old version with to strong ragdoll
											};
											sleep 3;
											if (!alive _u) exitWith {};
											_u setUnconscious true;

											if
											(
												missionNameSpace getVariable["mdhEnemyDamageEhForceOld",false] == true
											OR {profileNameSpace getVariable["mdhEnemyDamageEhForceOld",false] == true}
											)
											then
											{
												if (0.2 > random 1) then // stay longer Unconscious
												{
													_w = "";
													_t = primaryWeapon _u;
													if (secondaryWeapon _u != "") then 
													{
														_w = "Weapon_Empty" createVehicle [500,500,500];
														_u actionNow ["DropWeapon", _w, secondaryWeapon _u];
														_p = getPosWorld _u;
														_w setpos [(_p#0) + 0.3, _p#1, 0];
													};
													if (primaryWeapon _u != "") then 
													{
														_w = "Weapon_Empty" createVehicle [500,500,500];
														_u actionNow ["DropWeapon", _w, primaryWeapon _u];
														_p = getPosWorld _u;
														_w setpos [_p#0, _p#1, 0];
													};
													sleep 10; 
													sleep random 5;
													if (!alive _u) exitWith {};
			
													if (alive _u && {_t != ""}) then
													{
														_u actionNow ["TakeWeapon", _w, _t];
														_u selectWeapon primaryWeapon _u;
													};
												};
												_u setUnconscious false;
												sleep 5;
												_u setVariable ["mdhEnemyDamageEhForceHit",false];
												if (!alive _u) exitWith {};
												_u playMove "AmovPknlMstpSrasWrflDnon";
												_u selectWeapon primaryWeapon _u;
											}
											else
											{
												if (0.2 > random 1) then
												{
													_w = "";
													_t = primaryWeapon _u;
													if (secondaryWeapon _u != "") then 
													{
														_w = "Weapon_Empty" createVehicle [500,500,500];
														_u actionNow ["DropWeapon", _w, secondaryWeapon _u];
														_p = getPosWorld _u;
														_w setpos [(_p#0) + 0.3, _p#1, 0];
													};
													if (primaryWeapon _u != "") then 
													{
														_w = "Weapon_Empty" createVehicle [500,500,500];
														_u actionNow ["DropWeapon", _w, primaryWeapon _u];
														_p = getPosWorld _u;
														_w setpos [_p#0, _p#1, 0];
													};
													sleep 10; 
													sleep random 5;
													_u setUnconscious false;
													if (alive _u && {_t != ""}) then
													{
														_u actionNow ["TakeWeapon", _w, _t];
														_u selectWeapon primaryWeapon _u;
													};
													sleep 5;
													_u setVariable ["mdhEnemyDamageEhForceHit",false];
													if (!alive _u) exitWith {};
													_u playMove "AmovPknlMstpSrasWrflDnon";
													_u selectWeapon primaryWeapon _u;
												}
												else
												{
													_u disableConversation true;
													_u setvariable ["bis_nocoreconversations",true];											
													_u disableAI "FSM";
													_u disableAI "RADIOPROTOCOL";
													if (secondaryWeapon _u != "") then 
													{
														_w = "Weapon_Empty" createVehicle [500,500,500];
														_u actionNow ["DropWeapon", _w, secondaryWeapon _u];
														_p = getPosWorld _u;
														_w setpos [(_p#0) + 0.3, _p#1, 0];
													};
													if (primaryWeapon _u != "") then 
													{
														_w = "Weapon_Empty" createVehicle [500,500,500];
														_u actionNow ["DropWeapon", _w, primaryWeapon _u];
														_p = getPosWorld _u;
														_w setpos [_p#0, _p#1, 0];
													};
													sleep 120;
													sleep random 180;
													_u setDamage 1;
												};									
											};
										};
									};
								};
							};

							if
							(
								missionNameSpace getVariable ["pAiGetMoreDamageAtHit",0] == 1
							OR {missionNameSpace getVariable ["mdhEnemyDamageEhForceOld",false] == true}
							OR {profileNameSpace getVariable ["mdhEnemyDamageEhForceOld",false] == true}
							)
							then
							{
								_damage * 2
							}
						}]];
					};
				} forEach allUnits;
			};
		};

		if (hasInterface) then
		{
			uiSleep 0.6;
			call _diary;
		};

		sleep (2 + random 2);
		while {missionNameSpace getVariable ["pAiGetMoreDamageAtHit",0] == _valueCheck OR missionNameSpace getVariable ["pAiRagdollAtHit",_defaultValue] == _valueCheck} do
		{
			if (_env) then {call _mdhFnc};
			sleep (7 + random 3);
			if (hasInterface) then {call _diary};
		};
	};
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// MDH REVIVE FOR ALL PLAYERS(by Moerderhoschi) - v2025-04-03
// github: https://github.com/Moerderhoschi/arm3_mdhRevive
// steam:  https://steamcommunity.com/sharedfiles/filedetails/?id=3435005893
///////////////////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pMdhRevive",0] > 0 && {isMultiplayer} && {missionNameSpace getVariable ["pParamPreset",0] in [0,2,3]}) then
{
	0 spawn
	{
		_diary  = 0;
		if (hasInterface) then
		{
			_diary =
			{
				waitUntil {!(isNull player)};
				_c = true;
				_t = "MDH Revive";
				if (player diarySubjectExists "MDH Mods") then
				{
					{
						if (_x#1 == _t) exitWith {_c = false}
					} forEach (player allDiaryRecords "MDH Mods");
				}
				else
				{
					player createDiarySubject ["MDH Mods","MDH Mods"];
				};
		
				if(_c) then
				{
					mdhReviveModBriefingFnc =
					{
						if (isServer OR serverCommandAvailable "#logout") then
						{
							missionNameSpace setVariable[_this#0,_this#1,true];
							systemChat (_this#2);
							if ((_this#0) == "bis_revive_Bleedoutduration") then
							{
								missionNameSpace setVariable["pMdhReviveBleedoutTime",_this#1,true];
							};
						}
						else
						{
							systemChat "ONLY ADMIN CAN CHANGE OPTION";
						};
					};

					player createDiaryRecord
					[
						"MDH Mods",
						[
							_t,
							(
							  '<br/>MDH Revive is a script, created by Moerderhoschi for Arma 3.<br/>'
							+ '<br/>'
							+ 'Features:<br/>'
							+ '- You can revive unconscious players while laying on the ground.<br/>'
							+ '- You can drag other players while they unconscious.<br/>'
							+ '- You have a Spectatorcamera while unconscious.<br/>'
							+ '- You are immortal while on the ground and unconscious.<br/>'
							+ '- Autorevive option is available (default 4 min).<br/>'
							+ '- Bleedout option is available (default deact).<br/>'
							+ '- Spectatorcamera option is available (default units side player).<br/>'
							+ '<br/>'
							+ 'set Autorevive: '
							+    '<font color="#33CC33"><execute expression = "[''mdhReviveAutoReviveTime'',120,''MDH Revive Autorevive set 2 min''] call mdhReviveModBriefingFnc">2 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''mdhReviveAutoReviveTime'',180,''MDH Revive Autorevive set 3 min''] call mdhReviveModBriefingFnc">3 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''mdhReviveAutoReviveTime'',240,''MDH Revive Autorevive set 4 min''] call mdhReviveModBriefingFnc">4 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''mdhReviveAutoReviveTime'',300,''MDH Revive Autorevive set 5 min''] call mdhReviveModBriefingFnc">5 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''mdhReviveAutoReviveTime'',360,''MDH Revive Autorevive set 6 min''] call mdhReviveModBriefingFnc">6 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''mdhReviveAutoReviveTime'',600,''MDH Revive Autorevive set 10 min''] call mdhReviveModBriefingFnc">10 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''mdhReviveAutoReviveTime'',4^9,''MDH Revive Autorevive deactivated''] call mdhReviveModBriefingFnc">deact</execute></font color>'
							+ '<br/>'
							+ 'set BleedoutTime: '
							+    '<font color="#33CC33"><execute expression = "[''bis_revive_Bleedoutduration'',120,''MDH Revive BleedoutTime set 2 min''] call mdhReviveModBriefingFnc">2 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''bis_revive_Bleedoutduration'',180,''MDH Revive BleedoutTime set 3 min''] call mdhReviveModBriefingFnc">3 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''bis_revive_Bleedoutduration'',240,''MDH Revive BleedoutTime set 4 min''] call mdhReviveModBriefingFnc">4 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''bis_revive_Bleedoutduration'',300,''MDH Revive BleedoutTime set 5 min''] call mdhReviveModBriefingFnc">5 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''bis_revive_Bleedoutduration'',360,''MDH Revive BleedoutTime set 6 min''] call mdhReviveModBriefingFnc">6 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''bis_revive_Bleedoutduration'',600,''MDH Revive BleedoutTime set 10 min''] call mdhReviveModBriefingFnc">10 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''bis_revive_Bleedoutduration'',4^9,''MDH Revive BleedoutTime deactivated''] call mdhReviveModBriefingFnc">deact</execute></font color>'
							+ '<br/>'
							+ 'set Spectator: '
							+    '<font color="#33CC33"><execute expression = "[''pMdhReviveSpectator'',1,''MDH Revive Spectatorcamera set units side player''] call mdhReviveModBriefingFnc">units side player</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''pMdhReviveSpectator'',2,''MDH Revive Spectatorcamera set all units''] call mdhReviveModBriefingFnc">all units</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''pMdhReviveSpectator'',0,''MDH Revive Spectatorcamera deactivated''] call mdhReviveModBriefingFnc">deact</execute></font color>'
							+ '<br/>'
							+ '<br/>'
							+ 'If you have any question you can contact me at the steam workshop page.<br/>'
							+ '<br/>'
							+ 'Credits and Thanks:<br/>'
							+ 'Armed-Assault.de Crew - For many great ArmA moments in many years<br/>'
							+ 'BIS - For ArmA3<br/>'
							)
						]
					]
				};
				true
			};
		};

		if (hasInterface && {missionNameSpace getVariable ["pMdhRevive",0] == 1} && {isMultiplayer} && {missionNameSpace getVariable ["pParamPreset",0] in [0,3]}) then
		{
			uiSleep 0.3;
			call _diary;
		};

		mdhReviveAutoReviveTime = missionNameSpace getVariable["pMdhReviveAutoReviveTime", 240];
		sleep (1 + random 1);
		bis_reviveParam_mode = 1;
		bis_revive_unconsciousStateMode = 0;
		sleep 0.5;
		if (hasInterface) then {call BIS_fnc_reviveInit};
		sleep 1;
		bis_revive_duration = 5;
		bis_revive_durationmedic = 2;
		bis_revive_medicspeedmultiplier = 3;
		bis_revive_bleedoutduration = missionNameSpace getVariable["pMdhReviveBleedoutTime", 4^9];
		if (missionNameSpace getVariable ["pMdhRevive",0] == 2 OR missionNameSpace getVariable ["pParamPreset",0] == 2) exitWith {bis_revive_bleedoutduration = 300};
		if (hasInterface) then 
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
			_diaryTimer = 10;
			while{sleep 0.01; missionNameSpace getVariable ["pMdhRevive",0] > 0}do
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
									//("Revive " + name _x),
									("<t color='#00FF00'>Revive "+(name _x)+"</t>"),
									"a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
									"a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
									"lifeState _target == ""INCAPACITATED"" 
									&& {player distance _target < 3.2}
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
								//] call BIS_fnc_holdActionAdd;
								] call mdhHoldActionAdd;
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
								//_x addAction
								//[
								//	("<t color=""#FF8200"">Drag "+(name _x)+"</t>"),
								//	{
								//		params ["_target"];
								//		if (currentWeapon player == handgunWeapon player) then
								//		{
								//			player playMoveNow "acinpknlmstpsnonwpstdnon"; // pistol
								//		}
								//		else
								//		{
								//			player playMoveNow "acinpknlmstpsraswrfldnon"; // rifle
								//		};
								//		player setVariable ["mdhReviveDragging",true,true];
								//		_target setVariable ["mdhReviveDragInit",true,true];
								//		_target setVariable ["mdhReviveDraged",true,true];
								//		_target setVariable ["mdhReviveDragedBy",player,true];
								//		_target spawn
								//		{
								//			sleep 2;
								//			waitUntil
								//			{
								//				sleep 0.2;
								//				!(_this getVariable ["mdhReviveDraged",false])
								//				OR !(lifeState player in ["HEALTHY","INJURED"])
								//				OR lifeState _this != "INCAPACITATED"
								//				OR {_x isKindOf "man"} count attachedObjects player < 1
								//			};
								//			player setVariable ["mdhReviveDragging",false,true];
								//			for "_i" from 1 to 9 do
								//			{
								//				if (animationState player in["acinpknlmstpsraswrfldnon","acinpknlmwlksraswrfldb","acinpknlmstpsnonwpstdnon","acinpknlmwlksnonwpstdb"]) then {player switchMove ""};
								//				sleep 0.3;
								//			};
								//		};
								//	},0,98,true,false,""
								//	,"lifeState _target == ""INCAPACITATED""
								//	&& {vehicle player == player}
								//	&& {!(_target getVariable [""mdhReviveDraged"",false])}
								//	&& {time > _target getVariable [""mdhReviveDragEnableTime"",time + 5]}
								//	&& {_target in allPlayers}
								//	"
								//	,3,false
								//];

								[
									_x,
									("<t color='#FF8200'>Drag "+(name _x)+"</t>"),
									"a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_ca.paa",
									"a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_ca.paa",
									"lifeState _target == ""INCAPACITATED""
									&& {vehicle player == player}
									&& {player distance _target < 3}
									&& {!(_target getVariable [""mdhReviveDraged"",false])}
									&& {time > _target getVariable [""mdhReviveDragEnableTime"",time + 5]}
									&& {_target in allPlayers}
									",
									"true",
									{},
									{},
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
									}
									,{}
									,[]
									,1     // Action duration in seconds
									,98    // Priority
									,false // Remove on completion
									,false // Show in unconscious state
								//] call BIS_fnc_holdActionAdd;								
								] call mdhHoldActionAdd;
							};
						};
					} forEach allPlayers;
					
					_f = (actionIDs player findIf { "Stop Drag" in (player actionParams _x select 0) }) != -1;
					if (!_f) then
					{
						//player addAction
						//[
						//	("<t color=""#FF0000"">Stop Drag</t>"),
						//	{
						//		{if(_x isKindOf "man")then{detach _x;_x setVariable ["mdhReviveDraged",false,true]}}forEach attachedObjects player;
						//		player setVariable ["mdhReviveDragging",false,true];
						//		for "_i" from 1 to 4 do
						//		{
						//			if (animationState player in["acinpknlmstpsraswrfldnon","acinpknlmwlksraswrfldb","acinpknlmstpsnonwpstdnon","acinpknlmwlksnonwpstdb"]) then {player switchMove ""};
						//			sleep 0.5;
						//		};
						//	},0,98,true,false,""
						//	,"vehicle player == player && {player getVariable [""mdhReviveDragging"",false]} && {{_x isKindOf ""man""} count attachedObjects player > 0}"
						//	,3,false
						//];

						[
							player,
							("<t color='#FF8200'>Stop Drag</t>"),
							"a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_ca.paa",
							"a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_ca.paa",
							"vehicle player == player && {player getVariable [""mdhReviveDragging"",false]} && {{_x isKindOf ""man""} count attachedObjects player > 0}",
							"true",
							{},
							{},
							{
								{if(_x isKindOf "man")then{detach _x;_x setVariable ["mdhReviveDraged",false,true]}}forEach attachedObjects player;
								player setVariable ["mdhReviveDragging",false,true];
								for "_i" from 1 to 4 do
								{
									if (animationState player in["acinpknlmstpsraswrfldnon","acinpknlmwlksraswrfldb","acinpknlmstpsnonwpstdnon","acinpknlmwlksnonwpstdb"]) then {player switchMove ""};
									sleep 0.5;
								};
							}
							,{}
							,[]
							,1     // Action duration in seconds
							,97    // Priority
							,false // Remove on completion
							,false // Show in unconscious state
						//] call BIS_fnc_holdActionAdd;														
						] call mdhHoldActionAdd;
					};
	
					if (player getVariable ["mdhRevivePlayerName",""] == "") then {player setVariable ["mdhRevivePlayerName",name player,true]};
					if (time > _diaryTimer) then {call _diary; _diaryTimer = time + 10};
					call _mdhDragging;
	
					lifeState player == "INCAPACITATED"
				};
				player allowDamage false;
				player setVariable["mdhReviveDragEnableTime",time + 5,true];
				_endTime = time + 3 + mdhReviveAutoReviveTime;
				_side = player getVariable ["mdhRevivePlayerSide",west];
				if (missionNameSpace getVariable["pMdhReviveSpectator", 1] > 0) then
				{
					if (missionNameSpace getVariable["pMdhReviveSpectator", 2] == 2 OR name player == "Moerderhoschi") then
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
					if (time > _diaryTimer) then {call _diary; _diaryTimer = time + 10};

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
				player setUnconscious false;
				sleep 0.2;
				player allowDamage true;
			};
		};
	};
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// MDH HOLD ACTION ADD FUNCTION(by Moerderhoschi with massive help of GenCoder8) - v2025-03-27
// fixed version of BIS_fnc_holdActionAdd
///////////////////////////////////////////////////////////////////////////////////////////////////////////
if (hasInterface) then
{
	GenCoder8_fixHoldActTimer =
	{
		params["_title","_iconIdle","_hint"];
		private _frameProgress = "frameprog";
		if(time > (missionNamespace getVariable [_frameProgress,-1])) then
		{
			missionNamespace setVariable [_frameProgress,time + 0.065];
			bis_fnc_holdAction_animationIdleFrame = (bis_fnc_holdAction_animationIdleFrame + 1) % 12;
		};
		private _var = "bis_fnc_holdAction_animationIdleTime_" + (str _target) + "_" + (str _actionID);
		if (time > (missionNamespace getVariable [_var,-1]) && {_eval}) then
		{
			missionNamespace setVariable [_var, time + 0.065];
			if (!bis_fnc_holdAction_running) then
			{
				[_originalTarget,_actionID,_title,_iconIdle,bis_fnc_holdAction_texturesIdle,bis_fnc_holdAction_animationIdleFrame,_hint] call bis_fnc_holdAction_showIcon;
			};
		};
	};

	_origFNC = preprocessFileLineNumbers "a3\functions_f\HoldActions\fn_holdActionAdd.sqf";
	_newFNC = ([_origFNC, "bis_fnc_holdAction_animationTimerCode", true] call BIS_fnc_splitString)#0;
	_newFNC = _newFNC + "GenCoder8_fixHoldActTimer";
	_newFNC = _newFNC + ([_origFNC, "bis_fnc_holdAction_animationTimerCode", true] call BIS_fnc_splitString)#1;
	_newFNC = _newFNC + "GenCoder8_fixHoldActTimer";
	_newFNC = _newFNC + ([_origFNC, "bis_fnc_holdAction_animationTimerCode", true] call BIS_fnc_splitString)#2;
	mdhHoldActionAdd = compile _newFNC;
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
			_sunSet = date call BIS_fnc_sunriseSunsetTime;
			_sunRise = (_sunSet#0);
			_sunSet = (_sunSet#1);

			if (missionNameSpace getVariable ["mdhSADflares",false]) then
			{
				if (!isNil"mdhAlert") then
				{
					if
					(
						missionNameSpace getVariable ["mdhSADflareTime",0] < time 
						&& {lifeState _leader in ["HEALTHY","INJURED"]} 
						//&& {dayTime>18 or dayTime<7} 
						&& {dayTime > _sunSet OR {dayTime < _sunRise}}
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

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// MDH UNIT AREA MARKER FUNCTION(by Moerderhoschi) - v2025-03-11
// [thisTrigger,["east","guer"],"colorRed"] spawn mdhUnitAreaMarkerfunc
///////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isServer) then
{
	mdhUnitAreaMarkerfunc =
	{
		if (isServer) then
		{
			params["_trg", "_side","_color"];
			[_trg, _side, _color] spawn
			{
				params["_trg", "_side","_color"];
				_area = triggerArea _trg;
				_pos = getPosWorld _trg;
				_startPosX = _pos#0 - _area#0;
				_startPosY = _pos#1 - _area#1;
				_endPosX = _pos#0 + _area#0;
				_endPosY = _pos#1 + _area#1;
				_markerCorrectionX = 0;
				_markerCorrectionY = 0;
				_markers = [];
				_es = [];
				
				if (typeName _side == "STRING") then {_side = [_side]};
				_s = ["any","anybody","all"];
				
				_sc = _s + ["west","blu","blufor"];
				if (_sc findAny _side != -1) then {_es pushBack west};
				
				_sc = _s + ["east","red","opfor"];
				if (_sc findAny _side != -1) then {_es pushBack east};
				
				_sc = _s + ["guer","guerrilla","ind","independent","resistance","res","green"];
				if (_sc findAny _side != -1) then {_es pushBack resistance};
				
				_sc = _s + ["civ","civilian"];
				if (_sc findAny _side != -1) then {_es pushBack civilian};

				while {true} do
				{
					_sectors = [];
					_markersDel = [];
					_markersKeep = [];
					{
						if (side _x in _es) then
						{
							_pos = getPosWorld vehicle _x;
							_pos2 = _pos;
							_pos = [(((floor(((_pos#0)-_markerCorrectionX) / 100))*100)+50+_markerCorrectionX), (((floor(((_pos#1)-_markerCorrectionY) / 100))*100)+50+_markerCorrectionY)];
							_markerColor = _color;
			
							if
							(
								_pos2#0 <= _endPosX
								&& {_pos2#0 >= _startPosX}
								&& {_pos2#1 <= _endPosY}
								&& {_pos2#1 >= _startPosY}
							)
							then
							{
								_addSector = true;
								for "_i" from 0 to ((count _sectors) - 1) do
								{
									if
									(
										_sectors#_i#0 == _pos#0
										&& {_sectors#_i#1 == _pos#1}
										&& {_sectors#_i#2 == _markerColor}
									)
									then
									{
										_addSector = false
									};
								};
									
								if (_addSector) then
								{
									_sectors append [[_pos#0,_pos#1, _markerColor]];
								};
							};
						};
					} forEach allUnits;
		
					for "_i" from 0 to ((count _sectors)-1) do
					{
						_deleteFromCreationList = false;
						for "_i2" from 0 to ((count _markers)-1) do
						{
							if
							(
								((getMarkerPos (_markers#_i2))#0) == ((_sectors#_i)#0)
								&& {((getMarkerPos (_markers#_i2))#1) == ((_sectors#_i)#1)}
								&& {(getMarkerColor (_markers#_i2)) == ((_sectors#_i)#2)}
							)
							then
							{
								_markersKeep append [_markers#_i2];
								_deleteFromCreationList = true;
							};
						};
						if (_deleteFromCreationList) then
						{
							_sectors set [_i,-1];
						};
					};
				
					_sectors = _sectors - [-1];
					_markersDel = _markers - _markersKeep;
					{deleteMarker _x} forEach _markersDel;
					_markers = _markers - _markersDel;
				
					{
						_mdh_unitAresOnMapMarker = createMarker [ "mdh_unitArasOnMapMarkerName_" + format ["%1_%2",time,random 1000], [_x#0, _x#1]];
						_markers append [_mdh_unitAresOnMapMarker];
						_mdh_unitAresOnMapMarker setMarkerShape "RECTANGLE";
						_mdh_unitAresOnMapMarker setMarkerSize [50, 50];
						_mdh_unitAresOnMapMarker setMarkerAlpha 0.3;
						_mdh_unitAresOnMapMarker setMarkerBrush "Solid";
						_mdh_unitAresOnMapMarker setMarkerColor (_x#2);
					} forEach _sectors;

					if (!alive _trg) exitWith {{deleteMarker _x} forEach _markers};
					sleep 5;
				};												
			};
		};
	};
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MDH CLOSE AIR SUPPORT FUNCTION(by Moerderhoschi) - v2025-03-12
// modified version of BIS_fnc_moduleCAS
// [_pos,"gun",_dir] spawn mdhCASfunc
// [_pos,"bomb",_dir] spawn mdhCASfunc
// [thisList]spawn{while{count(_this#0)>0}do{[(getPos(selectRandom(_this#0))),selectRandom["g","g","g","bomb"],random 45] spawn mdhCASfunc;sleep 60}}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isServer) then
{
	mdhCASfunc =
	{
		if (!isServer) exitWith {};
		params ["_pos","_mode","_dir"];
		_logic = "logic" createVehicleLocal _pos;
		_logic setDir _dir;
		
		if (true) then {
		
			if !(isserver) exitwith {};
		
			_planeClass = _logic getvariable ["vehicle","I_Plane_Fighter_03_CAS_F"];
			_planeClass = _logic getvariable ["vehicle","O_Plane_CAS_02_F"];
			_planeClass = _logic getvariable ["vehicle","B_Plane_CAS_01_F"];
			_planeCfg = configfile >> "cfgvehicles" >> _planeClass;
			if !(isclass _planeCfg) exitwith {["Vehicle class '%1' not found",_planeClass] call bis_fnc_error; false};
		
			_z="--- Restore custom direction";
			_z="_dirVar = _fnc_scriptname + typeof _logic";
			_z="_logic setdir (missionnamespace getvariable [_dirVar,direction _logic])";
		
			_z="--- Detect gun";
			_z='_weaponTypesID = _logic getvariable ["type",getnumber (configfile >> "cfgvehicles" >> typeof _logic >> "moduleCAStype")]';
			_weaponTypesID = 0;
			if (_mode == "bomb") then {_weaponTypesID = 3};
			_weaponTypesID = 4;
			_weaponTypes = switch _weaponTypesID do {
				case 0: {["machinegun"]};
				case 1: {["missilelauncher"]};
				case 2: {["machinegun","missilelauncher"]};
				case 3: {["bomblauncher"]};
				case 4: {["machinegun","bomblauncher"]};
				default {[]};
			};
		
			_weapons = [];
			{
				if (tolower ((_x call bis_fnc_itemType) select 1) in _weaponTypes) then {
					_modes = getarray (configfile >> "cfgweapons" >> _x >> "modes");
					if (count _modes > 0) then {
						_mode = _modes select 0;
						if (_mode == "this") then {_mode = _x;};
						_weapons set [count _weapons,[_x,_mode]];
					};
				};
			} foreach (_planeClass call bis_fnc_weaponsEntityType);_z='getarray (_planeCfg >> "weapons")';
			if (count _weapons == 0) exitwith {["No weapon of types %2 wound on '%1'",_planeClass,_weaponTypes] call bis_fnc_error; false};
		
			_posATL = getposatl _logic;
			_pos = +_posATL;
			_pos set [2,(_pos select 2) + getterrainheightasl _pos];
			_dir = direction _logic;
		
			_dis = 3000;
			_alt = 1000;

			_pitch = atan (_alt / _dis);
			_speed = 400 / 3.6;
			_duration = ([0,0] distance [_dis,_alt]) / _speed;
		
			_z="--- Create plane";
			_planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
			_planePos set [2,(_pos select 2) + _alt];
			_planeSide = (getnumber (_planeCfg >> "side")) call bis_fnc_sideType;
			_planeArray = [_planePos,_dir,_planeClass,_planeSide] call bis_fnc_spawnVehicle;
			_plane = _planeArray select 0;
			_plane setposasl _planePos;
			_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
			_plane disableai "move";
			_plane disableai "target";
			_plane disableai "autotarget";
			_plane setcombatmode "blue";
			
			//_plane spawn {while {alive _this} do {systemChat str(round(getPos _this #2));sleep 0.1}};
		
			_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
			_velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
			_plane setvectordir _vectorDir;
			[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
			_vectorUp = vectorup _plane;
		
			_z="--- Remove all other weapons";
			_currentWeapons = weapons _plane;
			{
				if !(tolower ((_x call bis_fnc_itemType) select 1) in (_weaponTypes + ["countermeasureslauncher"])) then {
					_plane removeweapon _x;
				};
			} foreach _currentWeapons;
		
			_plane setvariable ["logic",_logic];
			_logic setvariable ["plane",_plane];
		
			_z="--- Approach";
			_fire = [] spawn {waituntil {false}};
			_fireNull = true;
			_time = time;
			
			_offset = if ({_x == "missilelauncher"} count _weaponTypes > 0) then {20} else {0};
			waituntil {
				_fireProgress = _plane getvariable ["fireProgress",0];
		
				_z="--- Update plane position when module was moved / rotated";
				if ((getposatl _logic distance _posATL > 0 || direction _logic != _dir) && _fireProgress == 0) then {
					_posATL = getposatl _logic;
					_pos = +_posATL;
					_pos set [2,(_pos select 2) + getterrainheightasl _pos];
					_dir = direction _logic;
					missionnamespace setvariable [_dirVar,_dir];
		
					_planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
					_planePos set [2,(_pos select 2) + _alt];
					_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
					_velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
					_plane setvectordir _vectorDir;
					_z="[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank";
					_vectorUp = vectorup _plane;
		
					_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
				};
		
				_z="--- Set the plane approach vector";
				_plane setVelocityTransformation [
					_planePos, [_pos select 0,_pos select 1,(_pos select 2) + _offset + _fireProgress * 12],
					_velocity, _velocity,
					_vectorDir,_vectorDir,
					_vectorUp, _vectorUp,
					(time - _time) / _duration
				];
				_plane setvelocity velocity _plane;
		
				_z="--- Fire!";
				_fireDist = 1000;
				_fireDist = 2000;
				if ((getposasl _plane) distance _pos < _fireDist && _fireNull) then {

					_z="--- Create laser target";
					private _targetType = if (_planeSide getfriend west > 0.6) then {"LaserTargetW"} else {"LaserTargetE"};
					_target = ((position _logic nearEntities [_targetType,250])) param [0,objnull];
					if (isnull _target) then {
						_target = createvehicle [_targetType,position _logic,[],0,"none"];
					};
					_plane reveal lasertarget _target;
					_plane dowatch lasertarget _target;
					_plane dotarget lasertarget _target;
		
					_fireNull = false;
					terminate _fire;
					_fire = [_plane,_weapons,_target,_weaponTypesID] spawn {
						_plane = _this select 0;
						_planeDriver = driver _plane;
						_weapons = _this select 1;
						_target = _this select 2;
						_weaponTypesID = _this select 3;
						_duration = 3;
						_duration = 99;
						_time = time + _duration;
						_startTime = 0;
						_bombDrop = 2;
						_bombCounter = 0;
						_bombDelay = 3;
						_machinegun = [_weapons#0];
						_bomblauncher = [_weapons#1];
						if (_weaponTypesID == 0) then
						{
							waituntil
							{
								{
									_planeDriver fireattarget [_target,(_x select 0)];
								} foreach _weapons;
								_plane setvariable ["fireProgress",(1 - ((_time - time) / _duration)) max 0 min 1];
								sleep 0.1;
								time > _time || (getPos _plane #2) < 250 || _weaponTypesID == 3 || isnull _plane
							};
						}
						else
						{
							waituntil
							{
								{_planeDriver fireattarget [_target,(_x select 0)]} foreach _machinegun;
								{if (time > (_startTime + _bombDelay) && {_bombCounter < _bombDrop}) then {_bombCounter = _bombCounter + 1; _startTime = time; _planeDriver fireattarget [_target,(_x select 0)]}} foreach _bomblauncher;
								_plane setvariable ["fireProgress",(1 - ((_time - time) / _duration)) max 0 min 1];
								sleep 0.1;
								time > _time || (getPos _plane #2) < 250 || isnull _plane
							};
						};
						sleep 1;
					};
				};
		
				sleep 0.01;
				scriptdone _fire || isnull _logic || isnull _plane
			};
			_plane setvelocity velocity _plane;
			_plane flyinheight _alt;
		
			_z="--- Fire CM";
			if (true) then {
				for "_i" from 0 to 5 do {
					driver _plane forceweaponfire ["CMFlareLauncher","Burst"];
					_time = time + 1.1;
					waituntil {time > _time || isnull _logic || isnull _plane};
				};
			};
		
			if !(isnull _logic) then {
				sleep 1;
				deletevehicle _logic;
				waituntil {_plane distance _pos > _dis || !alive _plane};
			};
		
			_z="--- Delete plane";
			if (alive _plane) then {
				_group = group _plane;
				_crew = crew _plane;
				deletevehicle _plane;
				{deletevehicle _x} foreach _crew;
				deletegroup _group;
			};
		};
	};
};
