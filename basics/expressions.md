# Expressions

Expressions operate on values and subexpressions, and can be reduced to other expressions or values. These enable more complex computation to be performed on values.

### Software
We first describe the syntax for declaring software-typed expressions.

#### Operations
In Gemini, operators are analagous to functions except their application is infix and the arguments are the operands. Further, operator overloading is very rare, unlike in other languages. For example, the addition of integers and reals involve separate operators (`+` and `+.` respectively). This is common in strongly typed languages, since it enables the exact determination of types when performing inference.

A complete list of the operators and their semantic results is shown below.

##### Arithmetic

| Operator | Type | Syntax | Semantic Result |
| --- | --- | --- | --- |
| `~` | `int -> int` | `~e` | Negation of integer operand |
| `+` | `int * int -> int` | `e1 + e2` | Addition of both integer operands |
| `-` | `int * int -> int` | `e1 - e2` | Subtraction of right integer operand from left integer operand |
| `/` | `int * int -> int` | `e1 / e2` | Division of left integer operand by right integer operand, rounded towards negative infinity |
| `*` | `int * int -> int` | `e1 * e2` | Multiplication of both integer operands |
| `%` | `int * int -> int` | `e1 % e2` | Modulo of dividend left integer operand with divisor right integer operand |
| `+.` | `real * real -> real` | `e1 +. e2` | Addition of both real operands |
| `-.` | `real * real -> real` | `e1 -. e2` | Subtraction of right real operand from left real operand |
| `/.` | `real * real -> real` | `e1 /. e2` | Division of left real operand by right real operand |
| `*.` | `real * real -> real` | `e1 *. e2` | Multiplication of both real operands |

##### Conditional

| Operator | Type | Syntax | Semantic Result |
| --- | --- | --- | --- |
| `andalso` | `int * int -> int` | `e1 andalso e2` | Logical conjunction of both integer operands |
| `orelse` | `int * int -> int` | `e1 orelse e2` | Logical disjunction of both integer operands |
| `not` | `int -> int` | `not e1` | Logical complementation of integer operand |

##### Comparison

| Operator | Type | Syntax | Semantic Result |
| --- | --- | --- | --- |
| `=` | `int * int -> int` | `e1 = e2` | Equality of both operands |
| `<>` | `int * int -> int` | `e1 <> e2` | Non-equality of both operands |
| `>` | `int * int -> int` | `e1 > e2` | Left operand has a strictly greater order than right operand |
| `<` | `int * int -> int` | `e1 < e2` | Left operand has a strictly lesser order than right operand |
| `>=` | `int * int -> int` | `e1 >= e2` | Left operand has a greater or equal order compared to right operand |
| `<=` | `int * int -> int` | `e1 <= e2` | Left operand has a lesser or equal order compared to right operand |

##### List

| Operator | Type | Syntax | Semantic Result |
| --- | --- | --- | --- |
| `::` | `'a * 'a list -> 'a list` | `e1::e2` | Append left element operand to right list operand |

#### Accesses
Many of the types we have seen, such as records, tuples, references, and arrays, contain inner/element values that can be accessed.

To access a record, of either software- or hardware-type, we use the notation `#f e` where `f` is the field name and `e` is the record expression. Accessing tuples is similar, except `f` is an integer literal corresponding to the numerical index.

**Example**
```Gemini
::> val person = {name = "Aditya", age = 21}
val person = {name = "Aditya", age = 21} : {name: string, age: int}
::> #name person
val ans = "Aditya" : string
::> val stat = ("Usain Bolt", 9.58)
val stat = ("Usain Bolt", 9.58) : string * real
::> #2 stat
val ans = 9.58 : real
```

To access the value of a reference, a process also known as _dereferencing_, we use the operator `$`.

**Example**
```Gemini
::> val my_ref = ref 42
val my_ref = ref 42 : int ref
::> $my_ref
val ans = 42 : int
```

To access an element of an array, we use the subscript notation `e[:i:]` where `e` is the array to subscript and `i` is the integer-typed value denoting the index. Indices begin at `0` and end at `n-1`, where `n` is the size of the array.

**Example**
```Gemini
::> val array = #['b:0, 'b:1]
val array = #['b:0, 'b:1] : bit[2]
::> array[:0:]
val ans = 'b:0 : bit
```

> Note that there is no built-in way to index lists; if you wish to do so, use the library function [`List.nth`](library/standard?id=list).

#### Conditionals
Conditional expressions enable control flow within a program. There are two types of conditionals: if-then-else expressions and if-then expressions.

The former is declared with syntax `if e1 then e2 else e3`, where `e1` is an integer-typed value and `e2` and `e3` share the same type. The result is `e2` is `e1` is nonzero, else it is `e3`.

The latter is a special case where the else clause is omitted and implicitly returns the empty tuple.

**Example**
```Gemini
::> val x = 42
val x = 42 : int
::> if x then "correct" else "incorrect"
val ans = "correct" : string
::> if x then print("correct")
val ans = () : unit
```

#### Assignment
Assignment statements are used to set the values of references. The syntax is `e1 := e2`, where `e1` is the reference and `e2` is the value to which to update.

**Example**
```Gemini
::> val r = ref 41
val r = ref 41 : int ref
::> r := 42
val ans = () : unit
::> r
val r = ref 42 : int ref
```

#### Sequences
Sequence expressions allow multiple expressions to be evaluated for side-effect, with the last one being returned as the final value. They are written with the syntax `(e1; e2; en)` for `n` expressions.

**Example**
```Gemini
::> val r = ref 10
val r = ref 10 : int ref
::> (r := 42; $r)
val ans = 42 : int
```

As the example above shows, the value of `r` was updated for side-effect, and it was then returned.

#### Pattern-match
Pattern-match expressions are used as another, more general, form of control flow. A pattern-match expression consists of a test expression `e` and an ordered set of match-result pairs `(m1, r1), ..., (mn, rn)`.

The value of `e` is compared to each match expression in order and for the first `mi` that matches, the corresponding `ri` is returned. The syntax is `case e of m1 => r1 |: m2 => r2 |: mn => rn`.

The match expressions may contain literals or identifiers. In the case of the former, matches are determined by equality. In the case of the latter, the value is bound to the identifier and, in the case of a match, is visible in the corresponding result expression.

**Example**
```Gemini
::> val x = 42
val x = 42 : int
::> case x of 0 => "zero"
..         |: 1 => "one"
..         |: n => (String.concat(["neither: ", Int.toString(n)]))
val ans = "neither: 42" : string
```

#### Let-bindings
Let-bindings are used to bind identifiers with values or types and to then evaluate an expression in the augmented scope.

The syntax is `let <decs> in e end`, where `<decs>` is a series of zero or more declarations, which are discussed further in the section on [declarations](basics/declarations), and `e` is the expression to return.

**Example**
```Gemini
::> let
..     val name = "Aditya"
..     val age = 21
..  in
..    String.concat([name, " is ", Int.toString(age), " years old."])
..  end
val ans = "Aditya is 21 years old" : string
```