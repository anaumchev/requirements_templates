note
	description: "Reusable abstract data type specification of stack."
	description: "Found in ``The design of data type specifications'' by Guttag, Horowitz and Musser:"
	EIS: "src=http://tinyurl.com/yxmnv23w"
	description: "Found in ``Abstract Data Types and the Development of Data Structures'' by Guttag:"
	EIS: "src=http://tinyurl.com/y45o32hq"
	description: "Found in ``Programming with Abstract Data Types'' by Liskov and Zilles:"
	EIS: "src=http://tinyurl.com/y5dc5k9h"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/y62gkzyz"

deferred class
	STACK_ADT [S, T]
	--	Stacks ``S'' contain elements of ``T''.

inherit

	EQUALITY_ADT [S]

feature
	-- Deferred definitions.

	new: S
		deferred
		end

	push (s: S; t: T)
		deferred
		end

	pop (s: S)
		deferred
		end

	top (s: S): T
		deferred
		end

	is_new (s: S): BOOLEAN
		deferred
		end

	size (s: S): INTEGER
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1 (t: T; other: S)
		local
			s: S
		do
			s := new
			pop (s)
			check
				s /~ other
			end
		end

	frozen a_2 (t: T)
		local
			s: S
		do
			s := new
			check
				top (s) /~ t
			end
		end

	frozen a_3_empty (s_1, s_2: S)
		require
			s_1 ~ s_2
		local
			empty_: BOOLEAN
		do
			empty_ := is_new (s_1)
		ensure
			s_1 ~ s_2
		end

	frozen a_3_size (s_1, s_2: S)
		require
			s_1 ~ s_2
		local
			size_: INTEGER
		do
			size_ := size (s_1)
		ensure
			s_1 ~ s_2
		end

	frozen a_3_top (s_1, s_2: S)
		require
			s_1 ~ s_2
		local
			top_: T
		do
			top_ := top (s_1)
		ensure
			s_1 ~ s_2
		end

	frozen a_4_if (s: S)
		require
			size (s) ~ 0
		do
		ensure
			is_new (s)
		end

	frozen a_4_only_if (s: S)
		require
			is_new (s)
		do
		ensure
			size (s) ~ 0
		end

	frozen a_5 (s_1, s_2: S; t: T)
		require
			s_1 ~ s_2
		do
			push (s_1, t)
			pop (s_1)
		ensure
			s_1 ~ s_2
		end

	frozen a_6 (s: S; t: T)
		do
			push (s, t)
		ensure
			top (s) ~ t
		end

	frozen a_7 (s: S; t: T; old_size: INTEGER)
		require
			size (s) ~ old_size
		do
			push (s, t)
		ensure
			size (s) ~ old_size + 1
		end

	frozen a_8 (s: S; t: T; old_size: INTEGER)
		require
			size (s) ~ old_size
			not is_new (s)
		do
			pop (s)
		ensure
			size (s) ~ old_size - 1
		end

	frozen a_9 (s: S; t: T)
		do
			push (s, t)
		ensure
			not is_new (s)
		end

	frozen a_10
		local
			s: S
		do
			s := new
			check
				is_new (s)
			end
		end

	frozen a_11
		local
			s: S
		do
			s := new
			check
				size (s) ~ 0
			end
		end

feature
	-- Well-definedness axioms.

	frozen new_well_defined
		local
			s_1, s_2: S
		do
			s_1 := new
			s_2 := new
			check
				s_1 ~ s_2
			end
		end

	frozen push_well_defined (s_1, s_2: S; t: T)
		require
			s_1 ~ s_2
		do
			push (s_1, t)
			push (s_2, t)
		ensure
			s_1 ~ s_2
		end

	frozen pop_well_defined (s_1, s_2: S)
		require
			s_1 ~ s_2
			s_1 /= s_2
			not is_new (s_1)
			not is_new (s_2)
		do
			pop (s_1)
			pop (s_2)
		ensure
			s_1 ~ s_2
		end

	frozen top_well_defined (s_1, s_2: S)
		require
			s_1 ~ s_2
		do
		ensure
			top (s_1) ~ top (s_2)
		end

	frozen empty_well_defined (s_1, s_2: S)
		require
			s_1 ~ s_2
		do
		ensure
			is_new (s_1) ~ is_new (s_2)
		end

	frozen size_well_defined (s_1, s_2: S)
		require
			s_1 ~ s_2
		do
		ensure
			size (s_1) ~ size (s_2)
		end

end
