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

package haxegui.containers;

//{{{ Imports
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import haxegui.containers.IContainer;
import haxegui.controls.Component;
import haxegui.controls.ScrollBar;
import haxegui.events.ResizeEvent;
import haxegui.managers.MouseManager;
import haxegui.managers.ScriptManager;
import haxegui.managers.StyleManager;
import haxegui.utils.Size;
//}}}


/**
* Generic "Canvas" or "Panel" to put components in.<br/>
* <p>It listens for and streches when receives resize events from it's parent.</p>
*/
class Container extends Component, implements IContainer
{

	//{{{ Constructor
	public function new (?parent : flash.display.DisplayObjectContainer, ?name:String, ?x : Float, ?y: Float) {
		super (parent, name, x, y);
		buttonMode = false;
		color = DefaultStyle.BACKGROUND;
		mouseEnabled = false;
		tabEnabled = false;
	}
	//}}}


	//{{{ Functions
	//{{{ addChild
	/** @todo probably recalcuate and fire a resize event **/
	public override function addChild(o : DisplayObject) : DisplayObject {
		dirty = true;
		return super.addChild(o);
	}
	//}}}


	//{{{ init
	override public function init(opts : Dynamic=null) {
		super.init(opts);


		description = null;


		if(Std.is(parent, haxegui.Window))
		if(x==0 && y==0)
		move(10,20);


		parent.addEventListener(ResizeEvent.RESIZE, onParentResize);
		parent.dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));
	}
	//}}}


	//{{{ onParentResize
	private function onParentResize(e:ResizeEvent) {
		var size = new Size();

		if(Std.is(parent, Component))
		size = new Size((cast parent).box.width - x, (cast parent).box.height - y);
		else
		size = new Size(parent.width, parent.height);

		box = size.toRect();

		redraw();
		dirty = false;

		dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));
	}
	//}}}


	//{{{ __init__
	static function __init__() {
		haxegui.Haxegui.register(Container);
	}
	//}}}
	//}}}
}
