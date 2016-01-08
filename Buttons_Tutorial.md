# Tutorial #2 - Buttons #

Last tutorial we created a window, windows accept some controls as direct children, like MenuBar or a ToolBar, but buttons are usually laid out in a Container.
This is visually represented by the window's transparency, we'll place an opaque container first.

In haxe, first import the Container and Button classes:
```
import haxegui.containers.Container;
import haxegui.controls.Button;
```

Following last tutorial's window creation code:
```
var cnt = new Container(win);
cnt.init();
```

Now to place a couple of buttons inside that container:
```
// normal button
var btn = new Button(cnt, "Button1");
btn.init({x:10, y:10, height: 30, label: "Button1"});

// same as a PushButton
var btn = new Button(cnt, "Button2");
btn.init({x:10, y:50, height: 30, toggle: true, label: "Button2"});

// disabled, pushed button, no label
var btn = new Button(cnt, "Button3");
btn.init({x:10, y:90, height:30, toggle: true, selected: true, disabled: true);
```

Or in a layout XML, inside a `<haxegui:Window>` tag:
```
<haxegui:containers:Container>
   <haxegui:controls:Button x="10" y="10" name="Button1" label="Button1"/>
   <haxegui:controls:Button x="10" y="50" name="Button2" label="Button2" toggle="true"/>
   <haxegui:controls:Button x="10" y="90" name="Button3" label="Button3" toggle="true" selected="true" disabled="true"/>
</haxegui:containers:Container>
```

For a button with an icon, import the Image class, a subclass named Icon is contained in that file:
```
import haxegui.controls.Image;
```

Pass an icon to the button's init function:
```
// from stock
btn.init({icon: Icon.STOCK_NEW});

// or from file
btn.init({icon: "run.png"});
```

Can also manually create icons and labels:
```
var btn = new Button(cnt);
btn.init();

var icon = new Icon(btn);
icon.init({src: Icon.STOCK_NEW});

var label = new Label(btn);
label.init({text: btn.name});
```

In XML:
```
<haxegui:controls:Button label="Button" icon="STOCK_NEW"/>
<haxegui:controls:Button>
   <haxegui:controls:Icon src="STOCK_NEW"/>
   <haxegui:controls:Label text="Button"/>
<haxegui:controls:Button>
```

You can interact with buttons using flash events, or with script which we'll touch in better depth later, so to add a click listener to a button in haxe you can do:
```
var onMouseClick = function(e:flash.events.MouseEvent) trace(e);
btn.addEventListener(flash.events.MouseEvent.CLICK, onMouseClick, false, 0, true);
```

or using script:
```
btn.setAction("mouseClick", "trace(event);");
```

and with script in XML:
```
<haxegui:controls:Button>
   <events>
      <script type="text/hscript" action="mouseClick>
         <![CDATA[
            trace(event);
         ]]>
      </script>
   </events>
<haxegui:controls:Button>
```

There are few special cases of buttons, sub-classes to be more accurate, like a CheckBox or a RadioButton, some are special to other controls, like the buttons on a Stepper or a ScrollBar, some of these will be shown in the next tutorial.