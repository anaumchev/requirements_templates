note
	description: "Reusable abstract data type specification of stting."
	description: "Found in ``The design of data type specifications'' by Guttag, Horowitz and Musser:"
	EIS: "src=http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.103.4685&rep=rep1&type=pdf"

deferred class
	STRING_ADT [S, C]
	--	Strings ``S'' contain ``C'' characters.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``S'' and ``C''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	EQUALITY_ADT [S]

feature
	-- Deferred definitions.

	null: S
		deferred
		end

	is_null (string: S): BOOLEAN
		deferred
		end

	len (string: S): INTEGER
		deferred
		end

	add_char (string: S; character: C)
		deferred
		end

	concat (string_1, string_2: S)
		deferred
		end

	substr (string: S; start, finish: INTEGER): S
		deferred
		end

	index (string_1, string_2: S): INTEGER
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1
		local
			string: S
		do
			string := null
			check
				is_null (string)
			end
		end

	frozen a_2 (string: S; character: C)
		do
			add_char (string, character)
			check
				not is_null (string)
			end
		end

	frozen a_3
		local
			string: S
		do
			string := null
			check
				len (string) ~ 0
			end
		end

	frozen a_4 (string: S; character: C; old_len: INTEGER)
		require
			len (string) ~ old_len
		do
			add_char (string, character)
		ensure
			len (string) ~ old_len + 1
		end

	frozen a_5 (string_1, string_2: S)
		require
			string_1 ~ string_2
		local
			string: S
		do
			string := null
			concat (string_1, string)
		ensure
			string_1 ~ string_2
		end

	frozen a_6 (string_1, string_2, string_3, string_4: S; character: C)
		require
			string_1 ~ string_4
			string_2 ~ string_3
		do
			add_char (string_1, character)
			concat (string_2, string_1)
			concat (string_3, string_4)
			add_char (string_3, character)
		ensure
			string_2 ~ string_3
		end

	frozen a_7 (start, finish: INTEGER)
		local
			string_1, string_2: S
		do
			string_1 := null
			string_2 := null
			check
				substr (string_2, start, finish) ~ string_1
			end
		end

	frozen a_8 (string: S; start, finish: INTEGER; character: C)
		require
			finish ~ 0
		local
			null_string: S
		do
			null_string := null
			add_char (string, character)
			check
				substr (string, start, finish) ~ null_string
			end
		end

	frozen a_9 (string_1, string_2: S; start, finish: INTEGER; character: C)
		require
			finish /~ 0
			finish ~ len (string_1) - start + 2
			string_2 ~ substr (string_1, start, finish - 1)
		do
			add_char (string_1, character)
			add_char (string_2, character)
		ensure
			string_2 ~ substr (string_1, start, finish)
		end

	frozen a_10 (string_1, string_2: S; start, finish: INTEGER; character: C)
		require
			finish /~ 0
			finish /~ len (string_1) - start + 2
			string_1 ~ string_2
		do
			add_char (string_1, character)
		ensure
			substr (string_1, start, finish) ~ substr (string_2, start, finish)
		end

	frozen a_11 (string: S)
		local
			null_string: S
		do
			null_string := null
			check
				index (string, null_string) ~ len (string) + 1
			end
		end

	frozen a_12 (string: S; character: C)
		local
			null_string: S
		do
			null_string := null
			add_char (string, character)
			check
				index (null_string, string) ~ 0
			end
		end

	frozen a_13 (string_1, string_2, string_3: S; character_1, character_2: C)
		require
			string_1 ~ string_3
		do
			add_char (string_1, character_1)
			add_char (string_2, character_2)
			check
				assume: index (string_3, string_2) /~ 0
			end
		ensure
			index (string_1, string_2) ~ index (string_3, string_2)
		end

	frozen a_14 (string_1, string_2, string_3, string_4: S; character_1, character_2: C)
		require
			string_1 ~ string_3
			string_2 ~ string_4
			character_1 ~ character_2
			index (string_1, string_2) ~ len (string_1) - len (string_2) + 1
		do
			add_char (string_1, character_1)
			add_char (string_2, character_2)
			check
				assume: index (string_3, string_2) ~ 0
			end
		ensure
			index (string_1, string_2) ~ index (string_3, string_4)
		end

	frozen a_15 (string_1, string_2, string_3: S; character_1, character_2: C)
		require
			string_1 ~ string_3
			character_1 /~ character_2
		do
			add_char (string_1, character_1)
			add_char (string_2, character_2)
			check
				assume: index (string_3, string_2) ~ 0
			end
		ensure
			index (string_1, string_2) ~ 0
		end

	frozen a_16 (string_1, string_2, string_3: S; character_1, character_2: C)
		require
			string_1 ~ string_3
			index (string_1, string_2) /~ len (string_1) - len (string_2) + 1
		do
			add_char (string_1, character_1)
			add_char (string_2, character_2)
			check
				assume: index (string_3, string_2) ~ 0
			end
		ensure
			index (string_1, string_2) ~ 0
		end

feature
	-- Well-definedness axioms.

	frozen null_well_defined
		local
			string_1, string_2: S
		do
			string_1 := null
			string_2 := null
			check
				string_1 /= string_2
			end
			check
				string_1 ~ string_2
			end
		end

	frozen is_null_well_defined (string_1, string_2: S)
		require
			string_1 ~ string_2
		do
		ensure
			is_null (string_1) ~ is_null (string_2)
		end

	frozen len_well_defined (string_1, string_2: S)
		require
			string_1 ~ string_2
		do
		ensure
			len (string_1) ~ len (string_2)
		end

	frozen add_char_well_defined (string_1, string_2: S; character: C)
		require
			string_1 ~ string_2
		do
			add_char (string_1, character)
			add_char (string_2, character)
		ensure
			string_1 ~ string_2
		end

	frozen concat_well_defined (string_1, string_2, string: S)
		require
			string_1 ~ string_2
		do
			concat (string_1, string)
			concat (string_2, string)
		ensure
			string_1 ~ string_2
		end

	frozen substr_well_defined (string_1, string_2: S; start, finish: INTEGER)
		require
			string_1 ~ string_2
		do
		ensure
			substr (string_1, start, finish) ~ substr (string_2, start, finish)
		end

	frozen index_well_defined (string_1, string_2, string: S)
		require
			string_1 ~ string_2
		do
		ensure
			index (string_1, string) ~ index (string_2, string)
		end

end
