note
	description: "Reusable abstract data type specification of set."
	description: "Taken from pages 2-3 of the ``The Algebraic Specification of Abstract Data Types'' article by J.V. Guttag and J.J. Horning."
	EIS: "protocol=URI", "src=https://link.springer.com/article/10.1007/BF00260922"

deferred class
	SET_ADT [S, E]
	--	Sets ``S'' contain ``E'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``S'' and ``E''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	EQUALITY_ADT [S]

feature
	-- Deferred definitions.

	empty_set: S
		deferred
		end

	insert (set: S; element: E)
		deferred
		end

	delete (set: S; element: E)
		deferred
		end

	member_of (set: S; element: E): BOOLEAN
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1 (element: E)
		local
			set: S
		do
			set := empty_set
			check
				not member_of (set, element)
			end
		end

	frozen a_2_1 (set: S; element: E)
		do
			insert (set, element)
		ensure
			member_of (set, element)
		end

	frozen a_2_2 (set: S; element_1, element_2: E; old_member_of: BOOLEAN)
		require
			element_1 /~ element_2
			member_of (set, element_2) ~ old_member_of
		do
			insert (set, element_1)
		ensure
			member_of (set, element_2) ~ old_member_of
		end

	frozen a_3 (element: E)
		local
			set_1, set_2: S
		do
			set_1 := empty_set
			set_2 := empty_set
			delete (set_1, element)
			check
				set_1 ~ set_2
			end
		end

	frozen a_4_1 (set_1, set_2: S; element: E)
		require
			set_1 ~ set_2
		do
			insert (set_1, element)
			delete (set_1, element)
			delete (set_2, element)
		ensure
			set_1 ~ set_2
		end

	frozen a_4_2 (set_1, set_2: S; element_1, element_2: E)
		require
			set_1 ~ set_2
			element_1 /~ element_2
		do
			insert (set_1, element_1)
			delete (set_1, element_2)
			delete (set_2, element_2)
			insert (set_2, element_1)
		ensure
			set_1 ~ set_2
		end

feature
	-- Well-definedness axioms.

	frozen empty_set_well_defined
		local
			set_1, set_2: S
		do
			set_1 := empty_set
			set_2 := empty_set
			check
				assert: set_1 /= set_2
			end
			check
				assert: set_1 ~ set_2
			end
		end

	frozen insert_well_defined (set_1, set_2: S; element: E)
		require
			set_1 ~ set_2
		do
			insert (set_1, element)
			insert (set_2, element)
		ensure
			set_1 ~ set_2
		end

	frozen delete_well_defined (set_1, set_2: S; element: E)
		require
			set_1 ~ set_2
		do
			delete (set_1, element)
			delete (set_2, element)
		ensure
			set_1 ~ set_2
		end

	frozen member_of_well_defined (set_1, set_2: S; element: E)
		require
			set_1 ~ set_2
		do
		ensure
			member_of (set_1, element) ~ member_of (set_2, element)
		end

end
