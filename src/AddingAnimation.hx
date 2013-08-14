package;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import motion.easing.Elastic;
import motion.Actuate;
import openfl.Assets;


class AddingAnimation extends Sample {
	var container:Sprite;
	
	
	public function new () {
		
		super ();
		
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		
		var bitmap = new Bitmap (Assets.getBitmapData ("assets/openfl.png"));
		bitmap.x = - bitmap.width / 2;
		bitmap.y = - bitmap.height / 2;
		bitmap.smoothing = true;
		
		container = new Sprite ();
		container.addChild (bitmap);
		
		addChild (container);
	}
	
	override  function show():Void 
	{
		super.show();
		
		container.x = 1280 / 2;
		container.y = 720 / 2;
		container.alpha = 0;
		container.scaleX = 0;
		container.scaleY = 0;
		
		Actuate.tween (container, 3, { alpha: 1 } );
		Actuate.tween (container, 4, { scaleX: 1, scaleY: 1 } ).delay (0.4).ease (Elastic.easeOut);
	}
	
	
}