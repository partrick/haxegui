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

import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.geom.Rectangle;

import flash.events.Event;
import flash.events.MouseEvent;

import haxegui.events.ResizeEvent;


import flash.filters.DropShadowFilter;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;

import haxegui.StyleManager;
import haxegui.controls.Component;
import haxegui.controls.Scrollbar;


class Container extends Component, implements IContainer, implements Dynamic
//~ , implements IChildList
{
	private var _clip : Bool;

	public function new (?parent : flash.display.DisplayObjectContainer, ?name:String, ?x : Float, ?y: Float)
	{
		super (parent, name, x, y);
	}

	public override function addChild(o : DisplayObject) : DisplayObject
	{
		//~ box = transform.pixelBounds.clone();
		//~ onResize(new ResizeEvent(ResizeEvent.RESIZE));
		//~ box = box.union(o.getBounds(this));
		this.dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));
		return super.addChild(o);
	}


	override public function init(opts : Dynamic=null)
	{
		color = DefaultStyle.BACKGROUND;

		super.init(opts);

		this.buttonMode = false;
		this.mouseEnabled = false;
		this.tabEnabled = false;


		// add the drop-shadow filter
		var shadow:DropShadowFilter = new DropShadowFilter (4, 45, DefaultStyle.DROPSHADOW, 0.5, 4, 4,0.75,BitmapFilterQuality.HIGH,true,false,false);
		this.filters = [shadow];

		//~ this.cacheAsBitmap = true;

		//~ if(this.parent!=null)
		parent.addEventListener(ResizeEvent.RESIZE, onParentResize);
		parent.dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));


	}


	public function onParentResize(e:ResizeEvent) {


		if(Std.is(parent, Component))
		{
			box = untyped parent.box.clone();
			box.width -= x;
			box.height -= y;
		}

		if(Std.is(parent.parent, ScrollPane)) {
			box = untyped parent.parent.box.clone();
		}



		redraw(null);
		//~ dirty = true;

		//
		dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));

		if(e != null)
			e.updateAfterEvent();
	}

	override public function redraw (opts:Dynamic = null):Void
	{
		StyleManager.exec(this,"redraw",
			{
				color: Opts.optInt(opts, "color", color),
			});
	}


	static function __init__() {
		haxegui.Haxegui.register(Container,initialize);
	}
	static function initialize() {
		StyleManager.initialize();
		StyleManager.setDefaultScript(
			Container,
			"redraw",
			"
				this.graphics.clear();
				this.graphics.beginFill (color);
				this.graphics.drawRect (0, 0, this.box.width, this.box.height );
				this.graphics.endFill ();
			"
		);
	}

}
