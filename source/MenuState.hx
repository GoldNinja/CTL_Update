package;

import nme.Lib;
import nme.Assets;
import nme.geom.Rectangle;
import nme.net.SharedObject;
import haxe.io.Eof;
import sys.io.File;
import cpp.Lib;

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
	private var OK_Blank:FlxSprite;
	
	private var txtLocalVer:FlxText;
	private var txtServerVer:FlxText;
	private var txtChecking:FlxText;
	private var txtDownloading:FlxText;
	private var txtComplete:FlxText;
	private var txtNoConnection:FlxText;
	
	private var loading_anim:Loading_Anim;
	private var loading:FlxSprite;
	private var Title_Est:FlxSprite;
	private var Title_Upd:FlxSprite;
	private var _timer:Float = 2;
	private var check_finished:Bool = false;
	public static var download_Finished:Bool = false;
	public static var an_error:Bool = false;
	
	private var fNameLocalVersion:String;
	
	public var localVer:String;
	public var serverVer:String;
	
	
	override public function create():Void
	{	FlxG.bgColor = 0xffFFFFFF;
		FlxG.mouse.show();
		
		logo = new FlxSprite(8, 8, "assets/sprites/Logo.png");
		add(logo);
		
		//---------------------------------------------------------------------------Title
		Title_Est = new FlxSprite(272, 19, "assets/sprites/Title_Est.png");
		Title_Upd = new FlxSprite(401, 55, "assets/sprites/Title_Upd.png");
		add(Title_Est);
		add(Title_Upd);
		
		
		//---------------------------------------------------------------------------Loading Animation
		loading = new FlxSprite(281, 210, "assets/sprites/Loading.png");
		add(loading);
		loading_anim = new Loading_Anim(281, 210);
		loading_anim.visible = true;
		add(loading_anim);
		
		
		//---------------------------------------------------------------------------Text labels
		txtLocalVer = new FlxText(200, 130, 130, "Your version: ", 8);
		txtServerVer = new FlxText(320, 130, 130, "Server version: ", 8);
		txtLocalVer.alignment = txtServerVer.alignment = "left";
		txtLocalVer.color = txtServerVer.color = 0xff005ebd;
		add(txtLocalVer);
		add(txtServerVer);
		
		txtChecking = new FlxText(250, 260, 100, "CHECKING SERVER", 8);
		txtChecking.color = 0xff005ebd;
		add(txtChecking);
		
		txtDownloading = new FlxText(250, 260, 100, "DOWNLOADING", 8);
		txtDownloading.color = 0xff005ebd;
		txtDownloading.visible = false;
		add(txtDownloading);
		
		txtComplete = new FlxText(250, 260, 100, "- COMPLETE -", 8);
		txtComplete.color = 0xff005ebd;
		txtComplete.visible = false;
		add(txtComplete);
		
		txtNoConnection = new FlxText(250, 260, 100, "NO CONNECTION!!", 8);
		txtNoConnection.color = 0xffbd0000;
		txtNoConnection.visible = false;
		add(txtNoConnection);
		
		txtChecking.alignment = txtDownloading.alignment = txtComplete.alignment = txtNoConnection.alignment = "center";
		
		
		//---------------------------------------------------------------------------Buttons
		OK_Blank = new FlxSprite(200, 170, "assets/sprites/Button_blank.png");
		add(OK_Blank);
		OK_Button = new FlxButton(200, 170, "Get Update", do_update);
		OK_Button.visible = false;
		add(OK_Button);
		CANCEL_Button = new FlxButton(320, 170, "Cancel", do_cancel);
		add(CANCEL_Button);
		
		
		fNameLocalVersion = "version.txt";
		
		//---------------------------------------------------------------------------Reading version.txt
		var fileContent = File.getContent(fNameLocalVersion);
		
		if (fileContent == null)
		{	fileContent = "ERROR";	}
		
		localVer = fileContent;
		
		txtLocalVer.text += fileContent;
		
		//---------------------------------------------------------------------------Download S_version.txt
		new DynamicFile("https://dl.dropboxusercontent.com/u/8876439/Estimation/version.txt", false);
		
	}
	
	override public function update():Void
	{	if (!check_finished)														//While Checking
		{	_timer -= FlxG.elapsed;	}
		
		if (an_error)
		{	
			txtDownloading.visible = false;
			loading_anim.visible = false;
			
			txtNoConnection.visible = true;
			OK_Button.visible = false;
			CANCEL_Button.label.text = "- CLOSE -";	
		}
		
		if (_timer < 0 && !check_finished)
		{	check_finished = true;
			
			OK_Button.visible = true;
			
			var S_fileContent = File.getContent("S_version.txt");		//Check local S_version.txt
			serverVer = S_fileContent;
			txtServerVer.text += S_fileContent;
			txtChecking.visible = false;
			loading_anim.visible = false;
			
			if (serverVer == null || serverVer == "ERROR")
			{
				txtNoConnection.visible = true;
				OK_Button.visible = false;
				CANCEL_Button.label.text = "- CLOSE -";
			}
			
			var S_fout = File.write("S_version.txt", false);			//Empty the S_version.txt
			S_fout.writeString("ERROR");
			S_fout.close();
		}
		
		if (download_Finished)
		{
			update_complete();
			download_Finished = false;
		}
		
		
		super.update();
		
		
	}
	
	override public function destroy():Void
	{	super.destroy();	}

	private function do_update():Void
	{	OK_Button.visible = false;
		txtDownloading.visible = true;
		loading_anim.visible = true;
		
		new DynamicFile("https://dl.dropboxusercontent.com/u/8876439/Estimation/Estimation%20TEST.xlsm", true);
		
	}
	
	private function do_cancel():Void						//Quit
	{	Lib.exit();	}
	
	private function update_complete():Void
	{	var fout = File.write(fNameLocalVersion, false);
		localVer = serverVer;
		fout.writeString(localVer);
		fout.close();
		
		txtDownloading.visible = false;
		txtComplete.visible = true;
		txtLocalVer.text = "Your version: " + localVer;
		loading_anim.visible = false;
		CANCEL_Button.label.text = "- Close -";
		
	}
	
}











