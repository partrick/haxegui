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

package haxegui;

import haxegui.controls.Component;
import haxegui.controls.Scrollbar;

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


class ScrollPane extends Component, implements Dynamic {

	public var color : UInt;
	
	public var content : Sprite;
	
	public var vert : Scrollbar;
	public var horz : Scrollbar;
	

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
	
		
	//~ public function init(?name, ?x:Float, ?y:Float) {
	public function init(?initObj:Dynamic) 
	{
		
		
		
		color = (cast parent).color;
		//~ box = untyped parent.box.clone();

		if(Reflect.isObject(initObj))
		{
			for(f in Reflect.fields(initObj))
				if(Reflect.hasField(this, f))
					if(f!="width" && f!="height")
						Reflect.setField(this, f, Reflect.field(initObj, f));
			
			box.width = ( Math.isNaN(initObj.width) ) ? box.width : initObj.width;
			box.height = ( Math.isNaN(initObj.height) ) ? box.height : initObj.height;
			//~ name = ( initObj.name == null) ? "container" : name;
			//~ move(initObj.x, initObj.y);
			//~ color = (initObj.color==null) ? color : initObj.color;
			//~ trace(Std.string(initObj));
		}	
		
		content = new Sprite();
		content.name = "content";
		//~ content.scrollRect = new Rectangle(0,0,box.width,box.height);
		content.scrollRect = new Rectangle(0,0, flash.Lib.current.stage.stageWidth, flash.Lib.current.stage.stageHeight);
		//~ content.scrollRect = new Rectangle();
		content.cacheAsBitmap = true;
		this.addChild(content);
		
		vert = cast this.addChild(new Scrollbar());
		vert.x = box.width - 20;
		vert.y = 0;
		vert.name = "vscrollbar";
		vert.color = color;
		vert.init(content);


		horz = cast this.addChild(new Scrollbar(true));
		horz.rotation = -90;
		//~ horz.y = box.height + 36 ;
		horz.name = "hscrollbar";
		horz.color = color;
		horz.init(content);

		//~ vert.scrollee = content;
		//~ horz.scrollee = content;
		
		cacheAsBitmap = true;
		content.cacheAsBitmap = true;

		parent.addEventListener(ResizeEvent.RESIZE, onResize);	
		parent.dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));
		
    	}

	/**
	 * 
	 * 
	 */
	public function onResize(e:ResizeEvent)
	{
		box = untyped parent.box.clone();

		box.width -= x;
		box.height -= y;

		if(horz.visible) box.height -= 20;
		if(vert.visible) box.width -= 20;

	
				//~ var transform = content.transform;
				//~ var bounds = transform.pixelBounds.clone();

				//~ horz.visible = bounds.width > box.width ;
				//~ vert.visible = bounds.height > box.height ;
	
	
			

				this.graphics.clear();
				if(horz.visible || vert.visible)
				{
					this.graphics.beginFill(color - 0x141414);
					this.graphics.drawRect(box.width, box.height,22 ,22);
					this.graphics.endFill();
				}
				

			
		//~ if(content.scrollRect==null || content.scrollRect.isEmpty())
			//~ content.scrollRect = new Rectangle();

		//~ content.scrollRect = new Rectangle(0,0,box.width,box.height);
		
		var r = box.clone();
		r.x = content.scrollRect.x;
		r.y = content.scrollRect.y;
		content.scrollRect = r.clone();
		
		//~ content.scrollRect = box.clone();
		//~ content.scrollRect.width  = box.width;
		//~ content.scrollRect.height  = box.height;
		//~ content.scrollRect = getRect(this);


		// add the drop-shadow filter
		var shadow:DropShadowFilter = new DropShadowFilter (4, 45, StyleManager.DROPSHADOW, 0.5, 4, 4,0.75,BitmapFilterQuality.HIGH,true,false,false);
		this.filters = [shadow];

		content.dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));
		dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));

		//~ e.updateAfterEvent();
		
	}//resize


}//scrollpane