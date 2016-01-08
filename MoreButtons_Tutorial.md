# Tutorial #3 - More On Buttons & Input Controls #

## CheckBoxes & RadioButtons ##

In haxegui, CheckBoxes and RadioButtons are subclasses of `haxegui.controls.PushButton`, their state is indicated by the inherited `selected` property, difference between them being that only a single RadioButton can be selected from a multiple under the same parent.

Following haxe code creates a CheckBox which controls the disabled state of a RadioButton:
```
var chkbox = new CheckBox();
chkbox.init({label: "Disable RadioButton", selected: true});

var radio = new RadioButton();
radio.init({disabled: chkbox.selected});

var onMouseClick = function(e:MouseEvent) {
   radio.disabled = chkbox.selected;
};

chkbox.addEventListener(MouseEvent.CLICK, onMouseClick, false, 0, true);
```

In XML, using script (more later):
```
<haxegui:controls:CheckBox selected="true">
  <events>
    <script type="text/hscript" action="mouseClick">
      <![CDATA[
      this.nextSibling().__setDisabled(this.__getSelected());
      ]]>
    </script>
  </events>
</haxegui:controls:CheckBox>
<haxegui:controls:RadioButton disabled="{this.prevSibling().__getSelected()}"/>
```

## Inputs ##

### Text Input ###
The haxegui Input is part of IText family of components, it is a component wrapper for a `flash.text.TextField`, its the basic text entry component, and is used on its own, and as part of more complex components.

A reference to the TextField is created as the `tf` member of the input, it is given the default TextFormat, by a call to `DefaultStyle.getTextFormat()`, and its text set.



To following haxe code creates two new inputs copying text from the first to the second:
```
var input1 = new Input();
input1.init({text: "Enter Text...", displayAsPassword: true});

var input2 = new Input();
input2.init({text: "", disabled: true});

var onTextInput = function(e:TextEvent) {
   input2.setText(input1.getText());
}
input.tf.addEventListener(flash.events.TextEvent.TEXT_INPUT, onTextInput, false, 0, true);
```

Just the creation in XML:
```
<haxegui:controls:Input text="Text"/>
<haxegui:controls:Input>Text</haxegui:controls:Input>
```

### Numerical Input ###

A Stepper, is a component that visually contains an input and two buttons to ease incrementing & decrementing the stepper's value, which is wrapped inside an Adjustment.

Being a part of the IAdjustable family of "range" widgets, steppers have a `adjustment` member which is an instance of the Adjustment class, a non-visual class that has functions to deal with values and ranges.

A Stepper listens for adjustments, like the case when one of the two buttons is pressed, and updates the text on the input, when the input changes, so does the adjustment value.

The following code should trace the verification of this:
```
var step = new Stepper();
step.init({value: 100, step: 100});
step.adjustment.setValue(step.adjustment.getStep());
trace(step.input.getText()==step.adjustment.valueAsString());
```

```
<haxegui:controls:Stepper value="100"/>
```