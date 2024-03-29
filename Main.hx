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


//{{{ Imports
import feffects.Tween;
import flash.Lib;
import flash.accessibility.Accessibility;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.external.ExternalInterface;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.geom.Transform;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.net.FileReferenceList;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.system.Capabilities;
import haxegui.Appearance;
import haxegui.Automator;
import haxegui.Binding;
import haxegui.ColorPicker2;
import haxegui.ColorPicker;
import haxegui.Console;
import haxegui.Haxegui;
import haxegui.Introspector;
import haxegui.RichTextEditor;
import haxegui.Stats;
import haxegui.containers.Accordion;
import haxegui.containers.Container;
import haxegui.containers.Divider;
import haxegui.containers.Grid;
import haxegui.containers.ScrollPane;
import haxegui.containers.Stack;
import haxegui.controls.Button;
import haxegui.controls.CheckBox;
import haxegui.controls.ComboBox;
import haxegui.controls.Component;
import haxegui.controls.Expander;
import haxegui.controls.Input;
import haxegui.controls.Label;
import haxegui.controls.MenuBar;
import haxegui.controls.PopupMenu;
import haxegui.controls.ProgressBar;
import haxegui.controls.RadioButton;
import haxegui.controls.Slider;
import haxegui.controls.Stepper;
import haxegui.controls.TabNavigator;
import haxegui.controls.ToolBar;
import haxegui.controls.UiList;
import haxegui.events.FileEvent;
import haxegui.events.MenuEvent;
import haxegui.managers.CursorManager;
import haxegui.managers.FocusManager;
import haxegui.managers.LayoutManager;
import haxegui.managers.MouseManager;
import haxegui.managers.ScriptManager;
import haxegui.managers.StyleManager;
import haxegui.managers.WindowManager;
import haxegui.utils.Color;
import haxegui.utils.Printing;
//}}}

/**
* Haxegui Demo Application
*
*
* @author Omer Goshen <gershon@goosemoose.com>
* @author Russell Weir <damonsbane@gmail.com>
* @version 0.26
*/
class Main extends Sprite, implements haxe.rtti.Infos {

	//{{{ members
	static var load	   : Xml;
	static var desktop : Sprite;
	static var root    : MovieClip = flash.Lib.current;
	static var stage   : Stage = root.stage;
	//}}}


	//{{{ main
	public static function main () {

		// Set stage propeties
		stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		stage.align = flash.display.StageAlign.TOP_LEFT;
		stage.stageFocusRect = true;
		stage.frameRate = 120;

		// Assign a stage resize listener
		stage.addEventListener(Event.RESIZE, onStageResize, false, 0, true);


		// Logos
		/*
		var logo = cast flash.Lib.current.addChild(flash.Lib.attach("Logo"));
		logo.name = "Logo";
		logo.x = cast (stage.stageWidth - logo.width) >> 1;
		logo.y = cast (stage.stageHeight - logo.height) >> 1;
		logo.mouseEnabled = false;
		*/
		// Setup Haxegui
		haxegui.Haxegui.init();

		// Desktop
		makeDekstop();

		// init
		haxe.Timer.delay( init, 50);

	}
	//}}}


	//{{{ makeDekstop
	/**
	* Draws a vertical gradient across the stage.
	*/
	public static function makeDekstop() {

		desktop = untyped flash.Lib.current.addChild(new Sprite());
		desktop.name = "desktop";
		desktop.mouseEnabled = false;

		var colors = [ DefaultStyle.BACKGROUND, Color.darken(DefaultStyle.BACKGROUND, 40) ];
		var alphas = [ 1, 1 ];
		var ratios = [ 0, 0xFF ];
		var matrix = new flash.geom.Matrix();
		matrix.createGradientBox(stage.stageWidth, stage.stageHeight, .5*Math.PI, 0, 0);
		desktop.graphics.beginGradientFill( flash.display.GradientType.LINEAR, colors, alphas, ratios, matrix );
		desktop.graphics.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
		desktop.graphics.endFill();
	}
	//}}}


