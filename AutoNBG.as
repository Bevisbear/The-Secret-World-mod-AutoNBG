/*


*/
import com.GameInterface.UtilsBase;
import mx.utils.Delegate;
import flash.geom.Point;
import com.GameInterface.DistributedValue;
import com.Utils.ID32;
import com.GameInterface.Tooltip.Tooltip;
import com.GameInterface.Tooltip.TooltipData;
import com.GameInterface.Tooltip.TooltipInterface;
import com.GameInterface.Tooltip.TooltipManager;
import com.Utils.Archive;
import com.GameInterface.NeedGreed;
import com.GameInterface.InventoryItem;
import com.GameInterface.WaypointInterface;
import com.GameInterface.Waypoint;
import com.GameInterface.Chat;
import com.Utils.Signal;

var m_VTIOIsLoadedMonitor:DistributedValue = DistributedValue.Create("VTIO_IsLoaded");
var VTIOAddonInfo:String = "AutoNBG|Shittakaburi & Bevis|1.7.0| AutoNBGWindowOn|_root.autonbg\\autonbg.m_AutoNBGIcon";


var m_WindowPosition:Point = new Point();
var m_AutoNBGWindow:MovieClip;
var m_AutoNBGIcon:MovieClip;
var m_tooltip:TooltipInterface;

var m_AutoNBGWindowOn:DistributedValue = DistributedValue.Create("AutoNBGWindowOn");

//NBG
var MANUAL:Number = 0;
var GREED:Number = 1;
var NEED:Number = 2;
var PASS:Number = 3;
var WeaponsGreenLessThanTenRoll:Number = MANUAL;
var WeaponsGreenTenRoll:Number = MANUAL;
var WeaponsBlueLessThanTenRoll:Number = MANUAL;
var WeaponsBlueTenRoll:Number = MANUAL;
var WeaponsPurpleRoll:Number = MANUAL;
var ToolkitsGreenRoll:Number = MANUAL;
var ToolkitsBlueRoll:Number = MANUAL;
var ToolkitsPurpleRoll:Number = MANUAL;
var PotionsRoll:Number = MANUAL;
var PotionsBlueRoll:Number = MANUAL;
var PotionsPurpleRoll:Number = MANUAL;
var SignetsGreenRoll:Number = MANUAL;
var SignetsBlueRoll:Number = MANUAL;
var SignetsPurpleRoll:Number = MANUAL;
var FragmentsGreenRoll:Number = MANUAL;
var FragmentsBlueRoll:Number = MANUAL;
var FragmentsPurpleRoll:Number = MANUAL;
var TheatricsRoll:Number = MANUAL;
var SequinsRoll:Number = MANUAL;
var GadgetsRoll:Number = MANUAL;
var ScenarioAugmentsGreenRoll:Number = MANUAL;
var ScenarioAugmentsBlueRoll:Number = MANUAL;
var ScenarioAugmentsPurpleRoll:Number = MANUAL;
var ScenarioAugmentsGoldRoll:Number = MANUAL;
var ScenarioMinesRoll:Number = MANUAL;
var ScenarioFirstAidRoll:Number = MANUAL;
var ScenarioBearArmsRoll:Number = MANUAL;
var ScenarioPotionsRoll:Number = MANUAL;
var ScenarioWeaponsRoll:Number = MANUAL;
var ScenarioToolkitsRoll:Number = MANUAL;
var ScenarioTheatricsRoll:Number = MANUAL;
var ScenarioGadgetsRoll:Number = MANUAL;
var DungeonWeaponsGreenTenRoll:Number = MANUAL;
var DungeonWeaponsBlueTenRoll:Number = MANUAL;
var DungeonWeaponsGreenLessThanTenRoll:Number = MANUAL;
var DungeonWeaponsBlueLessThanTenRoll:Number = MANUAL;
var DungeonWeaponsPurpleRoll:Number = MANUAL;
var DungeonTalismansGreenTenRoll:Number = MANUAL;
var DungeonTalismansBlueTenRoll:Number = MANUAL;
var DungeonTalismansGreenLessThanTenRoll:Number = MANUAL;
var DungeonTalismansBlueLessThanTenRoll:Number = MANUAL;
var DungeonTalismansPurpleRoll:Number = MANUAL;
var DungeonToolkitsGreenRoll:Number = MANUAL;
var DungeonToolkitsBlueRoll:Number = MANUAL;
var DungeonToolkitsAuxBlueRoll:Number = MANUAL;
var DungeonToolkitsPurpleRoll:Number = MANUAL;
var DungeonToolkitsAuxPurpleRoll:Number = MANUAL;
var DungeonToolkitsNightwatchRoll:Number = MANUAL;
var DungeonPotionsRoll:Number = MANUAL;
var DungeonBlueprintsRoll:Number = MANUAL;
var DungeonTheatricsRoll:Number = MANUAL;
var TokyoRareCocktailRoll:Number = MANUAL;
var AegisModuleGreenRoll:Number = MANUAL;
var AegisModuleBlueRoll:Number = MANUAL;
var AegisModulePurpleRoll:Number = MANUAL;
var AegisCapacitorlessThen4Roll:Number = MANUAL;  //Green
var AegisCapacitorMoreThen5Roll:Number = MANUAL;  //Green
var AegisCapacitorlessThen4BlueRoll:Number = MANUAL;
var AegisCapacitorMoreThen5BlueRoll:Number = MANUAL;
var AegisCapacitorlessThen4PurpleRoll:Number = MANUAL;
var AegisCapacitorMoreThen5PurpleRoll:Number = MANUAL;
/*
var AegisControllerGreenRoll:Number = MANUAL;
var AegisControllerBlueRoll:Number = MANUAL;
var AegisControllerPurpleRoll:Number = MANUAL;
var TokyoTokenRoll:Number = MANUAL;
*/
var UnusualFilthSampleRoll:Number = MANUAL;


var SCENARIO:Number = 0;
var DUNGEON:Number = 1;
var RAID:Number = 2;
var GENERAL:Number = 3;

var FIFOToggle:Boolean = true;
var AutoNBGToggle:Boolean = true;


