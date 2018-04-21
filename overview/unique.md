# What makes Gemini unique?

In addition to providing a high-level abstraction for describing hardware, Gemini is proof that unconventional programming language designs are possible to implement in practice. A few of these are:

#### Multiple Kinds

Similarly to how values have types such as `int`, `string`, or `real`, types also have types, referred to as _kinds_. In most programming language, there is a single atomic kind written `*` and pronounced "type", and a constructor written `=>`. The aforementioned types are all _proper_ and have kind `*`. However, some types, such as `list` are not types by themselves but _type constructors_. That is, they require another type, such as `int` in order to construct a valid type, in this case `int list`. These types have kind `* => *` and can be considered as type-level functions.

In Gemini, we take the idea of kinds one level further by having not one, but three kinds: `S`, `H`, and `M` denoting the software kind, hardware kind, and module kind respectively. The following grammar lists the member types of each kind.

```
S    ::= int
      |  real
      |  string
      |  T(S) list
      |  {l1: T(S), ..., ln: T(S)}
      |  T(S) ref
      |  T(H) sw
      |  C_i T(S)
      |  T(S) -> T(S)

H    ::= bit
      |  T(H) [n]
      |  T(H) @ n
      |  #{l1: T(H), ..., ln: T(H)}

M    ::= T(H) ~> T(H)
```

Gemini's kind system was designed intentionally with multiple kinds in order to prohibit certain types from existing. For example, it is not possible to declare higher-order modules, or a list of hardware values. The kinding system ensures that compilation results in an expressible Verilog module.

#### Value-Parameterized Types

As mentioned above, type constructors can be parameterized by another type. However, some types in Gemini are parameterized by values. For example, an array is itself not a type until parameterized by an integer denoting it's size. Two arrays of differing sizes are different types, much like how an `int list` is different from a `string list`. This allows modules to be parametrically polymorphic by array size.

Because of the way Gemini is compiled, it is possible to determine the value parameterizing a type at compile-time since software expressions get completely evaluated before processing the resulting program consisting only of hardware values.

#### Time as an Element

In many electronic circuits, the concept of time is paramount to its functionality. Memory elements such as flip-flops are clocked and the data they produce is dependent on a certain time delay. As such, Gemini models time as a type in order to help the programmer understand these delays and ensure that their module is synchronized correctly.

Few other programming languages capture time as a language element since software executes sequentially.