	//{{{ makeWindows
	/**
	* Make some top-level windows
	*/
	public static function makeWindows() {
		// Statistics
		// var stats = new Stats (flash.Lib.current, 540, 80);
		// stats.init();

		// Color Picker
		// var colorpicker = new ColorPicker2(flash.Lib.current, 100,100);
		// colorpicker.init();

		// var filedialog = new haxegui.FileDialog(flash.Lib.current, 100, 100);
		 // filedialog.init();

		// rte
		// var rte = new RichTextEditor(flash.Lib.current, 120,120);
		// rte.init();

		// style
		// var appearance = new Appearance(flash.Lib.current, 180,180);
		// appearance.init();

		// debugger
		// var introspect = new Introspector(flash.Lib.current, 150,150);
		// introspect.init();

		// Analog Clock
		//var clock = new haxegui.toys.AnalogClock(flash.Lib.current, 210,88);
		//clock.init();

		//
		var patchLayer = new Component(flash.Lib.current, "patchLayer");
		patchLayer.init();
		patchLayer.description = null;
		patchLayer.mouseEnabled = false;

	}
	//}}}


	//{{{ setRedirection
	/**
	* Redirect tracing to console
	*/
	public static function setRedirection(f:Dynamic) {
		haxe.Log.trace = f;
		ScriptManager.redirectTraces(f);
	}
	//}}}


	//{{{ log
	/**
	*
	*/
	public static dynamic function log(v:Dynamic) {
		trace(v, null);
	}
	//}}}


	//{{{ loadXml
	/**
	* Loads the layout
	*/
	static function loadXML(e:Event) : Void	{
		trace(here.methodName) ;
		var str = e.target.data;
		LayoutManager.loadLayouts(Xml.parse(str));

		for(k in LayoutManager.layouts.keys())
		trace("Loaded layout : " + k);

		LayoutManager.setLayout(Xml.parse(str).firstElement().get("name"));

		//~ LayoutManager.fetchLayout("samples/Example6.xml");
		//~ LayoutManager.setLayout("Example6");

/*
		var win = cast root.getChildByName("Widgets");
		var sp = win.getChildByName("ScrollPane1");
		var cnt = sp.content.getChildByName("Container1");



		var node = new haxegui.Node(cast sp);
		node.init();
		var node = new haxegui.Node(cast sp);
		node.init();
		node.move(20,20);
*/
		trace("Finished Initialization in "+ haxe.Timer.stamp() +" sec.");


		var welcome = "\n<FONT SIZE='14'>Hello and welcome to <B>haxegui</B>.</FONT>\n";
		var info = "\nCopyright (c) 2009 The haxegui developers\n";
		info += "<FONT SIZE='8'>"+flash.system.Capabilities.os+" "+flash.system.Capabilities.version+" "+flash.system.Capabilities.playerType+" "+(flash.system.Capabilities.isDebugger ? "Debug" : "")+".</FONT>\n";
		info += "\n\t<U><A HREF=\"http://haxe.org/\">haXe</A></U> (pronounced as hex) is an open source programming language.\n";
		info += "\tHaxe Graphical User Interface for the flash9 platform, is a set of classes\n\tworking as widgets like flash/flex's components and windows.\n\n";
		info += "\tThis console can exeute hscript in the textfield below,\n\ttype <I>help</I> to display a list of a few special commands.\n\n";

		log(welcome);
		log(info);
		log("");

	}
	//}}}


