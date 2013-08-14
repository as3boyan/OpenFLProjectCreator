package ;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import motion.Actuate;

class CustomTextField extends TextField
{

	public function new(?_size:Int = 36, _color:Int = 0xFFFFFF, _align:Dynamic = null) 
	{
		super();
		
		var text_format:TextFormat = new TextFormat("Arial", _size, _color);
		
		if (_align == null) 
		{
			text_format.align = TextFormatAlign.CENTER;
		}
		else
		{
			text_format.align = _align;
		}
		
		defaultTextFormat = text_format;
		width = 1280;
		height = 100;
		selectable = false;
		mouseEnabled = false;
		alpha = 0;
	}
	
	public function show(_text):Void
	{
		text = _text;
		
		Actuate.tween(this, 1, { alpha:1 } ).onComplete(function ():Void 
		{
			Actuate.tween(this, 3, { alpha:0 } );
		});
	}
	
	public function pulse(_text):Void
	{
		text = _text;
		
		fadeIn();
	}
	
	private function fadeIn()
	{
		Actuate.tween(this, 1, { alpha:1 } ).onComplete(fadeOut);
	}
	
	private function fadeOut()
	{
		Actuate.tween(this, 3, { alpha:0 } ).onComplete(fadeIn);
	}
	
	public function setAlpha(_alpha:Float):Void
	{
		Reflect.setProperty(this, "alpha", _alpha);
	}

	
}