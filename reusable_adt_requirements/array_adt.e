note
	description: "Reusable abstract data type specification of array."
	description: "Find a detailed description by the EIS link below."
	EIS: "protocol=URI", "src=https://www.cise.ufl.edu/class/cen6075/notes/Lecture34_fa16.ppt"
	description: "Follow the EIS link below for an example."
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/examples/is_array_array.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	ARRAY_ADT [A, E]
	--	Arrays ``A'' contain ``E'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``A'' and ``E''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit {NONE}

	EQUALITY_ADT [A]

feature
	-- Deferred definitions.

	make (new_first, new_last: INTEGER): A
			-- Define making up a new array from given indexes in terms of your concept.
		deferred
		end

	put (array: A; index: INTEGER; element: E)
			-- Define putting an indexed element into a new array in terms of your concept.
		deferred
		end

	first (array: A): INTEGER
			-- Define retrieving the index of the first element in an array in terms of your concept.
		deferred
		end

	last (array: A): INTEGER
			-- Define retrieving the index of the last element in an array in terms of your concept.
		deferred
		end

	eval (array: A; index: INTEGER): E
			-- Define retrieving an element of an array by index in terms of your concept.
		deferred
		end

feature
	-- Abstract data type axioms.

	a_1 (new_first, new_last: INTEGER)
			--	The index of the first element of a newly created array equals the
			--	value of the first argument supplied to the creation routine.
		local
			new_array: A
		do
			new_array := make (new_first, new_last)
			check
				first (new_array) ~ new_first
			end
		end

	a_2 (array: A; index: INTEGER; element: E; old_first: INTEGER)
			--	Putting an element by index to an array does not affect
			--	the index of the first element of the array.
		require
			first (array) ~ old_first
		do
			put (array, index, element)
		ensure
			first (array) ~ old_first
		end

	a_3 (new_first, new_last: INTEGER)
			--	The index of the last element of a newly created array equals the
			--	value of the second argument supplied to the creation routine.
		local
			new_array: A
		do
			new_array := make (new_first, new_last)
			check
				last (new_array) ~ new_last
			end
		end

	a_4 (array: A; index: INTEGER; element: E; old_last: INTEGER)
			--	Putting an element by index to an array does not affect
			--	the index of the last element of the array.
		require
			last (array) ~ old_last
		do
			put (array, index, element)
		ensure
			last (array) ~ old_last
		end

	a_5 (new_first, new_last: INTEGER; index: INTEGER; element: E)
		local
			array: A
		do
			array := make (new_first, new_last)
			check
				eval (array, index) /~ element
			end
		end

	a_6 (array: A; index_put, index_eval: INTEGER; element_1, element_2: E)
		require
			index_eval < first (array)
		do
			put (array, index_put, element_1)
		ensure
			eval (array, index_eval) /~ element_2
		end

	a_7 (array: A; index_put, index_eval: INTEGER; element_1, element_2: E)
		require
			index_eval > last (array)
		do
			put (array, index_put, element_1)
		ensure
			eval (array, index_eval) /~ element_2
		end

	a_8 (array: A; index: INTEGER; element: E)
			--	For an index from the interval between the indexes of the first and the last elements of an array,
			--	putting an element by the index to the array makes the element available for retrieval by the index.
		require
			index >= first (array)
			index <= last (array)
		do
			put (array, index, element)
		ensure
			eval (array, index) ~ element
		end

	a_9 (array: A; index_put: INTEGER; element: E; index_eval: INTEGER; old_element: E)
			--	For an index from the interval between the indexes of the first and the last elements of an array,
			--	putting an element by the index to the array does not affect the elements available by other indexes.
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
	-- Well-definedness axioms.

	make_well_defined (new_first, new_last: INTEGER)
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

	put_well_defined (array_1, array_2: A; index: INTEGER; element: E)
		require
			array_1 ~ array_2
		do
			put (array_1, index, element)
			put (array_2, index, element)
		ensure
			array_1 ~ array_2
		end

	first_well_defined (array_1, array_2: A)
		require
			array_1 ~ array_2
		do
		ensure
			first (array_1) ~ first (array_2)
		end

	last_well_defined (array_1, array_2: A)
		require
			array_1 ~ array_2
		do
		ensure
			last (array_1) ~ last (array_2)
		end

	eval_well_defined (array_1, array_2: A; index: INTEGER)
		require
			array_1 ~ array_2
		do
		ensure
			eval (array_1, index) ~ eval (array_2, index)
		end

end
