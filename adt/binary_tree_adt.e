note
	description: "Reusable abstract data type specification of binary tree."
	description: "Taken from ``The design of data type specifications'' article by Guttag, Horowitz and Musser, page 3."
	EIS: "protocol=URI", "src=http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.103.4685&rep=rep1&type=pdf"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	BINARY_TREE_ADT [B, I]
	--	Binary trees ``B'' contain ``I'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``B'' and ``I''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	EQUALITY_ADT [B]

feature
	-- Deferred definitions.

	empty_tree: B
		deferred
		end

	make (b_tree_left: B; item: I; b_tree_right: B): B
		deferred
		end

	is_empty_tree (b_tree: B): BOOLEAN
		deferred
		end

	left (b_tree: B): B
		deferred
		end

	data (b_tree: B): I
		deferred
		end

	right (b_tree: B): B
		deferred
		end

	is_in (b_tree: B; item: I): BOOLEAN
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1
		local
			b_tree: B
		do
			b_tree := empty_tree
			check
				is_empty_tree (b_tree)
			end
		end

	frozen a_2 (b_tree_left: B; item: I; b_tree_right: B)
		local
			b_tree: B
		do
			b_tree := make (b_tree_left, item, b_tree_right)
			check
				not is_empty_tree (b_tree)
			end
		end

	frozen a_3
		local
			b_tree_1, b_tree_2: B
		do
			b_tree_1 := empty_tree
			b_tree_2 := empty_tree
			check
				left (b_tree_1) ~ b_tree_2
			end
		end

	frozen a_4 (b_tree_left: B; item: I; b_tree_right: B)
		local
			b_tree: B
		do
			b_tree := make (b_tree_left, item, b_tree_right)
			check
				left (b_tree) ~ b_tree_left
			end
		end

	frozen a_5 (item: I)
		local
			b_tree: B
		do
			b_tree := empty_tree
			check
				data (b_tree) /~ item
			end
		end

	frozen a_6 (b_tree_left: B; item: I; b_tree_right: B)
		local
			b_tree: B
		do
			b_tree := make (b_tree_left, item, b_tree_right)
			check
				data (b_tree) ~ item
			end
		end

	frozen a_7
		local
			b_tree_1, b_tree_2: B
		do
			b_tree_1 := empty_tree
			b_tree_2 := empty_tree
			check
				right (b_tree_1) ~ b_tree_2
			end
		end

	frozen a_8 (b_tree_left: B; item: I; b_tree_right: B)
		local
			b_tree: B
		do
			b_tree := make (b_tree_left, item, b_tree_right)
			check
				right (b_tree) ~ b_tree_right
			end
		end

	frozen a_9 (item: I)
		local
			b_tree: B
		do
			b_tree := empty_tree
			check
				not is_in (b_tree, item)
			end
		end

	frozen a_10 (b_tree_left: B; item_1, item_2: I; b_tree_right: B)
		local
			b_tree: B
		do
			b_tree := make (b_tree_left, item_1, b_tree_right)
			check
				is_in (b_tree, item_2) = (item_1 ~ item_2 or is_in (b_tree_left, item_2) or is_in (b_tree_right, item_2))
			end
		end

feature
	-- Well-definedness axioms.

	frozen empty_tree_well_defined
		local
			b_tree_1, b_tree_2: B
		do
			b_tree_1 := empty_tree
			b_tree_2 := empty_tree
			check
				b_tree_1 /= b_tree_2
			end
			check
				b_tree_1 ~ b_tree_2
			end
		end

	frozen make_well_defined (b_tree_left: B; item: I; b_tree_right: B)
		local
			b_tree_1, b_tree_2: B
		do
			b_tree_1 := make (b_tree_left, item, b_tree_right)
			b_tree_2 := make (b_tree_left, item, b_tree_right)
			check
				b_tree_1 /= b_tree_2
			end
			check
				b_tree_1 ~ b_tree_2
			end
		end

	frozen is_empty_tree_well_defined (b_tree_1, b_tree_2: B)
		require
			b_tree_1 ~ b_tree_2
		do
		ensure
			is_empty_tree (b_tree_1) ~ is_empty_tree (b_tree_2)
		end

	frozen left_well_defined (b_tree_1, b_tree_2: B)
		require
			b_tree_1 ~ b_tree_2
		do
		ensure
			left (b_tree_1) ~ left (b_tree_2)
		end

	frozen data_well_defined (b_tree_1, b_tree_2: B)
		require
			b_tree_1 ~ b_tree_2
		do
		ensure
			data (b_tree_1) ~ data (b_tree_2)
		end

	frozen right_well_defined (b_tree_1, b_tree_2: B)
		require
			b_tree_1 ~ b_tree_2
		do
		ensure
			right (b_tree_1) ~ right (b_tree_2)
		end

	frozen is_in_well_defined (b_tree_1, b_tree_2: B; item: I)
		require
			b_tree_1 ~ b_tree_2
		do
		ensure
			is_in (b_tree_1, item) ~ is_in (b_tree_2, item)
		end

end
