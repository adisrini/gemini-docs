# Standard Library

The standard library provides several useful built-in functions and modules.

---

#### `Core`
| Name | Type | Result |
| - | - | - |
| `print` | `string -> unit` | Write a string to the standard output |
| `read` | `string -> string` | Read the contents of a file |

---

#### `List`
| Name | Type | Result |
| - | - | - |
| `nth` | `('a list * int) -> 'a` | Return an element from a list given an index; raises an exception if the index is out of bounds |
| `length` | `'a list -> int` | Return the length of a list |
| `rev` | `'a list -> 'a list` | Return the reversed list |
| `map` | `('a -> 'b) -> 'a list -> 'b list` | Return a list after applying a function to each element |
| `filter` | `('a -> int) -> 'a list -> 'a list` | Return a list containing only elements that satisfy the predicate function |
| `foldl` | `('a * 'b -> 'b) -> 'b -> 'a list -> 'b` | Accumulate a value by iterating over a list from left to right |
| `foldr` | `('a * 'b -> 'b) -> 'b -> 'a list -> 'b` | Same as `foldl`, except iteration is right to left |
| `flatten` | `'a list list -> 'a list` | Flattens several lists into one |

---

#### `Int`
| Name | Type | Result |
| - | - | - |
| `toString` | `int -> string` | Return a string representation of an int |

---

#### `Real`
| Name | Type | Result |
| - | - | - |
| `floor` | `real -> int` | Return a real rounded towards negative infinity |
| `ceil` | `real -> int` | Return a real rounded towards positive infinity |
| `round` | `real -> int` | Return a real rounded towards the closest integer |
| `fromInt` | `int -> real` | Return a real converted from an integer |
| `toString` | `real -> string` | Return a string representation of a real |

---

#### `String`
| Name | Type | Result |
| - | - | - |
| `size` | `string -> int` | Return the number of characters in a string |
| `substring` | `(string * int * int) -> string` | Return the substring from a start to end location of a string; raises an exception if either index is out of bounds |
| `concat` | `string list -> string` | Return the concatenation of all strings in a list |
| `split` | `string -> string -> string list` | Return a list of strings resulting from splitting an original string over some delimiter |

---

#### `Array`
| Name | Type | Result |
| - | - | - |
| `toList` | `'a[n] sw -> 'a sw list` | Return a list of software-wrapped hardware values from a software-wrapped hardware array |
| `fromList` | `'a sw list -> 'a[n] sw` | Return a software-wrapped hardware array from a list of software-wrapped hardware values |

---

#### `BitArray`
| Name | Type | Result |
| - | - | - |
| `twosComp` | `bit[n] ~> bit[n]` | Return a circuit performing twos-complement of a bit array

---

#### `HW`
| Name | Type | Result |
| - | - | - |
| `dff` | `'a -> 'a @ 1` | Return a DFF circuit with a given hardware input |

