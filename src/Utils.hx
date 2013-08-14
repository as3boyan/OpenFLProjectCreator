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

package ;
import haxe.macro.Context;

class Utils
{

	public function new() 
	{
		
	}
	
	static public function randColor():Int
	{
		return Std.int(Math.random() * 0xFFFFFF);
	}
	
	static public function randInt(min:Int , max:Int):Int
	{
		return Std.int(Math.random() * (max - min + 1) + min);
	}
	
	static public function extractRed(c:UInt):UInt
	{
		return ((c >> 16 ) & 0xFF);
	}
	
	static public function extractGreen(c:UInt):UInt
	{
		return ((c >> 8 ) & 0xFF);
	}
	
	static public function extractBlue(c:UInt):UInt
	{
		return (c & 0xFF);
	}
	
	static public function combineRGB(r:UInt, g:UInt, b:UInt):UInt
	{
		return ((r << 16) | (g << 8) | b);
	}
	
	static public function adjustBrightness(_color:Int, n:Int):UInt
	{
		var r:Int = extractRed(_color);
		var g:Int = extractGreen(_color);
		var b:Int = extractBlue(_color);
		
		r = Std.int(Math.min(r+n, 255));
		g = Std.int(Math.min(g+n, 255));
		b = Std.int(Math.min(b+n, 255));
		
		return combineRGB(r,g,b);
	}
	
	static public function getDistance(x1:Float, y1:Float, x2:Float, y2:Float):Float
	{
		var dx = x2-x1;
		var dy = y2-y1;
		return Math.sqrt(dx*dx + dy*dy);
	}
	
	#if (neko || cpp)
	static public function getExecutablePath():String
	{
		var executable_path:String = Sys.executablePath();
		executable_path = executable_path.substring(0, executable_path.lastIndexOf("\\")) + "\\";
		return executable_path;
	}
	#end
	
	macro static public function getBuildDate()
	{
		return Context.makeExpr(DateTools.delta(Date.now(), DateTools.hours(1)).toString(), Context.currentPos());
	}
	
}