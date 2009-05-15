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

import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.events.FocusEvent;
import flash.filters.DropShadowFilter;
import flash.filters.BitmapFilterQuality;
import flash.geom.Rectangle;
import flash.text.TextFormat;

import haxegui.CursorManager;
import haxegui.Opts;
import haxegui.StyleManager;
import haxegui.events.MoveEvent;

/**
*
* Button Class
*
* @version 0.1
* @author Omer Goshen <gershon@goosemoose.com>
* @author Russell Weir <damonsbane@gmail.com>
*
*/
class Button extends AbstractButton, implements Dynamic
{
	/**
	*  @see Label
	*/
	public var label :Label;
	public var fmt : TextFormat;

	override public function init(opts:Dynamic=null)
	{
		super.init(opts);

		label = new Label();
		label.text = Opts.optString(opts, "label", name);
		label.init();
		this.addChild(label);

		// register with focus manager
		//~ FocusManager.getInstance().addEventListener (FocusEvent.MOUSE_FOCUS_CHANGE, onFocusChanged);
	}


	public function onFocusChanged (e:FocusEvent)
	{
		//~ var color = this.hasFocus ()? DefaultStyle.BACKGROUND | 0x141414: DefaultStyle.BACKGROUND;
		redraw ();
	}

	static function __init__() {
		haxegui.Haxegui.register(Button,initialize);
	}
	static function initialize() {
		StyleManager.setDefaultScript(
			Button,
			"redraw",
			"
				this.graphics.clear();
				var colors = [ this.color | 0x323232, this.color - 0x141414 ];
				if(this.disabled)
					colors = [ this.color - 0x141414, this.color ];
				var alphas = [ 100, 100 ];
				var ratios = [ 0, 0xFF ];
				var matrix = new flash.geom.Matrix();
				matrix.createGradientBox(this.box.width, this.box.height, Math.PI/2, 0, 0);
				
				this.graphics.lineStyle (1,
					flash.display.LineScaleMode.NONE,
					flash.display.CapsStyle.ROUND,
					flash.display.JointStyle.ROUND
					);				
				this.graphics.lineGradientStyle (flash.display.GradientType.LINEAR, [ this.color, this.color - 0x202020 ], alphas, ratios, matrix);
				this.graphics.beginGradientFill( flash.display.GradientType.LINEAR, colors, alphas, ratios, matrix );
				this.graphics.drawRoundRect (0, 0, this.box.width, this.box.height, 12, 12 );
				this.graphics.endFill ();

				var fmt = DefaultStyle.getTextFormat(8, DefaultStyle.LABEL_TEXT, flash.text.TextFormatAlign.LEFT);
				if(this.disabled) fmt.color = this.color - 0x202020;
				this.label.tf.setTextFormat( fmt );

				if(this.filters.length == 0) {
					// add the drop-shadow filter
					var shadow = new flash.filters.DropShadowFilter(
							this.disabled ? 2 : 4, 45,
							DefaultStyle.DROPSHADOW,
							this.disabled ? 0.2 : 0.5,
							4, 4, 0.5,
							flash.filters.BitmapFilterQuality.HIGH,
							false, false, false );
					//~ var bevel:BevelFilter = new BevelFilter( 4, 45 ,color | 0x323232 ,1 ,0x000000, .25, 2, 2, 1, BitmapFilterQuality.LOW , flash.filters.BitmapFilterType.INNER, false );
					this.filters = [shadow];
				}

				if(this.label != null) {
					this.label.moveTo(
						Math.floor(.5*(this.box.width - this.label.width)),
						 Math.floor(.5*(this.box.height - this.label.height)) );
				}
			"
		);
	}
}