function onLoad()
{
	m_AutoNBGWindow = attachMovie("AutoNBGWindow", "window", getNextHighestDepth());
	m_AutoNBGWindow._x = 300;
	m_AutoNBGWindow._y = 200;
	m_AutoNBGWindow.SignalWindowClosed.Connect(SlotWindowClosed, this);
	m_AutoNBGWindow._visible = false;

	m_AutoNBGWindowOn.SetValue(false);
	m_AutoNBGWindowOn.SignalChanged.Connect(SlotWindowOnChanged, this);
	
	m_AutoNBGIcon = attachMovie("AutoNBGIcon", "button", getNextHighestDepth());
	//m_AutoNBGIcon = attachMovie("AutoNBGIcon_Disabled", "button", getNextHighestDepth());
	//m_AutoNBGIcon._width = 18;
	//m_AutoNBGIcon._height = 18;
	//m_AutoNBGIcon._x = 200;
	//m_AutoNBGIcon._y = 100;
	m_AutoNBGIcon._visible = false;
	
	NeedGreed.SignalCreateNeedGreedWindow.Connect(SlotShowNeedGreedWindow, this);
	
	SlotCheckVTIOIsLoaded();
	//VTIO
	//m_VTIOIsLoadedMonitor = DistributedValue.Create("VTIO_IsLoaded");
	m_VTIOIsLoadedMonitor.SignalChanged.Connect(SlotCheckVTIOIsLoaded, this);
	WaypointInterface.SignalPlayfieldChanged.Connect(SlotPlayfieldChanged, this);
 
}

 
function SlotWindowClosed() 
{
	m_AutoNBGWindow._visible = !m_AutoNBGWindow._visible;
	m_AutoNBGWindowOn.SetValue(false);
	Selection.setFocus(null);
}

function onEnterFrame()
{

}

function SlotWindowOnChanged(value:DistributedValue):Void
{
	var state:Boolean = value.GetValue();
	m_AutoNBGWindow._visible = state;
	m_AutoNBGWindow.LoadFrameOne();
}

function SlotCheckVTIOIsLoaded() 
{
	if (DistributedValue.GetDValue("VTIO_IsLoaded"))
	{
		DistributedValue.SetDValue("VTIO_RegisterAddon", VTIOAddonInfo);
	}
}

function OnModuleDeactivated():Archive
{
	var config:Archive = new Archive();

	config.AddEntry("DungeonWeaponsGreenTenRoll", DungeonWeaponsGreenTenRoll);
	config.AddEntry("DungeonWeaponsBlueTenRoll", DungeonWeaponsBlueTenRoll);
	config.AddEntry("DungeonWeaponsGreenLessThanTenRoll", DungeonWeaponsGreenLessThanTenRoll);
	config.AddEntry("DungeonWeaponsBlueLessThanTenRoll", DungeonWeaponsBlueLessThanTenRoll);
	config.AddEntry("DungeonWeaponsPurpleRoll", DungeonWeaponsPurpleRoll);
	config.AddEntry("DungeonTalismansGreenTenRoll", DungeonTalismansGreenTenRoll);
	config.AddEntry("DungeonTalismansBlueTenRoll", DungeonTalismansBlueTenRoll);
	config.AddEntry("DungeonTalismansGreenLessThanTenRoll", DungeonTalismansGreenLessThanTenRoll);
	config.AddEntry("DungeonTalismansBlueLessThanTenRoll", DungeonTalismansBlueLessThanTenRoll);
	config.AddEntry("DungeonTalismansPurpleRoll", DungeonTalismansPurpleRoll);
	config.AddEntry("DungeonToolkitsGreenRoll", DungeonToolkitsGreenRoll);
	config.AddEntry("DungeonToolkitsBlueRoll", DungeonToolkitsBlueRoll);
	config.AddEntry("DungeonToolkitsAuxBlueRoll", DungeonToolkitsAuxBlueRoll);
	config.AddEntry("DungeonToolkitsPurpleRoll", DungeonToolkitsPurpleRoll);
	config.AddEntry("DungeonToolkitsAuxPurpleRoll", DungeonToolkitsAuxPurpleRoll);
	config.AddEntry("DungeonToolkitsNightwatchRoll", DungeonToolkitsNightwatchRoll);
	config.AddEntry("DungeonPotionsRoll", DungeonPotionsRoll);
	config.AddEntry("DungeonBlueprintsRoll", DungeonBlueprintsRoll);
	config.AddEntry("DungeonTheatricsRoll", DungeonTheatricsRoll);
	config.AddEntry("ScenarioAugmentsGreenRoll", ScenarioAugmentsGreenRoll);
	config.AddEntry("ScenarioAugmentsBlueRoll", ScenarioAugmentsBlueRoll);
	config.AddEntry("ScenarioAugmentsPurpleRoll", ScenarioAugmentsPurpleRoll);
	config.AddEntry("ScenarioAugmentsGoldRoll", ScenarioAugmentsGoldRoll);
	config.AddEntry("ScenarioMinesRoll", ScenarioMinesRoll);
	config.AddEntry("ScenarioFirstAidRoll", ScenarioFirstAidRoll);
	config.AddEntry("ScenarioBearArmsRoll", ScenarioBearArmsRoll);
	config.AddEntry("ScenarioWeaponsRoll", ScenarioWeaponsRoll);
	config.AddEntry("ScenarioToolkitsRoll", ScenarioToolkitsRoll);
	config.AddEntry("ScenarioPotionsRoll", ScenarioPotionsRoll);
	config.AddEntry("ScenarioTheatricsRoll", ScenarioTheatricsRoll);
	config.AddEntry("ScenarioGadgetsRoll", ScenarioGadgetsRoll);
	config.AddEntry("WeaponsGreenLessThanTenRoll", WeaponsGreenLessThanTenRoll);
	config.AddEntry("WeaponsGreenTenRoll", WeaponsGreenTenRoll);
	config.AddEntry("WeaponsBlueLessThanTenRoll", WeaponsBlueLessThanTenRoll);
	config.AddEntry("WeaponsBlueTenRoll", WeaponsBlueTenRoll);
	config.AddEntry("WeaponsPurpleRoll", WeaponsPurpleRoll);
	config.AddEntry("ToolkitsGreenRoll", ToolkitsGreenRoll);
	config.AddEntry("ToolkitsBlueRoll", ToolkitsBlueRoll);
	config.AddEntry("ToolkitsPurpleRoll", ToolkitsPurpleRoll);
	config.AddEntry("PotionsRoll", PotionsRoll);
	config.AddEntry("SignetsGreenRoll", SignetsGreenRoll);
	config.AddEntry("SignetsBlueRoll", SignetsBlueRoll);
	config.AddEntry("SignetsPurpleRoll", SignetsPurpleRoll);
	config.AddEntry("FragmentsGreenRoll", FragmentsGreenRoll);
	config.AddEntry("FragmentsBlueRoll", FragmentsBlueRoll);
	config.AddEntry("FragmentsPurpleRoll", FragmentsPurpleRoll);
	config.AddEntry("TheatricsRoll", TheatricsRoll);
	config.AddEntry("SequinsRoll", SequinsRoll);
	config.AddEntry("GadgetsRoll", GadgetsRoll);
	config.AddEntry("TokyoRareCocktailRoll", TokyoRareCocktailRoll);
	config.AddEntry("AegisModuleGreenRoll", AegisModuleGreenRoll);
	config.AddEntry("AegisModuleBlueRoll", AegisModuleBlueRoll);
	config.AddEntry("AegisModulePurpleRoll", AegisModulePurpleRoll);
	config.AddEntry("AegisCapacitorlessThen4Roll", AegisCapacitorlessThen4Roll);
	config.AddEntry("AegisCapacitorMoreThen5Roll", AegisCapacitorMoreThen5Roll);
	config.AddEntry("AegisCapacitorlessThen4BlueRoll", AegisCapacitorlessThen4BlueRoll);
	config.AddEntry("AegisCapacitorMoreThen5BlueRoll", AegisCapacitorMoreThen5BlueRoll);
	config.AddEntry("AegisCapacitorlessThen4PurpleRoll", AegisCapacitorlessThen4PurpleRoll);
	config.AddEntry("AegisCapacitorMoreThen5PurpleRoll", AegisCapacitorMoreThen5PurpleRoll);
	/* Aegis Head
	config.AddEntry("AegisControllerGreenRoll", AegisControllerGreenRoll);
	config.AddEntry("AegisControllerBlueRoll", AegisControllerBlueRoll);
	config.AddEntry("AegisControllerPurpleRoll", AegisControllerPurpleRoll);
	*/
	// config.AddEntry("TokyoTokenRoll", TokyoTokenRoll);
	config.AddEntry("UnusualFilthSampleRoll", UnusualFilthSampleRoll);
	config.AddEntry("FIFOToggle", FIFOToggle);
	config.AddEntry("AutoNBGToggle", AutoNBGToggle);
	// config.AddEntry("AutoNBGDisableRollwindow", AutoNBGDisableRollwindow);
	return config;
}

