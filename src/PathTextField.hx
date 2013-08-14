package ;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.TextEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldType;

#if desktop
import sys.FileSystem;
#end

class PathTextField extends TextField
{
	var text_format:TextFormat;

	public var valid:Bool;
	
	public function new() 
	{
		super();
		
		text_format = new TextFormat("Arial", 24);
		
		defaultTextFormat = text_format;
		type = TextFieldType.INPUT;
		background = true;
		backgroundColor = 0xFFFFFF;
		border = true;
		borderColor = 0xCCCCCC;
		width = 350;
		height = 30;
		x = (1280 - width) / 2 - 75;
		
		valid = false;
		
		addEventListener(Event.CHANGE, onChange);
		addEventListener(TextEvent.TEXT_INPUT, onTextInput);
	}
	
	private function onTextInput(e:TextEvent):Void 
	{
		onChange(null);
		
	}
	
	public function onChange(e:Event):Void 
	{
		#if desktop
		if (FileSystem.exists(text))
		{
			text_format.color = 0x2C6D1B;
			defaultTextFormat = text_format;
			text = text;
			valid = true;
		}
		else
		{
			text_format.color = 0xA52727;
			defaultTextFormat = text_format;
			text = text;
			valid = false;
		}
		#end
	}
	
}