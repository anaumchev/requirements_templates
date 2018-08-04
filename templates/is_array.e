note
	description: "Behavioral description of a concept that behaves like array."
	description: "Find a detailed description by the EIS linke below."
	EIS: "protocol=URI", "src=https://www.cise.ufl.edu/class/cen6075/notes/Lecture34_fa16.ppt"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"
	date: "8/3/2018"

deferred class
	IS_ARRAY [A, E, I -> PART_COMPARABLE]
	--	Arrays ``A'' contain ``E'' objects indexed by comparable ``I'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``A'', ``E'' and ``I''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	IS_ANY [A]
	--	Arrays feature an equality relation and a copy operation.

feature -- Definitions

	make (new_first, new_last: I): A
			-- Define making up a new array from given indexes in terms of your concept.
		deferred
		end

	put (array: A; index: I; element: E)
			-- Define putting an indexed element into a new array in terms of your concept.
		deferred
		end

	first (array: A): I
			-- Define retrieving the index of the first element in an array in terms of your concept.
		deferred
		end

	last (array: A): I
			-- Define retrieving the index of the last element in an array in terms of your concept.
		deferred
		end

	eval (array: A; index: I): E
			-- Define retrieving an element of an array by index in terms of your concept.
		deferred
		end

feature
	-- Array axioms.

	a_1 (new_first, new_last: I)
			--	The index of the first element of a newly created array equals the
			--	value of the first argument supplied to the creation routine.
		local
			new_array: A
		do
			new_array := make (new_first, new_last)
			check
				first (new_array) = new_first
			end
		end

	a_2 (array: A; index: I; element: E; old_first: I)
			--	Putting an element by index to an array does not affect
			--	the index of the first element of the array.
		require
			first (array) = old_first
		do
			put (array, index, element)
		ensure
			first (array) = old_first
		end

	a_3 (new_first, new_last: I)
			--	The index of the last element of a newly created array equals the
			--	value of the second argument supplied to the creation routine.
		local
			new_array: A
		do
			new_array := make (new_first, new_last)
			check
				last (new_array) = new_last
			end
		end

	a_4 (array: A; index: I; element: E; old_last: I)
			--	Putting an element by index to an array does not affect
			--	the index of the last element of the array.
		require
			last (array) = old_last
		do
			put (array, index, element)
		ensure
			last (array) = old_last
		end

	a_5 (array: A; index: I; element: E)
			--	For an index from the interval between the indexes of the first and the last elements of an array,
			--	putting an element by the index to the array makes the element available for retrieval by the index.
		require
			index >= first (array)
			index <= last (array)
		do
			put (array, index, element)
		ensure
			eval (array, index) = element
		end

	a_6 (array: A; index_put: I; element: E; index_eval: I; old_element: E)
			--	For an index from the interval between the indexes of the first and the last elements of an array,
			--	putting an element by the index to the array does not affect the elements available by other indexes.
		require
			index_eval >= first (array)
			index_eval <= last (array)
			index_put /= index_eval
			eval (array, index_eval) = old_element
		do
			put (array, index_put, element)
		ensure
			eval (array, index_eval) = old_element
		end

feature
	-- Well-definedness axioms.

	make_well_defined (new_first, new_last: I)
		local
			array_1, array_2: A
		do
			array_1 := make (new_first, new_last)
			array_2 := make (new_first, new_last)
			check
				array_1 /= array_2
			end
			check
				are_equal (array_1, array_2)
			end
		end

	put_well_defined (array_1, array_2: A; index: I; element: E)
		require
			are_equal (array_1, array_2)
		do
			put (array_1, index, element)
			put (array_2, index, element)
		ensure
			are_equal (array_1, array_2)
		end

	first_well_defined (array_1, array_2: A)
		require
			are_equal (array_1, array_2)
		do
		ensure
			first (array_1) = first (array_2)
		end

	last_well_defined (array_1, array_2: A)
		require
			are_equal (array_1, array_2)
		do
		ensure
			last (array_1) = last (array_2)
		end

	eval_well_defined (array_1, array_2: A; index: I)
		require
			are_equal (array_1, array_2)
		do
		ensure
			eval (array_1, index) = eval (array_2, index)
		end

end
