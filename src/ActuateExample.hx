package;


import flash.display.Sprite;
import flash.events.Event;
import motion.Actuate;
import motion.easing.Quad;


class ActuateExample extends Sample {
	
	
	public function new () {
		
		super ();
				
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}
	
	private function onAdded(e:Event):Void 
	{	
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		initialize ();
		
		//var background:Sprite = new Sprite();
		//background.graphics.beginFill(0xFFFFFF);
		//background.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
		//background.graphics.endFill();
		//addChild(background);
		
		construct ();
	}
	
	override  function show():Void 
	{
		super.show();
	}
	
	private function animateCircle (circle:Sprite):Void {
		
		var duration = 1.5 + Math.random () * 4.5;
		var targetX = Math.random () * 1280;
		var targetY = Math.random () * 720;
		
		Actuate.tween (circle, duration, { x: targetX, y: targetY }, false).ease (Quad.easeOut).onComplete (animateCircle, [ circle ]);
		
	}
	
	
	private function construct ():Void {
		
		for (i in 0...80) {
			
			var creationDelay = Math.random () * 10;
			Actuate.timer (creationDelay).onComplete (createCircle);
			
		}
		
	}
	
	
	private function createCircle ():Void {
		
		var size = 5 + Math.random () * 35 + 20;
		var circle = new Sprite ();
		
		circle.graphics.beginFill (Std.int (Math.random () * 0xFFFFFF));
		circle.graphics.drawCircle (0, 0, size);
		circle.alpha = 0.2 + Math.random () * 0.6;
		circle.x = Math.random () * 1280;
		circle.y = Math.random () * 720;
		
		addChildAt (circle, 0);
		animateCircle (circle);
		
	}
	
	
	private function initialize ():Void {
		
		stage.addEventListener (Event.ACTIVATE, stage_onActivate);
		stage.addEventListener (Event.DEACTIVATE, stage_onDeactivate);
		
	}
	
	
	
	
	// Event Handlers
	
	
	
	
	private function stage_onActivate (event:Event):Void {
		
		Actuate.resumeAll ();
		
	}
	
	
	private function stage_onDeactivate (event:Event):Void {
		
		Actuate.pauseAll ();
		
	}
	
	
}