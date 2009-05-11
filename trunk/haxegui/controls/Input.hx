// 
// The MIT License
// 
// Copyright (c) 2004 - 2006 Paul D Turner & The CEGUI Development Team
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

package haxegui.controls;

import flash.geom.Rectangle;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.events.Event;
import flash.events.TextEvent;

import haxegui.controls.Component;

import haxegui.StyleManager;


import flash.filters.DropShadowFilter;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;

class Input extends Component
{

    public var tf : TextField;
    
    
	public function new(?parent : DisplayObjectContainer, ?name:String, ?x:Float, ?y:Float)
	{
	    super(parent, name, x, y);
	}

	/**
	 * 
	 * 
	 * 
	 */
	public function init(?initObj:Dynamic) : Void
	{
	    box = new Rectangle(0, 0, 140, 20);
		if(Reflect.isObject(initObj))
		{
			//~ trace(Std.string(initObj));
		for (f in Reflect.fields (initObj))
		  if (Reflect.hasField (this, f))
		    if (f != "width" && f != "height")
		      Reflect.setField (this, f, Reflect.field (initObj, f));

		    box.width = ( Math.isNaN(initObj.width) ) ? box.width : initObj.width;
		    box.height = ( Math.isNaN(initObj.height) ) ? box.height : initObj.height;

		}

	    //~ buttonMode = false;
	    mouseEnabled = true;
	    tabEnabled = true;

	    graphics.lineStyle (2, StyleManager.BACKGROUND - 0x202020);
	    graphics.beginFill (StyleManager.INPUT_BACK);
	    graphics.drawRoundRect(0, 0, box.width, box.height, 8, 8 );
	    graphics.endFill ();

	    var shadow:DropShadowFilter = new DropShadowFilter (4, 45, StyleManager.DROPSHADOW, 0.8, 4, 4, 0.65, BitmapFilterQuality.HIGH, true, false, false );
	    filters = [shadow];

	    tf = new TextField();
	    tf.name = "tf";
	    tf.type = flash.text.TextFieldType.INPUT;
	    tf.text = name;
	    tf.background = false;
	    tf.border = false;
	    tf.height = box.height - 3;
	    tf.x = tf.y = 4;
	    tf.embedFonts = true;
	    
	    tf.setTextFormat(StyleManager.getTextFormat());
	    addChild(tf);
	    
	}



}
