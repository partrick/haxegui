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

package haxegui.toys;


//{{{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import haxegui.controls.Component;
import haxegui.managers.StyleManager;
import haxegui.utils.Color;
//}}}

/**
* Component wrapper for a curve.<br/>
* @todo Cubic bezier
*/
class Curvy extends Line
{
	//{{{ Members
	var points : Array<Point>;
	var cp : Array<Point>;

	var controlPoint : haxegui.toys.Circle;
	var anchors 	 : Array<haxegui.toys.Rectangle>;
	//}}}


	//{{{ Functions
	//{{{ init
	override public function init(?opts:Dynamic) {
		super.init();


		color = Color.random();


		start = new Point(stage.mouseX, stage.mouseY);
		end = new Point(stage.mouseX, stage.mouseY);
		points = [start, end];
		cp = [Point.interpolate( start, end.add(new Point(0,50)), .5 )];

		//{{{ redraw
		setAction("redraw",
		"
		this.graphics.clear();
		this.graphics.lineStyle(6,this.color);
		this.graphics.moveTo( this.start.x, this.start.y );
		this.graphics.curveTo(this.cp[0].x, this.cp[0].y, this.end.x, this.end.y);

		this.graphics.lineStyle(1, Color.tint(~this.color, .5));
		this.graphics.moveTo( this.start.x, this.start.y );
		this.graphics.lineTo( this.cp[0].x, this.cp[0].y );

		this.graphics.moveTo( this.end.x, this.end.y );
		this.graphics.lineTo( this.cp[0].x, this.cp[0].y );
		"
		);
		//}}}

		filters = [new flash.filters.DropShadowFilter (8, 45, DefaultStyle.DROPSHADOW, 0.8, 4, 4, 0.65, flash.filters.BitmapFilterQuality.HIGH, false, false, false )];


		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		stage.addEventListener(MouseEvent.MOUSE_UP, onRelease);
	}
	//}}}


	//{{{ onMouseDown
	override function onMouseDown(e:MouseEvent) {
		for(i in getElementsByClass(Circle))
		i.visible = true;
		super.onMouseDown(e);
	}
	//}}}


	//{{{ onMove
	override function onMove(e) {

		end = new Point(e.stageX, e.stageY);

		points = [start, end];
		cp = [Point.interpolate( start, end.add(new Point(0,200)), .5 )];

		var self = this;

		if(controlPoint==null) {
			controlPoint = new Circle(this);
			controlPoint.blendMode = flash.display.BlendMode.DIFFERENCE;
			controlPoint.visible = false;
			controlPoint.moveTo(cp[0].x, cp[0].y);
			controlPoint.init({radius: 6});
			controlPoint.addEventListener(MouseEvent.MOUSE_DOWN, function(e) {
				self.stage.addEventListener(MouseEvent.MOUSE_MOVE, self.updateControlPoints, false, 0, true);
				self.controlPoint.startDrag();
				self.stage.addEventListener(MouseEvent.MOUSE_UP, function(e) {
					self.controlPoint.stopDrag();
					self.stage.removeEventListener(MouseEvent.MOUSE_MOVE, self.updateControlPoints);
				}, false, 0, true);
			});

		}
		else
		controlPoint.moveToPoint(cp[0]);


		// updateControlPoints();
		redraw();
	}
	//}}}


	//{{{ updateControlPoints
	function updateControlPoints(?e:Dynamic) {

		cp = [new Point(stage.mouseX, stage.mouseY)];

		// for(i in 0...cp.length)
		// if(numChildren>i)
		// if(this.getChildAt(i)!=null) {
		// cp = [Point.interpolate( start, new Point(stage.mouseX, stage.mouseY).add(new Point(0,200)), .5 )];
		// }
		//~ dirty = true;
		redraw();
	}
	//}}}


	//{{{ __init__
	static function __init__() {
		haxegui.Haxegui.register(Curvy);
	}
	//}}}
	//}}}
}
