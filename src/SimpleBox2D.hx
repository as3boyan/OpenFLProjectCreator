package;


import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;


class SimpleBox2D extends Sample {
	
	
	private static var PHYSICS_SCALE:Float = 1 / 30;
	
	private var PhysicsDebug:Sprite;
	private var World:B2World;
	var box1:B2Body;
	var circle1:B2Body;
	var box2:B2Body;
	var circle2:B2Body;
	
	
	public function new () {
		
		super ();
		
		World = new B2World (new B2Vec2 (0, 10.0), true);
		
		PhysicsDebug = new Sprite ();
		addChild (PhysicsDebug);
		
		var debugDraw = new B2DebugDraw ();
		debugDraw.setSprite (PhysicsDebug);
		debugDraw.setDrawScale (1 / PHYSICS_SCALE);
		debugDraw.setFlags (B2DebugDraw.e_shapeBit);
		
		World.setDebugDraw (debugDraw);
		
		box1 = createBox (250, 500, 1280, 100, false);
		box2 = createBox (250, 100, 100, 100, true);
		circle1 = createCircle (100, 100, 50, false);
		circle2 = createCircle (400, 100, 50, true);
		
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
		
	}
	
	override  function show():Void 
	{
		super.show();
		
		if (box2.getPosition().y > 10)
		{
			box2.applyForce(new B2Vec2(0, -350), new B2Vec2(0, 0));
			circle2.applyForce(new B2Vec2(0, -350), new B2Vec2(0, 0));
		}
	}
	
	private function createBox (x:Float, y:Float, width:Float, height:Float, dynamicBody:Bool):B2Body {
		
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * PHYSICS_SCALE, y * PHYSICS_SCALE);
		
		if (dynamicBody) {
			
			bodyDefinition.type = B2Body.b2_dynamicBody;
		}
		
		var polygon = new B2PolygonShape ();
		polygon.setAsBox ((width / 2) * PHYSICS_SCALE, (height / 2) * PHYSICS_SCALE);
		
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = polygon;
		
		var body = World.createBody (bodyDefinition);
		body.createFixture(fixtureDefinition);
		
		return body;
	}
	
	
	private function createCircle (x:Float, y:Float, radius:Float, dynamicBody:Bool):B2Body {
		
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * PHYSICS_SCALE, y * PHYSICS_SCALE);
		
		if (dynamicBody) {
			
			bodyDefinition.type = B2Body.b2_dynamicBody;
			
		}
		
		var circle = new B2CircleShape (radius * PHYSICS_SCALE);
		
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = circle;
		
		var body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		
		return body;
	}
	
	
	
	
	// Event Handlers
	
	
	
	
	private function this_onEnterFrame (event:Event):Void {
		
		World.step (1 / 30, 10, 10);
		World.clearForces ();
		World.drawDebugData ();
		
	}
	
	
}