package;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import openfl.Assets;


class DisplayingABitmap extends Sample {
	
	
	public function new () {
		
		super ();
		
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		
		var bitmap = new Bitmap (Assets.getBitmapData ("assets/openfl.png"));
		addChild (bitmap);
		
		bitmap.x = (1280 - bitmap.width) / 2;
		bitmap.y = (720 - bitmap.height) / 2;
	}
	
	override  function show():Void 
	{
		super.show();
	}
}