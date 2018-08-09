note
	description: "Reusable abstract data type specification of list."
	description: "Follow the EIS link below for details."
	EIS: "protocol=URI", "src=https://en.wikipedia.org/wiki/List_(abstract_data_type)#Abstract_definition"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	LIST_ADT [L, E]
	--	Lists ``L'' contain ``E'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``L'' and ``E''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit {NONE}

	EQUALITY_ADT [L]

feature
	--	Deferred definitions.


	nil: L
		deferred
		end

	cons (l: L; e: E)
		deferred
		end

	first (l: L): E
		deferred
		end

	rest (l: L): L
		deferred
		end

feature
	--	Abstract data type axioms.


	a_1 (l: L; e: E)
		do
			cons (l, e)
		ensure
			first (l) ~ e
		end

	a_2 (l: L; e: E; old_l: L)
		require
			l ~ old_l
		do
			cons (l, e)
		ensure
			rest (l) ~ old_l
		end

feature

	nil_well_defined
		local
			list_1, list_2: L
		do
			list_1 := nil
			list_2 := nil
			check
				assert: list_1 /= list_2
			end
			check
				assert: list_1 ~ list_2
			end
		end

	cons_well_defined (list_1, list_2: L; element: E)
		require
			list_1 ~ list_2
		do
			cons (list_1, element)
			cons (list_2, element)
		ensure
			list_1 ~ list_2
		end

	first_well_defined (list_1, list_2: L)
		require
			list_1 ~ list_2
		do
		ensure
			first (list_1) ~ first (list_2)
		end

	rest_well_defined (list_1, list_2: L)
		require
			list_1 ~ list_2
		do
		ensure
			rest (list_1) ~ rest (list_2)
		end

end
