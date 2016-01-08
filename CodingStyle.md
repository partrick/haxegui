# This describes the preferred style for writing haxegui code #

## Variables ##
no `m_` prefixes for members, or i\f\b prefixes for ints\floats\boolean, haxe is well typed.
Use camelCase not underscores.

## Functions ##
event callbacks are prefixed with 'on', and usually in past tense, onChanged\onSomethingHappened, getters\setters are sometimes prefixed with two underscores.

Please use explicit folding around functions, where top line is only the function's name:
```
//{{{ doesSomething
/**
* Javadoc
*/
function doesSomething() {
   trace("done.");
//}}}
```

javadoc starts only with `/**` and ends either way.

## Classes ##

Use explicit folding to group members and functions and around constructor, for files with multiple classes, also around those.

## Enums ##

Use uppercase for enum constructs, or for static members of classes acting as enums...

## General ##
Use explicit folding around imports and also sorting.

Same-line brackets for functions, for\while-loops, and if-else blocks.

Prefer to use single quotes "'" inside strings and not escaped doubles "\""