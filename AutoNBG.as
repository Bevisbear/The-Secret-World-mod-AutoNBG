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

var VTIOAddonInfo:String = "AutoNBG|Shittakaburi & Bevis|1.7.10| AutoNBGWindowOn|_root.autonbg\\autonbg.m_Icon";

var m_CompassCheckTimerID:Number;
var m_CompassCheckTimerLimit:Number = 256;
var m_CompassCheckTimerCount:Number = 0;
var m_WindowPosition:Point = new Point();
var m_AutoNBGWindow:MovieClip;
var m_Icon:MovieClip;
var m_tooltip:TooltipInterface;
var m_VTIOIsLoadedMonitor:DistributedValue;

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
var PotionsRareRoll:Number = MANUAL;
var PotionsPurpleRoll:Number = MANUAL;
var SignetsGreenRoll:Number = MANUAL;
var SignetsBlueRoll:Number = MANUAL;
var SignetsPurpleRoll:Number = MANUAL;
var FragmentsGreenRoll:Number = MANUAL;
var FragmentsBlueRoll:Number = MANUAL;
var FragmentsPurpleRoll:Number = MANUAL;
var TheatricsRoll:Number = MANUAL;
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
var DungeonAEGISToolkitsBlueRoll:Number = MANUAL;
var DungeonMKToolkitsBlueRoll:Number = MANUAL;
var DungeonToolkitsAuxBlueRoll:Number = MANUAL;
var DungeonToolkitsPurpleRoll:Number = MANUAL;
var DungeonToolkitsAuxPurpleRoll:Number = MANUAL;
var DungeonToolkitsNightwatchRoll:Number = MANUAL;
var DungeonAEGISToolkitsPurpleRoll:Number = MANUAL;
var DungeonMKToolkitsPurpleRoll:Number = MANUAL;
var DungeonGadgetGreenRoll:Number = MANUAL;
var DungeonGadgetBlueRoll:Number = MANUAL;
var DungeonPotionsRoll:Number = MANUAL;
var DungeonBlueprintsRoll:Number = MANUAL;
var DungeonTheatricsRoll:Number = MANUAL;
var DungeonUtaLoreRoll:Number = MANUAL;  //Uta's Contract
var DungeonCatEarsRoll:Number = MANUAL;  //Cat Ears
var DuAegisCapacitorlessThen4Roll:Number = MANUAL;  //Green
var DuAegisCapacitorMoreThen5Roll:Number = MANUAL;  //Green
var DuAegisCapacitorlessThen4BlueRoll:Number = MANUAL;
var DuAegisCapacitorMoreThen5BlueRoll:Number = MANUAL;
var DuAegisCapacitorlessThen4PurpleRoll:Number = MANUAL;
var DuAegisCapacitorMoreThen5PurpleRoll:Number = MANUAL;
var DuAEConvalescencelessThen4Roll:Number = MANUAL;  //Green
var DuAEConvalescenceMoreThen5Roll:Number = MANUAL;  //Green
var DuAEConvalescenceThen4BlueRoll:Number = MANUAL;
var DuAEConvalescenceMoreThen5BlueRoll:Number = MANUAL;
var DuAEConvalescenceThen4PurpleRoll:Number = MANUAL;
var DuAEConvalescenceMoreThen5PurpleRoll:Number = MANUAL;
var DuAERampartlessThen4Roll:Number = MANUAL;  //Green
var DuAERampartMoreThen5Roll:Number = MANUAL;  //Green
var DuAERampartThen4BlueRoll:Number = MANUAL;
var DuAERampartMoreThen5BlueRoll:Number = MANUAL;
var DuAERampartThen4PurpleRoll:Number = MANUAL;
var DuAERampartMoreThen5PurpleRoll:Number = MANUAL;
var DuAegisModuleGreenRoll:Number = MANUAL;
var DuAegisModuleBlueRoll:Number = MANUAL;
var DuAegisModulePurpleRoll:Number = MANUAL;
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

var BlackBullionRoll:Number = MANUAL;

var ESocksRRoll:Number = MANUAL;
var ESocksLRoll:Number = MANUAL;
var EPWPRoll:Number = MANUAL;
var EPoTTDRoll:Number = MANUAL;
var EGrimGlamourGreenRoll:Number = MANUAL;
var EGrimGlamourBlueRoll:Number = MANUAL;
var EGrimGlamourPurpleRoll:Number = MANUAL;
var EFamineRoll:Number = MANUAL;
var ENPNRRoll:Number = MANUAL;


