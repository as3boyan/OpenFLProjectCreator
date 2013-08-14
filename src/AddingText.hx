package;


import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

@:font("assets/KatamotzIkasi.ttf") class DefaultFont extends Font {}


class AddingText extends Sample {
	
	
	public function new () {
		
		super ();
		
		Font.registerFont (DefaultFont);
		
		var format = new TextFormat ("Katamotz Ikasi", 30, 0x7A0026);
		format.align = TextFormatAlign.CENTER;
		var textField = new TextField ();
		
		textField.defaultTextFormat = format;
		textField.embedFonts = true;
		textField.selectable = false;
		
		textField.y = 350;
		textField.width = 1280;
		
		textField.text = "Hello World";
		
		addChild (textField);
		
	}
	
	override  function show():Void 
	{
		super.show();
	}
}