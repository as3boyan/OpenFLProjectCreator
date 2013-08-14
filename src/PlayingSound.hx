package;


import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.media.SoundChannel;
import motion.Actuate;
import openfl.Assets;


class PlayingSound extends Sample {
	
	
	private var Fill:Sprite;
	
	private var channel:SoundChannel;
	private var position:Float;
	
	
	public function new () {
		
		super ();
		
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
		
	}
	
	override  function show():Void 
	{
		super.show();
		
		if (channel == null) {
			
			play ();
			
		}
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		
		Fill = new Sprite ();
		Fill.graphics.beginFill (0x3CB878);
		Fill.graphics.drawRect (0, 0, stage.stageWidth, stage.stageHeight);
		Fill.alpha = 0.1;
		Fill.buttonMode = true;
		Fill.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
		addChild (Fill);
	}
	
	
	private function pause ():Void {
		
		if (channel != null) {
			
			position = channel.position;
			channel.removeEventListener (Event.SOUND_COMPLETE, channel_onSoundComplete);
			channel.stop ();
			channel = null;
			
		}
		
		Actuate.tween (Fill, 3, { alpha: 0.1 } );
		
	}
	
	
	private function play ():Void {
		
		var sound = Assets.getSound ("assets/stars.mp3");
		
		channel = sound.play (position);
		channel.addEventListener (Event.SOUND_COMPLETE, channel_onSoundComplete);
		
		Actuate.tween (Fill, 3, { alpha: 1 } );
		
	}
	
	
	
	
	// Event Handlers
	
	
	
	
	private function channel_onSoundComplete (event:Event):Void {
		
		pause ();
		
		position = 0;
		
	}
	
	
	private function this_onMouseDown (event:MouseEvent):Void {
		
		if (channel == null) {
			
			play ();
			
		} else {
			
			pause ();
			
		}
		
	}
	
	
}