function OnModuleActivated(config:Archive) 
{
	var config:Archive = config;
	if (config != undefined)
	{
		DungeonWeaponsGreenTenRoll = config.FindEntry("DungeonWeaponsGreenTenRoll", MANUAL);
		DungeonWeaponsBlueTenRoll = config.FindEntry("DungeonWeaponsBlueTenRoll", MANUAL);
		DungeonWeaponsGreenLessThanTenRoll = config.FindEntry("DungeonWeaponsGreenLessThanTenRoll", MANUAL);
		DungeonWeaponsBlueLessThanTenRoll = config.FindEntry("DungeonWeaponsBlueLessThanTenRoll", MANUAL);
		DungeonWeaponsPurpleRoll = config.FindEntry("DungeonWeaponsPurpleRoll", MANUAL);
		DungeonTalismansGreenTenRoll = config.FindEntry("DungeonTalismansGreenTenRoll", MANUAL);
		DungeonTalismansBlueTenRoll = config.FindEntry("DungeonTalismansBlueTenRoll", MANUAL);
		DungeonTalismansGreenLessThanTenRoll = config.FindEntry("DungeonTalismansGreenLessThanTenRoll", MANUAL);
		DungeonTalismansBlueLessThanTenRoll = config.FindEntry("DungeonTalismansBlueLessThanTenRoll", MANUAL);
		DungeonTalismansPurpleRoll = config.FindEntry("DungeonTalismansPurpleRoll", MANUAL);
		DungeonToolkitsGreenRoll = config.FindEntry("DungeonToolkitsGreenRoll", MANUAL);
		DungeonToolkitsBlueRoll = config.FindEntry("DungeonToolkitsBlueRoll", MANUAL);
		DungeonToolkitsAuxBlueRoll = config.FindEntry("DungeonToolkitsAuxBlueRoll", MANUAL);
		DungeonToolkitsPurpleRoll = config.FindEntry("DungeonToolkitsPurpleRoll", MANUAL);
		DungeonToolkitsAuxPurpleRoll = config.FindEntry("DungeonToolkitsAuxPurpleRoll", MANUAL);
		DungeonToolkitsNightwatchRoll = config.FindEntry("DungeonToolkitsNightwatchRoll", MANUAL);
		DungeonPotionsRoll = config.FindEntry("DungeonPotionsRoll", MANUAL);
		DungeonBlueprintsRoll = config.FindEntry("DungeonBlueprintsRoll", MANUAL);
		DungeonTheatricsRoll = config.FindEntry("DungeonTheatricsRoll", MANUAL);		
		ScenarioAugmentsGreenRoll = config.FindEntry("ScenarioAugmentsGreenRoll", MANUAL);
		ScenarioAugmentsBlueRoll = config.FindEntry("ScenarioAugmentsBlueRoll", MANUAL);
		ScenarioAugmentsPurpleRoll = config.FindEntry("ScenarioAugmentsPurpleRoll", MANUAL);
		ScenarioAugmentsGoldRoll = config.FindEntry("ScenarioAugmentsGoldRoll", MANUAL);
		ScenarioMinesRoll = config.FindEntry("ScenarioMinesRoll", MANUAL);
		ScenarioFirstAidRoll = config.FindEntry("ScenarioFirstAidRoll", MANUAL);
		ScenarioBearArmsRoll = config.FindEntry("ScenarioBearArmsRoll", MANUAL);
		ScenarioWeaponsRoll = config.FindEntry("ScenarioWeaponsRoll", MANUAL);
		ScenarioToolkitsRoll = config.FindEntry("ScenarioToolkitsRoll", MANUAL);
		ScenarioPotionsRoll = config.FindEntry("ScenarioPotionsRoll", MANUAL);
		ScenarioTheatricsRoll = config.FindEntry("ScenarioTheatricsRoll", MANUAL);
		ScenarioGadgetsRoll = config.FindEntry("ScenarioGadgetsRoll", MANUAL);
		WeaponsGreenTenRoll = config.FindEntry("WeaponsGreenTenRoll", MANUAL);
		WeaponsBlueTenRoll = config.FindEntry("WeaponsBlueTenRoll", MANUAL);
		WeaponsGreenLessThanTenRoll = config.FindEntry("WeaponsGreenLessThanTenRoll", MANUAL);
		WeaponsBlueLessThanTenRoll = config.FindEntry("WeaponsBlueLessThanTenRoll", MANUAL);
		WeaponsPurpleRoll = config.FindEntry("WeaponsPurpleRoll", MANUAL);
		ToolkitsGreenRoll = config.FindEntry("ToolkitsGreenRoll", MANUAL);
		ToolkitsBlueRoll = config.FindEntry("ToolkitsBlueRoll", MANUAL);
		ToolkitsPurpleRoll = config.FindEntry("ToolkitsPurpleRoll", MANUAL);
		PotionsRoll = config.FindEntry("PotionsRoll", MANUAL);
		SignetsGreenRoll = config.FindEntry("SignetsGreenRoll", MANUAL);
		SignetsBlueRoll = config.FindEntry("SignetsBlueRoll", MANUAL);
		SignetsPurpleRoll = config.FindEntry("SignetsPurpleRoll", MANUAL);
		FragmentsGreenRoll = config.FindEntry("FragmentsGreenRoll", MANUAL);
		FragmentsBlueRoll = config.FindEntry("FragmentsBlueRoll", MANUAL);
		FragmentsPurpleRoll = config.FindEntry("FragmentsPurpleRoll", MANUAL);
		TheatricsRoll = config.FindEntry("TheatricsRoll", MANUAL);
		SequinsRoll = config.FindEntry("SequinsRoll", MANUAL);
		GadgetsRoll = config.FindEntry("GadgetsRoll", MANUAL);
		TokyoRareCocktailRoll = config.FindEntry("TokyoRareCocktailRoll", MANUAL);
		AegisModuleGreenRoll = config.FindEntry("AegisModuleGreenRoll", MANUAL);
		AegisModuleBlueRoll = config.FindEntry("AegisModuleBlueRoll", MANUAL);
		AegisModulePurpleRoll = config.FindEntry("AegisModulePurpleRoll", MANUAL);
		AegisCapacitorlessThen4Roll = config.FindEntry("AegisCapacitorlessThen4Roll", MANUAL); //Green
		AegisCapacitorMoreThen5Roll = config.FindEntry("AegisCapacitorMoreThen5Roll", MANUAL); //Green
		AegisCapacitorlessThen4BlueRoll = config.FindEntry("AegisCapacitorlessThen4BlueRoll", MANUAL);
		AegisCapacitorMoreThen5BlueRoll = config.FindEntry("AegisCapacitorMoreThen5BlueRoll", MANUAL);
		AegisCapacitorlessThen4PurpleRoll = config.FindEntry("AegisCapacitorlessThen4PurpleRoll", MANUAL);
		AegisCapacitorMoreThen5PurpleRoll = config.FindEntry("AegisCapacitorMoreThen5PurpleRoll", MANUAL);
		/*
		AegisControllerGreenRoll = config.FindEntry("AegisControllerGreenRoll", MANUAL);
		AegisControllerBlueRoll = config.FindEntry("AegisControllerBlueRoll", MANUAL);
		AegisControllerPurpleRoll = config.FindEntry("AegisControllerPurpleRoll", MANUAL);
		TokyoTokenRoll = config.FindEntry("TokyoTokenRoll", MANUAL);
		*/
		UnusualFilthSampleRoll = config.FindEntry("UnusualFilthSampleRoll", MANUAL);
		
		FIFOToggle = config.FindEntry("FIFOToggle", true);
		AutoNBGToggle = config.FindEntry("AutoNBGToggle", true);
		// AutoNBGDisableRollwindow = config.FindEntry("AutoNBGDisableRollwindow", true);
	}
}

