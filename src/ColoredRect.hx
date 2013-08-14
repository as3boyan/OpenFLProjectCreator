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

import flash.display.Sprite;

class ColoredRect extends Sprite
{

	public function new(_width:Int, _height:Int, ?_color:Int=-1) 
	{
		super();
		
		if (_color == -1) _color = Utils.adjustBrightness(Utils.randColor(),100);
		graphics.beginFill(_color);
		graphics.drawRect(0, 0, _width, _height);
		graphics.endFill();
		//trace(_color);
	}
	
}