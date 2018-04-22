# Declarations

Declarations are ways to bind expressions to identifiers so that they may be reused. They may be made in [let-bindings](basics/expressions?id=let-bindings) and are visible from their point of declaration onwards in the scope of the binding. In Gemini, there are five kinds of declarations that can be made: values, functions, types, datatypes, and modules.

#### Values

Value declarations bind an identifier to a value. They may either be declared implicitly (with no type), or explicitly (with a type). The syntax for [types](basics/types) is covered in another section.

**Example**
```Gemini
::> let val numbers = [1, 2, 3] in List.nth(numbers, 0) end
val ans = 1 : int
::> let val numbers : int list = [1, 2, 3] in List.nth(numbers, 0) end
val ans = 1 : int
```

#### Types

Type declarations bind an identifier to a type. The syntax for [types](basics/types) is covered in another section.

**Example**
```Gemini
::> let
..    type integers = int list
..    val numbers : integers = [1, 2, 3]
..  in
..    List.nth(numbers, 0)
..  end
val ans = 1 : int
```

Type declarations may also be declared polymorphically by introducing type variables.

**Example**
```Gemini
::> let
..    type 'a things = 'a list
..    val numbers : int things = [1, 2, 3]
..    val words : string things = ["apple", "banana", "coconut"]
..  in
..    (List.nth(numbers, 0), List.nth(words, 0))
..  end
val ans = (1, "apple") : int * string
```

#### Functions

Function declarations bind an identifier to a function. A function has one or more arguments, where each argument is either an identifier, a tuple of arguments, or a record of arguments. The arguments and functions may be declared implicitly, explicitly, or with a mix of both.

The examples in this section progressively demonstrate the expressive power of Gemini.

The following declares the function `multmap` that multiplies all integers in a list by some constant. The explicit types are unnecessary, but demonstrate how types can be specified.

```Gemini
::> fun multmap(const : int, lst : int list) : int list = case x of
                                                               [] => []
                                                            |: a::rest => (a * const)::(multmap(const, rest))
val multmap : int * int list -> int list
::> multmap(9, [1, 2, 3])
val ans = [9, 18, 27] : int list
```

In the above example, there was only one function argument with type `int * int list`. However, when multiple arguments are used, programmers can utilize currying.

For example, consider the following version of `multmap` with arguments curried instead of in a tuple.

```Gemini
::> fun curried_multmap const lst = case x of
                                         [] => []
                                      |: a::rest => (a * const)::(multmap const rest)
val curried_multmap : int -> int list -> int list
```

The function looks largely the same, except the arguments are applied successively and the type of the function is now `int -> int list -> int list`. This means that I can _partially apply_ `curried_multmap` in order to achieve a different function.

```Gemini
::> val multby3map = curried_multmap 3
val multby3map : int list -> int list
::> multby3map [1, 2, 3]
val ans = [3, 6, 9] : int list
```

The result of partially applying `curried_multmap` is another function with type `int list -> int list`. This function is the same as `curried_multmap`, except `const` is bound to the value `3` in all future application. This is a powerful feature of functional programming languages that enhances expressibility and reduces code duplication.

Another powerful feature is that of _higher-order functions_. Functions are treated like values and may be passed as arguments to other functions. This is best exemplified by the most generic form of `map`, which takes both a mapping function and a list and returns the mapped version of the list.

```Gemini
::> fun map f x = case x of
                       [] => []
                    |: a::rest => (f a)::(map f rest)
val map : ('a -> 'b) -> 'a list -> 'b list
::> fun add_42_and_make_string n = Int.toString(n + 42)
val add_42_and_make_string : int -> string
::> val custom_map = map add_42_and_make_string
val custom_map : int list -> string list
::> custom_map [0, 100, 60]
val ans = ["42", "142", "102"] : string list
```

#### Datatypes
Datatype declarations bind an identifier to a datatype. A datatype consists of one or more constructors, each with their own type of arguments. They are most useful when the same type of data may have multiple representations.

We distinguish between software datatypes and hardware datatypes. In the former, all constructors have software types, whereas in the latter, all constructors have hardware types.

The software datatype is declared with the syntax `sdatatype d = C1 of T1 |: Cn of Tn`, where `Ci` is a datatype constructor that accepts software type `Ti`.

**Example**
```Gemini
::> sdatatype int_tree = NODE of (int_tree * int_tree * int)
..                    |: LEAF of int
sdatatype int_tree
::> val root = NODE(LEAF(1), LEAF(3), 2)
val root  = NODE(LEAF(1), LEAF(3), 2) : int_tree
```

Constructors need not accept any type.

**Example**
```Gemini
::> sdatatype int_option = SOME of int
..                      |: NONE
sdatatype int_option
::> val x = NONE
val x = NONE : int_option
```

Like types, datatypes may also be parametrically polymorphic by introducing type variables.

```Gemini
::> sdatatype 'a option = SOME of 'a
..                     |: NONE
sdatatype 'a option
::> val x = SOME "Aditya"
val x = SOME "Aditya" : string option
::> val y = SOME 42
val y = SOME 42 : int option
```

Datatypes are particularly useful in conjunction with pattern-matching expressions as they allow the deconstruction of values to determine the wrapping constructor.

**Example**
```Gemini
::> fun mapPartial f x = case x of
..                            [] => []
..                         |: (a::rest) => (case (f a) of
..                                               NONE => mapPartial f rest
..                                            |: SOME v => v::(mapPartial f rest))
val mapPartial : ('a -> 'b option) -> 'a list -> 'b list
```

Hardware datatypes are similar in syntax to software datatypes, except the keyword `hdatatype` is used.

#### Modules
Module declarations bind an identifier to a module. A module is similar to a function, except it operates on hardware-typed values and produces a hardware-typed value. Further, exactly one argument must be specified, preventing higher-order modules from existing. The module and any arguments may be implicitly or explicitly typed.

Inside a module, any kind of software expressions may exist, but the returned value must be a hardware-typed value.

**Example**
```Gemini
::> module odd_xor_even_and #(a, b) =
..    let fun isEven n = n % 2 = 0
..    in
..      #[Array.length(a); gen i => if isEven(i)
..                                  then a[:i:] & b[:i:]
..                                  else a[:i:] ^ b[:i:]]
..    end
val odd_xor_even_and : 'a[n] #* 'a[n] ~> 'a[n]
```

Modules may also be parameterized with software values.

**Example**
```Gemini
::> module xor_and <:freq:> #(a, b) =
..    let fun isAnd n = n % freq = 0
..    in
..      #[Array.length(a); gen i => if isAnd(i)
..                                  then a[:i:] & b[:i:]
..                                  else a[:i:] ^ b[:i:]]
..    end
val xor_and : int -> 'a[n] #* 'a[n] ~> 'a[n]
::> val double_xor_single_and = xor_and<:3:>
val double_xor_single_and : 'a[n] #* 'a[n] ~> 'a[n]
```
