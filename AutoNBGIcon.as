import com.GameInterface.UtilsBase;
import com.GameInterface.Tooltip.Tooltip;
import com.GameInterface.Tooltip.TooltipData;
import com.GameInterface.Tooltip.TooltipInterface;
import com.GameInterface.Tooltip.TooltipManager;
import mx.utils.Delegate;
import com.GameInterface.DistributedValue;
import com.GameInterface.InventoryItem
import GUI.Inventory.IconBox;
import GUI.Inventory.ItemIconBox;
import GUI.Inventory.ShortcutsIconBox;

/*
 This code is based on the icon handling from BooWarnings by Aedani, original code by Viper.  Thanks to Aedani and Viper. And Boorish.
*/

class AutoNBGIcon extends MovieClip 
{
	//private var m_AutoNBGIcon:MovieClip;
	private var m_tooltip:TooltipInterface;
	
	public function AutoNBGIcon() 
	{
		super();
		onPress = Delegate.create(this, onPress);
		onRollOver = Delegate.create(this, onRollover);
		onRollOut = Delegate.create(this, onRollout);
	}
	
	public function onLoad() 
	{
		//UtilsBase.PrintChatText("AutoNBGIcon: onLoad");
	
	}
	
	public function onPress():Void
	{
		if (m_tooltip != undefined)	m_tooltip.Close();
		DistributedValue.SetDValue("AutoNBGWindowOn", !DistributedValue.GetDValue("AutoNBGWindowOn"));
	}

	public function onRollover():Void
	{
		if (m_tooltip != undefined) m_tooltip.Close();
		var tooltipData:TooltipData = new TooltipData();
		tooltipData.AddAttribute("", "<font face='_StandardFont' size='13' color='#FF8000'><b>AutoNBG v 1.7.0 - Alpha</b></font>"); //Maintaining color and style for uniformity with other VTIO addons.
		tooltipData.AddAttributeSplitter();
		tooltipData.AddAttribute("", "");
		tooltipData.AddAttribute("", "<font face='_StandardFont' size='12' color='#FFFFFF'>Open/Close AutoNBG Config</font>");
		tooltipData.m_Padding = 4;
		tooltipData.m_MaxWidth = 210;
		m_tooltip = TooltipManager.GetInstance().ShowTooltip(undefined, TooltipInterface.e_OrientationVertical, 0, tooltipData);
	}

	public function onRollout():Void
	{
		if (m_tooltip != undefined)	m_tooltip.Close();
	}

}