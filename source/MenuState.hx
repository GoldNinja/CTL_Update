package;

import nme.Lib;
import nme.Assets;
import nme.geom.Rectangle;
import nme.net.SharedObject;
import haxe.io.Eof;
import sys.io.File;
import cpp.Lib;

import Std;



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
	private var txtUpdate:FlxText;
	private var txtLocalVer:FlxText;
	private var txtServerVer:FlxText;
	private var txtChecking:FlxText;
	
	private var _timer:Float = 3;
	private var check_finished:Bool = false;
	
	private var OK_Timer:Float = 0.2;
	private var OK_Timer_Switch:Bool = false;
	
	private var fNameLocalVersion:String;
	
	public var localVer:String;
	public var serverVer:String;
	
	
	override public function create():Void
	{	FlxG.bgColor = 0xffFFFFFF;
		FlxG.mouse.show();
		
		logo = new FlxSprite(8, 8, "assets/sprites/Logo.png");
		add(logo);
		
		//---------------------------------------------------------------------------Temp Title
		txtUpdate = new FlxText(120, 18, 400, "Estimation Updater", 26);
		txtUpdate.color = 0xff005ebd;
		add(txtUpdate);
		
		//---------------------------------------------------------------------------Version labels
		txtLocalVer = new FlxText(100, 160, 100, "Your version: ", 8);
		txtServerVer = new FlxText(200, 160, 100, "Server version: ", 8);
		txtLocalVer.alignment = txtServerVer.alignment = "left";
		txtLocalVer.color = txtServerVer.color = 0xff005ebd;
		add(txtLocalVer);
		add(txtServerVer);
		
		txtChecking = new FlxText(150, 250, 100, "CHECKING SERVER", 8);
		txtChecking.color = 0xff005ebd;
		add(txtChecking);
		
		//---------------------------------------------------------------------------Buttons
		OK_Button = new FlxButton(100, 100, "Get Update", do_update);
		OK_Button.active = false;
		add(OK_Button);
		CANCEL_Button = new FlxButton(200, 100, "Cancel", do_cancel);
		add(CANCEL_Button);
		
		//fName = "c:/estimation/version.txt";
		fNameLocalVersion = "version.txt";
		
		// Reading file
		var fout = File.write(fNameLocalVersion, false);
		
		var fileContent = File.getContent(fNameLocalVersion);
		
		if (fileContent == null)
		{	fileContent = "1";	}
		
		localVer = fileContent;
		
		txtLocalVer.text += fileContent;
		
		new DynamicFile("https://dl.dropboxusercontent.com/u/8876439/Estimation/version.txt", false);
		
	}
	
	override public function update():Void
	{	if (!check_finished)
		{	_timer -= FlxG.elapsed;	}
		
		if (_timer < 0 && !check_finished)
		{	check_finished = true;
			
			OK_Button.active = true;
			
			var S_fileContent = File.getContent("S_version.txt");
			serverVer = S_fileContent;
			txtServerVer.text += S_fileContent;
			txtChecking.visible = false;
		}
		super.update();
		
		if (OK_Timer_Switch)
		{	OK_Timer -= FlxG.elapsed;	}
		
		if (OK_Timer < 0)
		{	OK_Button.active = false;	}
		
		
	}
	
	override public function destroy():Void
	{	super.destroy();	}

	private function do_update():Void
	{	OK_Timer_Switch = true;
	
		new DynamicFile("https://dl.dropboxusercontent.com/u/8876439/Estimation/Estimation%20Beta%20130425.xlsm", true);
		
		update_complete();
	}
	
	private function do_cancel():Void						//Quit
	{	Lib.exit();	}
	
	private function update_complete():Void
	{
		var fout = File.write(fNameLocalVersion, false);
		localVer = serverVer;
		fout.writeString(localVer);
		fout.close();
	}
	
}