function SlotShowNeedGreedWindow(lootBagId:ID32, itemPos:Number, item:InventoryItem, timeout:Number):Void
{
	if (!AutoNBGToggle) return;
	
	switch(ModeCheck())
	{
		case SCENARIO: 
			//UtilsBase.PrintChatText("AutoNBG: In SCENARIO.");
			NBGScenarios(lootBagId, itemPos, item, timeout);
			break;
		case DUNGEON: 
			//UtilsBase.PrintChatText("AutoNBG: In DUNGEON.");
			NBGDungeons(lootBagId, itemPos, item, timeout);
			break;
		case RAID: 
			UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Inactive during NY raid.");
			//NBGRaid(lootBagId, itemPos, item, timeout);
			break;
		case GENERAL: 
			//UtilsBase.PrintChatText("AutoNBG: In GENERAL.");
			NBGGeneral(lootBagId, itemPos, item, timeout);
			break;
		default:
			UtilsBase.PrintChatText("AutoNBG: ERROR: Not in understood zone.");
			break;
	}
}

function RollNBG(lootBagId:ID32, itemPos:Number, item:InventoryItem, roll:Number)	

{
	switch(roll)
	{
		case MANUAL:
		if (FIFOToggle) FIFOManualRoll(item);
			break;
		case NEED:
			if (FIFOToggle) FIFONeedRoll(item);
			NeedGreed.Need(lootBagId, itemPos);
			break;
		case GREED:
			if (FIFOToggle) FIFOGreedRoll(item);
			NeedGreed.Greed(lootBagId, itemPos);
			break;
		case PASS:
			if (FIFOToggle) FIFOPassRoll(item);
			NeedGreed.Pass(lootBagId, itemPos);
			break;
		default:
			UtilsBase.PrintChatText("AutoNBG: " + roll + " is not a valid roll selection. Something has gone horribly wrong. Please report this to the author. You probably should stop using this mod or never do again whatever you just did.");
			break;
	}
}

