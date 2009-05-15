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

import flash.geom.Rectangle;

import flash.display.DisplayObjectContainer;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;

import flash.text.TextField;
import flash.text.TextFormat;


import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.events.FocusEvent;
import haxegui.events.MenuEvent;

import flash.filters.DropShadowFilter;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;

import haxegui.controls.Component;
import haxegui.controls.AbstractButton;
import haxegui.CursorManager;
import haxegui.StyleManager;

import feffects.Tween;
import feffects.easing.Quint;
import feffects.easing.Sine;
import feffects.easing.Back;
import feffects.easing.Bounce;
import feffects.easing.Circ;
import feffects.easing.Cubic;
import feffects.easing.Elastic;
import feffects.easing.Expo;
import feffects.easing.Linear;
import feffects.easing.Quad;
import feffects.easing.Quart;



/**
*
* ListItem Class
*
* @version 0.1
* @author <gershon@goosemoose.com>
* @author Russell Weir'
*
*/
class PopupMenuItem extends AbstractButton, implements Dynamic
{

	public var tf : TextField;
	public var fmt : TextFormat;

	override public function init(opts:Dynamic=null)
	{

		super.init(opts);


		tf = new TextField();
		tf.name = "tf";
		//~ label.text = Opts.optString(opts, "label", name);
		tf.text = name;

		//~ label.move( Math.floor(.5*(this.box.width - label.width)), Math.floor(.5*(this.box.height - label.height)) );
		this.addChild(tf);

		// add the drop-shadow filter
		var shadow:DropShadowFilter = new DropShadowFilter (4, 45, DefaultStyle.DROPSHADOW, 0.5, 4, 4, 0.5, BitmapFilterQuality.HIGH, false, false, false );
		//~ var bevel:BevelFilter = new BevelFilter( 4, 45 ,color | 0x323232 ,1 ,0x000000, .25, 2, 2, 1, BitmapFilterQuality.LOW , flash.filters.BitmapFilterType.INNER, false );
		this.filters = [shadow];
		//~ this.filters = [shadow, bevel];

		// register with focus manager
		//~ FocusManager.getInstance().addEventListener (FocusEvent.MOUSE_FOCUS_CHANGE, onFocusChanged);

		action_redraw =
			"
			this.graphics.clear();
			var colors = [ color | 0x323232, color - 0x141414 ];
			var alphas = [ 100, 100 ];
			var ratios = [ 0, 0xFF ];
			var matrix = new flash.geom.Matrix();
			matrix.createGradientBox(this.box.width, this.box.height, Math.PI/2, 0, 0);
            this.graphics.lineStyle(2);
			this.graphics.lineGradientStyle (flash.display.GradientType.LINEAR, [ color, color - 0x202020 ], alphas, ratios, matrix);
			this.graphics.beginGradientFill( flash.display.GradientType.LINEAR, colors, alphas, ratios, matrix );
			this.graphics.drawRoundRect (0, 0, this.box.width, this.box.height, 8, 8 );
			this.graphics.endFill ();
			";

		redraw();

	}

	static function __init__() {
		haxegui.Haxegui.register(PopupMenuItem,initialize);
	}
	static function initialize() {
	}
}



/**
*
*
*
*
*/
class PopupMenu extends AbstractButton
{

	private var items : UInt;
	private var _item : UInt;

	private static var _instance:PopupMenu = null;


	private function new(parent:DisplayObjectContainer=null, name:String=null, ?x:Float, ?y:Float)
	{
		super(parent,name,x,y);
	}

	public static function getInstance ():PopupMenu
	{
		if (PopupMenu._instance == null)
		{
		PopupMenu._instance = new PopupMenu ();
		}
		return PopupMenu._instance;
	}





	override public function init(opts:Dynamic=null) : Void
	{
		close();

		if(Reflect.hasField(opts,"parent"))
			untyped opts.parent.addChild(this);

		if(Std.is(parent, Component))
			color = (cast parent).color;

		super.init(opts);

		var px = Opts.optFloat(opts,"x",0);
		var py = Opts.optFloat(opts,"y",0);
		this.mouseEnabled = false;
		this.tabEnabled = false;

		items = 1 + Math.round( Math.random()*19 );


		for (i in 0...items)
		{
		var item = new PopupMenuItem(this, "Item" + (i+1) );
		item.graphics.lineStyle(2, color - 0x323232);
		item.graphics.beginFill (color, .8);
		item.graphics.drawRect (0, 0, 100, 20);
		item.graphics.endFill ();

			var myPath = new Array<Dynamic>();

			myPath.push ({x:0, y: Math.exp(2)*2*i});
			//~ myPath.push ({x:0});
			//~ myPath.push ({x:2*i*Math.cos(i)});
			//~ myPath.push ({x:0});
			//~ item.alpha = 0;
			var p = new flash.geom.Point(px,py);
			p = localToGlobal( p );

			//~ item.alpha = 0;
			//~ item.x = 100 + (flash.Lib.current.stage.stageWidth - p.x);
			//~ item.y = -p.y  - 20*i ;
			item.y = 20*i ;


		item.buttonMode = true;

		item.addEventListener (MouseEvent.ROLL_OVER, onItemRollOver, false, 0, true);
		item.addEventListener (MouseEvent.ROLL_OUT, onItemRollOut, false, 0, true);
		item.addEventListener (MouseEvent.MOUSE_DOWN, onItemMouseDown, false, 0, true);

		var tf = new TextField ();
		tf.name = "tf";
		tf.text = item.name;
		tf.selectable = false;
		tf.width = 40;
		tf.height = 20;
		tf.embedFonts = true;
		tf.mouseEnabled = false;
		tf.setTextFormat (DefaultStyle.getTextFormat());
		item.addChild (tf);

		// add the drop-shadow filter
		var shadow:DropShadowFilter = new DropShadowFilter (4, 45, 0x000000, 0.8,4, 4,0.65,BitmapFilterQuality.HIGH,false,false,false);
		item.filters = [shadow];

		//~ var t = new Tween( 0, item.y, 150 + 150*i, item, "y", Back.easeInOut );
		var t2 = new Tween( 0, 1, 350, item, "alpha", Linear.easeNone );

		//~ item.y = 0 ;
		item.alpha = 0 ;

		//~ haxe.Timer.delay( function(){t2.start();}, 150*(items-i) );
		haxe.Timer.delay( function(){t2.start();}, Std.int(4*Math.exp(2)*i ) );
		//~ haxe.Timer.delay( function(){t.start();}, 150*(items-i) );
		//~ t.start();


		}

		// position
		this.x = px + 10;
		this.y = py + 20;


		// shutdown event
		this.addEventListener (MenuEvent.MENU_HIDE, close, false, 0, true);

		//
		dispatchEvent (new MenuEvent(MenuEvent.MENU_SHOW, false, false, parent, this ));

	}

