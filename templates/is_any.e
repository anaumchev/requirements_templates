note
	description: "Behavior of all concepts with equality and copy."
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"
	date: "8/3/2018"

deferred class
	IS_ANY [G]
	--	To apply this template to your concept,
	--	inherit from this class with your concept for ``G''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

feature
	--	Deferred definitions to effect based on your concept.

	are_equal (v_1, v_2: G): BOOLEAN
			-- Define an equality relation over objects of your concept.
		deferred
		end

	copy_from_other (object, other: G)
			-- Define what it means to copy to an object of your concept from another one.
		deferred
		end

feature
	-- Axioms of equality.

	equality_reflexivity (v: G)
			--	Equality is reflexive.
		note
			EIS: "protocol=URI", "src=http://www.mathwords.com/r/reflexive_property.htm"
		do
		ensure
			are_equal (v, v)
		end

	equality_commutativity (v_1, v_2: G)
			--	Equality is symmetric.
		note
			EIS: "protocol=URI", "src=http://www.mathwords.com/s/symmetric_property.htm"
		require
			are_equal (v_1, v_2)
		do
		ensure
			are_equal (v_2, v_1)
		end

	equality_transitivity (v_1, v_2, v_3: G)
			--	Equality is transitive.
		note
			EIS: "protocol=URI", "src=http://www.mathwords.com/t/transitive_property.htm"
		require
			are_equal (v_1, v_2)
			are_equal (v_2, v_3)
		do
		ensure
			are_equal (v_1, v_3)
		end

feature
	--	Well-definedness axioms.

	copy_well_defined (object_1, object_2, other: G)
			-- Copying from one and the same object
			-- must not affect the equality relation.
		note
			EIS: "protocol=URI", "src=https://en.wikipedia.org/wiki/Well-defined"
		require
			are_equal (object_1, object_2)
		do
			copy_from_other (object_1, other)
			copy_from_other (object_2, other)
		ensure
			are_equal (object_1, object_2)
		end

end