var SCENARIO:Number = 0;
var DUNGEON:Number = 1;
var RAID:Number = 2;
var GENERAL:Number = 3;

var FIFOToggle:Boolean = true;
var AutoNBGToggle:Boolean = true;


function onLoad() {
	m_VTIOIsLoadedMonitor = DistributedValue.Create("VTIO_IsLoaded");
	m_VTIOIsLoadedMonitor.SignalChanged.Connect(SlotCheckVTIOIsLoaded, this);
  m_AutoNBGWindowOn.SetValue(false);
	m_AutoNBGWindowOn.SignalChanged.Connect(SlotWindowOnChanged, this);
	m_Icon = attachMovie("Icon", "m_Icon", getNextHighestDepth());
	m_Icon._width = 18;
	m_Icon._height = 18;
	m_Icon.onMousePress = function(buttonID) {
		if (buttonID == 1) {
			// Do left mouse button stuff.
			if (m_Tooltip != undefined)	m_Tooltip.Close();
			SetOptionWindow(m_AutoNBGWindow == undefined || !m_AutoNBGWindow._visible);
		} else if (buttonID == 2) {
			// Do right mouse button stuff.
		}
	}
	m_Icon.onRollOver = function() {
		if (m_Tooltip != undefined) m_Tooltip.Close();
        var tooltipData:TooltipData = new TooltipData();
		tooltipData.AddAttribute("", "<font face='_StandardFont' size='13' color='#FF8000'><b>AutoNBG v 1.7.10</b></font>");
        tooltipData.AddAttributeSplitter();
        tooltipData.AddAttribute("", "");
        tooltipData.AddAttribute("", "<font face='_StandardFont' size='12' color='#FFFFFF'>Open/Close AutoNBG Config.</font>");
        tooltipData.m_Padding = 4;
        tooltipData.m_MaxWidth = 210;
		m_Tooltip = TooltipManager.GetInstance().ShowTooltip(undefined, TooltipInterface.e_OrientationVertical, 0, tooltipData);
	}
	m_Icon.onRollOut = function() {
		if (m_Tooltip != undefined)	m_Tooltip.Close();
	}
	
	m_CompassCheckTimerID = setInterval(PositionIcon, 100);
	PositionIcon();
	SlotCheckVTIOIsLoaded();
	
	NeedGreed.SignalCreateNeedGreedWindow.Connect(SlotShowNeedGreedWindow, this);
	WaypointInterface.SignalPlayfieldChanged.Connect(SlotPlayfieldChanged, this);
 
}
function SlotCheckVTIOIsLoaded()
{
    if (com.GameInterface.DistributedValueBase.GetDValue("VTIO_IsLoaded"))
    {
        com.GameInterface.DistributedValueBase.SetDValue("VTIO_RegisterAddon", VTIOAddonInfo);
    }
}
function SlotOptionWindowState() {
  var open = com.GameInterface.DistributedValueBase.GetDValue("AutoNBGWindowOn");
  SetOptionWindow(open) ;
}
function m_AutoNBGWindowUnload()
{
    m_AutoNBGWindow = undefined;
}
function SetOptionWindow(open) 
{
    if (open)
    {
        if (m_AutoNBGWindow == undefined)
        {
            m_AutoNBGWindow = attachMovie("AutoNBGWindow", "window", getNextHighestDepth());
		        var visibleRect = Stage["visibleRect"];
		        m_AutoNBGWindow._x = (visibleRect.width - m_AutoNBGWindow._width) / 2;
		        m_AutoNBGWindow._y = (visibleRect.height - m_AutoNBGWindow._height) / 2;
            m_AutoNBGWindow.SignalPositionChanged.Connect(SaveWindowPos, this);
            m_AutoNBGWindow.onUnload = mx.utils.Delegate.create(this, m_AutoNBGWindowUnload);
        }
        else
        {
            m_AutoNBGWindow._visible = true;
            m_AutoNBGWindowOn.SetValue(false);
	          m_AutoNBGWindowOn.SignalChanged.Connect(SlotWindowOnChanged, this);
        } // end else if
        com.GameInterface.DistributedValueBase.SetDValue("AutoNBGWindowOn", true);
    }
    else
    {
        if (m_AutoNBGWindow != undefined)
        {
            m_AutoNBGWindow.removeMovieClip();
        } 
        com.GameInterface.DistributedValueBase.SetDValue("AutoNBGWindowOn", false);
    } 
}


function SlotWindowOnChanged(value:DistributedValue):Void
{
	var state:Boolean = value.GetValue();
	m_AutoNBGWindow._visible = state;
	m_AutoNBGWindow.LoadFrameOne();
}

