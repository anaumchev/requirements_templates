note
	description: "Reusable abstract data type specification of binary tree with ``inord'' operation."
	description: "Found in ``The design of data type specifications'' by Guttag, Horowitz and Musser:"
	EIS: "src=http://tinyurl.com/yxmnv23w"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/y3peoll5"

deferred class
	BINARY_TREE_WITH_INORD_ADT [B, I, Q, QS -> QUEUE_WITH_APPEND_ADT [Q, I]]
	--	Binary trees ``B'' contain elements of ``I''.
	--  They rely on queues ``Q'' with elements of ``I'' conforming to the
	--  ``QUEUE_WITH_APPEND_ADT'' specification.

inherit

	BINARY_TREE_ADT [B, I]

feature
	-- Deferred definitions.

	in_ord (b_tree: B): Q
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_11
		local
			b_tree: B
		do
			b_tree := empty_tree
			check
				in_ord (b_tree) ~ ({QS}).default.newq
			end
		end

	frozen a_12 (b_tree_left: B; item: I; b_tree_right: B; q_left, q_right: Q)
		require
			in_ord (b_tree_left) ~ q_left
			in_ord (b_tree_right) ~ q_right
		local
			b_tree: B
		do
			b_tree := make (b_tree_left, item, b_tree_right)
			({QS}).default.addq (q_left, item)
			({QS}).default.appendq (q_left, q_right)
			check
				in_ord (b_tree) ~ q_left
			end
		end

feature
	-- Well-definedness axioms.

	frozen in_ord_well_defined (b_tree_1, b_tree_2: B)
		require
			b_tree_1 ~ b_tree_2
		do
		ensure
			in_ord (b_tree_1) ~ in_ord (b_tree_2)
		end

end








