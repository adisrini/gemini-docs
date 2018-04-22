# Types

In the section talking about [what makes Gemini unique](overview/unique.md), we mentioned the existence of multiple kinds. Here, we denote the syntax for declaring each type, broken down by kind.

#### Software Types

| Type        | Syntax    |
| ----------- | --------- |
| integer     | `int`     |
| real        | `real`    |
| string      | `string`  |
| list of T<sub>S</sub>   | T<sub>S</sub> `list` |
| ref of T<sub>S</sub>    | T<sub>S</sub> `ref`  |
| software-wrapped T<sub>H</sub>    | T<sub>H</sub> `sw`  |
| labeled record | `{a: ` T<sub>S1</sub>, ..., `z: ` T<sub>Sn</sub>`}` |
| unlabeled record (tuple) | T<sub>S1</sub> `*` ... `*` T<sub>Sn</sub> |
| function from T<sub>S1</sub> to T<sub>S2</sub> | T<sub>S1</sub> `->` T<sub>S2</sub> |

#### Hardware Types

| Type        | Syntax    |
| ----------- | --------- |
| bit     | `bit`     |
| array of T<sub>H</sub>   | T<sub>H</sub> `[n]` |
| temporal of T<sub>H</sub>    | T<sub>H</sub> `@ n`  |
| labeled record | `#{a: ` T<sub>H1</sub>, ..., `z: ` T<sub>Hn</sub>`}` |
| unlabeled record (tuple) | T<sub>H1</sub> `#*` ... `#*` T<sub>Hn</sub> |

#### Module Types

| Type        | Syntax    |
| ----------- | --------- |
| module from T<sub>H1</sub> to T<sub>H2</sub> | T<sub>H1</sub> `~>` T<sub>H2</sub> |