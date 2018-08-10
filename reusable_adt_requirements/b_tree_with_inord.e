note
	description: "Reusable abstract data type specification of binary tree with ``inord'' operation."
	description: "Taken from ``The design of data type specifications'' article by Guttag, Horowitz and Musser, page 3."
	EIS: "protocol=URI", "src=http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.103.4685&rep=rep1&type=pdf"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	B_TREE_WITH_INORD [B, I, Q, QS -> QUEUE_WITH_APPEND [Q, I]]
	--	Binary trees ``B'' contain ``I'' objects and may be represented as queues conforming to the ``QUEUE_WITH_APPEND'' specification.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``B'', ``I'', ``Q'', and ``QS''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit {NONE}

	B_TREE [B, I]

feature
	--	Deferred definitions.

	in_ord (b_tree: B): Q
		deferred
		end

feature
	--	Abstract data type axioms.

	a_11
		local
			b_tree: B
		do
			b_tree := empty_tree
			check
				in_ord (b_tree) ~ ({QS}).default.newq
			end
		end

	a_12 (b_tree_left: B; item: I; b_tree_right: B; q_left, q_right: Q)
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

	in_ord_well_defined (b_tree_1, b_tree_2: B)
		require
			b_tree_1 ~ b_tree_2
		do
		ensure
			in_ord (b_tree_1) ~ in_ord (b_tree_2)
		end

end
