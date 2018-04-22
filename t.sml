let
	datatype tree = NODE of {left: tree, right: tree, value: int}
		      | LEAF of int

	val root = NODE{
			left = NODE{
				left = LEAF(1),
				right = LEAF(3),
				value = 2
			},
			right = NODE{
				left = LEAF(5),
				right = LEAF(7),
				value = 6
			},
			value = 4
		}

	fun inorder(node) = case node of 
				 NODE{left, right, value} => inorder(left) @ [value] @ inorder(right)
			       | LEAF(v) => [v]

	fun preorder(node) = case node of
                                 NODE{left, right, value} => preorder(left) @ preorder(right) @ [value]
                               | LEAF(v) => [v]

	fun postorder(node) = case node of
                                 NODE{left, right, value} => postorder(left) @ postorder(right) @ [value]
                               | LEAF(v) => [v]

in
	inorder(root) @ preorder(root) @ postorder(root)
end
