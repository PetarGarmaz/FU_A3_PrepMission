class TabletLockScreen {
	idd = 4600;
	
	class Controls {
		class TabletBody: RscPicture {
			idc = 4611;
			text = "Images\GUI\FUT_Body.paa";
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.319688 * safezoneW;
			h = 0.55 * safezoneH;
		};
		
		class Location: RscPicture {
			idc = 4612;
			text = "Images\GUI\FUT_Location.paa";
			x = 0.545 * safezoneW + safezoneX;
			y = 0.45 * safezoneH + safezoneY;
			w = 0.0134375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class TooltipText: RscText {
			idc = 4613;
			text = "Press Home to Unlock"; //--- ToDo: Localize;
			x = 0.46 * safezoneW + safezoneX;
			y = 0.625 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class LocationText: RscText {
			idc = 4614;
			text = "Chernogorsk"; //--- ToDo: Localize;
			x = 0.56 * safezoneW + safezoneX;
			y = 0.45 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class TemperatureText: RscStructuredText {
			idc = 4615;
			text = "<t size=""3"">13°</t>"; //--- ToDo: Localize;
			x = 0.58 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.042 * safezoneW;
			h = 0.056 * safezoneH;
		};
		
		class Weather: RscPicture {
			idc = 4616;
			text = "Images\GUI\FUT_WeatherSunny.paa";
			x = 0.538 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.04 * safezoneW;
			h = 0.071 * safezoneH;
		};
		
		class HomeButton: RscButton {
			idc = 4617;
			x = 0.4928 * safezoneW + safezoneX;
			y = 0.69 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Home Button";
			soundClick[] = {"A3\Sounds_F_Orange\MissionSFX\Orange_Timeline_iconFadeIn",0.177828,1};
		};
		
		class TimeText: RscStructuredText {
			idc = 4618;
			text = "<t size=""3"">00:00</t>"; //--- ToDo: Localize;
			x = 0.375 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.08 * safezoneH;
		};
		
		class DateText: RscText {
			idc = 4619;
			text = "Monday, January 1st, 2020"; //--- ToDo: Localize;
			x = 0.375 * safezoneW + safezoneX;
			y = 0.45 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};

class TabletMenuScreen {
	idd = 4601;
	
	class Controls {
		class TabletBody: RscPicture {
			idc = 4611;
			text = "Images\GUI\FUT_Body.paa";
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.319688 * safezoneW;
			h = 0.55 * safezoneH;
		};
		
		class StatsButton: RscActiveText {
			idc = 4612;
			text = "Images\GUI\FUT_Stats.paa";
			x = 0.395 * safezoneW + safezoneX;
			y = 0.388 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			tooltip = "Player Stats";
		};
		
		class VirtualGarageButton: RscActiveText {
			idc = 4613;
			text = "Images\GUI\FUT_Garage.paa";
			x = 0.473 * safezoneW + safezoneX;
			y = 0.388 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			tooltip = "Virtual Garage";
		};
		
		class MissionsButton: RscActiveText {
			idc = 4614;
			text = "Images\GUI\FUT_Missions.paa";
			x = 0.551 * safezoneW + safezoneX;
			y = 0.388 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			tooltip = "Missions";
		};
		
		class SupplyButton: RscActiveText {
			idc = 4615;
			text = "Images\GUI\FUT_SupplyDrop.paa";
			x = 0.395 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			tooltip = "Supply Drop";
		};
		
		class GroupButton: RscActiveText {
			idc = 4616;
			text = "Images\GUI\FUT_Group.paa";
			x = 0.473 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			tooltip = "Group";
		};
		
		class SettingsButton: RscActiveText {
			idc = 4617;
			text = "Images\GUI\FUT_Settings.paa";
			x = 0.551 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			tooltip = "Player Settings";
		};
		
		class HomeButton: RscButton {
			idc = 4618;
			x = 0.4928 * safezoneW + safezoneX;
			y = 0.69 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Home Button";
			soundClick[] = {"A3\Sounds_F_Orange\MissionSFX\Orange_Timeline_fadeOut",0.141254,1};
		};
		
		/*class TimeText: RscStructuredText {
			idc = 4618;
			text = "<t size=""3"">00:00</t>"; //--- ToDo: Localize;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.08 * safezoneH;
		};
		
		class DateText: RscText {
			idc = 4619;
			text = "Monday, January 1st, 2020"; //--- ToDo: Localize;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.45 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.022 * safezoneH;
		};*/
	};
};

class TabletStatsScreen {
	idd = 4602;
	
	class Controls {
		class TabletBody: RscPicture {
			idc = 4611;
			text = "Images\GUI\FUT_BodyStats.paa";
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.319688 * safezoneW;
			h = 0.55 * safezoneH;
		};
		
		
		//Texts
		class KillsText: RscStructuredText {
			idc = 4612;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.388 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			tooltip = "Total Kills";
		};
		
		class DeathsText: RscStructuredText {
			idc = 4613;
			x = 0.473 * safezoneW + safezoneX;
			y = 0.388 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			tooltip = "Total Deaths";
		};
		
		class KDRText: RscStructuredText {
			idc = 4614;
			x = 0.551 * safezoneW + safezoneX;
			y = 0.388 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			tooltip = "KDR = Kills / Deaths";
		};
		
		class ShotsFiredText: RscStructuredText {
			idc = 4615;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			tooltip = "Total Shots Fired";
		};
		
		class ShotsPerKillText: RscStructuredText {
			idc = 4616;
			x = 0.473 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			tooltip = "SpK = Shots Fired / Kills";
		};
		
		class MaxLifetimeText: RscStructuredText {
			idc = 4617;
			x = 0.551 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			tooltip = "Best lifetime (in min)";
		};
		
		class HomeButton: RscButton {
			idc = 4618;
			x = 0.4928 * safezoneW + safezoneX;
			y = 0.69 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Home Button";
			soundClick[] = {"A3\Sounds_F_Orange\MissionSFX\Orange_Timeline_fadeOut",0.141254,1};
		};
		
		class BackButton: RscButton {
			idc = 4619;
			x = 0.523 * safezoneW + safezoneX;
			y = 0.69 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Return Button";
		};
	};
};

class TabletMissions {
	idd = 4603;
	
	class Controls {
		class TabletBody: RscPicture {
			idc = 4611;
			text = "Images\GUI\FUT_Body.paa";
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.319688 * safezoneW;
			h = 0.55 * safezoneH;
		};
		
		class MainButton: RscActiveText {
			idc = 4612;
			text = "Images\GUI\FUT_MissionMain.paa";
			x = 0.395 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			
			tooltip = "Accept Main Mission";
		};
		
		class CapButton: RscActiveText {
			idc = 4613;
			text = "Images\GUI\FUT_MissionCAP.paa";
			x = 0.473 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			
			tooltip = "Accept CAP Mission";
		};
		
		class SideButton: RscActiveText {
			idc = 4614;
			text = "Images\GUI\FUT_MissionSide.paa";
			x = 0.551 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			
			tooltip = "Accept Side Mission";
		};
		
		class HomeButton: RscButton {
			idc = 4618;
			x = 0.4928 * safezoneW + safezoneX;
			y = 0.69 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Home Button";
			soundClick[] = {"A3\Sounds_F_Orange\MissionSFX\Orange_Timeline_fadeOut",0.141254,1};
		};
		
		class BackButton: RscButton {
			idc = 4619;
			x = 0.523 * safezoneW + safezoneX;
			y = 0.69 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Return Button";
		};
	};
};

class TabletSupplyDrop {
	idd = 4604;
	
	class Controls {
		class TabletBody: RscPicture {
			idc = 4611;
			text = "Images\GUI\FUT_Body.paa";
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.319688 * safezoneW;
			h = 0.55 * safezoneH;
		};
		
		class QuadButton: RscActiveText {
			idc = 4612;
			text = "Images\GUI\FUT_Quad.paa";
			x = 0.395 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			
			tooltip = "Request Quad Bike";
		};
		
		class RecruitsButton: RscActiveText {
			idc = 4613;
			text = "Images\GUI\FUT_Reinforcements.paa";
			x = 0.473 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			
			tooltip = "Request Reinfocements";
		};
		
		class SuppliesButton: RscActiveText {
			idc = 4614;
			text = "Images\GUI\FUT_Supplies.paa";
			x = 0.551 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			
			tooltip = "Request Supplies";
		};
		
		class HomeButton: RscButton {
			idc = 4618;
			x = 0.4928 * safezoneW + safezoneX;
			y = 0.69 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Home Button";
			soundClick[] = {"A3\Sounds_F_Orange\MissionSFX\Orange_Timeline_fadeOut",0.141254,1};
		};
		
		class BackButton: RscButton {
			idc = 4619;
			x = 0.523 * safezoneW + safezoneX;
			y = 0.69 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Return Button";
		};
	};
};

class TabletGroups {
	idd = 4605;
	
	class Controls {
		class TabletBody: RscPicture {
			idc = 4611;
			text = "Images\GUI\FUT_Body.paa";
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.319688 * safezoneW;
			h = 0.55 * safezoneH;
		};
		
		class AllGroups: RscListbox
		{
			idc = 4612;
			x = 0.381377 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.242 * safezoneH;
		};
		
		class GroupMembers: RscListbox{
			idc = 4613;
			x = 0.505158 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.165 * safezoneH;
		};
		
		class JoinGroup: RscActiveText{
			idc = 4614;
			text = "#(argb,8,8,3)color(0.470,0.667,0.314,0.8)";
			x = 0.381377 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.044 * safezoneH;
			style = ST_PICTURE;
			color[] = {0.470,0.667,0.314,0.8};
			colorActive[] = {0.470,0.667,0.314,0.65};
			colorDisabled[] = {0.470,0.667,0.314,0.8};
			tooltip = "Join Group";
		};
		
		class GroupDescriptionBG: RscPicture{
			idc = 4615;
			text = "#(argb,8,8,3)color(0.243,0.369,0.188,0.8)";
			x = 0.505158 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.121 * safezoneH;
		};
		
		class GroupDescription: RscStructuredText{
			idc = 4616;
			text = "<t size=""1"">Rank: <br/>Vitals Stable: <br/>Magazine Count: <br/>Has Medical Training: <br/>Has Engineer Training: </t>";
			x = 0.505158 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.121 * safezoneH;
		};
		
		class HomeButton: RscButton {
			idc = 4618;
			x = 0.4928 * safezoneW + safezoneX;
			y = 0.69 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Home Button";
			soundClick[] = {"A3\Sounds_F_Orange\MissionSFX\Orange_Timeline_fadeOut",0.141254,1};
		};
		
		class BackButton: RscButton {
			idc = 4619;
			x = 0.523 * safezoneW + safezoneX;
			y = 0.69 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Return Button";
		};
	};
};

class TabletSettings {
	idd = 4606;
	
	class Controls {
		class TabletBody: RscPicture {
			idc = 4611;
			text = "Images\GUI\FUT_Body.paa";
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.319688 * safezoneW;
			h = 0.55 * safezoneH;
		};
		
		class TracersButton: RscActiveText {
			idc = 4612;
			text = "Images\GUI\FUT_Tracers.paa";
			x = 0.395 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			
			tooltip = "See Bullet Trajectory";
		};
		
		class AmmoButton: RscActiveText {
			idc = 4613;
			text = "Images\GUI\FUT_Ammo.paa";
			x = 0.473 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			
			tooltip = "Unlimited Ammo";
		};
		
		class CallsignButton: RscActiveText {
			idc = 4614;
			text = "Images\GUI\FUT_Callsign.paa";
			x = 0.551 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.054 * safezoneW;
			h = 0.092 * safezoneH;
			style = ST_PICTURE;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,0.65};
			colorDisabled[] = {1,1,1,0.8};
			
			tooltip = "Change Group Callsign (UNAVAILABLE)";
		};
		
		class HomeButton: RscButton {
			idc = 4618;
			x = 0.4928 * safezoneW + safezoneX;
			y = 0.69 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Home Button";
			soundClick[] = {"A3\Sounds_F_Orange\MissionSFX\Orange_Timeline_fadeOut",0.141254,1};
		};
		
		class BackButton: RscButton {
			idc = 4619;
			x = 0.523 * safezoneW + safezoneX;
			y = 0.69 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Return Button";
		};
	};
};

/*
class TabletCallsign {
	idd = 4607;
	
	class Controls {
		class TabletBody: RscPicture {
			idc = 4611;
			text = "Images\GUI\FUT_Body.paa";
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.319688 * safezoneW;
			h = 0.55 * safezoneH;
		};
		
		class RscButtonMenu_2400: RscPicture {
			idc = 4612;
			text = "#(argb,8,8,3)color(0,0,0,0.5)"; //--- ToDo: Localize;
			x = 0.407164 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.185671 * safezoneW;
			h = 0.077 * safezoneH;
		};
		
		class RscButtonMenuOK_2600: RscButton {
			idc = 4613;
			x = 0.407164 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0825207 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class RscButtonMenuCancel_2700: RscButton {
			idc = 4614;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0928357 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class RscEdit_1400: RscEdit {
			idc = 4615;
			text = ""; //--- ToDo: Localize;
			x = 0.417479 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.165041 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};*/


//Tablet Pos, size = ["0.340156 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.319688 * safezoneW","0.55 * safezoneH"]


/*
colorBackground[] = 
	{
		0.243,
		0.369,
		0.188,
		1
	};

*/

//[0.243,0.369,0.188,1]