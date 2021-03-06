note
	description: "Reusable abstract data type specification of list."
	description: "Found in Wikipedia:"
	EIS: "src=http://tinyurl.com/yxu9yze9"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/yym548bu"

deferred class
	LIST_ADT [L, E]
	--	Lists ``L'' contain elements of ``E''.

inherit

	EQUALITY_ADT [L]

feature
	-- Deferred definitions.

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
	-- Abstract data type axioms.

	frozen a_1 (l: L; e: E)
		do
			cons (l, e)
		ensure
			first (l) ~ e
		end

	frozen a_2 (l: L; e: E; old_l: L)
		require
			l ~ old_l
		do
			cons (l, e)
		ensure
			rest (l) ~ old_l
		end

feature
	-- Well-definedness axioms.

	frozen nil_well_defined
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

	frozen cons_well_defined (list_1, list_2: L; element: E)
		require
			list_1 ~ list_2
		do
			cons (list_1, element)
			cons (list_2, element)
		ensure
			list_1 ~ list_2
		end

	frozen first_well_defined (list_1, list_2: L)
		require
			list_1 ~ list_2
		do
		ensure
			first (list_1) ~ first (list_2)
		end

	frozen rest_well_defined (list_1, list_2: L)
		require
			list_1 ~ list_2
		do
		ensure
			rest (list_1) ~ rest (list_2)
		end

end
