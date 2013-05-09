package ;
/** @author Gold_Ninja */

import org.flixel.FlxSprite;

class Loading_Anim extends FlxSprite
{

	public function new(_x:Int, _y:Int)
	{	super(_x, _y);
		loadGraphic("assets/sprites/Loading_Anim.png", true, false, 36, 36);
		
		addAnimation("idle", [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19], 24, true);
		play("idle");
		
	}
	
}