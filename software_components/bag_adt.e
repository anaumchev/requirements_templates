note
	description: "Reusable abstract data type specification of bag."
	description: "Found in ``The Algebraic Specification of Abstract Data Types'' by Guttag and Horning:"
	EIS: "src=https://link.springer.com/article/10.1007/BF00260922"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/yyensvjt"

deferred class
	BAG_ADT [B, E]
	--	Bags ``B'' contain elements of ``E''.

inherit

	EQUALITY_ADT [B]

feature
	-- Deferred definitions.

	empty_bag: B
		deferred
		end

	insert (bag: B; element: E)
		deferred
		end

	delete (bag: B; element: E)
		deferred
		end

	member_of (bag: B; element: E): BOOLEAN
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1 (element: E)
		local
			bag: B
		do
			bag := empty_bag
			check
				not member_of (bag, element)
			end
		end

	frozen a_2_1 (bag: B; element: E)
		do
			insert (bag, element)
		ensure
			member_of (bag, element)
		end

	frozen a_2_2 (bag: B; element_1, element_2: E; old_member_of: BOOLEAN)
		require
			element_1 /~ element_2
			member_of (bag, element_2) ~ old_member_of
		do
			insert (bag, element_1)
		ensure
			member_of (bag, element_2) ~ old_member_of
		end

	frozen a_3 (element: E)
		local
			bag_1, bag_2: B
		do
			bag_1 := empty_bag
			bag_2 := empty_bag
			delete (bag_1, element)
			check
				bag_1 ~ bag_2
			end
		end

	frozen a_4_1 (bag_1, bag_2: B; element: E)
		do
			check
				assume: bag_1 ~ bag_2
			end
			insert (bag_1, element)
			delete (bag_1, element)
			check
				assert: bag_1 ~ bag_2
			end
		end

	frozen a_4_2 (bag_1, bag_2: B; element_1, element_2: E)
		require
			bag_1 ~ bag_2
			element_1 /~ element_2
		do
			insert (bag_1, element_1)
			delete (bag_1, element_2)
			delete (bag_2, element_2)
			insert (bag_2, element_1)
		ensure
			bag_1 ~ bag_2
		end

feature
	-- Well-definedness axioms.

	frozen empty_bag_well_defined
		local
			bag_1, bag_2: B
		do
			bag_1 := empty_bag
			bag_2 := empty_bag
			check
				assert: bag_1 /= bag_2
			end
			check
				assert: bag_1 ~ bag_2
			end
		end

	frozen insert_well_defined (bag_1, bag_2: B; element: E)
		require
			bag_1 ~ bag_2
		do
			insert (bag_1, element)
			insert (bag_2, element)
		ensure
			bag_1 ~ bag_2
		end

	frozen delete_well_defined (bag_1, bag_2: B; element: E)
		require
			bag_1 ~ bag_2
		do
			delete (bag_1, element)
			delete (bag_2, element)
		ensure
			bag_1 ~ bag_2
		end

	frozen member_of_well_defined (bag_1, bag_2: B; element: E)
		require
			bag_1 ~ bag_2
		do
		ensure
			member_of (bag_1, element) ~ member_of (bag_2, element)
		end

end
