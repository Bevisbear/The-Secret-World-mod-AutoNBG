import com.Components.Window;
import com.GameInterface.Chat;
import com.GameInterface.Game.Character;
import com.GameInterface.Game.CharacterBase;
import com.GameInterface.Log;
import com.Utils.Signal;
import flash.geom.Point;
import gfx.controls.Button;
import mx.utils.Delegate;
import com.GameInterface.MathLib.Vector3;
import com.GameInterface.Game.Camera;
import com.Utils.ID32;
import GUI.CharacterCreation.HeadSection;
//import com.GameInterface.Game.Dynel;
import GUI.CharacterCreation.CameraController;
import com.GameInterface.Utils;
import flash.utils.* 
import com.GameInterface.DistributedValue;
import com.GameInterface.UtilsBase;
import com.Utils.Archive;
import com.GameInterface.Inventory;
import com.GameInterface.InventoryItem;
import com.GameInterface.InventoryBase;
import gfx.controls.DropdownMenu;
import flash.display;

class AutoNBGWindow extends MovieClip 
{
	private var m_Background:MovieClip;
	
	//General
	private var m_WeaponsGreenTenDropDownMenu:DropdownMenu;
	private var m_WeaponsBlueTenDropDownMenu:DropdownMenu;
	private var m_WeaponsGreenLessThanTenDropDownMenu:DropdownMenu;
	private var m_WeaponsBlueLessThanTenDropDownMenu:DropdownMenu;
	
	//Scenarios
	private var m_WeaponsPurpleDropDownMenu:DropdownMenu;
	private var m_ToolkitsGreenDropDownMenu:DropdownMenu;
	private var m_ToolkitsBlueDropDownMenu:DropdownMenu;
	private var m_ToolkitsPurpleDropDownMenu:DropdownMenu;
	private var m_PotionsDropDownMenu:DropdownMenu;
	private var m_SignetsGreenDropDownMenu:DropdownMenu;
	private var m_SignetsBlueDropDownMenu:DropdownMenu;
	private var m_SignetsPurpleDropDownMenu:DropdownMenu;
	private var m_FragmentsBlueDropDownMenu:DropdownMenu;
	private var m_FragmentsPurpleDropDownMenu:DropdownMenu;
	private var m_TheatricsDropDownMenu:DropdownMenu;
	private var m_SequinsDropDownMenu:DropdownMenu;
	private var m_GadgetsDropDownMenu:DropdownMenu;
	private var m_ScenarioAugmentsGreenDropDownMenu:DropdownMenu;
	private var m_ScenarioAugmentsBlueDropDownMenu:DropdownMenu;
	private var m_ScenarioAugmentsPurpleDropDownMenu:DropdownMenu;
	private var m_ScenarioAugmentsGoldDropDownMenu:DropdownMenu;
	private var m_ScenarioMinesDropDownMenu:DropdownMenu;
	private var m_ScenarioFirstAidDropDownMenu:DropdownMenu;
	private var m_ScenarioBearArmsDropDownMenu:DropdownMenu;
	private var m_ScenarioPotionsDropDownMenu:DropdownMenu;
	private var m_ScenarioWeaponsDropDownMenu:DropdownMenu;
	private var m_ScenarioToolkitsDropDownMenu:DropdownMenu;
	private var m_ScenarioTheatricsDropDownMenu:DropdownMenu;
	private var m_ScenarioGadgetsDropDownMenu:DropdownMenu;
	
	
	//Dungeons
	private var m_DungeonWeaponsGreenTenDropDownMenu:DropdownMenu;
	private var m_DungeonWeaponsBlueTenDropDownMenu:DropdownMenu;
	private var m_DungeonWeaponsGreenLessThanTenDropDownMenu:DropdownMenu;
	private var m_DungeonWeaponsBlueLessThanTenDropDownMenu:DropdownMenu;
	private var m_DungeonWeaponsPurpleDropDownMenu:DropdownMenu;
	
	private var m_DungeonTalismansGreenTenDropDownMenu:DropdownMenu;
	private var m_DungeonTalismansBlueTenDropDownMenu:DropdownMenu;
	private var m_DungeonTalismansGreenLessThanTenDropDownMenu:DropdownMenu;
	private var m_DungeonTalismansBlueLessThanTenDropDownMenu:DropdownMenu;
	private var m_DungeonTalismansPurpleDropDownMenu:DropdownMenu;
	
	private var m_DungeonToolkitsGreenDropDownMenu:DropdownMenu;
	private var m_DungeonToolkitsBlueDropDownMenu:DropdownMenu;
	private var m_DungeonToolkitsAuxBlueDropDownMenu:DropdownMenu;
	private var m_DungeonToolkitsPurpleDropDownMenu:DropdownMenu;
	private var m_DungeonToolkitsAuxPurpleDropDownMenu:DropdownMenu;
	private var m_DungeonToolkitsNightwatchDropDownMenu:DropdownMenu;
	private var m_DungeonPotionsDropDownMenu:DropdownMenu;
	private var m_DungeonBlueprintsDropDownMenu:DropdownMenu;
	private var m_DungeonTheatricsDropDownMenu:DropdownMenu;
	
	//Tokyo
	private var m_TokyoRareCocktailDropDownMenu:DropdownMenu;
	private var m_AegisModuleGreenDropDownMenu:DropdownMenu;
	private var m_AegisModuleBlueDropDownMenu:DropdownMenu;
	private var m_AegisModulePurpleDropDownMenu:DropdownMenu;
	private var m_AegisCapacitorlessThen4DropDownMenu:DropdownMenu; //Green
	private var m_AegisCapacitorMoreThen5DropDownMenu:DropdownMenu; //Green
	private var m_AegisCapacitorlessThen4BlueDropDownMenu:DropdownMenu;
	private var m_AegisCapacitorMoreThen5BlueDropDownMenu:DropdownMenu;
	private var m_AegisCapacitorlessThen4PurpleDropDownMenu:DropdownMenu;
	private var m_AegisCapacitorMoreThen5PurpleDropDownMenu:DropdownMenu;
	/*
	private var m_AegisControllerGreenDropDownMenu:DropdownMenu;
	private var m_AegisControllerBlueDropDownMenu:DropdownMenu;
	private var m_AegisControllerPurpleDropDownMenu:DropdownMenu;
	private var m_TokyoTokenDropDownMenu:DropdownMenu;
	*/
	private var m_UnusualFilthSampleDropDownMenu:DropdownMenu;
	
	
	//Buttons
	private var m_GeneralButton:MovieClip;
	private var m_DungeonButton:MovieClip;
	private var m_ScenarioButton:MovieClip;
	private var m_TokyoButton:MovieClip;
	private var m_HelpButton:MovieClip;
	private var m_ExitButton:Button;
	private var m_ActiveLoot:TextField;
	
