_person = _this param [0];
_facewear = goggles _person;
_randomType = [0, 6] call BIS_fnc_randomInt;
_civLoadouts = [
	[[],[],[],["U_BG_Guerrilla_6_1",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",3],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4]]],[],["B_AssaultPack_khk",[["rhs_18rnd_9x21mm_7N28",5,18],[["rhs_weap_6p53","","","",["rhs_18rnd_9x21mm_7N28",18],[],""],1]]],"H_Cap_oli","",[],["ItemMap","","","ItemCompass","ItemWatch",""]],
	[[],[],[],["U_BG_Guerilla3_1",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",3],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4]]],[],["B_AssaultPack_rgr",[["rhs_18rnd_9x21mm_7N28",5,18],[["rhs_weap_6p53","","","",[],[],""],1]]],"H_Watchcap_cbr","",[],["ItemMap","","","ItemCompass","ItemWatch",""]],
	[[],[],[],["U_C_HunterBody_grn",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",3],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4]]],[],["B_FieldPack_cbr",[["rhs_18rnd_9x21mm_7N28",5,18],[["rhs_weap_6p53","","","",[],[],""],1]]],"H_Hat_tan","",[],["ItemMap","","","ItemCompass","ItemWatch",""]],
	[[],[],[],["U_BG_leader",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",3],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4]]],[],["B_AssaultPack_dgtl",[["rhs_18rnd_9x21mm_7N28",5,18],[["rhs_weap_6p53","","","",[],[],""],1]]],"H_Watchcap_camo","",[],["ItemMap","","","ItemCompass","ItemWatch",""]],
	[[],[],[],["U_BG_Guerrilla_6_1",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",3],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4]]],["V_Pocketed_coyote_F",[]],["B_FieldPack_cbr",[["rhs_18rnd_9x21mm_7N28",5,18],[["rhs_weap_6p53","","","",[],[],""],1]]],"H_Watchcap_khk","G_Spectacles_Tinted",[],["ItemMap","","","ItemCompass","ItemWatch",""]],
	[[],[],[],["U_OrestesBody",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",3]]],[],["B_AssaultPack_blk",[["rhs_18rnd_9x21mm_7N28",5,18],[["rhs_weap_6p53","","","",[],[],""],1]]],"H_Watchcap_blk","G_Spectacles_Tinted",[],["ItemMap","","","ItemCompass","ItemWatch",""]],
	[[],[],[],["U_C_E_LooterJacket_01_F",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",3],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4]]],[],["B_AssaultPack_blk",[["rhs_18rnd_9x21mm_7N28",5,18],[["rhs_weap_6p53","","","",[],[],""],1]]],"H_Cap_press","",[],["ItemMap","","","ItemCompass","ItemWatch",""]]
];

_person setUnitLoadout (_civLoadouts select _randomType);
_person addGoggles _facewear;
_person setCaptive true;

_person addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	
	_unit setCaptive false;
	_unit removeAllEventHandlers "Fired";
}];