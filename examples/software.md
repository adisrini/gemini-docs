# Software Examples

#### Canonical Functions
The canonical functions can all be implemented very simply in Gemini with the use of pattern-matching. These are shown below.

#### `map`
```Gemini
fun map f x = case x of
                   [] => []
                |: a::rest => (f a)::(map f rest)
```

#### `filter`
```Gemini
fun filter f x = case x of
                      [] => []
                   |: a::rest => if (f a)
                                 then a::(filter f rest)
                                 else (filter f rest)
```

#### `foldl`
```Gemini
fun foldl f acc init = case init of
                            [] => acc
                         |: (x::rest) => (foldl f (f(x, acc)) rest)
```

#### `foldr`
```Gemini
fun foldr f acc init = case init of
                              [] => acc
                           |: (x::rest) => f(x, (foldr f acc rest))
```

#### `mapPartial`
```Gemini
fun mapPartial f x = case x of
                          [] => []
                       |: (a::rest) => (case (f a) of
                                             NONE => mapPartial f rest
                                          |: SOME v => v::(mapPartial f rest))
```

---

#### Tree Traversals
Leveraging recursive datatypes, we can define a tree and then perform any kind of traversal over it.

```Gemini
let
  sdatatype tree = NODE of (tree * tree * int)
                |: LEAF of int

  (*
          4
        /   \
       2     6
      / \   / \
     1  3  5   7

  *)

  val root =  NODE{
                NODE(
                  LEAF(1),
                  LEAF(3),
                  2
                ),
                NODE(
                  LEAF(5),
                  LEAF(7),
                  6
                ),
                4
              )

  fun inorder(node) =  case node of
                            NODE(l, r, v) => List.flatten([inorder(l), [v], inorder(r)])
                         |: LEAF(v) => [v]

  fun preorder(node) = case node of
                            NODE(l, r, v) => List.flatten([[v], preorder(l), preorder(r)])
                         |: LEAF(v) => [v]

  fun postorder(node) =  case node of
                              NODE(l, r, v) => List.flatten([postorder(l), postorder(r), [v]])
                           |: LEAF(v) => [v]

in
  {inorder = inorder(root), preorder = preorder(root), postorder = postorder(root)}
end
```

#### Arithmetic Interpreter
We can even write an interpreter in Gemini to parse files describing arithmetic expressions and evaluate them.