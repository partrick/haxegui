# Tutorial #1 - Windows #

See http://code.google.com/p/haxegui/source/checkout for download details, where you can grab the latest revision, we'll be editing a file like `Main.hx`, with a similar directory tree to the svn's trunk, see also `makefile` and `Compile.hxml` for compilation.
This tutorial assumes you have the `haxegui` root directory at your project base, we'll be editing a class with a `static main()` function, the entry point for the application.

First we'll need to import a couple of classes to help booting up the haxegui framework:
```
import haxegui.Haxegui;
import haxegui.Window;
import haxegui.LayoutManager;
```

We then setup some stage properties, and initiate haxegui:
```
public static function main () {
// Set stage propeties
stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
stage.align = flash.display.StageAlign.TOP_LEFT;

// Setup Haxegui
haxegui.Haxegui.init();
}
```

Now we'll be adding top-level, first and fastest way is to do so using only haxe, later i'll present layouts, as an alternative method.

add the following to `main()`:
```
var win = new Window(flash.Lib.current, "Window", 100, 100);
win.init({width: 320, height:240});
```

This creates a new window on stage (child of root), named "Window" at coordinates {x:100, y:100}, it is setup, drawn, and is assigned event listeners with a call to `init()`, the function is inherited from Component, and takes an object of arguments, which is filled with component-specific default values if arguments are missing.

The created window is draggable via the TitleBar, and resizeable via frame edges and corners, the default skin is semi-transparent and has a drop shadow.

We'll now take a look at another way of creating windows, this time using XML layout set with the LayoutManager, parsed internally, with XmlParser.

```
// create an Xml object, containing layout as root node and a single window
var str = '
<haxegui:Layout name="Simple Window">
   <haxegui:Window name="Window" x="100" y="100" width="320" height="200"/>
</haxegui:Layout>';

// load the layouts from an Xml, only parsing is done here, no initiating of objects yet
LayoutManager.loadLayouts(Xml.parse(str));

// LayoutManager should report 1 loaded layout, named "Simple Window"
for(k in LayoutManager.layouts.keys())
trace("Loaded layout : " + k);

// apply a named layout, this creates and initiates everything
// the layout's name is grabbed from the xml, instead of an explicitly named string
LayoutManager.setLayout(Xml.parse(str).firstElement().get("name"));
```

Xml can be loaded from file, received from remote connection, or included as compile-time resource.
The attributes in the window node are exactly the same as those fields passed in the object to `init()`, the creation mechanism differs only syntacticly.

A Shortcut for creating windows, using a static function from WindowManager, which returns a new Window, and calling init() on that:
```
WindowManager.addWindow().init()
```

Next tutorial we'll be doing basic layout and adding buttons to a window.