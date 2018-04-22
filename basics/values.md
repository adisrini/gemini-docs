# Values

Values are atomic units of data that cannot be evaluated or reduced any further. They are the basis of any program and all expressions compute on them. Here, we describe the ways to declare various types of values and give examples.

> For all of these examples, we show code snippets with the following format:
> ```
::> <input>
<output>
> ```

### Software
We first describe the syntax for declaring software-typed values.

#### Integers
Integers are whole numbers that may be positive, negative, or zero. The most straightforward way of declaring integers is as a base-10 literal, such as `42`, `1337`, or `~123`.

Integers can also be declared in other bases, like binary, octal, or hexadecimal.

**Example**
```Gemini
::> 42
val ans = 42 : int
::> #'b:101010
val ans = 42 : int
::> #'o:52
val ans = 42 : int
::> #'h:2A
val ans = 42 : int
```

#### Reals
Reals are floating point numbers that may be positive, negative, or zero. They encompass all real numbers expressible in IEEE floating point notation. They may be expressed as decimal numbers or in exponential notation. 

**Example**
```Gemini
::> 3.14159
val ans = 3.14159 : real
::> 6.022E~23
val ans = 6.022E~23 : real
::> 2.99792458E8
val ans = 299792458 : int
```

#### Strings
Strings are sequences of ASCII characters. They must be declared on a single line, and may include any of the following escape characters:

* `\n` newline
* `\t` tab
* `\"` double-quote
* `\\` backslash

**Example**
```Gemini
::> print("Hello,\n\tWorld!\n")
Hello,
  World!
val ans = () : unit
```

#### Lists
Lists are variable-length collections of other values. All the values in a list must be the same type. They can be declared in several ways. The most straightforward way is enclosing a comma-separated list of values in square brackets.

**Example**
```Gemini
::> [1, 2, 3]
val ans = [1, 2, 3] : int list
::> [["a"], ["b", "c"]]
val ans = [["a"], ["b", "c"]] : string list list
```

Lists can also be initialized using the cons operator `::`, which appends an element to the beginning of a list.

**Example**
```Gemini
::> 1::[1, 2, 3, 5, 8]
val ans = [1, 1, 2, 3, 5, 8] : int list
```

#### References
In its purest form, functional programming treats all values as functions with an input and output. The concept of state does not exist, and functions cannot "side-effect", or change the state of another value. This tends to reduce room for bugs since the consequences of all functions are known. Further, any time a new value computed it simply rebinds the identifier. The original value still exists and can be accessed in the previous lexical scope.

However, many functional programming languages introduce the notion of _references_, which enable programmers to manipulate state by storing references to values. These references can be assigned and the value they hold will be updated, allowing object-oriented designs to be implemented if desired.

**Example**
```Gemini
::> ref 42
val ans = ref 42 : int ref
```
To see more about how these values can be updated, view the section on [assignment](basics/expressions?id=assignment).

#### Software-Wrappers
The dichotomy between software-typed and hardware-typed is well-enforced in Gemini to ensure that a program cannot be ill-defined. However, the benefit of having software constructs is limited if there was no way to manipulate on hardware values. The software-wrapper allows programmers to wrap up hardware values and use them in software constructs before unwrapping them to be used in hardware. The hardware value itself can never be read, but it may persist to lists, records, references, functions, or any other software type. The [hardware examples](examples/hardware) demonstrate how useful this can be.

**Example**
```Gemini
::> sw 'b:0
val ans = sw 'b:0 : bit ref
```

#### Software Labeled Records
Labeled records allow logical grouping of values with named fields to provide structure. Records may also be nested.

**Example**
```Gemini
::> {name = "Aditya", age = 21}
val ans = {name = "Aditya", age = 21} : {name: string, age: int}
::> {meals = {breakfast = "eggs", lunch = "sandwich", dinner = "pasta"}}
val ans = {meals = {breakfast = "eggs", lunch = "sandwich", dinner = "pasta"}} : {meals : {breakfast: string, lunch: string, dinner: string}}
```

#### Software Unlabeled Records (Tuples)
Unlabeled records, also known as tuples, also allow for logical grouping of values. They are equivalent to records except the field names are implicitly numbered from `1` to `n`.

**Example**
```Gemini
::> ("Usain Bolt", 9.58)
val ans = ("Usain Bolt", 9.58) : string * real
```

#### Functions
Function declarations are covered in the section on [declarations](basics/declarations?id=functions).

### Hardware
Next, we first describe the syntax for declaring hardware-typed values.

#### Bits
Bits are the basis of all hardware values. There are two ways to declare bit constant literals.

**Example**
```Gemini
::> 'b:0
val ans = 'b:0 : bit
::> 'b:1
val ans = 'b:1 : bit
```

#### Arrays
Arrays are fixed-length vectors of hardware-typed values. All values in an array must be of the same type. The most straightforward way to declare an array is enclosing a comma-separated list of values with square brackets and prefixing with the pound symbol (`#`).

**Example**
```Gemini
::> #['b:1, 'b:0, 'b:1, 'b:0]
val ans = #['b:1, 'b:0, 'b:1, 'b:0] : bit[4]
::> #[#['b:0, 'b:1], #['b:1, 'b:0]]
val ans = #[#['b:0, 'b:0], #['b:0, 'b:1], #['b:1, 'b:0], #['b:1, 'b:1]] : bit[2][4]
```

#### Hardware Labeled Records
These are similar to software labeled records, except the values must be hardware-typed. The syntax for declaration is almost identical, except it is prefixed with the pound symbol (`#`).

**Example**
```Gemini
::> #{valid = 'b:0, dirty = 'b:1}
val ans = #{valid = 'b:0, dirty = 'b:1} : #{valid: bit, dirty: bit}
```
#### Hardware Unlabeled Records (Tuples)
These are similar to software tuples, except the values must be hardware-typed. The syntax for declaration is almost identical, except it is prefixed with the pound symbol (`#`).

**Example**
```Gemini
::> #('b:0, #['b:1, 'b:1])
val ans = #('b:0, #['b:1, 'b:1]) : bit #* bit[2]
```