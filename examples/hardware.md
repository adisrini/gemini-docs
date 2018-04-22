# Hardware Examples

#### Explicit Logic
This example showcases how software constructs can be used to express complex datatypes and structures with the ultimate goal of producing hardware. In particular, it demonstrates how fluidly hardware values can be wrapped, passed around in software constructs, and then unwrapped.

```Gemini
let
  sdatatype explicitLogic = AND of explicitLogic list
                         |: OR of explicitLogic list
                         |: XOR of explicitLogic list
                         |: NOT of explicitLogic
                         |: INP of bit sw

  fun NAND lst = NOT(AND lst)
  fun NOR lst = NOT(OR lst)

  fun toHW expl =
    let
      fun listToArray elist = sw #[List.length elist; gen i => (unsw (toHW (List.nth(elist, i))))]
    in
      case expl of
           INP(b) => b
        |: AND(lst) => sw (&-> (unsw (listToArray lst)))
        |: OR(lst) => sw (|-> (unsw (listToArray lst)))
        |: XOR(lst) => sw (^-> (unsw (listToArray lst)))
        |: NOT(el) => sw (! (unsw (toHW el)))
    end

  module mycircuit #(a, b, c) =
    let
      (* equivalent to if we had written !(c ^ (a & b)) *)
      val temp = NOT(XOR[INP(sw c), AND [INP(sw a), INP(sw b)]])
    in
      unsw (toHW temp)
    end

in
  mycircuit
end
```

---

#### N-bit Adder
This example demonstrates how Gemini allows programmers to do more with less code. A ripple-carry adder is declared that is parametrically polymorphic in the size of the arrays, allowing instantiation of any size with great ease.
```Gemini
let
  val numbits = 4

  module rca_helper #(ai : bit, bi : bit, cin : bit) =
    let
      val sum = ai ^ bi ^ cin
      val cout = (ai & bi) | (ai & cin) | (bi & cin)
    in
      #(cout, sum)
    end

  fun getSecond x = (sw #2(unsw x))

  module rca <:n:> #(a, b) =
    let
      val couts = #[n; gen i => if i = 0 then
                                  rca_helper #(a[:i:], b[:i:], 'b:0)
                                else
                                  rca_helper #(a[:i:], b[:i:], #1(couts[:i - 1:]))]
    in
      unsw Array.fromList(List.map getSecond (Array.toList(sw couts)))
    end

  module n_bit_rca #(a : bit[4], b : bit[4]) = rca <:numbits:> #(a, b)

in
  n_bit_rca
end
```