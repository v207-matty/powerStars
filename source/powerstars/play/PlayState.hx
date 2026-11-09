package powerstars.play;

import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import powerstars.play.components.*;
import flixel.*;

class PlayState extends FlxState
{
	var player:Player;
	var playerSpeed:Float = 1;

	public var playerMovementSpeed(get, null):Float;

	function get_playerMovementSpeed():Float
		return player.width * (0.2 * playerSpeed);

	var inputEnabled:Bool = false;

	var realm:Realm = NONE;
	var section:Array<Int> = [0, 0];
    var sectionText:FlxText;

	var transitionColor:FlxColor = FlxColor.WHITE;
	var transitionDuration:Float = 1;

	override function create()
	{
		super.create();

		add(player = new Player());
        add(sectionText = new FlxText(0,0,0,'',16));

		refresh(false);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (inputEnabled)
			playerControls();
	}

	public var control_left(get, null):Bool;

	function get_control_left():Bool
		return FlxG.keys.anyPressed([A, LEFT]);

	public var control_right(get, null):Bool;

	function get_control_right():Bool
		return FlxG.keys.anyPressed([D, RIGHT]);

	public var moving_left(get, null):Bool;

	function get_moving_left():Bool
		return player.x <= 0;

	public var moving_right(get, null):Bool;

	function get_moving_right():Bool
		return player.x >= FlxG.width - player.width;

	public function playerControls()
	{
		playerSpeed = FlxMath.lerp(playerSpeed, (control_left || control_right) ? 1 : 0.01, 0.04);

		if (control_left)
			player.x -= playerMovementSpeed;
		if (control_right)
			player.x += playerMovementSpeed;

		if (moving_left || moving_right)
		{
			refresh(true);

			if (moving_left)
				section[0]--;
			else if (moving_right)
				section[0]++;
		}
	}

	public function refresh(cameraFade = true)
	{
		function onCameraFadeDone()
		{
			player.screenCenter();

			inputEnabled = true;

            sectionText.text = '${section}';

			if (cameraFade)
				camera.fade(transitionColor, transitionDuration / 2, true, false);
		}

		inputEnabled = false;

		if (cameraFade)
			camera.fade(transitionColor, transitionDuration / 2, false, onCameraFadeDone, true);
		else
			onCameraFadeDone();
	}
}