	//{{{ init
	public static function init ()	{

		var bootupMessages = new Array<{v:Dynamic, inf:haxe.PosInfos}>();
		var bootupHandler = function(v : Dynamic, ?inf:haxe.PosInfos) {
			bootupMessages.push({v:v, inf:inf});
		}
		setRedirection(bootupHandler);


		// Console to show some debug
		var console = new Console (flash.Lib.current, 50, 50);
		console.init({color:0x2E2E2E, visible: true });
		haxe.Log.clear();
		setRedirection(console.log);

		log = function(v:Dynamic) {
			console.log(v, null);
		}

		log("*** Bootup messages:");
		for(e in bootupMessages)
		console.log(e.v, e.inf);

		stage.addEventListener(KeyboardEvent.KEY_DOWN,
		function(e){
			switch(e.charCode) {
				case "`".code:
				console.visible = !console.visible;
			}
		});

		/////////////////////////////////////////////////////////////////////////
		// Make some windows
		/////////////////////////////////////////////////////////////////////////
		makeWindows();

		/////////////////////////////////////////////////////////////////////////
		// Load XML
		/////////////////////////////////////////////////////////////////////////
		var loader:URLLoader = new URLLoader();
		loader.addEventListener(Event.COMPLETE, loadXML, false, 0, true);

		var layout = "";
		try {
			// get the flashvars from root
			var fvars = root.loaderInfo.parameters;
			// trace(here.methodName + " " + Printing.print_r(l));

			// try and grab the base url from flashvars first
			var baseURL = Reflect.field(fvars, "baseURL");
			if(baseURL==null) baseURL = Haxegui.loader.node.domain.att.baseurl;
			if(baseURL==null) baseURL = "";
			Haxegui.baseURL = baseURL;

			// try layout from flash vars
			layout = Reflect.field(fvars, "layout");
			if(layout==null)
			layout = Haxegui.loader.node.layout.att.url;

		} catch (e:Dynamic) {
			trace(here.methodName + " " + e);
		}


		loader.load(new URLRequest(Haxegui.baseURL+layout));


		// remoting
		// var URL = "http://localhost:2000/remoting.n";
		// var cnx = haxe.remoting.HttpAsyncConnection.urlConnect(URL);
		// cnx.setErrorHandler( function(err) trace("Error : "+Std.string(err)) );

		// Print known scripts to console
		#if debug
		var a = new Array<String>();
		var keys : Iterator<String> = untyped ScriptManager.defaultActions.keys();
		for(k in keys)
		a.push( k.split('.').slice(-2,-1).join('.') + "." + k.split('.').pop() );
		a.sort(function(a,b) { if(a==b) return 0; if(a < b) return -1; return 1;});
		log("Registered scripts: " + Std.string(a));
		#end

		// ExternalInterface
		//flash.system.Security.allowDomain("*");
		//flash.external.ExternalInterface.addCallback( "onChange", onChange );
	}
	//}}}


	//{{{ onChange
	/**
	* Used for [ExternalInterface] communcation
	* @param str A [String] width new layout to load
	*/
	static function onLayoutChange(str: String) {
		//trace("Javascript Return: " + str);

		//str = str.split("\n").join("").split("\t").join("");
		//str = "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>"+str;
		//trace(Xml.parse(str).firstElement().get("name"));

		LayoutManager.loadLayouts(Xml.parse(str));
		for(k in LayoutManager.layouts.keys())
		trace("Loaded layout : " + k);
		LayoutManager.setLayout(Xml.parse(str).firstElement().get("name"));

	}
	//}}}


	//{{{ onStageResize
	/**
	* Redraw the desktop background
	*/
	public static function onStageResize(e:Event) {
		if(desktop==null) return;

		var stage = e.target;

		desktop.graphics.clear();
		var colors = [ DefaultStyle.BACKGROUND, Color.darken(DefaultStyle.BACKGROUND,40) ];
		var alphas = [ 1, 1 ];
		var ratios = [ 0, 0xFF ];
		var matrix = new flash.geom.Matrix();
		matrix.createGradientBox(stage.stageWidth, stage.stageHeight, .5*Math.PI, 0, 0);
		desktop.graphics.beginGradientFill( flash.display.GradientType.LINEAR, colors, alphas, ratios, matrix );

		desktop.graphics.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
		desktop.graphics.endFill();
		/*
		var logo = cast flash.Lib.current.getChildByName("Logo");
		logo.x = Std.int(stage.stageWidth - logo.width) >> 1;
		logo.y = Std.int(stage.stageHeight - logo.height) >> 1;
		*/
	}
	//}}}
}

