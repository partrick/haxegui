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

import haxegui.Component;
import haxegui.controls.ScrollBar;

import flash.geom.Rectangle;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.Sprite;
import haxegui.events.ResizeEvent;

import flash.filters.DropShadowFilter;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.BevelFilter;

import haxegui.managers.StyleManager;

class ScrollPane extends Component
{
	public var content : Sprite;

	public var vert : ScrollBar;
	public var horz : ScrollBar;


	public function new (?parent:DisplayObjectContainer, ?name:String, ?x:Float, ?y:Float)
	{
		super(parent, name, x, y);
		//~ this.name = (name==null) ? "scroll_pane" : name;
	}


	public override function addChild(o : DisplayObject) : DisplayObject
	{
		if(content!=null && vert!=null && horz!=null)
			return content.addChild(o);
		return super.addChild(o);
	}


	override public function init(?opts:Dynamic)
	{
		if(Std.is(parent, Component))
			color = (cast parent).color;
		//~ box = untyped parent.box.clone();
		box = new Rectangle(0, 0, 140, 100);
		//~ fitH = fitV = true;

		super.init(opts);

		fitH = Opts.optBool(opts,"fitH", true);
		fitV = Opts.optBool(opts,"fitV", true);


		content = new Sprite();
		content.name = "content";
		//~ content.scrollRect = new Rectangle(0,0,box.width,box.height);
		content.scrollRect = new Rectangle(0,0, flash.Lib.current.stage.stageWidth, flash.Lib.current.stage.stageHeight);
		//~ content.scrollRect = new Rectangle();
		content.cacheAsBitmap = true;
		this.addChild(content);

		if(Opts.optBool(opts,"vert", true)) {
		vert = new ScrollBar(this, "vscrollbar", this.box.width - 20, 0, false);
		vert.init({target: content, color: this.color});
		}

		if(Opts.optBool(opts,"horz", true)) {
		horz = new ScrollBar(this, "hscrollbar", null, null, true);
		horz.init({target: content, color: this.color});
		}

		cacheAsBitmap = true;
		content.cacheAsBitmap = true;

		parent.addEventListener(ResizeEvent.RESIZE, onParentResize);
		parent.dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));

	}

	/**
	*
	*
	*/
	public function onParentResize(e:ResizeEvent)
	{
		//~ box = untyped parent.box.clone();
		if(fitH) box.width = (cast parent).box.width - x - ((vert!=null && vert.visible) ? 20 : 0); 
		if(fitV) box.height = (cast parent).box.height - y - ((horz!=null && horz.visible) ? 20 : 0);

		//~ box.width -= x;
		//~ box.height -= y;

		//~ if(horz.visible) box.height -= 20;
		//~ if(vert.visible) box.width -= 20;



				//~ if( (horz!=null && horz.visible) || (vert!=null && vert.visible))
				//~ {
					//~ this.graphics.clear();
					//~ this.graphics.beginFill(color - 0x141414);
					//~ this.graphics.drawRect(box.width, box.height, 22, 22);
					//~ this.graphics.endFill();
				//~ }

		var r = box.clone();
		r.x = content.scrollRect.x;
		r.y = content.scrollRect.y;
		content.scrollRect = r.clone();

		// add the drop-shadow filter
		var shadow:DropShadowFilter = new DropShadowFilter (4, 45, DefaultStyle.DROPSHADOW, 0.5, 8, 8,0.5,BitmapFilterQuality.HIGH,true,false,false);
		this.filters = [shadow];

		content.dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));
		dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));

		//~ e.updateAfterEvent();

	}//resize


	
	
	static function __init__() {
		haxegui.Haxegui.register(ScrollPane,initialize);
	}
	static function initialize() {
	}
}
