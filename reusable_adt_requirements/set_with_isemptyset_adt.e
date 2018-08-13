note
	description: "Reusable abstract data type specification of set with ``is_empty_set'' operation."
	description: "Taken from ``The design of data type specifications'' article by Guttag, Horowitz and Musser, page 4."
	EIS: "protocol=URI", "src=http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.103.4685&rep=rep1&type=pdf"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	SET_WITH_ISEMPTYSET_ADT [S, I]
	--	Sets ``S'' contain ``I'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``S'' and ``I''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	EQUALITY_ADT [S]

feature
	-- Deferred definitions.

	empty_set: S
		deferred
		end

	is_empty_set (set: S): BOOLEAN
		deferred
		end

	insert (set: S; item: I)
		deferred
		end

	del_set (set: S; item: I)
		deferred
		end

	has (set: S; item: I): BOOLEAN
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1
		local
			set: S
		do
			set := empty_set
			check
				is_empty_set (set)
			end
		end

	frozen a_2 (set: S; item: I)
		do
			insert (set, item)
		ensure
			not is_empty_set (set)
		end

	frozen a_3 (item: I)
		local
			set: S
		do
			set := empty_set
			check
				not has (set, item)
			end
		end

	frozen a_4 (set: S; item: I)
		do
			insert (set, item)
		ensure
			has (set, item)
		end

	frozen a_5 (set: S; item_1, item_2: I; old_has: BOOLEAN)
		require
			item_1 /~ item_2
			has (set, item_2) ~ old_has
		do
			insert (set, item_1)
		ensure
			has (set, item_2) ~ old_has
		end

	frozen a_6 (set: S; item: I)
		local
			e_set: S
		do
			e_set := empty_set
			del_set (e_set, item)
			check
				e_set /~ set
			end
		end

	frozen a_7 (set_1, set_2: S; item: I)
		require
			set_1 ~ set_2
		do
			insert (set_1, item)
			del_set (set_1, item)
			del_set (set_2, item)
		ensure
			set_1 ~ set_2
		end

	frozen a_8 (set_1, set_2: S; item_1, item_2: I)
		require
			item_1 /~ item_2
			set_1 ~ set_2
		do
			insert (set_1, item_1)
			del_set (set_1, item_2)
			del_set (set_2, item_2)
			insert (set_2, item_1)
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
				set_1 /= set_2
			end
			check
				set_1 ~ set_2
			end
		end

	frozen is_empty_set_well_defined (set_1, set_2: S)
		require
			set_1 ~ set_2
		do
		ensure
			is_empty_set (set_1) ~ is_empty_set (set_2)
		end

	frozen insert_well_defined (set_1, set_2: S; item: I)
		require
			set_1 ~ set_2
		do
			insert (set_1, item)
			insert (set_2, item)
		ensure
			set_1 ~ set_2
		end

	frozen del_set_well_defined (set_1, set_2: S; item: I)
		require
			set_1 ~ set_2
		do
			del_set (set_1, item)
			del_set (set_2, item)
		ensure
			set_1 ~ set_2
		end

	frozen has_well_defined (set_1, set_2: S; item: I)
		require
			set_1 ~ set_2
		do
		ensure
			has (set_1, item) ~ has (set_2, item)
		end

end
