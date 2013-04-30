package;

import nme.Assets;
import nme.geom.Rectangle;
import nme.net.SharedObject;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxU;

class MenuState extends FlxState
{	private var logo:FlxSprite;
	private var OK_Button:FlxButton;
	private var CANCEL_Button:FlxButton;
	
	override public function create():Void
	{
		FlxG.bgColor = 0xffFFFFFF;
		FlxG.mouse.show();
		
		logo = new FlxSprite(8, 8, "assets/sprites/Logo.png");
		add(logo);
		
		OK_Button = new FlxButton(100, 100, "Get Update", do_update);
		add(OK_Button);
		CANCEL_Button = new FlxButton(100, 100, "Cancel", do_cancel);
		add(CANCEL_Button);
		
		
		
	}
	
	override public function destroy():Void
	{	super.destroy();	}

	override public function update():Void
	{	super.update();	}
	
	private function do_update():Void
	{
		
	}
	
	private function do_cancel():Void
	{
		
	}
	
	
	
}











