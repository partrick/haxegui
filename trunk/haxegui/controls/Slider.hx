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
import flash.display.DisplayObjectContainer;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.FocusEvent;

import haxegui.events.MoveEvent;
import haxegui.events.ResizeEvent;
import haxegui.events.DragEvent;



import flash.filters.DropShadowFilter;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.BevelFilter;


import haxegui.CursorManager;
import haxegui.StyleManager;
import haxegui.FocusManager;

class Slider extends Component, implements Dynamic
{
	
  public var handle : Component;
  public var color : UInt;
  //~ public var value : Float;
  public var max : Float;
  

  public function new (?parent:DisplayObjectContainer, ?name:String, ?x:Float, ?y:Float)
	{
		super(parent, name, x, y);
		max = 100;
	}


  /**
   * 
   * 
   * 
   * 
   */
  public function init(?initObj:Dynamic)
	{
		//super.init(initObj);

		box = new Rectangle(0,0,140,20);
		color = StyleManager.BACKGROUND;
		
		if(Reflect.isObject(initObj))
		{
			for(f in Reflect.fields(initObj))
				if(Reflect.hasField(this, f))
				    if (f != "width" && f != "height")
					Reflect.setField(this, f, Reflect.field(initObj, f));
			//~ name = (initObj.name == null) ? name : initObj.name;
			//~ move(initObj.x, initObj.y);
			box.width = ( Math.isNaN(initObj.width) ) ? box.width : initObj.width;
			box.height = ( Math.isNaN(initObj.height) ) ? box.height : initObj.height;
			disabled = (initObj.disabled==null) ? disabled : initObj.disabled;
		}

		
		this.graphics.clear();
		this.graphics.lineStyle(4, color - 0x323232);
		this.graphics.moveTo(0, box.height/2);
		this.graphics.lineTo(box.width, box.height/2);

		this.graphics.lineStyle(1, color - 0x323232);
		var s = box.width/20;
		for(i in 1...20)
		{
		this.graphics.moveTo(i*s, 4);
		this.graphics.lineTo(i*s, box.height-4);
		}
		
		this.graphics.lineStyle(0,0,0);
		this.graphics.beginFill(0,0);
		this.graphics.drawRect(0,0,box.width,box.height);
		this.graphics.endFill();
		
	
		handle = new Component(this, "handle");
		//~ handle.move(0,4);
		handle.graphics.lineStyle(2, color - 0x141414);
		
       		  var colors = [ color | 0x323232, color - 0x141414 ];
		  var alphas = [ 100, 100 ];
		  var ratios = [ 0, 0xFF ];
		  //~ var matrix = { a:200, b:0, c:0, d:0, e:200, f:0, g:200, h:200, i:1 };
		  var matrix = new flash.geom.Matrix();
		  matrix.createGradientBox(15, 20, Math.PI/2, 0, 0);
		  handle.graphics.beginGradientFill( flash.display.GradientType.LINEAR, colors, alphas, ratios, matrix );


		//~ handle.graphics.beginFill(color);
		handle.graphics.drawRoundRect(0,0,8,20,4,4);
		//~ handle.move(0,-15);
		
		// add the drop-shadow filters
		var shadow:DropShadowFilter = new DropShadowFilter (4, 45, StyleManager.DROPSHADOW, 0.8, 4, 4, 0.65, BitmapFilterQuality.HIGH, false, false, false );
		//~ var bevel:BevelFilter = new BevelFilter( 4, 45 ,color | 0x323232 ,1 ,0x000000, .25, 2, 2, 1, BitmapFilterQuality.LOW , flash.filters.BitmapFilterType.INNER, false );

		//~ handle.filters = [shadow, bevel];
		handle.filters = [shadow];


		
		addEventListener (MouseEvent.MOUSE_WHEEL, onMouseWheel);
		
		handle.addEventListener (MouseEvent.MOUSE_DOWN, onMouseDown);
		handle.addEventListener (MouseEvent.MOUSE_UP,   onMouseUp);
		handle.addEventListener (MouseEvent.ROLL_OVER, onRollOver);
		handle.addEventListener (MouseEvent.ROLL_OUT,  onRollOut);
		
		handle.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);	
	
		
		this.addEventListener (Event.CHANGE, onChanged);
	
	}
	
	
	public function onChanged(?e:Event)
	{
	    //~ trace(e);
	    if(handle.x < 0) handle.x = 0;
	    if(handle.x > (box.width - handle.width) ) handle.x = box.width - handle.width;

	}
	

	public function onMouseWheel(e:MouseEvent)
	{
	    //trace(e);
	    handle.x += e.delta * 5;
	    dispatchEvent(new Event(Event.CHANGE));
	}
	

	/**
	*
	*
	*/
	public function onRollOver(e:MouseEvent) : Void
	{
		if(disabled) return;
		//~ redraw(StyleManager.BACKGROUND + 0x323232 );
//		redraw(StyleManager.BACKGROUND | 0x141414 );
		//~ var color = checked ? StyleManager.BACKGROUND - 0x202020 : StyleManager.BACKGROUND;
		//~ redraw(color | 0x202020 );
		redraw(color | 0x4C4C4C );
		
		//~ redraw(color + 0x141414 );
		CursorManager.getInstance().setCursor(Cursor.HAND);

	}

	/**
	*
	*
	*/
	public  function onRollOut(e:MouseEvent) : Void	
	{
		//~ var color = checked ? StyleManager.BACKGROUND - 0x202020 : StyleManager.BACKGROUND;
		redraw(color);
//		CursorManager.getInstance().setCursor(Cursor.ARROW);
	}			
	


    public function redraw(color:UInt)
    {
	if(color==0) color = this.color;
		    handle.graphics.clear();
    		handle.graphics.lineStyle(2, color - 0x141414);
		
       		  var colors = [ color | 0x323232, color - 0x141414 ];
		  var alphas = [ 100, 100 ];
		  var ratios = [ 0, 0xFF ];
		  //~ var matrix = { a:200, b:0, c:0, d:0, e:200, f:0, g:200, h:200, i:1 };
		  var matrix = new flash.geom.Matrix();
		  matrix.createGradientBox(15, 20, Math.PI/2, 0, 0);
		  handle.graphics.beginGradientFill( flash.display.GradientType.LINEAR, colors, alphas, ratios, matrix );


		//~ handle.graphics.beginFill(color);
		handle.graphics.drawRoundRect(0,0,8,20,4,4);
		handle.graphics.endFill();
    }
    

  /**
   *
   */
  function onMouseDown (e:MouseEvent) : Void
  {
    
    CursorManager.getInstance ().setCursor (Cursor.DRAG);

    redraw(color | 0x666666);


    //
    FocusManager.getInstance().setFocus (this);

	handle.startDrag(false,new Rectangle(0,e.target.y, box.width - handle.width ,0));
	//~ e.target.startDrag(false,new Rectangle(0,e.target.y, box.width - handle.width ,0));
	//~ e.target.stage.startDrag(false,new Rectangle(0,e.target.y, box.width - handle.width ,0));

	e.target.stage.addEventListener (MouseEvent.MOUSE_MOVE, onMouseMove);

	}

  public function onMouseMove (e:MouseEvent)
	{
	
	dispatchEvent(new Event(Event.CHANGE));
	//~ onChanged();
	e.updateAfterEvent();
	}
	
  function onMouseUp (e:MouseEvent) : Void
  {
	if(hitTestObject( CursorManager.getInstance().getCursor() ))
	    CursorManager.getInstance().setCursor (Cursor.HAND);	    
	//~ else
	    //~ CursorManager.getInstance().setCursor (Cursor.ARROW);

	handle.stopDrag();
	//~ e.target.stopDrag();
	//~ e.target.stage.stopDrag();
	e.target.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onMouseMove);
	
	redraw(color);

  }


}