function ModeCheck():Number
{
	switch(_root.waypoints.m_PlayfieldID)
	{
		case 7600: //Hotel
			//UtilsBase.PrintChatText("AutoNBG: In Hotel.");
			return SCENARIO;
			break;
		case 7610: //Mansion
			//UtilsBase.PrintChatText("AutoNBG: In Mansion.");
			return SCENARIO;
			break;
		case 7620: //Castle
			//UtilsBase.PrintChatText("AutoNBG: In Castle.");
			return SCENARIO;
			break;
		case 7601: //Hotel
			//UtilsBase.PrintChatText("AutoNBG: In Hotel.");
			return SCENARIO;
			break;
		case 7611: //Mansion
			//UtilsBase.PrintChatText("AutoNBG: In Mansion.");
			return SCENARIO;
			break;
		case 7621: //Castle
			//UtilsBase.PrintChatText("AutoNBG: In Castle.");
			return SCENARIO;
			break;
		case 7602: //Hotel
			//UtilsBase.PrintChatText("AutoNBG: In Hotel.");
			return SCENARIO;
			break;
		case 7612: //Mansion
			//UtilsBase.PrintChatText("AutoNBG: In Mansion.");
			return SCENARIO;
			break;
		case 7622: //Castle
			//UtilsBase.PrintChatText("AutoNBG: In Castle.");
			return SCENARIO;
			break;
		case 7603: //Hotel
			//UtilsBase.PrintChatText("AutoNBG: In Hotel.");
			return SCENARIO;
			break;
		case 7613: //Mansion
			//UtilsBase.PrintChatText("AutoNBG: In Mansion.");
			return SCENARIO;
			break;
		case 7623: //Castle
			//UtilsBase.PrintChatText("AutoNBG: In Castle.");
			return SCENARIO;
			break;			
		case 5040: //Polaris
			//UtilsBase.PrintChatText("AutoNBG: In Polaris.");
			return DUNGEON;
			break;
		case 5140: //Hell Raised
			//UtilsBase.PrintChatText("AutoNBG: In Hell Raised.");
			return DUNGEON;
			break;
		case 5170: //Darkness Wars
			//UtilsBase.PrintChatText("AutoNBG: In Darkness Wars.");
			return DUNGEON;
			break;
		case 5080: //The Ankh
			//UtilsBase.PrintChatText("AutoNBG: In The Ankh.");
			return DUNGEON;
			break;
		case 5150: //Hell Fallen
			//UtilsBase.PrintChatText("AutoNBG: In Hell Fallen.");
			return DUNGEON;
			break;
		case 5190: //Facility
			//UtilsBase.PrintChatText("AutoNBG: In Facility.");
			return DUNGEON;
			break;
		case 5160: //Hell Eternal
			//UtilsBase.PrintChatText("AutoNBG: In Hell Eternal.");
			return DUNGEON;
			break;
		case 5000: //Slaughterhouse
			//UtilsBase.PrintChatText("AutoNBG: In Slaughterhouse.");
			return DUNGEON;
			break;
		case 5710: //NYRaid
			//UtilsBase.PrintChatText("AutoNBG: In NYRaid.");
			return RAID;
			break;
		default:
			//UtilsBase.PrintChatText("AutoNBG: Not in Scenario or Dungeon.");
			return GENERAL;
			break;
	}
}

