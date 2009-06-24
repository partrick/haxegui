// Copyright (c) 2009 The haxegui developers
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

package haxegui;

import Type;

import flash.geom.Rectangle;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.LineScaleMode;

import flash.text.TextFormat;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.FocusEvent;

import haxegui.events.MoveEvent;
import haxegui.events.ResizeEvent;
import haxegui.events.DragEvent;

import flash.ui.Mouse;
import flash.ui.Keyboard;

import haxegui.Component;

import haxegui.managers.WindowManager;
import haxegui.managers.MouseManager;
import haxegui.managers.CursorManager;
import haxegui.managers.StyleManager;


class ToolBar extends Component
{

	public var handle : Sprite;

	public function new (? parent : DisplayObjectContainer, ? name : String,
			? x : Float, ? y : Float, ? width : Float, ? height : Float)
	{
		super (parent, name, x, y);
	}

	override public function init (? opts : Dynamic)
	{
		color = DefaultStyle.BACKGROUND;
		box = new Rectangle(0,0,502,40);

		super.init(opts);

		handle = new Sprite();
		handle.name = "handle";
		handle.graphics.lineStyle(1, color - 0x202020);
		handle.graphics.beginFill(color, .5);
		handle.graphics.drawRoundRect(4, 8, 8, box.height - 16, 4, 4);
		handle.graphics.endFill();
		addChild(handle);

		// inner-drop-shadow filter
		var shadow = new flash.filters.DropShadowFilter (4, 45, DefaultStyle.DROPSHADOW, 0.5,4, 4, 0.5, flash.filters.BitmapFilterQuality.LOW,true,false,false);
		this.filters = [shadow];


		parent.addEventListener (ResizeEvent.RESIZE, onParentResize);
	}


	public function onParentResize(e:ResizeEvent)
	{
		var b = untyped parent.box.clone();
		//~ box = untyped parent.box.clone();
		//~ if(!Math.isNaN(e.oldWidth))
		//~ box.width = e.oldWidth;


		box.width = b.width - x;
		//~ box.height -= y;

		//~ var _m = new Shape();
		//~ _m.graphics.beginFill(0xFF00FF);
		//~ _m.graphics.drawRect(0,0,box.width,box.height);
		//~ _m.graphics.endFill();
		//~ mask = _m;

		scrollRect = box.clone();

		redraw();

		e.updateAfterEvent();
	}

	static function __init__() {
		haxegui.Haxegui.register(ToolBar);
	}
}