	public function draw() : Void {
		if(numChildren>2)
		this.graphics.lineStyle (2, 0x1A1A1A, 0.9);
		//this.graphics.beginFill (0x595959, .8);
		//this.graphics.drawRect (0, 0, 100, 20 * (items - 1));
		this.graphics.drawRect (0, 0, 100, 20 * (numChildren - 1));
		//this.graphics.endFill ();

		// add the drop-shadow filter
		var shadow:DropShadowFilter = new DropShadowFilter (4, 45, 0x000000, 0.8,
								4, 4,
								0.65,
								BitmapFilterQuality.HIGH,
								false,
								false,
								false);
		var af:Array < Dynamic > = new Array ();
		af.push (shadow);
		this.filters = af;


		//~ }
	}//draw

	public function close (e:Event=null)
	{


		while(numChildren>0)
			this.removeChildAt(numChildren-1);

		items = _item = 0;
		this.graphics.clear();
		this.filters = null;


		if(this.hasEventListener(KeyboardEvent.KEY_DOWN))
			this.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

		// remove
		if (this.parent != null)
			if (this.parent.contains (this))
				this.parent.removeChild (this);


	}



	function onMouseOut (e:MouseEvent)
	{
	}


	function onItemRollOver (e:MouseEvent)
	{
		if(!this.contains(e.target)) return;
		_item = this.getChildIndex(e.target);
		onChanged();

		CursorManager.setCursor( Cursor.HAND );
	}


	public function onItemRollOut (e:MouseEvent)
	{


		var self = this;
		if(self==null || self.stage==null) return;
		self.stage.addEventListener(MouseEvent.MOUSE_DOWN,
		function(e)
		{
			//~ untyped self.stage.removeEventListenr(MouseEvent.MOUSE_DOWN);
			self.close();
		}, false, 0, true);


	}


	/**
	*
	*/
	public function onItemMouseDown(e:MouseEvent) {
		//~ dispatchEvent(new MenuEvent(MenuEvent.ITEM_CLICK, false, false, this, e.target.parent));
		dispatchEvent(new MenuEvent(MenuEvent.ITEM_CLICK, false, false));
			trace(Std.string(here)+Std.string(e));
	}


	override public function onKeyDown (e:KeyboardEvent) {
		/*
		var item = cast (this.getChildAt (_item), Sprite);
		item.graphics.clear ();
		item.graphics.beginFill (0x595959);
		item.graphics.drawRect (0, 0, 100, 20);
		item.graphics.endFill ();

		switch (e.keyCode)
		{
		case flash.ui.Keyboard.UP:
		if (_item > 0)
		_item--;
		case flash.ui.Keyboard.DOWN:
		if (_item < this.numChildren - 1)
		_item++;
		}
			*/
	}//end onKeyDown

	public function numItems() {
		return items;
	}

	public function nextItem() {
		_item++;
		if(_item>numChildren-1) _item=1;
		onChanged();
	}

	public function prevItem() {
		_item--;
		if(_item<=0) _item=numChildren-1;
		onChanged();
	}

	public function getItem() {
		trace(this.getChildAt(_item).name);
	}

	public function onChanged() {
		//trace(_item);
		//for(i in 0...items) {
		//~ for(i in 0...numChildren)
		//~ {
			//~ var item = cast(this.getChildAt(i), Sprite);
			//var color = (i==_item) ? color + 0x333333 : color;
			//~ var color = (i==_item) ? this.color | 0x202020 : this.color;
			//~ item.graphics.clear ();
			//~ item.graphics.lineStyle(2, color - 0x323232);
			//~ item.graphics.beginFill (color, .8);
			//~ item.graphics.drawRect (0, 0, 100, 20);
			//~ //item.graphics.endFill ();
//~
			//~ var tf : TextField = cast item.getChildByName("tf");
			//~ var fmt = new TextFormat ();
			//~ fmt.color = DefaultStyle.LABEL_TEXT ;
			//~ tf.setTextFormat (fmt);
//~
		//~ }
		var item = cast(this.getChildAt(_item), Sprite);

	}

	static function __init__() {
		haxegui.Haxegui.register(PopupMenu,initialize);
	}
	static function initialize() {
	}
}
