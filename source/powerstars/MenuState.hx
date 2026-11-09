package powerstars;

import flixel.*;
import flixel.text.FlxText;
import powerstars.play.PlayState;

class MenuState extends FlxState
{
	var title:FlxText;

	override function create()
	{
		super.create();

		add(title = new FlxText(0, 0, 0, 'POWER STARS', 64));
		title.screenCenter();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ANY)
			FlxG.switchState(() -> new PlayState());
	}
}
