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

import flash.display.DisplayObjectContainer;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import haxegui.Opts;
import haxegui.managers.StyleManager;
import haxegui.controls.Component;

import haxegui.utils.Size;
import haxegui.utils.Color;

/**
*
* Label class, non-interactive text component.
*
* @author Omer Goshen <gershon@goosemoose.com>
* @author Russell Weir <damonsbane@gmail.com>
* @version 0.1
*/
class Label extends Component
{
	public var tf 						: TextField;
	public var txt (getText, setText)  : String;

	override public function init(opts : Dynamic=null) {
		super.init(opts);
		
		tf = new TextField();
		tf.name = "tf";
		tf.text = text;
		tf.type = TextFieldType.DYNAMIC;
		tf.embedFonts = true;
		tf.multiline = true;
		tf.autoSize =  TextFieldAutoSize.LEFT;
		tf.selectable = false;
		tf.mouseEnabled = false;
		tf.tabEnabled = false;
		tf.focusRect = false;

		//~ this.mouseEnabled = false;
		this.tabEnabled = false;
		this.focusRect = false;

		tf.text = Opts.optString(opts, "innerData", text);
		tf.defaultTextFormat = DefaultStyle.getTextFormat();
		tf.setTextFormat(DefaultStyle.getTextFormat());
		this.addChild(tf);

		resize(new Size(tf.width, tf.height));
		move(Opts.optFloat(opts,"x",0), Opts.optFloat(opts,"y",0));

		dirty = false;
	}

	public function getText() : String {
		return tf.text;
	}

	public function setText(s:String) : String {
		tf.text = s;
		//tf.setTextFormat(DefaultStyle.getTextFormat());
		return tf.text;
	}

	static function __init__() {
		haxegui.Haxegui.register(Label,initialize);
	}

	static function initialize() {
	}


	public override function redraw(opts:Dynamic=null) {
		
		tf.x = Math.round(tf.x);
		tf.y = Math.round(tf.y);
		
		super.redraw(Opts.clone(opts));
	}
	
}