	//Signal
	public var SignalWindowClosed:Signal;
	
	//Boolean
	private var m_Dragging:Boolean = false;
	
	var m_AutoNBGWindowOn:DistributedValue;
	var categoryDropDownData:Array;
	
	private var m_FIFOToggleCheckbox:MovieClip;
	private var m_AutoNBGToggleCheckbox:MovieClip;
	/* private var m_AutoNBGDisableRollwindowCheckbox:MovieClip; */


	public function AutoNBGWindow() 
	{
		super();

		SignalWindowClosed = new Signal();
		categoryDropDownData = new Array("Manual", "Greed", "Need", "Pass");
		
		m_Background.onRelease = Delegate.create(this, handleStopDrag);
		m_Background.onReleaseOutside = Delegate.create(this, handleStopDrag);
		m_Background.onPress = Delegate.create(this, handleStartDrag);
	}
	
	public function onLoad() 
	{
		m_AutoNBGWindowOn = DistributedValue.Create("AutoNBGWindowOn");
		m_GeneralButton.addEventListener("click", this, "onGeneralButtonClick", true);
		m_DungeonButton.addEventListener("click", this, "onDungeonButtonClick", true);
		m_ScenarioButton.addEventListener("click", this, "onScenarioButtonClick", true);
		m_TokyoButton.addEventListener("click", this, "onTokyoButtonClick", true);
		m_HelpButton.addEventListener("click", this, "onHelpButtonClick", true);
		m_ExitButton.addEventListener("click", this, "onExitButtonClick", true);
	}
	
	private function onGeneralButtonClick(eventObj:Object) 
	{
		if (!m_GeneralButton.selected)
		{
			gotoAndStop(1);
			Selection.setFocus(null);
			return;
		}
		gotoAndStop(2);
		m_DungeonButton.selected = false;
		m_ScenarioButton.selected = false;
		m_TokyoButton.selected = false;
		m_HelpButton.selected = false;
		Selection.setFocus(null);
	}

	private function onDungeonButtonClick(eventObj:Object) 
	{
		if (!m_DungeonButton.selected)
		{
			gotoAndStop(1);
			Selection.setFocus(null);
			return;
		}
		gotoAndStop(4);
		m_GeneralButton.selected = false;
		m_ScenarioButton.selected = false;
		m_TokyoButton.selected = false;
		m_HelpButton.selected = false;
		Selection.setFocus(null);
	}

	private function onScenarioButtonClick(eventObj:Object) 
	{
		if (!m_ScenarioButton.selected)
		{
			//UtilsBase.PrintChatText("Scenario is no longer selected.");
			gotoAndStop(1);
			Selection.setFocus(null);
			return;
		}
		
		//UtilsBase.PrintChatText("onScenarioButtonClick");
		gotoAndStop(3);
		m_GeneralButton.selected = false;
		m_DungeonButton.selected = false;
		m_TokyoButton.selected = false;
		m_HelpButton.selected = false;
		Selection.setFocus(null);
	}
	private function onTokyoButtonClick(eventObj:Object) 
	{
		if (!m_TokyoButton.selected)
		{
			//UtilsBase.PrintChatText("Tokyo is no longer selected.");
			gotoAndStop(1);
			Selection.setFocus(null);
			return;
		}
		
		//UtilsBase.PrintChatText("onTokyoButtonClick");
		gotoAndStop(5);
		m_GeneralButton.selected = false;
		m_DungeonButton.selected = false;
		m_ScenarioButton.selected = false;
		m_HelpButton.selected = false;
		Selection.setFocus(null);
	}
	private function onHelpButtonClick(eventObj:Object) 
	{
		if (!m_HelpButton.selected)
		{
			//UtilsBase.PrintChatText("Help is no longer selected.");
		gotoAndStop(1);
	  Selection.setFocus(null);
			return;
		}
		
		//UtilsBase.PrintChatText("onHelpButtonClick");
		gotoAndStop(6);
		m_GeneralButton.selected = false;
		m_DungeonButton.selected = false;
		m_ScenarioButton.selected = false;
		m_TokyoButton.selected = false;
		Selection.setFocus(null);
	}
	
