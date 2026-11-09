package powerstars.play.components;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class Player extends FlxSprite
{
	override public function new()
	{
		super();

		makeGraphic(64, 64, FlxColor.RED);
	}
}
