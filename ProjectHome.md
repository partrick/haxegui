Haxe Graphical User Interface for the flash9 platform, is a set of classes working as widgets like flash/flex's components and windows.

Currently the library contains the following widgets: Button, Label, Input, Checkbox, Radiobox, Combobox, Slider, Scrollbar, Scrollpane, List, Tree, Popup-Menu, Window, ColoPicker

Widgets are tweened and scripted, can be hard-coded or loaded from xml.

You can see some samples on the blog at http://haxegui.blogspot.com/

A little usage sample:
```
// WindowaManager is a singleton, can just as well call:
// var window = new Window(flash.Lib.current, "Window", 120, 10);
// 
var window = WindowManager.getInstance().addWindow (flash.Lib.current);
window.init({name:"Window", x:120, y:10});

//
var menubar =  new Menubar (window, "Menubar", 10, 20);
menubar.init();

//
var toolbar =  new Toolbar (window, "Toolbar", 10, 44);
toolbar.init();
```

will add a top-level window with a menubar and toolbar.

# Future Plans: #

  * Package for use with haxelib, better documentation and lingual support.

  * Add more widgets: ~~Tree~~, Datagrid, ~~Tab navigation~~, Graph plotters, more containers.

  * Layout managing, box-model.

  * Validation, serialization of data and external interface communication.

  * ~~Extract rendering code to xml, to be exact, each widget should contain a reference to its rendering code (hscript), making it possible to use plugged-in rendering engines ( like vector / bitmap / scale9grid etc. )~~

  * GuiBuilder ofcourse.



_(For a more complete, mature library, you'll might want to checkout Aswing.)_





# Demos \ SVN Compilation and running : #

### About: ###

The demos show the widget palette, a color picker, map-like drag control and xml loading & scripting.

### Dependencies: ###

**swfmill:**
The almighty http://swfmill.org/ needed for packaging assets and just for being cool and open-sourced.
Assets have already been compiled in the demos.

**Haxe:**

![http://haxegui.googlecode.com/svn/trunk/assets/haxe_banner_med.png](http://haxegui.googlecode.com/svn/trunk/assets/haxe_banner_med.png)

Our Beloved compiler for generating everything else.

**haxelib:**
Some libs are needed for compiling: hscript, feffect (10x to http://filt3r.free.fr/index.php/ on both!)


### Compiling: ###


On Linux, just type `make` in working directory.
On Win32, take a look at the makefile until a proper batch script will be written

This will call swfmill for linking assets and haxe for compiling, mainly _App.hx_ which contains code for the Widget Playground and for loading the _config.xml_ file, rest of the stuff is hscript, which "interpreters some code dynamically" see http://code.google.com/p/hscript/ for more.

**Update**:
As of SVN > ~[r120](https://code.google.com/p/haxegui/source/detail?r=120), StyleManager was introduced, styles could be runtime-loaded, but the default style is compiled into the binary with haxe's resource-compiling.
To generate the style, build the _stylecompiler_ under the _Tools_ directory, copy to somewhere in your path (~/bin/ on linux), and run it in _assets/styles/_ like this:
`stylecompiler default`, to generate _default\_style.xml_


### Running: ###

Run `main.swf` in Flash Player >= 9.

