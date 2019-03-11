note
	description: "Reusable abstract data type specification of array."
	description: "Found in ``Abstract Data Types and Software Validation '' by Guttag, Horowitz and Musser:"
	EIS: "src=https://pdfs.semanticscholar.org/372d/4f331d0a6cd5fb4ee0c04d4a0753b8eb659f.pdf"
	description: "Found in ``Abstract Data Types and the Development of Data Structures'' by Guttag:"
	EIS: "src=http://tinyurl.com/y45o32hq"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/y69xc6fy"

deferred class
	ARRAY_ADT [A, E]
	--	Arrays ``A'' contain elements of ``E''.

inherit

	EQUALITY_ADT [A]

feature
	-- Deferred definitions.

	make (new_first, new_last: INTEGER): A
		deferred
		end

	put (array: A; index: INTEGER; element: E)
		deferred
		end

	first (array: A): INTEGER
		deferred
		end

	last (array: A): INTEGER
		deferred
		end

	eval (array: A; index: INTEGER): E
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1 (new_first, new_last: INTEGER)
		local
			new_array: A
		do
			new_array := make (new_first, new_last)
			check
				first (new_array) ~ new_first
			end
		end

	frozen a_2 (array: A; index: INTEGER; element: E; old_first: INTEGER)
		require
			first (array) ~ old_first
		do
			put (array, index, element)
		ensure
			first (array) ~ old_first
		end

	frozen a_3 (new_first, new_last: INTEGER)
		local
			new_array: A
		do
			new_array := make (new_first, new_last)
			check
				last (new_array) ~ new_last
			end
		end

	frozen a_4 (array: A; index: INTEGER; element: E; old_last: INTEGER)
		require
			last (array) ~ old_last
		do
			put (array, index, element)
		ensure
			last (array) ~ old_last
		end

	frozen a_5 (new_first, new_last: INTEGER; index: INTEGER; element: E)
		local
			array: A
		do
			array := make (new_first, new_last)
			check
				eval (array, index) /~ element
			end
		end

	frozen a_6 (array: A; index_put, index_eval: INTEGER; element_1, element_2: E)
		require
			index_eval < first (array)
		do
			put (array, index_put, element_1)
		ensure
			eval (array, index_eval) /~ element_2
		end

	frozen a_7 (array: A; index_put, index_eval: INTEGER; element_1, element_2: E)
		require
			index_eval > last (array)
		do
			put (array, index_put, element_1)
		ensure
			eval (array, index_eval) /~ element_2
		end

	frozen a_8 (array: A; index: INTEGER; element: E)
		require
			index >= first (array)
			index <= last (array)
		do
			put (array, index, element)
		ensure
			eval (array, index) ~ element
		end

	frozen a_9 (array: A; index_put: INTEGER; element: E; index_eval: INTEGER; old_element: E)
		require
			index_eval >= first (array)
			index_eval <= last (array)
			index_put /~ index_eval
			eval (array, index_eval) ~ old_element
		do
			put (array, index_put, element)
		ensure
			eval (array, index_eval) ~ old_element
		end

feature

	frozen make_well_defined (new_first, new_last: INTEGER)
		local
			array_1, array_2: A
		do
			array_1 := make (new_first, new_last)
			array_2 := make (new_first, new_last)
			check
				array_1 /= array_2
			end
			check
				array_1 ~ array_2
			end
		end

	frozen put_well_defined (array_1, array_2: A; index: INTEGER; element: E)
		require
			array_1 ~ array_2
		do
			put (array_1, index, element)
			put (array_2, index, element)
		ensure
			array_1 ~ array_2
		end

	frozen first_well_defined (array_1, array_2: A)
		require
			array_1 ~ array_2
		do
		ensure
			first (array_1) ~ first (array_2)
		end

	frozen last_well_defined (array_1, array_2: A)
		require
			array_1 ~ array_2
		do
		ensure
			last (array_1) ~ last (array_2)
		end

	frozen eval_well_defined (array_1, array_2: A; index: INTEGER)
		require
			array_1 ~ array_2
		do
		ensure
			eval (array_1, index) ~ eval (array_2, index)
		end

end