function SlotWindowClosed() 
{
	m_AutoNBGWindow._visible = !m_AutoNBGWindow._visible;
	m_AutoNBGWindowOn.SetValue(false);
	Selection.setFocus(null);
}
function PositionIcon() {
	m_CompassCheckTimerCount++;
	if (m_CompassCheckTimerCount > m_CompassCheckTimerLimit) clearInterval(m_CompassCheckTimerID);
	if (_root.compass._x > 0) {
		clearInterval(m_CompassCheckTimerID);
		m_Icon._x = _root.compass._x - 64;
		m_Icon._y = _root.compass._y + 0;
	}
}


function onEnterFrame()
{

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
	config.AddEntry("DungeonAEGISToolkitsBlueRoll", DungeonAEGISToolkitsBlueRoll);
	config.AddEntry("DungeonMKToolkitsBlueRoll", DungeonMKToolkitsBlueRoll);
	config.AddEntry("DungeonToolkitsAuxBlueRoll", DungeonToolkitsAuxBlueRoll);
	config.AddEntry("DungeonToolkitsPurpleRoll", DungeonToolkitsPurpleRoll);
	config.AddEntry("DungeonToolkitsAuxPurpleRoll", DungeonToolkitsAuxPurpleRoll);
	config.AddEntry("DungeonToolkitsNightwatchRoll", DungeonToolkitsNightwatchRoll);
	config.AddEntry("DungeonAEGISToolkitsPurpleRoll", DungeonAEGISToolkitsPurpleRoll);
	config.AddEntry("DungeonMKToolkitsPurpleRoll", DungeonMKToolkitsPurpleRoll);
	config.AddEntry("DungeonGadgetGreenRoll", DungeonGadgetGreenRoll);
	config.AddEntry("DungeonGadgetBlueRoll", DungeonGadgetBlueRoll);
	config.AddEntry("DungeonPotionsRoll", DungeonPotionsRoll);
	config.AddEntry("DungeonBlueprintsRoll", DungeonBlueprintsRoll);
	config.AddEntry("DungeonTheatricsRoll", DungeonTheatricsRoll);
	config.AddEntry("DungeonUtaLoreRoll", DungeonUtaLoreRoll);
	config.AddEntry("DungeonCatEarsRoll", DungeonCatEarsRoll);
	config.AddEntry("DuAegisCapacitorlessThen4Roll", DuAegisCapacitorlessThen4Roll);
	config.AddEntry("DuAegisCapacitorMoreThen5Roll", DuAegisCapacitorMoreThen5Roll);
	config.AddEntry("DuAegisCapacitorlessThen4BlueRoll", DuAegisCapacitorlessThen4BlueRoll);
	config.AddEntry("DuAegisCapacitorMoreThen5BlueRoll", DuAegisCapacitorMoreThen5BlueRoll);
	config.AddEntry("DuAegisCapacitorlessThen4PurpleRoll", DuAegisCapacitorlessThen4PurpleRoll);
	config.AddEntry("DuAegisCapacitorMoreThen5PurpleRoll", DuAegisCapacitorMoreThen5PurpleRoll);
	config.AddEntry("DuAEConvalescencelessThen4Roll", DuAEConvalescencelessThen4Roll);
	config.AddEntry("DuAEConvalescenceMoreThen5Roll", DuAEConvalescenceMoreThen5Roll);
	config.AddEntry("DuAEConvalescencelessThen4BlueRoll", DuAEConvalescencelessThen4BlueRoll);
	config.AddEntry("DuAEConvalescenceMoreThen5BlueRoll", DuAEConvalescenceMoreThen5BlueRoll);
	config.AddEntry("DuAEConvalescencelessThen4PurpleRoll", DuAEConvalescencelessThen4PurpleRoll);
	config.AddEntry("DuAEConvalescenceMoreThen5PurpleRoll", DuAEConvalescenceMoreThen5PurpleRoll);
	config.AddEntry("DuAERampartlessThen4Roll", DuAERampartlessThen4Roll);
	config.AddEntry("DuAERampartMoreThen5Roll", DuAERampartMoreThen5Roll);
	config.AddEntry("DuAERampartlessThen4BlueRoll", DuAERampartlessThen4BlueRoll);
	config.AddEntry("DuAERampartMoreThen5BlueRoll", DuAERampartMoreThen5BlueRoll);
	config.AddEntry("DuAERampartlessThen4PurpleRoll", DuAERampartlessThen4PurpleRoll);
	config.AddEntry("DuAERampartMoreThen5PurpleRoll", DuAERampartMoreThen5PurpleRoll);
	config.AddEntry("DuAegisModuleGreenRoll", DuAegisModuleGreenRoll);
	config.AddEntry("DuAegisModuleBlueRoll", DuAegisModuleBlueRoll);
	config.AddEntry("DuAegisModulePurpleRoll", DuAegisModulePurpleRoll);
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
	config.AddEntry("PotionsRareRoll", PotionsRareRoll);
	config.AddEntry("SignetsGreenRoll", SignetsGreenRoll);
	config.AddEntry("SignetsBlueRoll", SignetsBlueRoll);
	config.AddEntry("SignetsPurpleRoll", SignetsPurpleRoll);
	config.AddEntry("FragmentsGreenRoll", FragmentsGreenRoll);
	config.AddEntry("FragmentsBlueRoll", FragmentsBlueRoll);
	config.AddEntry("FragmentsPurpleRoll", FragmentsPurpleRoll);
	config.AddEntry("TheatricsRoll", TheatricsRoll);
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
	config.AddEntry("BlackBullionRoll", BlackBullionRoll);
	config.AddEntry("UnusualFilthSampleRoll", UnusualFilthSampleRoll);
	config.AddEntry("ESocksRRoll", ESocksRRoll);
	config.AddEntry("ESocksLRoll", ESocksLRoll);
	config.AddEntry("EPWPRoll", EPWPRoll);
	config.AddEntry("EPoTTDRoll", EPoTTDRoll);
	config.AddEntry("EGrimGlamourGreenRoll", EGrimGlamourGreenRoll);
	config.AddEntry("EGrimGlamourBlueRoll", EGrimGlamourBlueRoll);
	config.AddEntry("EGrimGlamourPurpleRoll", EGrimGlamourPurpleRoll);
	config.AddEntry("EFamineRoll", EFamineRoll);
	config.AddEntry("ENPNRRoll", ENPNRRoll);
	
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
		DungeonAEGISToolkitsBlueRoll = config.FindEntry("DungeonAEGISToolkitsBlueRoll", MANUAL);
		DungeonMKToolkitsBlueRoll = config.FindEntry("DungeonMKToolkitsBlueRoll", MANUAL);
		DungeonToolkitsAuxBlueRoll = config.FindEntry("DungeonToolkitsAuxBlueRoll", MANUAL);
		DungeonToolkitsPurpleRoll = config.FindEntry("DungeonToolkitsPurpleRoll", MANUAL);
		DungeonToolkitsAuxPurpleRoll = config.FindEntry("DungeonToolkitsAuxPurpleRoll", MANUAL);
		DungeonToolkitsNightwatchRoll = config.FindEntry("DungeonToolkitsNightwatchRoll", MANUAL);
		DungeonAEGISToolkitsPurpleRoll = config.FindEntry("DungeonAEGISToolkitsPurpleRoll", MANUAL);
		DungeonMKToolkitsPurpleRoll = config.FindEntry("DungeonMKToolkitsPurpleRoll", MANUAL);
		DungeonGadgetGreenRoll = config.FindEntry("DungeonGadgetGreenRoll", MANUAL);
		DungeonGadgetBlueRoll = config.FindEntry("DungeonGadgetBlueRoll", MANUAL);
		DungeonPotionsRoll = config.FindEntry("DungeonPotionsRoll", MANUAL);
		DungeonBlueprintsRoll = config.FindEntry("DungeonBlueprintsRoll", MANUAL);
		DungeonTheatricsRoll = config.FindEntry("DungeonTheatricsRoll", MANUAL);
		DungeonUtaLoreRoll = config.FindEntry("DungeonUtaLoreRoll", MANUAL);
		DungeonCatEarsRoll = config.FindEntry("DungeonCatEarsRoll", MANUAL);
		DuAegisCapacitorlessThen4Roll = config.FindEntry("DuAegisCapacitorlessThen4Roll", MANUAL); //Green
		DuAegisCapacitorMoreThen5Roll = config.FindEntry("DuAegisCapacitorMoreThen5Roll", MANUAL); //Green
		DuAegisCapacitorlessThen4BlueRoll = config.FindEntry("DuAegisCapacitorlessThen4BlueRoll", MANUAL);
		DuAegisCapacitorMoreThen5BlueRoll = config.FindEntry("DuAegisCapacitorMoreThen5BlueRoll", MANUAL);
		DuAegisCapacitorlessThen4PurpleRoll = config.FindEntry("DuAegisCapacitorlessThen4PurpleRoll", MANUAL);
		DuAegisCapacitorMoreThen5PurpleRoll = config.FindEntry("DuAegisCapacitorMoreThen5PurpleRoll", MANUAL);
		DuAEConvalescencelessThen4Roll = config.FindEntry("DuAEConvalescencelessThen4Roll", MANUAL); //Green
		DuAEConvalescenceMoreThen5Roll = config.FindEntry("DuAEConvalescenceMoreThen5Roll", MANUAL); //Green
		DuAEConvalescencelessThen4BlueRoll = config.FindEntry("DuAEConvalescencelessThen4BlueRoll", MANUAL);
		DuAEConvalescenceMoreThen5BlueRoll = config.FindEntry("DuAEConvalescenceMoreThen5BlueRoll", MANUAL);
		DuAEConvalescencelessThen4PurpleRoll = config.FindEntry("DuAEConvalescencelessThen4PurpleRoll", MANUAL);
		DuAEConvalescenceMoreThen5PurpleRoll = config.FindEntry("DuAEConvalescenceMoreThen5PurpleRoll", MANUAL);
		DuAERampartlessThen4Roll = config.FindEntry("DuAERampartlessThen4Roll", MANUAL); //Green
		DuAERampartMoreThen5Roll = config.FindEntry("DuAERampartMoreThen5Roll", MANUAL); //Green
		DuAERampartlessThen4BlueRoll = config.FindEntry("DuAERampartlessThen4BlueRoll", MANUAL);
		DuAERampartMoreThen5BlueRoll = config.FindEntry("DuAERampartMoreThen5BlueRoll", MANUAL);
		DuAERampartlessThen4PurpleRoll = config.FindEntry("DuAERampartlessThen4PurpleRoll", MANUAL);
		DuAERampartMoreThen5PurpleRoll = config.FindEntry("DuAERampartMoreThen5PurpleRoll", MANUAL);
		DuAegisModuleGreenRoll = config.FindEntry("DuAegisModuleGreenRoll", MANUAL);
		DuAegisModuleBlueRoll = config.FindEntry("DuAegisModuleBlueRoll", MANUAL);
		DuAegisModulePurpleRoll = config.FindEntry("DuAegisModulePurpleRoll", MANUAL);
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
		PotionsRareRoll = config.FindEntry("PotionsRareRoll", MANUAL);
		SignetsGreenRoll = config.FindEntry("SignetsGreenRoll", MANUAL);
		SignetsBlueRoll = config.FindEntry("SignetsBlueRoll", MANUAL);
		SignetsPurpleRoll = config.FindEntry("SignetsPurpleRoll", MANUAL);
		FragmentsGreenRoll = config.FindEntry("FragmentsGreenRoll", MANUAL);
		FragmentsBlueRoll = config.FindEntry("FragmentsBlueRoll", MANUAL);
		FragmentsPurpleRoll = config.FindEntry("FragmentsPurpleRoll", MANUAL);
		TheatricsRoll = config.FindEntry("TheatricsRoll", MANUAL);
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
		BlackBullionRoll = config.FindEntry("BlackBullionRoll", MANUAL);
		
		UnusualFilthSampleRoll = config.FindEntry("UnusualFilthSampleRoll", MANUAL);
		
		ESocksRRoll = config.FindEntry("ESocksRRoll", MANUAL);
		ESocksLRoll = config.FindEntry("ESocksLRoll", MANUAL);
		EPWPRoll = config.FindEntry("EPWPRoll", MANUAL);
		EPoTTDRoll = config.FindEntry("EPoTTDRoll", MANUAL);
		EGrimGlamourGreenRoll = config.FindEntry("EGrimGlamourGreenRoll", MANUAL);
		EGrimGlamourBlueRoll = config.FindEntry("EGrimGlamourBlueRoll", MANUAL);
		EGrimGlamourPurpleRoll = config.FindEntry("EGrimGlamourPurpleRoll", MANUAL);
		EFamineRoll = config.FindEntry("EFamineRoll", MANUAL);
		ENPNRRoll = config.FindEntry("ENPNRRoll", MANUAL);
		
		
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
			UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Raid mode, please manual everything.");
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
		case 6892: //Orochi Tower - Penthouse
			//UtilsBase.PrintChatText("AutoNBG: Orochi Tower - Penthouse.");
			return DUNGEON;
			break;
		case 6900: //The Manufactory
			//UtilsBase.PrintChatText("AutoNBG: The Manufactory.");
			return DUNGEON;
			break;
		case 6910: //The Manufactory Part 2
			//UtilsBase.PrintChatText("AutoNBG: The Manufactory Part 2.");
			return DUNGEON;
			break;
		case 5710: //NY Raid
			//UtilsBase.PrintChatText("AutoNBG: In NYRaid.");
			return RAID;
			break;
		case 5715: //NY Raid NM
			//UtilsBase.PrintChatText("AutoNBG: In NYRaid NM.");
			return RAID;
			break;
		case 5720: //KM Raid
			//UtilsBase.PrintChatText("AutoNBG: In KM Raid.");
			return RAID;
			break;
		case 5730: //Flappy Raid
			//UtilsBase.PrintChatText("AutoNBG: In Flappy Raid.");
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
	
	UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: " + item.m_Name + " is an unknown or unexpected item. Report: Mode=Scenario. Zone=" + _root.waypoints.m_PlayfieldID + ". m_Rarity=" + item.m_Rarity + ". itemtypegui=" + item.m_ItemTypeGUI + ". m_Icon.Instance=" + item.m_Icon.GetInstance() + ". Please report this to https://forums.thesecretworld.com/showthread.php?80618-Addon-AutoNBG");
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
	     
	     if (item.m_Icon.GetInstance() == 8500484) //AE Capacitor
		{
			if (item.m_Rank <= 4)
			{
				RollNBG(lootBagId, itemPos, item, DuAegisCapacitorlessThen4Roll);
				return;
			}
			if (item.m_Rank >= 5)
			{
				RollNBG(lootBagId, itemPos, item, DuAegisCapacitorMoreThen5Roll);
				return;
			}
		}
		if (item.m_Icon.GetInstance() == 8761781) //AE Concalescence Capacitor
		{
			if (item.m_Rank <= 4)
			{
				RollNBG(lootBagId, itemPos, item, DuAEConvalescencelessThen4Roll);
				return;
			}
			if (item.m_Rank >= 5)
			{
				RollNBG(lootBagId, itemPos, item, DuAEConvalescenceMoreThen5Roll);
				return;
			}
		}
		if (item.m_Icon.GetInstance() == 8731255) //AE Rampart Capacitor
		{
			if (item.m_Rank <= 4)
			{
				RollNBG(lootBagId, itemPos, item, DuAERampartlessThen4Roll);
				return;
			}
			if (item.m_Rank >= 5)
			{
				RollNBG(lootBagId, itemPos, item, DuAERampartMoreThen5Roll);
				return;
			}
		}
		if (item.m_ItemTypeGUI == 24905333) //Aegis Module
		{
			RollNBG(lootBagId, itemPos, item, DuAegisModuleGreenRoll);
			return;
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
		
		if (item.m_ItemTypeGUI == 226155763) //Gadget
		{
			RollNBG(lootBagId, itemPos, item, DungeonGadgetGreenRoll);
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
			if (item.m_Icon.GetInstance() == 8500482) //AEGIS 2.0 Kit
			{
				RollNBG(lootBagId, itemPos, item, DungeonAEGISToolkitsBlueRoll);
				return;
			}
			if (item.m_Icon.GetInstance() == 8466717) //Memory Expansion Module Mk
			{
				RollNBG(lootBagId, itemPos, item, DungeonMKToolkitsBlueRoll);
				return;
			}
			
			RollNBG(lootBagId, itemPos, item, DungeonToolkitsBlueRoll);
			return;
		}
		if (item.m_ItemTypeGUI == 191246932) //Toolkits
		{
			if (item.m_Icon.GetInstance() == 7895146) //Aux Kit
			{
				RollNBG(lootBagId, itemPos, item, DungeonToolkitsAuxBlueRoll);
				return;
			}
			if (item.m_Icon.GetInstance() == 8500482) //AEGIS 2.0 Kit
			{
				RollNBG(lootBagId, itemPos, item, DungeonAEGISToolkitsBlueRoll);
				return;
			}
			if (item.m_Icon.GetInstance() == 8466717) //Memory Expansion Module Mk
			{
				RollNBG(lootBagId, itemPos, item, DungeonMKToolkitsBlueRoll);
				return;
			}
			
			RollNBG(lootBagId, itemPos, item, DungeonToolkitsBlueRoll);
			return;
		}
		if (item.m_ItemTypeGUI == 226155763) //Gadget
		{
			RollNBG(lootBagId, itemPos, item, DungeonGadgetBlueRoll);
			return;
		}
		if (item.m_Icon.GetInstance() == 8500484) //AE Capacitor 
		{
			if (item.m_Rank <= 4)
			{
				RollNBG(lootBagId, itemPos, item, DuAegisCapacitorlessThen4BlueRoll);
				return;
			}
			if (item.m_Rank >= 5)
			{
				RollNBG(lootBagId, itemPos, item, DuAegisCapacitorMoreThen5BlueRoll);
				return;
			}
		}
		if (item.m_Icon.GetInstance() == 8761781) //AE Concalescence Capacitor
		{
			if (item.m_Rank <= 4)
			{
				RollNBG(lootBagId, itemPos, item, DuAEConvalescencelessThen4BlueRoll);
				return;
			}
			if (item.m_Rank >= 5)
			{
				RollNBG(lootBagId, itemPos, item, DuAEConvalescenceMoreThen5BlueRoll);
				return;
			}
		}
		if (item.m_Icon.GetInstance() == 8731255) //AE Rampart Capacitor
		{
			if (item.m_Rank <= 4)
			{
				RollNBG(lootBagId, itemPos, item, DuAERampartlessThen4BlueRoll);
				return;
			}
			if (item.m_Rank >= 5)
			{
				RollNBG(lootBagId, itemPos, item, DuAERampartMoreThen5BlueRoll);
				return;
			}
		}
		if (item.m_Icon.GetInstance() == 7376597) //Uta's Contract
		{
			RollNBG(lootBagId, itemPos, item, DungeonUtaLoreRoll);
			return;
		}
		if (item.m_Icon.GetInstance() == 7457535) //Cat Ears
		{
			RollNBG(lootBagId, itemPos, item, DungeonCatEarsRoll);
			return;
		}
		if (item.m_ItemTypeGUI == 24905333) //Aegis Module
		{
			RollNBG(lootBagId, itemPos, item, DuAegisModuleBlueRoll);
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
			
			if (item.m_Icon.GetInstance() == 8500482) //AEGIS 3.0 Kit
			{
				RollNBG(lootBagId, itemPos, item, DungeonAEGISToolkitsPurpleRoll);
				return;
			}
			if (item.m_Icon.GetInstance() == 8466717) //Memory Expansion Module Mk
			{
				RollNBG(lootBagId, itemPos, item, DungeonMKToolkitsPurpleRoll);
				return;
			}
			
			RollNBG(lootBagId, itemPos, item, DungeonToolkitsPurpleRoll);
			return;
		}
		if (item.m_Icon.GetInstance() == 8500484) //AE Capacitor 
		{
			if (item.m_Rank <= 4)
			{
				RollNBG(lootBagId, itemPos, item, DuAegisCapacitorlessThen4PurpleRoll);
				return;
			}
			if (item.m_Rank >= 5)
			{
				RollNBG(lootBagId, itemPos, item, DuAegisCapacitorMoreThen5PurpleRoll);
				return;
			}
		}
		if (item.m_Icon.GetInstance() == 8761781) //AE Concalescence Capacitor
		{
			if (item.m_Rank <= 4)
			{
				RollNBG(lootBagId, itemPos, item, DuAEConvalescencelessThen4PurpleRoll);
				return;
			}
			if (item.m_Rank >= 5)
			{
				RollNBG(lootBagId, itemPos, item, DuAEConvalescenceMoreThen5PurpleRoll);
				return;
			}
		}
		if (item.m_Icon.GetInstance() == 8731255) //AE Rampart Capacitor
		{
			if (item.m_Rank <= 4)
			{
				RollNBG(lootBagId, itemPos, item, DuAERampartlessThen4PurpleRoll);
				return;
			}
			if (item.m_Rank >= 5)
			{
				RollNBG(lootBagId, itemPos, item, DuAERampartMoreThen5PurpleRoll);
				return;
			}
		}
		if (item.m_ItemTypeGUI == 24905333) //Aegis Module
		{
			RollNBG(lootBagId, itemPos, item, DuAegisModulePurpleRoll);
			return;
		}
	}
	
	if (item.m_Rarity == 1)
	{
		UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: " + item.m_Name + " is a common item. Please adjust the Need/Greed threshold for your group to 'Uncommon'.");
	}
	
	
	UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: " + item.m_Name + " is an unknown or unexpected item. Report: Mode=Dungeons. Zone=" + _root.waypoints.m_PlayfieldID + ". m_Rarity=" + item.m_Rarity + ". itemtypegui=" + item.m_ItemTypeGUI + ". m_Icon.Instance=" + item.m_Icon.GetInstance() + ". Please report this to https://forums.thesecretworld.com/showthread.php?80618-Addon-AutoNBG");
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
		
		if (item.m_ItemTypeGUI == 24905333) //Aegis Module
		{
			RollNBG(lootBagId, itemPos, item, AegisModuleGreenRoll);
			return;
		}
		if (item.m_Icon.GetInstance() == 7466288) //BlackBullion
		{
			RollNBG(lootBagId, itemPos, item, BlackBullionRoll);
			return;
		}
		if (item.m_Icon.GetInstance() == 8500481) //UnusualFilthSample
		{
			RollNBG(lootBagId, itemPos, item, UnusualFilthSampleRoll);
			return;
		}
		if (item.m_Icon.GetInstance() == 6806219) //EGrimGlamourGreen
		{
			RollNBG(lootBagId, itemPos, item, EGrimGlamourGreenRoll);
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
		if (item.m_ItemTypeGUI == 180871029) //PotionsRare
		{
			RollNBG(lootBagId, itemPos, item, PotionsRareRoll);
			return;
		}
		
		if (item.m_Icon.GetInstance() == 8396909) //ESocksR
		{
			RollNBG(lootBagId, itemPos, item, ESocksRRoll);
			return;
		}
		if (item.m_Icon.GetInstance() == 8396911) //ESocksL
		{
			RollNBG(lootBagId, itemPos, item, ESocksLRoll);
			return;
		}
		if (item.m_Icon.GetInstance() == 7457530) //Poorly Wrapped Present
		{
			RollNBG(lootBagId, itemPos, item, EPWPRoll);
			return;
		}
		if (item.m_Icon.GetInstance() == 7457532) //Pre-owned tank top, dirty
		{
			RollNBG(lootBagId, itemPos, item, EPoTTDRoll);
			return;
		}
		if (item.m_Icon.GetInstance() == 6806219) //EGrimGlamourBlue
		{
			RollNBG(lootBagId, itemPos, item, EGrimGlamourBlueRoll);
			return;
		}
		if (item.m_Icon.GetInstance() == 8397598) //EFamine
		{
			RollNBG(lootBagId, itemPos, item, EFamineRoll);
			return;
		}
		if (item.m_Icon.GetInstance() == 7457534) //Novelty plastic nose, red
		{
			RollNBG(lootBagId, itemPos, item, ENPNRRoll);
			return;
		}
		if ((item.m_ItemTypeGUI == 180871029) || (item.m_Icon.GetInstance() == 7473831) || (item.m_Icon.GetInstance() == 7473832) || (item.m_Icon.GetInstance() == 7473835) || (item.m_Icon.GetInstance() == 7487430)) //tokyo Cocktail & Consumab
		{
			RollNBG(lootBagId, itemPos, item, TokyoRareCocktailRoll);
			return;
		}
		if (item.m_ItemTypeGUI == 228394866) //Aegis Capacitor
		{
			if (item.m_Rank <= 4)
			{
				RollNBG(lootBagId, itemPos, item, AegisCapacitorlessThen4BlueRoll);
				return;
			}
			if (item.m_Rank >= 5)
			{
				RollNBG(lootBagId, itemPos, item, AegisCapacitorMoreThen5BlueRoll);
				return;
			}
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
		if (item.m_Icon.GetInstance() == 6806219) //EGrimGlamourPurple
		{
			RollNBG(lootBagId, itemPos, item, EGrimGlamourPurpleRoll);
			return;
		}
	}
	
	if (item.m_Rarity == 1)
	{
		UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: " + item.m_Name + " is a common item. Please adjust the Need/Greed threshold for your group to 'Uncommon'.");
	}
	
	UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: " + item.m_Name + " is an unknown or unexpected item. Report: Mode=General. Zone=" + _root.waypoints.m_PlayfieldID + ". m_Rarity=" + item.m_Rarity + ". itemtypegui=" + item.m_ItemTypeGUI + ". m_Icon.Instance=" + item.m_Icon.GetInstance() + ". Please report this to https://forums.thesecretworld.com/showthread.php?80618-Addon-AutoNBG");
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
	if (newPlayfield == 5710 || newPlayfield == 5720 || newPlayfield == 5730)
	{
		//UtilsBase.PrintChatText("<font color='#00FFFF'>AutoNBG</font>: Inactive during NY raid.");
		Chat.SignalShowFIFOMessage.Emit("<font color='#00FFFF'>AutoNBG</font>: Inactive, you at raid now, will be manual everything.", 0);
	}
}