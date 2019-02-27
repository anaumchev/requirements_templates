note
	description: "Reusable abstract data type specification of a type with a copy operation."

deferred class
	COPY_ADT [G]

inherit

	EQUALITY_ADT [G]

feature
	-- Deferred definitions.

	copy_from_other (object, other: G)
			-- Define what it means to copy to an object of your concept from another one.
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_0 (object, old_other, other: G)
		require
			other ~ old_other
		do
			copy_from_other (object, other)
		ensure
			object ~ old_other
		end

feature
	-- Well-definedness axioms.

	frozen copy_well_defined (object_1, object_2, other: G)
			-- Copying from one and the same object
			-- must not affect the equality relation.
		note
			EIS: "src=https://en.wikipedia.org/wiki/Well-defined"
		require
			object_1 ~ object_2
		do
			copy_from_other (object_1, other)
			copy_from_other (object_2, other)
		ensure
			object_1 ~ object_2
		end

end
