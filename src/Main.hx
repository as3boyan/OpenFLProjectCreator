package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.ui.Keyboard;
import haxe.Timer;
import motion.Actuate;
import openfl.Assets;
import piratepig.PiratePig;

#if desktop
import sys.io.Process;
import sys.FileSystem;
#end

class Main extends Sprite 
{
	var inited:Bool;
	var n:Int;
	var samples:Array<Sample>;
	
	var tf:CustomTextField;
	var sample_names:Array<String>;
	var background:Sprite;
	var tf2:CustomTextField;
	var notification_panel:NotificationPanel;
	var sample_texts:Array<String>;
	var tf_right:CustomTextField;
	var tf_left:CustomTextField;
	var tf_path:PathTextField;
	var background2:Bitmap;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
		
		n = 0;
		
		background = new Sprite();
		background.addChild(new Bitmap(Assets.getBitmapData("assets/openfl_background.png")));
		background.y = (720 - background.height) / 2 - 85;
		background.alpha = 0;
		background.useHandCursor = true;
		background.addEventListener(MouseEvent.CLICK, onBackgroundClick);
		addChild(background);
		
		notification_panel = new NotificationPanel();
		addChild(notification_panel);
		
		Actuate.tween(background, 1, { alpha:1 } ).onComplete(init2);
	}
	
	private function onBackgroundClick(e:MouseEvent):Void 
	{
		Actuate.stop(background);
		
		if (tf2 != null)
		{
			Actuate.stop(tf2);
			removeChild(tf2);
		}
		
		background.removeEventListener(MouseEvent.CLICK, onBackgroundClick);
		
		Actuate.tween(background, 3, { alpha:0 } );
		
		background2 = new Bitmap(new BitmapData(1280, 720, false));
		background2.alpha = 0;
		addChildAt(background2, 0);
		
		Actuate.tween(background2, 3, { alpha:1 } ).onComplete(init3);
	}
	
	private function init2():Void
	{
		tf2 = new CustomTextField(72);
		tf2.pulse("click to continue");
		tf2.y = 600;
		addChild(tf2);
	}
	
	private function init3():Void
	{				
		samples = [new ActuateExample(), new AddingAnimation(), new AddingText(), 
		new DisplayingABitmap(), new HandlingKeyboardEvents(), new HandlingMouseEvents(), 
		new PlayingSound(), new SimpleBox2D(), new PiratePig()];
		
		sample_names = ["ActuateExample", "AddingAnimation", "AddingText", 
		"DisplayingABitmap", "HandlingKeyboardEvents", "HandlingMouseEvents", 
		"PlayingSound", "SimpleBox2D", "PiratePig", "SimpleOpenGLView", "HerokuShaders"];
		
		sample_texts = [
		"Actuate is a tween library\nYou can use it to tween object properties:\nActuate.tween (MySprite, 1, { alpha: 1 } );",
		"Simple animation using Actuate\nActuate.tween (container, 4, { scaleX: 1, scaleY: 1 } ).delay (0.4).ease (Elastic.easeOut);",
		"You can embed custom fonts:\n@:font(\"assets/KatamotzIkasi.ttf\") class DefaultFont extends Font {}\nFont.registerFont (DefaultFont);",
		"You can add images using Assets.getBitmapData():\nvar bitmap = new Bitmap (Assets.getBitmapData (\"assets/openfl.png\"))\naddChild (bitmap);\nthey will be stored in cache by default",	
		"Use arrow keys to move OpenFL logo\nYou can handle keyboard keypresses by adding listeners on KeyboardEvent:\nstage.addEventListener (KeyboardEvent.KEY_DOWN, stage_onKeyDown);",
		"Hold and move your left mouse button on OpenFL logo to move it\nYou can handle mouse interaction to sprite by adding listeners on MouseEvent\n sprite.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);",
		"You can play/pause payback of active sound, if you click everywhere on stage\n(screen will became green when playback is active)\nYou can play sound using:\nvar sound = Assets.getSound (\"assets/stars.mp3\");\nsound.play ();",
		"You can add physics to your game/app using Box2D\n You can create dynamic objects(affected by gravity and other forces)\n and non dynamic(they remain fixed position) specifying type of B2BodyDef",
		"Crossplatform match 3 game made using OpenFL",
		"Simple OpenGL example\nYou can get access to low level OpenGL and use custom shaders using openfl.gl package(Should work on all platforms, except flash)",
		"These shaders are taken from http://glsl.heroku.com(Should work on all platforms, except flash)"
		];

		removeChild(background);
		
		#if !flash
		samples.push(new SimpleOpenGLView());
		samples.push(new HerokuShaders());
		#end
		
		for (sample in samples)
		{
			sample.visible = false;
			addChild(sample);
		}
		
		tf_left = new CustomTextField(72, 0x000000, TextFormatAlign.LEFT);
		tf_left.setAlpha(0.05);
		tf_left.mouseEnabled = true;
		tf_left.text = "<";
		tf_left.scaleX = 5;
		tf_left.scaleY = 5;
		tf_left.width = 150/3;
		tf_left.height = 100;
		tf_left.y = 175;
		tf_left.addEventListener(MouseEvent.CLICK, onLeftClick);
		addChild(tf_left);
		
		tf_right = new CustomTextField(72, 0x000000, TextFormatAlign.LEFT);
		tf_right.setAlpha(0.05);
		tf_right.mouseEnabled = true;
		tf_right.text = ">";
		tf_right.scaleX = 5;
		tf_right.scaleY = 5;
		tf_right.width = 150/3;
		tf_right.height = 100;
		tf_right.x = 1280 - 150/3 *5 + 15;
		tf_right.y = 175;
		tf_right.addEventListener(MouseEvent.CLICK, onRightClick);
		addChild(tf_right);
		
		tf = new CustomTextField(null, 0x000000);
		addChild(tf);
		
		addEventListener(Event.RESIZE, onResize);
		
		onResize(null);
		
		showSample(0);
		
		#if desktop
		var tf_description:CustomTextField = new CustomTextField(18, 0x000000, TextFormatAlign.CENTER);
		tf_description.text = "Type prefered path and click \"Create Project\" to create selected sample project";
		tf_description.setAlpha(0.3);
		tf_description.y = 600;
		addChild(tf_description);
		
		tf_path = new PathTextField();
		tf_path.y = tf_description.y + 40;
		addChild(tf_path);
		
		var button:Button = new Button(this, tf_path.x + tf_path.width + 75, tf_path.y + 15 + 3, "Create Project", onClick);
		button.setWidth(150,30);
		addChild(button);
		#end
		
		
	}
	
	#if desktop
	function onClick() 
	{
		tf_path.onChange(null);
		
		if (!tf_path.valid)
		{
			notification_panel.show("Specified path doesn't exist! Check entered path\n(path text should became green if path exist)", 10000);
			return;
		}
		
		Sys.setCwd(tf_path.text);
		Sys.command("haxelib run openfl", ["create", sample_names[n]]);
		
		if (tf_path.text.lastIndexOf("\\") != -1)
		{
			tf_path.text = tf_path.text.substr(0, tf_path.text.length -1);
		}
		
		tf_path.onChange(null);
		
		notification_panel.show("Sample project " + sample_names[n] + "\nshould be created at " + tf_path.text + "\\" + sample_names[n], 5000);
				
		#if windows
		Sys.command("explorer", [  tf_path.text + "\\" + sample_names[n] + "\\" + sample_names[n] + ".hxproj" ]);
		#end
	}
	
	#end
	
	private function onRightClick(e:MouseEvent):Void 
	{
		showNextSample();
	}
	
	private function onLeftClick(e:MouseEvent):Void 
	{
		showPrevSample();
	}
	
	private function onResize(e:Event):Void 
	{
		scaleX = stage.stageWidth / 1280;
		scaleY = stage.stageHeight / 720;
	}
	
	private function showNextSample()
	{
		n++;
		if (n == samples.length) n = 0;
		showSample(n);
		
		stage.focus = tf_path;
	}
	
	private function showPrevSample()
	{
		n--;
		if (n == -1) n = samples.length - 1;
		showSample(n);
	}
	
	private function showSample(i:Int):Void
	{
		for (sample in samples)
		{
			sample.visible = false;
		}
		
		samples[i].visible = true;
		samples[i].show();
		
		if (sample_names[i] == "HerokuShaders")
		{
			background2.visible = false;
		}
		else
		{
			background2.visible = true;
		}
		
		notification_panel.show(sample_names[i] + "\n" + sample_texts[i], 15000);
	}
	

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