	public function WeaponsGreenTenDropdownEvent(eventObj:Object) 
	{
		_parent.WeaponsGreenTenRoll = m_WeaponsGreenTenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function WeaponsBlueTenDropdownEvent(eventObj:Object) 
	{
		_parent.WeaponsBlueTenRoll = m_WeaponsBlueTenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function WeaponsGreenLessThanTenDropdownEvent(eventObj:Object) 
	{
		_parent.WeaponsGreenLessThanTenRoll = m_WeaponsGreenLessThanTenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function WeaponsBlueLessThanTenDropdownEvent(eventObj:Object) 
	{
		_parent.WeaponsBlueLessThanTenRoll = m_WeaponsBlueLessThanTenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function WeaponsPurpleDropdownEvent(eventObj:Object) 
	{
		_parent.WeaponsPurpleRoll = m_WeaponsPurpleDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function ToolkitsGreenDropdownEvent(eventObj:Object) 
	{
		_parent.ToolkitsGreenRoll = m_ToolkitsGreenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function ToolkitsBlueDropdownEvent(eventObj:Object) 
	{
		_parent.ToolkitsBlueRoll = m_ToolkitsBlueDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function ToolkitsPurpleDropdownEvent(eventObj:Object) 
	{
		_parent.ToolkitsPurpleRoll = m_ToolkitsPurpleDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function PotionsDropdownEvent(eventObj:Object) 
	{
		_parent.PotionsRoll = m_PotionsDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function SignetsGreenDropdownEvent(eventObj:Object) 
	{
		_parent.SignetsGreenRoll = m_SignetsGreenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function SignetsBlueDropdownEvent(eventObj:Object) 
	{
		_parent.SignetsBlueRoll = m_SignetsBlueDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function SignetsPurpleDropdownEvent(eventObj:Object) 
	{
		_parent.SignetsPurpleRoll = m_SignetsPurpleDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function FragmentsBlueDropdownEvent(eventObj:Object) 
	{
		_parent.FragmentsBlueRoll = m_FragmentsBlueDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function FragmentsPurpleDropdownEvent(eventObj:Object) 
	{
		_parent.FragmentsPurpleRoll = m_FragmentsPurpleDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function TheatricsDropdownEvent(eventObj:Object) 
	{
		_parent.TheatricsRoll = m_TheatricsDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function SequinsDropdownEvent(eventObj:Object) 
	{
		_parent.SequinsRoll = m_SequinsDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function GadgetsDropdownEvent(eventObj:Object) 
	{
		_parent.GadgetsRoll = m_GadgetsDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function ScenarioAugmentsGreenDropdownEvent(eventObj:Object) 
	{
		_parent.ScenarioAugmentsGreenRoll = m_ScenarioAugmentsGreenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	public function ScenarioAugmentsBlueDropdownEvent(eventObj:Object) 
	{
		_parent.ScenarioAugmentsBlueRoll = m_ScenarioAugmentsBlueDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	public function ScenarioAugmentsPurpleDropdownEvent(eventObj:Object) 
	{
		_parent.ScenarioAugmentsPurpleRoll = m_ScenarioAugmentsPurpleDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	public function ScenarioAugmentsGoldDropdownEvent(eventObj:Object) 
	{
		_parent.ScenarioAugmentsGoldRoll = m_ScenarioAugmentsGoldDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function ScenarioMinesDropdownEvent(eventObj:Object) 
	{
		_parent.ScenarioMinesRoll = m_ScenarioMinesDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function ScenarioFirstAidDropdownEvent(eventObj:Object) 
	{
		_parent.ScenarioFirstAidRoll = m_ScenarioFirstAidDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function ScenarioBearArmsDropdownEvent(eventObj:Object) 
	{
		_parent.ScenarioBearArmsRoll = m_ScenarioBearArmsDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function ScenarioPotionsDropdownEvent(eventObj:Object) 
	{
		_parent.ScenarioPotionsRoll = m_ScenarioPotionsDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function ScenarioWeaponsDropdownEvent(eventObj:Object) 
	{
		_parent.ScenarioWeaponsRoll = m_ScenarioWeaponsDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function ScenarioToolkitsDropdownEvent(eventObj:Object) 
	{
		_parent.ScenarioToolkitsRoll = m_ScenarioToolkitsDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function ScenarioTheatricsDropdownEvent(eventObj:Object) 
	{
		_parent.ScenarioTheatricsRoll = m_ScenarioTheatricsDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function ScenarioGadgetsDropdownEvent(eventObj:Object) 
	{
		_parent.ScenarioGadgetsRoll = m_ScenarioGadgetsDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonWeaponsGreen10PlusDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonWeaponsGreenTenRoll = m_DungeonWeaponsGreenTenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonWeaponsGreenLessThan10DropdownEvent(eventObj:Object) 
	{
		_parent.DungeonWeaponsGreenLessThanTenRoll = m_DungeonWeaponsGreenLessThanTenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonWeaponsBlue10PlusDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonWeaponsBlueTenRoll = m_DungeonWeaponsBlueTenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonWeaponsBlueLessThan10DropdownEvent(eventObj:Object) 
	{
		_parent.DungeonWeaponsBlueLessThanTenRoll = m_DungeonWeaponsBlueLessThanTenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function DungeonWeaponsPurpleDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonWeaponsPurpleRoll = m_DungeonWeaponsPurpleDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	public function DungeonTalismansGreen10PlusDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonTalismansGreenTenRoll = m_DungeonTalismansGreenTenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonTalismansGreenLessThan10DropdownEvent(eventObj:Object) 
	{
		_parent.DungeonTalismansGreenLessThanTenRoll = m_DungeonTalismansGreenLessThanTenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonTalismansBlue10PlusDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonTalismansBlueTenRoll = m_DungeonTalismansBlueTenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonTalismansBlueLessThan10DropdownEvent(eventObj:Object) 
	{
		_parent.DungeonTalismansBlueLessThanTenRoll = m_DungeonTalismansBlueLessThanTenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function DungeonTalismansPurpleDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonTalismansPurpleRoll = m_DungeonTalismansPurpleDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonToolkitsGreenDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonToolkitsGreenRoll = m_DungeonToolkitsGreenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonToolkitsBlueDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonToolkitsBlueRoll = m_DungeonToolkitsBlueDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonToolkitsAuxBlueDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonToolkitsAuxBlueRoll = m_DungeonToolkitsAuxBlueDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function DungeonToolkitsPurpleDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonToolkitsPurpleRoll = m_DungeonToolkitsPurpleDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonToolkitsAuxPurpleDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonToolkitsAuxPurpleRoll = m_DungeonToolkitsAuxPurpleDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonToolkitsNightwatchDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonToolkitsNightwatchRoll = m_DungeonToolkitsNightwatchDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonPotionsDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonPotionsRoll = m_DungeonPotionsDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonBlueprintsDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonBlueprintsRoll = m_DungeonBlueprintsDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	
	public function DungeonTheatricsDropdownEvent(eventObj:Object) 
	{
		_parent.DungeonTheatricsRoll = m_DungeonTheatricsDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	public function TokyoRareCocktailDropDownEvent(eventObj:Object) 
	{
		_parent.TokyoRareCocktailRoll = m_TokyoRareCocktailDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}

	public function AegisModuleGreenDropDownEvent(eventObj:Object) 
	{
		_parent.AegisModuleGreenRoll = m_AegisModuleGreenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	public function AegisModuleBlueDropDownEvent(eventObj:Object) 
	{
		_parent.AegisModuleBlueRoll = m_AegisModuleBlueDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	public function AegisModulePuepleDropDownEvent(eventObj:Object) 
	{
		_parent.AegisModulePurpleRoll = m_AegisModulePurpleDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	public function AegisCapacitorlessThen4DropDownEvent(eventObj:Object) 
	{
		_parent.AegisCapacitorlessThen4Roll = m_AegisCapacitorlessThen4DropDownMenu.selectedIndex;
		Selection.setFocus(null); //Green
	}
	public function AegisCapacitorMoreThen5DropDownEvent(eventObj:Object) 
	{
		_parent.AegisCapacitorMoreThen5Roll = m_AegisCapacitorMoreThen5DropDownMenu.selectedIndex;
		Selection.setFocus(null); //Green
	}
	public function AegisCapacitorlessThen4BlueDropDownEvent(eventObj:Object) 
	{
		_parent.AegisCapacitorlessThen4BlueRoll = m_AegisCapacitorlessThen4BlueDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	public function AegisCapacitorMoreThen5BlueDropDownEvent(eventObj:Object) 
	{
		_parent.AegisCapacitorMoreThen5BlueRoll = m_AegisCapacitorMoreThen5BlueDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	public function AegisCapacitorlessThen4PurpleDropDownEvent(eventObj:Object) 
	{
		_parent.AegisCapacitorlessThen4PurpleRoll = m_AegisCapacitorlessThen4PurpleDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	public function AegisCapacitorMoreThen5PurpleDropDownEvent(eventObj:Object) 
	{
		_parent.AegisCapacitorMoreThen5PurpleRoll = m_AegisCapacitorMoreThen5PurpleDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	/*
	public function AegisControllerGreenDropDownEvent(eventObj:Object) 
	{
		_parent.AegisControllerGreenRoll = m_AegisControllerGreenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	public function AegisControllerBlueDropDownEvent(eventObj:Object) 
	{
		_parent.AegisControllerBlueRoll = m_AegisControllerBlueDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	public function AegisControllerPurpleDropDownEvent(eventObj:Object) 
	{
		_parent.AegisControllerPurpleRoll = m_AegisControllerPurpleDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	}
	public function TokyoTokenDropDownEvent(eventObj:Object) 
	{
		_parent.TokyoTokenRoll = m_TokyoTokenDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	} 
	*/
	public function UnusualFilthSampleDropDownEvent(eventObj:Object) 
	{
		_parent.UnusualFilthSampleRoll = m_UnusualFilthSampleDropDownMenu.selectedIndex;
		Selection.setFocus(null);
	} 
	

/*	public function onAutoNBGDisableRollwindowCheckBoxChecked(eventObj:Object) 
	{
		_parent.AutoNBGDisableRollwindow = !_parent.AutoNBGDisableRollwindow;
		Selection.setFocus(null);
	}  */
	
	public function onAutoNBGToggleCheckBoxChecked(eventObj:Object) 
	{
		_parent.AutoNBGToggle = !_parent.AutoNBGToggle;
		Selection.setFocus(null);
	}
	
	public function onFIFOToggleCheckBoxChecked(eventObj:Object) 
	{
		_parent.FIFOToggle = !_parent.FIFOToggle;
		Selection.setFocus(null);
	}
	
	public function onExitButtonClick(eventObj:Object) 
	{
		m_AutoNBGWindowOn.SetValue(false);
		Selection.setFocus(null);
	}
	
	private function handleStartDrag() 
	{
		this.startDrag();
	}
	
	private function handleStopDrag(buttonIdx:Number) 
	{
		this.stopDrag();
	}
	
	public function onEnterFrame()
	{

	}
	
	public function LoadFrameTwo()
	{
		//Dropdowns
		m_WeaponsGreenTenDropDownMenu.dataProvider = categoryDropDownData;
		m_WeaponsGreenTenDropDownMenu.rowCount = categoryDropDownData.length;
		m_WeaponsGreenTenDropDownMenu.addEventListener("change", this, "WeaponsGreenTenDropdownEvent");
		
		m_WeaponsBlueTenDropDownMenu.dataProvider = categoryDropDownData;
		m_WeaponsBlueTenDropDownMenu.rowCount = categoryDropDownData.length;
		m_WeaponsBlueTenDropDownMenu.addEventListener("change", this, "WeaponsBlueTenDropdownEvent");

		m_WeaponsGreenLessThanTenDropDownMenu.dataProvider = categoryDropDownData;
		m_WeaponsGreenLessThanTenDropDownMenu.rowCount = categoryDropDownData.length;
		m_WeaponsGreenLessThanTenDropDownMenu.addEventListener("change", this, "WeaponsGreenLessThanTenDropdownEvent");
		
		m_WeaponsBlueLessThanTenDropDownMenu.dataProvider = categoryDropDownData;
		m_WeaponsBlueLessThanTenDropDownMenu.rowCount = categoryDropDownData.length;
		m_WeaponsBlueLessThanTenDropDownMenu.addEventListener("change", this, "WeaponsBlueLessThanTenDropdownEvent");
		
		m_WeaponsPurpleDropDownMenu.dataProvider = categoryDropDownData;
		m_WeaponsPurpleDropDownMenu.rowCount = categoryDropDownData.length;
		m_WeaponsPurpleDropDownMenu.addEventListener("change", this, "WeaponsPurpleDropdownEvent");

		m_ToolkitsGreenDropDownMenu.dataProvider = categoryDropDownData;
		m_ToolkitsGreenDropDownMenu.rowCount = categoryDropDownData.length;
		m_ToolkitsGreenDropDownMenu.addEventListener("change", this, "ToolkitsGreenDropdownEvent");
		
		m_ToolkitsBlueDropDownMenu.dataProvider = categoryDropDownData;
		m_ToolkitsBlueDropDownMenu.rowCount = categoryDropDownData.length;
		m_ToolkitsBlueDropDownMenu.addEventListener("change", this, "ToolkitsBlueDropdownEvent");

		m_ToolkitsPurpleDropDownMenu.dataProvider = categoryDropDownData;
		m_ToolkitsPurpleDropDownMenu.rowCount = categoryDropDownData.length;
		m_ToolkitsPurpleDropDownMenu.addEventListener("change", this, "ToolkitsPurpleDropdownEvent");
		
		m_PotionsDropDownMenu.dataProvider = categoryDropDownData;
		m_PotionsDropDownMenu.rowCount = categoryDropDownData.length;
		m_PotionsDropDownMenu.addEventListener("change", this, "PotionsDropdownEvent");
		
		m_SignetsGreenDropDownMenu.dataProvider = categoryDropDownData;
		m_SignetsGreenDropDownMenu.rowCount = categoryDropDownData.length;
		m_SignetsGreenDropDownMenu.addEventListener("change", this, "SignetsGreenDropdownEvent");
		
		m_SignetsBlueDropDownMenu.dataProvider = categoryDropDownData;
		m_SignetsBlueDropDownMenu.rowCount = categoryDropDownData.length;
		m_SignetsBlueDropDownMenu.addEventListener("change", this, "SignetsBlueDropdownEvent");

		m_SignetsPurpleDropDownMenu.dataProvider = categoryDropDownData;
		m_SignetsPurpleDropDownMenu.rowCount = categoryDropDownData.length;
		m_SignetsPurpleDropDownMenu.addEventListener("change", this, "SignetsPurpleDropdownEvent");
		
		m_FragmentsBlueDropDownMenu.dataProvider = categoryDropDownData;
		m_FragmentsBlueDropDownMenu.rowCount = categoryDropDownData.length;
		m_FragmentsBlueDropDownMenu.addEventListener("change", this, "FragmentsBlueDropdownEvent");

		m_FragmentsPurpleDropDownMenu.dataProvider = categoryDropDownData;
		m_FragmentsPurpleDropDownMenu.rowCount = categoryDropDownData.length;
		m_FragmentsPurpleDropDownMenu.addEventListener("change", this, "FragmentsPurpleDropdownEvent");
		
		m_TheatricsDropDownMenu.dataProvider = categoryDropDownData;
		m_TheatricsDropDownMenu.rowCount = categoryDropDownData.length;
		m_TheatricsDropDownMenu.addEventListener("change", this, "TheatricsDropdownEvent");
		
		m_SequinsDropDownMenu.dataProvider = categoryDropDownData;
		m_SequinsDropDownMenu.rowCount = categoryDropDownData.length;
		m_SequinsDropDownMenu.addEventListener("change", this, "SequinsDropdownEvent");
		
		m_GadgetsDropDownMenu.dataProvider = categoryDropDownData;
		m_GadgetsDropDownMenu.rowCount = categoryDropDownData.length;
		m_GadgetsDropDownMenu.addEventListener("change", this, "GadgetsDropdownEvent");
		
		//Selected Indices
		m_WeaponsGreenTenDropDownMenu.selectedIndex = _parent.WeaponsGreenTenRoll;
		m_WeaponsBlueTenDropDownMenu.selectedIndex = _parent.WeaponsBlueTenRoll;
		m_WeaponsGreenLessThanTenDropDownMenu.selectedIndex = _parent.WeaponsGreenLessThanTenRoll;
		m_WeaponsBlueLessThanTenDropDownMenu.selectedIndex = _parent.WeaponsBlueLessThanTenRoll;		
		
		m_WeaponsPurpleDropDownMenu.selectedIndex = _parent.WeaponsPurpleRoll;
		
		m_ToolkitsGreenDropDownMenu.selectedIndex = _parent.ToolkitsGreenRoll;
		m_ToolkitsBlueDropDownMenu.selectedIndex = _parent.ToolkitsBlueRoll;
		m_ToolkitsPurpleDropDownMenu.selectedIndex = _parent.ToolkitsPurpleRoll;
		
		m_PotionsDropDownMenu.selectedIndex = _parent.PotionsRoll;
				
		m_SignetsGreenDropDownMenu.selectedIndex = _parent.SignetsGreenRoll;
		m_SignetsBlueDropDownMenu.selectedIndex = _parent.SignetsBlueRoll;
		m_SignetsPurpleDropDownMenu.selectedIndex = _parent.SignetsPurpleRoll;
		
		m_FragmentsBlueDropDownMenu.selectedIndex = _parent.FragmentsBlueRoll;
		m_FragmentsPurpleDropDownMenu.selectedIndex = _parent.FragmentsPurpleRoll;
		
		m_TheatricsDropDownMenu.selectedIndex = _parent.TheatricsRoll;
		m_SequinsDropDownMenu.selectedIndex = _parent.SequinsRoll;
		m_GadgetsDropDownMenu.selectedIndex = _parent.GadgetsRoll;

	}
	
	public function LoadFrameThree()
	{
		//Dropdowns
		m_ScenarioAugmentsGreenDropDownMenu.dataProvider = categoryDropDownData;
		m_ScenarioAugmentsGreenDropDownMenu.rowCount = categoryDropDownData.length;
		m_ScenarioAugmentsGreenDropDownMenu.addEventListener("change", this, "ScenarioAugmentsGreenDropdownEvent");
		
		m_ScenarioAugmentsBlueDropDownMenu.dataProvider = categoryDropDownData;
		m_ScenarioAugmentsBlueDropDownMenu.rowCount = categoryDropDownData.length;
		m_ScenarioAugmentsBlueDropDownMenu.addEventListener("change", this, "ScenarioAugmentsBlueDropdownEvent");
		
		m_ScenarioAugmentsPurpleDropDownMenu.dataProvider = categoryDropDownData;
		m_ScenarioAugmentsPurpleDropDownMenu.rowCount = categoryDropDownData.length;
		m_ScenarioAugmentsPurpleDropDownMenu.addEventListener("change", this, "ScenarioAugmentsPurpleDropdownEvent");
		
		m_ScenarioAugmentsGoldDropDownMenu.dataProvider = categoryDropDownData;
		m_ScenarioAugmentsGoldDropDownMenu.rowCount = categoryDropDownData.length;
		m_ScenarioAugmentsGoldDropDownMenu.addEventListener("change", this, "ScenarioAugmentsGoldDropdownEvent");
		
		m_ScenarioMinesDropDownMenu.dataProvider = categoryDropDownData;
		m_ScenarioMinesDropDownMenu.rowCount = categoryDropDownData.length;
		m_ScenarioMinesDropDownMenu.addEventListener("change", this, "ScenarioMinesDropdownEvent");
		
		m_ScenarioFirstAidDropDownMenu.dataProvider = categoryDropDownData;
		m_ScenarioFirstAidDropDownMenu.rowCount = categoryDropDownData.length;
		m_ScenarioFirstAidDropDownMenu.addEventListener("change", this, "ScenarioFirstAidDropdownEvent");
		
		m_ScenarioBearArmsDropDownMenu.dataProvider = categoryDropDownData;
		m_ScenarioBearArmsDropDownMenu.rowCount = categoryDropDownData.length;
		m_ScenarioBearArmsDropDownMenu.addEventListener("change", this, "ScenarioBearArmsDropdownEvent");
		
		m_ScenarioPotionsDropDownMenu.dataProvider = categoryDropDownData;
		m_ScenarioPotionsDropDownMenu.rowCount = categoryDropDownData.length;
		m_ScenarioPotionsDropDownMenu.addEventListener("change", this, "ScenarioPotionsDropdownEvent");
		
		m_ScenarioWeaponsDropDownMenu.dataProvider = categoryDropDownData;
		m_ScenarioWeaponsDropDownMenu.rowCount = categoryDropDownData.length;
		m_ScenarioWeaponsDropDownMenu.addEventListener("change", this, "ScenarioWeaponsDropdownEvent");
		
		m_ScenarioToolkitsDropDownMenu.dataProvider = categoryDropDownData;
		m_ScenarioToolkitsDropDownMenu.rowCount = categoryDropDownData.length;
		m_ScenarioToolkitsDropDownMenu.addEventListener("change", this, "ScenarioToolkitsDropdownEvent");
		
		m_ScenarioTheatricsDropDownMenu.dataProvider = categoryDropDownData;
		m_ScenarioTheatricsDropDownMenu.rowCount = categoryDropDownData.length;
		m_ScenarioTheatricsDropDownMenu.addEventListener("change", this, "ScenarioTheatricsDropdownEvent");
		
		m_ScenarioGadgetsDropDownMenu.dataProvider = categoryDropDownData;
		m_ScenarioGadgetsDropDownMenu.rowCount = categoryDropDownData.length;
		m_ScenarioGadgetsDropDownMenu.addEventListener("change", this, "ScenarioGadgetsDropdownEvent");
		
		//Selected Indices
		m_ScenarioAugmentsGreenDropDownMenu.selectedIndex = _parent.ScenarioAugmentsGreenRoll;
		m_ScenarioAugmentsBlueDropDownMenu.selectedIndex = _parent.ScenarioAugmentsBlueRoll;
		m_ScenarioAugmentsPurpleDropDownMenu.selectedIndex = _parent.ScenarioAugmentsPurpleRoll;
		m_ScenarioAugmentsGoldDropDownMenu.selectedIndex = _parent.ScenarioAugmentsGoldRoll;
		m_ScenarioMinesDropDownMenu.selectedIndex = _parent.ScenarioMinesRoll;
		m_ScenarioFirstAidDropDownMenu.selectedIndex = _parent.ScenarioFirstAidRoll;
		m_ScenarioBearArmsDropDownMenu.selectedIndex = _parent.ScenarioBearArmsRoll;
		m_ScenarioPotionsDropDownMenu.selectedIndex = _parent.ScenarioPotionsRoll;
		m_ScenarioWeaponsDropDownMenu.selectedIndex = _parent.ScenarioWeaponsRoll;
		m_ScenarioToolkitsDropDownMenu.selectedIndex = _parent.ScenarioToolkitsRoll;
		m_ScenarioTheatricsDropDownMenu.selectedIndex = _parent.ScenarioTheatricsRoll;
		m_ScenarioGadgetsDropDownMenu.selectedIndex = _parent.ScenarioGadgetsRoll;
	}
	
	public function GetLootMode():String
	{
		switch(_root.waypoints.m_PlayfieldID)
		{
			case 7600: //Hotel
				//UtilsBase.PrintChatText("AutoNBG: In Hotel.");
				return "Scenario";
				break;
			case 7610: //Mansion
				//UtilsBase.PrintChatText("AutoNBG: In Mansion.");
				return "Scenario";
				break;
			case 7620: //Castle
				//UtilsBase.PrintChatText("AutoNBG: In Castle.");
				return "Scenario";
				break;
			case 7601: //Hotel
				//UtilsBase.PrintChatText("AutoNBG: In Hotel.");
				return "Scenario";
				break;
			case 7611: //Mansion
				//UtilsBase.PrintChatText("AutoNBG: In Mansion.");
				return "Scenario";
				break;
			case 7621: //Castle
				//UtilsBase.PrintChatText("AutoNBG: In Castle.");
				return "Scenario";
				break;
			case 7602: //Hotel
				//UtilsBase.PrintChatText("AutoNBG: In Hotel.");
				return "Scenario";
				break;
			case 7612: //Mansion
				//UtilsBase.PrintChatText("AutoNBG: In Mansion.");
				return "Scenario";
				break;
			case 7622: //Castle
				//UtilsBase.PrintChatText("AutoNBG: In Castle.");
				return "Scenario";
				break;
			case 7603: //Hotel
				//UtilsBase.PrintChatText("AutoNBG: In Hotel.");
				return "Scenario";
				break;
			case 7613: //Mansion
				//UtilsBase.PrintChatText("AutoNBG: In Mansion.");
				return "Scenario";
				break;
			case 7623: //Castle
				//UtilsBase.PrintChatText("AutoNBG: In Castle.");
				return "Scenario";
				break;	
			case 5040: //Polaris
				//UtilsBase.PrintChatText("AutoNBG: In Polaris.");
				return "Dungeon";
				break;
			case 5140: //Hell Raised
				//UtilsBase.PrintChatText("AutoNBG: In Hell Raised.");
				return "Dungeon";
				break;
			case 5170: //Darkness Wars
				//UtilsBase.PrintChatText("AutoNBG: In Darkness Wars.");
				return "Dungeon";
				break;
			case 5080: //The Ankh
				//UtilsBase.PrintChatText("AutoNBG: In The Ankh.");
				return "Dungeon";
				break;
			case 5150: //Hell Fallen
				//UtilsBase.PrintChatText("AutoNBG: In Hell Fallen.");
				return "Dungeon";
				break;
			case 5190: //Facility
				//UtilsBase.PrintChatText("AutoNBG: In Facility.");
				return "Dungeon";
				break;
			case 5160: //Hell Eternal
				//UtilsBase.PrintChatText("AutoNBG: In Hell Eternal.");
				return "Dungeon";
				break;
			case 5000: //Slaughterhouse
				//UtilsBase.PrintChatText("AutoNBG: In Slaughterhouse.");
				return "Dungeon";
				break;
			case 5710: //NYRaid
				//UtilsBase.PrintChatText("AutoNBG: In NYRaid.");
				return "Raid";
				break;
			default:
				//UtilsBase.PrintChatText("AutoNBG: Not in Scenario or Dungeon.");
				return "General and Tokyo";
				break;
		}
	}
	
	public function LoadFrameFour()
	{
		//Dropdowns
		m_DungeonWeaponsGreenTenDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonWeaponsGreenTenDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonWeaponsGreenTenDropDownMenu.addEventListener("change", this, "DungeonWeaponsGreen10PlusDropdownEvent");
		m_DungeonWeaponsBlueTenDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonWeaponsBlueTenDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonWeaponsBlueTenDropDownMenu.addEventListener("change", this, "DungeonWeaponsBlue10PlusDropdownEvent");
		m_DungeonWeaponsGreenLessThanTenDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonWeaponsGreenLessThanTenDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonWeaponsGreenLessThanTenDropDownMenu.addEventListener("change", this, "DungeonWeaponsGreenLessThan10DropdownEvent");
		m_DungeonWeaponsBlueLessThanTenDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonWeaponsBlueLessThanTenDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonWeaponsBlueLessThanTenDropDownMenu.addEventListener("change", this, "DungeonWeaponsBlueLessThan10DropdownEvent");
		m_DungeonWeaponsPurpleDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonWeaponsPurpleDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonWeaponsPurpleDropDownMenu.addEventListener("change", this, "DungeonWeaponsPurpleDropdownEvent");
		m_DungeonTalismansGreenTenDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonTalismansGreenTenDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonTalismansGreenTenDropDownMenu.addEventListener("change", this, "DungeonTalismansGreen10PlusDropdownEvent");
		m_DungeonTalismansBlueTenDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonTalismansBlueTenDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonTalismansBlueTenDropDownMenu.addEventListener("change", this, "DungeonTalismansBlue10PlusDropdownEvent");
		m_DungeonTalismansGreenLessThanTenDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonTalismansGreenLessThanTenDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonTalismansGreenLessThanTenDropDownMenu.addEventListener("change", this, "DungeonTalismansGreenLessThan10DropdownEvent");
		m_DungeonTalismansBlueLessThanTenDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonTalismansBlueLessThanTenDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonTalismansBlueLessThanTenDropDownMenu.addEventListener("change", this, "DungeonTalismansBlueLessThan10DropdownEvent");
		m_DungeonTalismansPurpleDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonTalismansPurpleDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonTalismansPurpleDropDownMenu.addEventListener("change", this, "DungeonTalismansPurpleDropdownEvent");
		m_DungeonToolkitsGreenDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonToolkitsGreenDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonToolkitsGreenDropDownMenu.addEventListener("change", this, "DungeonToolkitsGreenDropdownEvent");
		m_DungeonToolkitsBlueDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonToolkitsBlueDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonToolkitsBlueDropDownMenu.addEventListener("change", this, "DungeonToolkitsBlueDropdownEvent");
		m_DungeonToolkitsAuxBlueDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonToolkitsAuxBlueDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonToolkitsAuxBlueDropDownMenu.addEventListener("change", this, "DungeonToolkitsAuxBlueDropdownEvent");		
		m_DungeonToolkitsPurpleDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonToolkitsPurpleDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonToolkitsPurpleDropDownMenu.addEventListener("change", this, "DungeonToolkitsPurpleDropdownEvent");
		m_DungeonToolkitsAuxPurpleDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonToolkitsAuxPurpleDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonToolkitsAuxPurpleDropDownMenu.addEventListener("change", this, "DungeonToolkitsAuxPurpleDropdownEvent");		
		m_DungeonToolkitsNightwatchDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonToolkitsNightwatchDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonToolkitsNightwatchDropDownMenu.addEventListener("change", this, "DungeonToolkitsNightwatchDropdownEvent");		
		m_DungeonPotionsDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonPotionsDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonPotionsDropDownMenu.addEventListener("change", this, "DungeonPotionsDropdownEvent");
		m_DungeonBlueprintsDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonBlueprintsDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonBlueprintsDropDownMenu.addEventListener("change", this, "DungeonBlueprintsDropdownEvent");
		m_DungeonTheatricsDropDownMenu.dataProvider = categoryDropDownData;
		m_DungeonTheatricsDropDownMenu.rowCount = categoryDropDownData.length;
		m_DungeonTheatricsDropDownMenu.addEventListener("change", this, "DungeonTheatricsDropdownEvent");

		
		//Selected Indices
		m_DungeonWeaponsGreenLessThanTenDropDownMenu.selectedIndex = _parent.DungeonWeaponsGreenLessThanTenRoll;
		m_DungeonWeaponsBlueLessThanTenDropDownMenu.selectedIndex = _parent.DungeonWeaponsBlueLessThanTenRoll;
		m_DungeonWeaponsGreenTenDropDownMenu.selectedIndex = _parent.DungeonWeaponsGreenTenRoll;
		m_DungeonWeaponsBlueTenDropDownMenu.selectedIndex = _parent.DungeonWeaponsBlueTenRoll;
		m_DungeonWeaponsPurpleDropDownMenu.selectedIndex = _parent.DungeonWeaponsPurpleRoll;
		m_DungeonTalismansGreenLessThanTenDropDownMenu.selectedIndex = _parent.DungeonTalismansGreenLessThanTenRoll;
		m_DungeonTalismansBlueLessThanTenDropDownMenu.selectedIndex = _parent.DungeonTalismansBlueLessThanTenRoll;
		m_DungeonTalismansGreenTenDropDownMenu.selectedIndex = _parent.DungeonTalismansGreenTenRoll;
		m_DungeonTalismansBlueTenDropDownMenu.selectedIndex = _parent.DungeonTalismansBlueTenRoll;
		m_DungeonTalismansPurpleDropDownMenu.selectedIndex = _parent.DungeonTalismansPurpleRoll;
		m_DungeonToolkitsGreenDropDownMenu.selectedIndex = _parent.DungeonToolkitsGreenRoll;
		m_DungeonToolkitsBlueDropDownMenu.selectedIndex = _parent.DungeonToolkitsBlueRoll;
		m_DungeonToolkitsAuxBlueDropDownMenu.selectedIndex = _parent.DungeonToolkitsAuxBlueRoll;
		m_DungeonToolkitsPurpleDropDownMenu.selectedIndex = _parent.DungeonToolkitsPurpleRoll;
		m_DungeonToolkitsAuxPurpleDropDownMenu.selectedIndex = _parent.DungeonToolkitsAuxPurpleRoll;
		m_DungeonToolkitsNightwatchDropDownMenu.selectedIndex = _parent.DungeonToolkitsNightwatchRoll;
		m_DungeonPotionsDropDownMenu.selectedIndex = _parent.DungeonPotionsRoll;
		m_DungeonBlueprintsDropDownMenu.selectedIndex = _parent.DungeonBlueprintsRoll;
		m_DungeonTheatricsDropDownMenu.selectedIndex = _parent.DungeonTheatricsRoll;
	}
	
	public function LoadFrameFive()
	{
		//Dropdowns
		m_TokyoRareCocktailDropDownMenu.dataProvider = categoryDropDownData;
		m_TokyoRareCocktailDropDownMenu.rowCount = categoryDropDownData.length;
		m_TokyoRareCocktailDropDownMenu.addEventListener("change", this, "TokyoRareCocktailDropDownEvent");
		m_AegisModuleGreenDropDownMenu.dataProvider = categoryDropDownData;
		m_AegisModuleGreenDropDownMenu.rowCount = categoryDropDownData.length;
		m_AegisModuleGreenDropDownMenu.addEventListener("change", this, "AegisModuleGreenDropDownEvent");
		m_AegisModuleBlueDropDownMenu.dataProvider = categoryDropDownData;
		m_AegisModuleBlueDropDownMenu.rowCount = categoryDropDownData.length;
		m_AegisModuleBlueDropDownMenu.addEventListener("change", this, "AegisModuleBlueDropDownEvent");
		m_AegisModulePurpleDropDownMenu.dataProvider = categoryDropDownData;
		m_AegisModulePurpleDropDownMenu.rowCount = categoryDropDownData.length;
		m_AegisModulePurpleDropDownMenu.addEventListener("change", this, "AegisModulePurpleDropDownEvent");
		m_AegisCapacitorlessThen4DropDownMenu.dataProvider = categoryDropDownData;
		m_AegisCapacitorlessThen4DropDownMenu.rowCount = categoryDropDownData.length;
		m_AegisCapacitorlessThen4DropDownMenu.addEventListener("change", this, "AegisCapacitorlessThen4DropDownEvent"); //Green
		m_AegisCapacitorMoreThen5DropDownMenu.dataProvider = categoryDropDownData;
		m_AegisCapacitorMoreThen5DropDownMenu.rowCount = categoryDropDownData.length;
		m_AegisCapacitorMoreThen5DropDownMenu.addEventListener("change", this, "AegisCapacitorMoreThen5DropDownEvent"); //Green
		m_AegisCapacitorlessThen4BlueDropDownMenu.dataProvider = categoryDropDownData;
		m_AegisCapacitorlessThen4BlueDropDownMenu.rowCount = categoryDropDownData.length;
		m_AegisCapacitorlessThen4BlueDropDownMenu.addEventListener("change", this, "AegisCapacitorlessThen4BlueDropDownEvent");
		m_AegisCapacitorMoreThen5BlueDropDownMenu.dataProvider = categoryDropDownData;
		m_AegisCapacitorMoreThen5BlueDropDownMenu.rowCount = categoryDropDownData.length;
		m_AegisCapacitorMoreThen5BlueDropDownMenu.addEventListener("change", this, "AegisCapacitorMoreThen5BlueDropDownEvent");
		m_AegisCapacitorlessThen4PurpleDropDownMenu.dataProvider = categoryDropDownData;
		m_AegisCapacitorlessThen4PurpleDropDownMenu.rowCount = categoryDropDownData.length;
		m_AegisCapacitorlessThen4PurpleDropDownMenu.addEventListener("change", this, "AegisCapacitorlessThen4PurpleDropDownEvent");
		m_AegisCapacitorMoreThen5PurpleDropDownMenu.dataProvider = categoryDropDownData;
		m_AegisCapacitorMoreThen5PurpleDropDownMenu.rowCount = categoryDropDownData.length;
		m_AegisCapacitorMoreThen5PurpleDropDownMenu.addEventListener("change", this, "AegisCapacitorMoreThen5PurpleDropDownEvent");
		/*
		m_AegisControllerGreenDropDownMenu.dataProvider = categoryDropDownData;
		m_AegisControllerGreenDropDownMenu.rowCount = categoryDropDownData.length;
		m_AegisControllerGreenDropDownMenu.addEventListener("change", this, "AegisControllerGreenDropDownEvent");
		m_AegisControllerBlueDropDownMenu.dataProvider = categoryDropDownData;
		m_AegisControllerBlueDropDownMenu.rowCount = categoryDropDownData.length;
		m_AegisControllerBlueDropDownMenu.addEventListener("change", this, "AegisControllerBlueDropDownEvent");
		m_AegisControllerPurpleDropDownMenu.dataProvider = categoryDropDownData;
		m_AegisControllerPurpleDropDownMenu.rowCount = categoryDropDownData.length;
		m_AegisControllerPurpleDropDownMenu.addEventListener("change", this, "AegisControllerPurpleDropDownEvent");
		m_TokyoTokenDropDownMenu.dataProvider = categoryDropDownData;
		m_TokyoTokenDropDownMenu.rowCount = categoryDropDownData.length;
		m_TokyoTokenDropDownMenu.addEventListener("change", this, "TokyoTokenDropDownEvent"); */
		m_UnusualFilthSampleDropDownMenu.dataProvider = categoryDropDownData;
		m_UnusualFilthSampleDropDownMenu.rowCount = categoryDropDownData.length;
		m_UnusualFilthSampleDropDownMenu.addEventListener("change", this, "UnusualFilthSampleDropDownEvent");
		
		//Selected Indices
		m_TokyoRareCocktailDropDownMenu.selectedIndex = _parent.TokyoRareCocktailRoll;
		m_AegisModuleGreenDropDownMenu.selectedIndex = _parent.AegisModuleGreenRoll;
		m_AegisModuleBlueDropDownMenu.selectedIndex = _parent.AegisModuleBlueRoll;
		m_AegisModulePurpleDropDownMenu.selectedIndex = _parent.AegisModulePurpleRoll;
		m_AegisCapacitorlessThen4DropDownMenu.selectedIndex = _parent.AegisCapacitorlessThen4Roll;
		m_AegisCapacitorMoreThen5DropDownMenu.selectedIndex = _parent.AegisCapacitorMoreThen5Roll;
		m_AegisCapacitorlessThen4BlueDropDownMenu.selectedIndex = _parent.AegisCapacitorlessThen4BlueRoll;
		m_AegisCapacitorMoreThen5BlueDropDownMenu.selectedIndex = _parent.AegisCapacitorMoreThen5BlueRoll;
		m_AegisCapacitorlessThen4PurpleDropDownMenu.selectedIndex = _parent.AegisCapacitorlessThen4PurpleRoll;
		m_AegisCapacitorMoreThen5PurpleDropDownMenu.selectedIndex = _parent.AegisCapacitorMoreThen5PurpleRoll;
		/*
		m_AegisControllerGreenDropDownMenu.selectedIndex = _parent.AegisControllerGreenRoll;
		m_AegisControllerBlueDropDownMenu.selectedIndex = _parent.AegisControllerBlueRoll;
		m_AegisControllerPurpleDropDownMenu.selectedIndex = _parent.AegisControllerPurpleRoll;
		m_TokyoTokenDropDownMenu.selectedIndex = _parent.TokyoTokenRoll;
		*/
		m_UnusualFilthSampleDropDownMenu.selectedIndex = _parent.UnusualFilthSampleRoll;
	}
	
	public function LoadFrameOne()
	{
		m_ActiveLoot.text = GetLootMode();
		
		m_FIFOToggleCheckbox.addEventListener("click", this, "onFIFOToggleCheckBoxChecked", true);
		m_AutoNBGToggleCheckbox.addEventListener("click", this, "onAutoNBGToggleCheckBoxChecked", true);
	/*	m_AutoNBGDisableRollwindowCheckbox.addEventListener("click", this, "onAutoNBGDisableRollwindowCheckBoxChecked", true); */
		
		//Selected
		m_FIFOToggleCheckbox.m_Text.textField.text = "Enable FIFO";
		m_FIFOToggleCheckbox.m_Text.textField.textColor = 0xFFFFFF;
		m_FIFOToggleCheckbox.selected = _parent.FIFOToggle;
		
		m_AutoNBGToggleCheckbox.m_Text.textField.text = "Enable AutoNBG";
		m_AutoNBGToggleCheckbox.m_Text.textField.textColor = 0xFFFFFF;
		m_AutoNBGToggleCheckbox.selected = _parent.AutoNBGToggle;
	/*	
		m_AutoNBGDisableRollwindowCheckbox.m_Text.textField.text = "Disable Roll Window";
		m_AutoNBGDisableRollwindowCheckbox.m_Text.textField.textColor = 0xFFFFFF;
		m_AutoNBGDisableRollwindowCheckbox.selected = _parent.AutoNBGDisableRollwindow;  */
	}
}