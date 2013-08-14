/*
 * Endurance Logger, program that is intended to help you to track your fitness progress
 * Copyright (C) 2013 AS3Boyan
 * 
 * This file is part of Endurance Logger.
 * Endurance Logger is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Endurance Logger is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Endurance Logger.  If not, see <http://www.gnu.org/licenses/>.
*/

package;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import haxe.Timer;
import motion.Actuate;

class NotificationPanel extends Sprite
{

	var tf:TextField;
	var timer:Timer;
	var text_queue:Array<String>;
	var time_queue:Array<Int>;
	var active:Bool;
	var text_format:TextFormat;
	
	public function new() 
	{		
		super();
		
		text_format = new TextFormat();
		text_format.align = TextFormatAlign.CENTER;
		text_format.font = "Arial";
		text_format.size = 36;
		text_format.color = 0x000000;
		
		tf = new TextField();
		tf.defaultTextFormat = text_format;
		Reflect.setProperty(tf, "alpha", 0.3);
		
		//Previous workout sessions are shown as half transparent graph
		
		tf.mouseEnabled = false;
		tf.wordWrap = true;
		tf.multiline = true;
		tf.selectable = false;
		
		addChild(tf);
		
		text_queue = new Array();
		time_queue = new Array();
		
		active = false;
		
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
		addEventListener(MouseEvent.CLICK, onClick);
	}
	
	private function onClick(e:MouseEvent):Void 
	{
		hide();
	}
	
	public function show(_text:String, _time:Int = 3000):Void
	{
		text_queue.push(_text);
		time_queue.push(_time);
		
		checkQueue();
	}
	
	public function hide():Void
	{
		mouseEnabled = false;
		Actuate.tween(this, 1, { y: -height } ).onComplete(checkQueue);
		timer.stop();
	}
	
	function checkQueue() 
	{
		active = false;
		
		if (text_queue.length > 0)
		{
			var text_queue_element:String = text_queue.splice(0, 1)[0];
			
			if (text_queue_element.length > 250)
			{
				text_format.size = 12;
			}
			else if (text_queue_element.length > 150)
			{
				text_format.size = 22;
			}
			else if (text_queue_element.length > 100)
			{
				text_format.size = 24;
			}
			else
			{
				text_format.size = 36;
			}
			
			tf.defaultTextFormat = text_format;
			
			showText(text_queue_element);
		}
	}
	
	function showText(_text:String):Void
	{
		tf.text = _text;
		tf.y = (720 / 4 - tf.textHeight) / 2;
		
		Actuate.stop(this);
		Actuate.tween(this, 1, { y: 0 } );
	
		if (timer != null) timer.stop();
		
		timer = new Timer(time_queue.splice(0, 1)[0]);
		timer.run = hide;
		
		mouseEnabled = true;
		active = true;
		parent.setChildIndex(this, parent.numChildren - 1);
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		
		graphics.beginFill(0xFFFFFF, 0.3);
		graphics.drawRect(0, 0, 1280, 720 / 4);
		graphics.endFill();
		
		tf.width = 1280;
		tf.height = 720 / 4;
		
		y = -height;
	}
	
}