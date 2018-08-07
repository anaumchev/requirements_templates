note
	description: "Summary description for {IS_ARRAY2_ARRAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IS_ARRAY_ARRAY [G]

inherit

	ARRAY_ADT [ARRAY [G], G]

	IS_ARRAY_WITH_COPY [G]

feature

	make (new_first, new_last: INTEGER): ARRAY [G]
			-- Define making up a new array from given indexes in terms of your concept.
		do
			create Result.make_filled (({G}).default, new_first, new_last)
		end

	put (array: ARRAY [G]; index: INTEGER; element: G)
			-- Define putting an indexed element into a new array in terms of your concept.
		do
			array.put (element, index)
		end

	first (array: ARRAY [G]): INTEGER
			-- Define retrieving the index of the first element in an array in terms of your concept.
		do
			Result := array.lower
		end

	last (array: ARRAY [G]): INTEGER
			-- Define retrieving the index of the last element in an array in terms of your concept.
		do
			Result := array.upper
		end

	eval (array: ARRAY [G]; index: INTEGER): G
			-- Define retrieving an element of an array by index in terms of your concept.
		do
			Result := array [index]
		end

end
