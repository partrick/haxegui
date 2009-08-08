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

package haxegui.controls;


//{{{ Imports
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.ui.Keyboard;
import haxegui.DataSource;
import haxegui.controls.AbstractButton;
import haxegui.controls.Component;
import haxegui.controls.Image;
import haxegui.controls.Label;
import haxegui.events.MenuEvent;
import haxegui.events.ResizeEvent;
import haxegui.managers.FocusManager;
import haxegui.managers.StyleManager;
import haxegui.utils.Color;
import haxegui.utils.Opts;
import haxegui.utils.Size;
//}}}


using haxegui.controls.Component;
using haxegui.utils.Color;


//{{{ MenuBarItem
/**
* MenuBarItem Class
*
* @author Omer Goshen <gershon@goosemoose.com>
* @author Russell Weir <damonsbane@gmail.com>
* @version 0.2
*/
class MenuBarItem extends AbstractButton, implements IAggregate {

	public var label : Label;
	public var icon  : Icon;
	public var menu  : PopupMenu;


	//{{{ init
	override public function init(opts:Dynamic=null) {
		if(!Std.is(parent, MenuBar)) throw parent+" not a MenuBar";
		box = new Size(40,24).toRect();
		menu = new PopupMenu();


		super.init(opts);


		label = new Label(this);
		label.init({text: name});
		label.move(4,4);
		label.mouseEnabled = false;

	}
	//}}}


	//{{{ onMouseClick
	public override function onMouseClick(e:MouseEvent) {
		// var a = new haxegui.Alert();
		// a.init({label: this+"."+here.methodName+":\n\n\n"+"Not implemented yet..."});

		var p = parent.localToGlobal(new flash.geom.Point(x, y));
		trace(p);

		if(menu!=null)
		menu.destroy();
		menu = new PopupMenu(flash.Lib.current);
		// menu = new PopupMenu(getParentWindow());

		menu.dataSource = new DataSource();
		menu.dataSource.data = ["MenuItem", "MenuItem", "MenuItem", "MenuItem", "MenuItem"];
		menu.init ({color: this.color});

		// menu.init ({x: p.x, y: p.y, color: this.color});
		menu.toFront();

		menu.x = p.x;
		menu.y = p.y + 20;

		super.onMouseClick(e);
	}
	//}}}


	//{{{ __init__
	static function __init__() {
		haxegui.Haxegui.register(MenuBarItem);
	}
	//}}}
}
//}}}


//{{{ MenuBar
/**
* MenuBar Class
*
* @version 0.1
* @author Omer Goshen <gershon@goosemoose.com>
* @author Russell Weir <damonsbane@gmail.com>
*/
class MenuBar extends Component, implements IRubberBand {
	//{{{ Members
	public var items : Array<MenuBarItem>;

	public var numMenus : Int;

	private var _menu:Int;
	//}}} Members


	//{{{ init
	override public function init(opts : Dynamic=null) {
		// assuming parent is a window
		box = new Size(parent.asComponent().box.width - 10, 24).toRect();

		color = (cast parent).color;
		items = [];


		super.init(opts);


		redraw({box: this.box});

		buttonMode = false;
		tabEnabled = false;
		focusRect = false;
		mouseEnabled = false;


		_menu = 0;
		numMenus = 1+Math.round( Math.random() * 4 );

		for (i in 0...numMenus) {
			var menu = new MenuBarItem(this, "Menu"+(i+1), 40*i, 0);
			menu.init({color: this.color});
		}

		// inner-drop-shadow filter
		var shadow:DropShadowFilter = new DropShadowFilter (4, 45, DefaultStyle.DROPSHADOW, 0.5,4, 4,0.75,BitmapFilterQuality.LOW,true,false,false);
		this.filters = [shadow];

		parent.addEventListener(ResizeEvent.RESIZE, onParentResize);

	}
	//}}}


	//{{{ addChild
	override function addChild(child : flash.display.DisplayObject) : flash.display.DisplayObject {
		if(Std.is(child, MenuBarItem))
		items.push(cast child);
		return super.addChild(child);
	}
	//}}}


	//{{{ onParentResize
	public function onParentResize(e:ResizeEvent) {
		box.width = untyped parent.box.width - 10;

		var b = box.clone();
		b.height = box.height;
		b.x = b.y =0;
		this.scrollRect = b;

		dirty = true;

		//e.updateAfterEvent();
	}
	//}}}


	//{{{ onKeyDown
	override public function onKeyDown (e:KeyboardEvent) {}

	//}}}


	//{{{ openMenuByName

	/**
	*
	*/
	function openMenuByName (name:String) {
		openMenuAt (this.getChildIndex (this.getChildByName (name)));
	}

	//}}}


	//{{{ openMenuAt
	/**
	*
	*/
	function openMenuAt (i:UInt) {
		var menu = this.getChildAt (i);
		//~ var popup = PopupMenu.getInstance();
		//~ popup.init ({parent:this.parent, x:menu.x, y:menu.y + 20});
		//register new popups for close
	}
	//}}}


	//{{{ __init__
	static function __init__() {
		haxegui.Haxegui.register(MenuBar);
	}
	//}}}
}
//}}}