function NBGScenarios(lootBagId:ID32, itemPos:Number, item:InventoryItem, timeout:Number):Void
{
	if (item.m_Rarity == 2) //Green
	{
		if (item.m_ItemType == 1) //Weapons
		{
			RollNBG(lootBagId, itemPos, item, ScenarioWeaponsRoll);
			return;
		}
		
		if (item.m_ItemType == 2) //Talisman
		{
			RollNBG(lootBagId, itemPos, item, ScenarioWeaponsRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 5128296) //Glyphs
		{
			RollNBG(lootBagId, itemPos, item, ScenarioWeaponsRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 191246932) //Toolkits
		{
			RollNBG(lootBagId, itemPos, item, ScenarioToolkitsRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 180871029) //Potions
		{
			RollNBG(lootBagId, itemPos, item, ScenarioPotionsRoll);
			return;
		}
		
		if ((item.m_ItemTypeGUI == 37701508) || (item.m_ItemTypeGUI == 54475780) || (item.m_ItemTypeGUI == 205404756) || (item.m_ItemTypeGUI == 80435316) || (item.m_ItemTypeGUI == 52991092))//Augments
		{
			RollNBG(lootBagId, itemPos, item, ScenarioAugmentsGreenRoll);
			return;
		}
		
		if ((item.m_Icon.GetInstance() == 7465819) || (item.m_Icon.GetInstance() == 7013424) || (item.m_Icon.GetInstance() == 7473833) || (item.m_Icon.GetInstance() == 7465823)) //Mines
		{
			RollNBG(lootBagId, itemPos, item, ScenarioMinesRoll);
			return;
		}
		
		if (item.m_Icon.GetInstance() == 7438102) //First Aid Kit
		{
			RollNBG(lootBagId, itemPos, item, ScenarioFirstAidRoll);
			return;
		}
		
		if (item.m_Icon.GetInstance() == 7519365) //Bear Arms
		{
			RollNBG(lootBagId, itemPos, item, ScenarioBearArmsRoll);
			return;
		}
		
		if (item.m_Icon.GetInstance() == 7911511) //Theatrics
		{
			RollNBG(lootBagId, itemPos, item, ScenarioTheatricsRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 226155763) //Gadgets
		{
			RollNBG(lootBagId, itemPos, item, ScenarioGadgetsRoll);
			return;
		}
	}
	
	if (item.m_Rarity == 3) //Blue
	{
		if (item.m_ItemType == 1)//WEAPON
		{
			RollNBG(lootBagId, itemPos, item, ScenarioWeaponsRoll);
			return;
		}
		
		if (item.m_ItemType == 2)//TALISMAN
		{
			RollNBG(lootBagId, itemPos, item, ScenarioWeaponsRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 5128296) //Glyphs
		{
			RollNBG(lootBagId, itemPos, item, ScenarioWeaponsRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 191246932) //Toolkits
		{
			RollNBG(lootBagId, itemPos, item, ScenarioToolkitsRoll);
			return;
		}
		
		if ((item.m_ItemTypeGUI == 37701508) || (item.m_ItemTypeGUI == 54475780) || (item.m_ItemTypeGUI == 205404756) || (item.m_ItemTypeGUI == 80435316) || (item.m_ItemTypeGUI == 52991092))//Augments
		{
			RollNBG(lootBagId, itemPos, item, ScenarioAugmentsBlueRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 226155763) //Gadgets
		{
			RollNBG(lootBagId, itemPos, item, ScenarioGadgetsRoll);
			return;
		}
	}
	
	if (item.m_Rarity == 4) //Purple
	{
		if (item.m_ItemType == 1) //Weapons
		{
			RollNBG(lootBagId, itemPos, item, ScenarioWeaponsRoll);
			return;
		}
		
		if (item.m_ItemType == 2)//Talisman
		{
			RollNBG(lootBagId, itemPos, item, ScenarioWeaponsRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 5128296) //Glyphs
		{
			RollNBG(lootBagId, itemPos, item, ScenarioWeaponsRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 191246932) //Toolkits
		{
			RollNBG(lootBagId, itemPos, item, ScenarioToolkitsRoll);
			return;
		}
		
		if ((item.m_ItemTypeGUI == 37701508) || (item.m_ItemTypeGUI == 54475780) || (item.m_ItemTypeGUI == 205404756) || (item.m_ItemTypeGUI == 80435316) || (item.m_ItemTypeGUI == 52991092))//Augments
		{
			RollNBG(lootBagId, itemPos, item, ScenarioAugmentsPurpleRoll);
			return;
		}
	}
	
	if (item.m_Rarity == 5) //Yellow
	{
		if ((item.m_ItemTypeGUI == 37701508) || (item.m_ItemTypeGUI == 54475780) || (item.m_ItemTypeGUI == 205404756) || (item.m_ItemTypeGUI == 80435316) || (item.m_ItemTypeGUI == 52991092))//Augments
		{
			RollNBG(lootBagId, itemPos, item, ScenarioAugmentsGoldRoll);
			return;
		}
	}
	
	if (item.m_Rarity == 1)
	{
		UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: " + item.m_Name + " is a common item. Please adjust the Need/Greed threshold for your group to 'Uncommon'.");
	}
	
	UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: " + item.m_Name + " is an unknown or unexpected item. Report: Mode=Scenario. Zone=" + _root.waypoints.m_PlayfieldID + ". itemtypegui=" + item.m_ItemTypeGUI + ". m_Icon.Instance=" + item.m_Icon.GetInstance());
}

function NBGDungeons(lootBagId:ID32, itemPos:Number, item:InventoryItem, timeout:Number):Void
{
	if (item.m_Rarity == 2) //Green
	{
		if (item.m_ItemType == 1) //Weapons
		{
			if (item.m_Rank < 10)
			{
				RollNBG(lootBagId, itemPos, item, DungeonWeaponsGreenLessThanTenRoll);
				return;
			}
			if (item.m_Rank == 10)
			{
				RollNBG(lootBagId, itemPos, item, DungeonWeaponsGreenTenRoll);
				return;
			}
		}
		if (item.m_ItemType == 2) //Talisman
		{
			if (item.m_Rank < 10)
			{
				RollNBG(lootBagId, itemPos, item, DungeonTalismansGreenLessThanTenRoll);
				return;
			}
			if (item.m_Rank == 10)
			{
				RollNBG(lootBagId, itemPos, item, DungeonTalismansGreenTenRoll);
				return;
			}
		}
		
		if (item.m_ItemTypeGUI == 5128296) //Glyphs
		{
			if (item.m_Rank < 10)
			{
				RollNBG(lootBagId, itemPos, item, DungeonTalismansGreenLessThanTenRoll);
				return;
			}
			if (item.m_Rank == 10)
			{
				RollNBG(lootBagId, itemPos, item, DungeonTalismansGreenTenRoll);
				return;
			}
		}
		
		if (item.m_ItemTypeGUI == 191246932) //Toolkits
		{
			RollNBG(lootBagId, itemPos, item, DungeonToolkitsGreenRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 180871029) //Potions
		{
			RollNBG(lootBagId, itemPos, item, DungeonPotionsRoll);
			return;
		}

		if (item.m_Icon.GetInstance() == 7911511) //Theatrics
		{
			RollNBG(lootBagId, itemPos, item, DungeonTheatricsRoll);
			return;
		}
		
		if ((item.m_ItemTypeGUI == 0) && !(item.m_Icon.GetInstance() == 7911511)) //Blueprints (not Theatrics)
		{
			RollNBG(lootBagId, itemPos, item, DungeonBlueprintsRoll);
			return;
		}
	}
	
	if (item.m_Rarity == 3) //Blue
	{
		if (item.m_ItemType == 1)//WEAPON
		{
			if (item.m_Rank < 10)
			{
				RollNBG(lootBagId, itemPos, item, DungeonWeaponsBlueLessThanTenRoll);
				return;
			}
			if (item.m_Rank == 10)
			{
				RollNBG(lootBagId, itemPos, item, DungeonWeaponsBlueTenRoll);
				return;
			}
		}
		
		if (item.m_ItemType == 2)//TALISMAN
		{
			if (item.m_Rank < 10)
			{
				RollNBG(lootBagId, itemPos, item, DungeonTalismansBlueLessThanTenRoll);
				return;
			}
			if (item.m_Rank == 10)
			{
				RollNBG(lootBagId, itemPos, item, DungeonTalismansBlueTenRoll);
				return;
			}
		}
		
		if (item.m_ItemTypeGUI == 5128296) //Glyphs
		{
			if (item.m_Rank < 10)
			{
				RollNBG(lootBagId, itemPos, item, DungeonTalismansBlueLessThanTenRoll);
				return;
			}
			if (item.m_Rank == 10)
			{
				RollNBG(lootBagId, itemPos, item, DungeonTalismansBlueTenRoll);
				return;
			}
		}
		
		if (item.m_ItemTypeGUI == 191246932) //Toolkits
		{
			if (item.m_Icon.GetInstance() == 7895146) //Aux Kit
			{
				RollNBG(lootBagId, itemPos, item, DungeonToolkitsAuxBlueRoll);
				return;
			}
			
			RollNBG(lootBagId, itemPos, item, DungeonToolkitsBlueRoll);
			return;
		}
	}
	
	if (item.m_Rarity == 4) //Purple
	{
		if (item.m_ItemType == 1) //Weapons
		{
			RollNBG(lootBagId, itemPos, item, DungeonWeaponsPurpleRoll);
			return;
		}
		
		if (item.m_ItemType == 2)//Talisman
		{
			RollNBG(lootBagId, itemPos, item, DungeonTalismansPurpleRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 5128296) //Glyphs
		{
			RollNBG(lootBagId, itemPos, item, DungeonTalismansPurpleRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 191246932) //Toolkits
		{
			if (item.m_Icon.GetInstance() == 7895146) //Aux Kit
			{
				RollNBG(lootBagId, itemPos, item, DungeonToolkitsAuxPurpleRoll);
				return;
			}
			
			if (item.m_Icon.GetInstance() == 7355223) //Nightwatch Glyph Kit
			{
				RollNBG(lootBagId, itemPos, item, DungeonToolkitsNightwatchRoll);
				return;
			}
			
			RollNBG(lootBagId, itemPos, item, DungeonToolkitsPurpleRoll);
			return;
		}
	}
	
	if (item.m_Rarity == 1)
	{
		UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: " + item.m_Name + " is a common item. Please adjust the Need/Greed threshold for your group to 'Uncommon'.");
	}
	
	
	UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: " + item.m_Name + " is an unknown or unexpected item. Report: Mode=Dungeons. Zone=" + _root.waypoints.m_PlayfieldID + ". itemtypegui=" + item.m_ItemTypeGUI + ". m_Icon.Instance=" + item.m_Icon.GetInstance());
}

function NBGGeneral(lootBagId:ID32, itemPos:Number, item:InventoryItem, timeout:Number):Void
{
	if (item.m_Rarity == 2) //Green
	{
		if (item.m_ItemType == 1) //Weapons
		{
			if (item.m_Rank < 10)
			{
				RollNBG(lootBagId, itemPos, item, WeaponsGreenLessThanTenRoll);
				return;
			}
			if (item.m_Rank == 10 || item.m_Icon.GetInstance() == 8130722)
			{
				RollNBG(lootBagId, itemPos, item, WeaponsGreenTenRoll);
				return;
			}
		}
		if (item.m_ItemType == 2) //Talisman
		{
			if (item.m_Rank < 10)
			{
				RollNBG(lootBagId, itemPos, item, WeaponsGreenLessThanTenRoll);
				return;
			}
			if (item.m_Rank == 10)
			{
				RollNBG(lootBagId, itemPos, item, WeaponsGreenTenRoll);
				return;
			}
		}
		
		if (item.m_ItemTypeGUI == 5128296) //Glyphs
		{
			if (item.m_Rank < 10)
			{
				RollNBG(lootBagId, itemPos, item, WeaponsGreenLessThanTenRoll);
				return;
			}
			if (item.m_Rank == 10)
			{
				RollNBG(lootBagId, itemPos, item, WeaponsGreenTenRoll);
				return;
			}
		}
		
		if (item.m_ItemTypeGUI == 94364868) //Signets
		{
			RollNBG(lootBagId, itemPos, item, SignetsGreenRoll);
			return;
		}
		
		if ((item.m_Icon.GetInstance() >= 7895156) && (item.m_Icon.GetInstance() <= 7895163)) //Aux Signets
		{
			RollNBG(lootBagId, itemPos, item, SignetsGreenRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 191246932) //Toolkits
		{
			RollNBG(lootBagId, itemPos, item, ToolkitsGreenRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 180871029) //Potions
		{
			RollNBG(lootBagId, itemPos, item, PotionsRoll);
			return;
		}
		
		if (item.m_Icon.GetInstance() == 7911511) //Theatrics
		{
			RollNBG(lootBagId, itemPos, item, TheatricsRoll);
			return;
		}
		
		if ((item.m_Icon.GetInstance() == 7466290) || (item.m_Icon.GetInstance() == 7466287) || (item.m_Icon.GetInstance() == 7466289))//Sequins
		{
			RollNBG(lootBagId, itemPos, item, SequinsRoll);
			return;
		}
		if (item.m_ItemTypeGUI == 24905333) //Aegis Module
		{
			RollNBG(lootBagId, itemPos, item, AegisModuleGreenRoll);
			return;
		}
		if (item.m_Icon.GetInstance() == 8500481) //UnusualFilthSample
		{
			RollNBG(lootBagId, itemPos, item, UnusualFilthSampleRoll);
			return;
		}
		if (item.m_ItemTypeGUI == 228394866) //Aegis Capacitor
		{
			if (item.m_Rank <= 4)
			{
				RollNBG(lootBagId, itemPos, item, AegisCapacitorlessThen4Roll);
				return;
			}
			if (item.m_Rank >= 5)
			{
				RollNBG(lootBagId, itemPos, item, AegisCapacitorMoreThen5Roll);
				return;
			}
		}
	}
	
	if (item.m_Rarity == 3) //Blue
	{
		if (item.m_ItemType == 1)//WEAPON
		{
			if (item.m_Rank < 10)
			{
				RollNBG(lootBagId, itemPos, item, WeaponsBlueLessThanTenRoll);
				return;
			}
			if (item.m_Rank == 10)
			{
				RollNBG(lootBagId, itemPos, item, WeaponsBlueTenRoll);
				return;
			}
		}
		
		if (item.m_ItemType == 2)//TALISMAN
		{
			if (item.m_Rank < 10)
			{
				RollNBG(lootBagId, itemPos, item, WeaponsBlueLessThanTenRoll);
				return;
			}
			if (item.m_Rank == 10)
			{
				RollNBG(lootBagId, itemPos, item, WeaponsBlueTenRoll);
				return;
			}
		}
		
		if (item.m_ItemTypeGUI == 5128296) //Glyphs
		{
			if (item.m_Rank < 10)
			{
				RollNBG(lootBagId, itemPos, item, WeaponsBlueLessThanTenRoll);
				return;
			}
			if (item.m_Rank == 10)
			{
				RollNBG(lootBagId, itemPos, item, WeaponsBlueTenRoll);
				return;
			}
		}
		
		if (item.m_ItemTypeGUI == 197642084)//Fragments
		{
			RollNBG(lootBagId, itemPos, item, FragmentsBlueRoll);
			return;
		}
		
		if ((item.m_Icon.GetInstance() >= 7895156) && (item.m_Icon.GetInstance() <= 7895163)) //Aux Signets
		{
			RollNBG(lootBagId, itemPos, item, SignetsBlueRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 94364868) //Signets
		{
			RollNBG(lootBagId, itemPos, item, SignetsBlueRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 191246932) //Toolkits
		{
			RollNBG(lootBagId, itemPos, item, ToolkitsBlueRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 226155763) //Gadgets
		{
			RollNBG(lootBagId, itemPos, item, GadgetsRoll);
			return;
		}
		if ((item.m_ItemTypeGUI == 180871029) || (item.m_Icon.GetInstance() == 7473831) || (item.m_Icon.GetInstance() == 7473832) || (item.m_Icon.GetInstance() == 7473835) || (item.m_Icon.GetInstance() == 7487430)) //tokyo Cocktail & Consumab
		{
			RollNBG(lootBagId, itemPos, item, TokyoRareCocktailRoll);
			return;
		}
	}
	
	if (item.m_Rarity == 4) //Purple
	{
		if (item.m_ItemType == 1) //Weapons
		{
			RollNBG(lootBagId, itemPos, item, WeaponsPurpleRoll);
			return;
		}
		
		if (item.m_ItemType == 2)//Talisman
		{
			RollNBG(lootBagId, itemPos, item, WeaponsPurpleRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 5128296) //Glyphs
		{
			RollNBG(lootBagId, itemPos, item, WeaponsPurpleRoll);
			return;
		}
		
		if ((item.m_ItemTypeGUI == 197642084) || (item.m_Icon.GetInstance() == 6698994))//Fragments
		{
			RollNBG(lootBagId, itemPos, item, FragmentsPurpleRoll);
			return;
		}
		
		if ((item.m_Icon.GetInstance() >= 7895156) && (item.m_Icon.GetInstance() <= 7895163)) //Aux Signets
		{
			RollNBG(lootBagId, itemPos, item, SignetsPurpleRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 94364868) //Signets
		{
			RollNBG(lootBagId, itemPos, item, SignetsPurpleRoll);
			return;
		}
		
		if (item.m_ItemTypeGUI == 191246932) //Toolkits
		{
			RollNBG(lootBagId, itemPos, item, ToolkitsPurpleRoll);
			return;
		}
	}
	
	if (item.m_Rarity == 1)
	{
		UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: " + item.m_Name + " is a common item. Please adjust the Need/Greed threshold for your group to 'Uncommon'.");
	}
	
	UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: " + item.m_Name + " is an unknown or unexpected item. Report: Mode=General. Zone=" + _root.waypoints.m_PlayfieldID + ". itemtypegui=" + item.m_ItemTypeGUI + ". m_Icon.Instance=" + item.m_Icon.GetInstance());
}

function FIFOManualRoll(item:InventoryItem):Void
{
	if (item.m_Rarity == 2) //Green
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Rolling Need for <font color='#2EFE2E'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Manual for <font color='#2EFE2E'>" + item.m_Name + "</font>.", 0);
	}
	
	if (item.m_Rarity == 3) //Blue
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Rolling Need for <font color='#235BC3'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Manual for <font color='#235BC3'>" + item.m_Name + "</font>.", 0);
	}
	
	if (item.m_Rarity == 4) //Purple
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Rolling Need for <font color='#642EFE'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Manual for <font color='#9A2EFE'>" + item.m_Name + "</font>.", 0);
	}
	
	if (item.m_Rarity == 5) //Yellow
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Rolling Need for <font color='#ffff00'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Manual for <font color='#ffff00'>" + item.m_Name + "</font>.", 0);
	}
}

function FIFONeedRoll(item:InventoryItem):Void
{
	if (item.m_Rarity == 2) //Green
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Rolling Need for <font color='#2EFE2E'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Rolling Need for <font color='#2EFE2E'>" + item.m_Name + "</font>.", 0);
	}
	
	if (item.m_Rarity == 3) //Blue
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Rolling Need for <font color='#235BC3'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Rolling Need for <font color='#235BC3'>" + item.m_Name + "</font>.", 0);
	}
	
	if (item.m_Rarity == 4) //Purple
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Rolling Need for <font color='#642EFE'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Rolling Need for <font color='#9A2EFE'>" + item.m_Name + "</font>.", 0);
	}
	
	if (item.m_Rarity == 5) //Yellow
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Rolling Need for <font color='#ffff00'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Rolling Need for <font color='#ffff00'>" + item.m_Name + "</font>.", 0);
	}
}

function FIFOGreedRoll(item:InventoryItem):Void
{
	if (item.m_Rarity == 2) //Green
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Rolling Greed for <font color='#2EFE2E'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Rolling Greed for <font color='#2EFE2E'>" + item.m_Name + "</font>.", 0);
	}
	
	if (item.m_Rarity == 3) //Blue
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Rolling Greed for <font color='#235BC3'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Rolling Greed for <font color='#235BC3'>" + item.m_Name + "</font>.", 0);
	}
	
	if (item.m_Rarity == 4) //Purple
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Rolling Greed for <font color='#642EFE'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Rolling Greed for <font color='#9A2EFE'>" + item.m_Name + "</font>.", 0);
	}
	
	if (item.m_Rarity == 5) //Yellow
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Rolling Greed for <font color='#ffff00'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Rolling Greed for <font color='#ffff00'>" + item.m_Name + "</font>.", 0);
	}
}

function FIFOPassRoll(item:InventoryItem):Void
{
	if (item.m_Rarity == 2) //Green
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Passing on <font color='#2EFE2E'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Passing on <font color='#2EFE2E'>" + item.m_Name + "</font>.", 0);
	}
	
	if (item.m_Rarity == 3) //Blue
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Passing on <font color='#235BC3'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Passing on <font color='#235BC3'>" + item.m_Name + "</font>.", 0);
	}
	
	if (item.m_Rarity == 4) //Purple
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Passing on <font color='#642EFE'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Passing on <font color='#9A2EFE'>" + item.m_Name + "</font>.", 0);
	}
	
	if (item.m_Rarity == 5) //Yellow
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Passing on <font color='#ffff00'>" + item.m_Name + "</font>.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Passing on <font color='#ffff00'>" + item.m_Name + "</font>.", 0);
	}
}

function SlotPlayfieldChanged(newPlayfield:Number):Void
{
	if (newPlayfield == 5710)
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Inactive during NY raid.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Inactive during NY raid.", 0);
	}
}