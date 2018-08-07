note
	description: "Summary description for {IS_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LIST_ADT [L, E]

inherit

	EQUALITY_ADT [L]

feature

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

end
