note
	description: "Reusable abstract data type specification of bag."
	description: "Taken from pages 2-3 of the ``The Algebraic Specification of Abstract Data Types'' article by J.V. Guttag and J.J. Horning."
	EIS: "protocol=URI", "src=https://link.springer.com/article/10.1007/BF00260922"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	SET_ADT [S, E]
	--	Sets ``S'' contain ``E'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``S'' and ``E''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit {NONE}
		--	Sets are much like bags.
		--	The name of the constructor is different.
		--	One of the bag axioms, ``a_4_1'', is irrelevant to sets.

	BAG_ADT [S, E]
		rename
			empty_bag as empty_set
		undefine
			a_4_1
		end

feature
	--	Abstract data type axioms.

	a_4_1 (set_1, set_2: S; element: E)
		do
			check
				assume: set_1 ~ set_2
			end
			insert (set_1, element)
			delete (set_1, element)
			delete (set_2, element)
			check
				assert: set_1 ~ set_2
			end
		end

end
