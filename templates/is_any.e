note
	description: "Behavior of all concepts with equality and copy."
	description: "Follow the EIS link below for an example."
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/examples/is_array2_any.e"
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
			v ~ v
		end

	equality_commutativity (v_1, v_2: G)
			--	Equality is symmetric.
		note
			EIS: "protocol=URI", "src=http://www.mathwords.com/s/symmetric_property.htm"
		require
			v_1 ~ v_2
		do
		ensure
			v_2 ~ v_1
		end

	equality_transitivity (v_1, v_2, v_3: G)
			--	Equality is transitive.
		note
			EIS: "protocol=URI", "src=http://www.mathwords.com/t/transitive_property.htm"
		require
			v_1 ~ v_2
			v_2 ~ v_3
		do
		ensure
			v_1 ~ v_3
		end

feature
	--	ADT axioms

	a_0 (object, old_other, other: G)
		require
			other ~ old_other
		do
			copy_from_other (object, other)
		ensure
			object ~ old_other
		end

feature
	--	Well-definedness axioms.

	copy_well_defined (object_1, object_2, other: G)
			-- Copying from one and the same object
			-- must not affect the equality relation.
		note
			EIS: "protocol=URI", "src=https://en.wikipedia.org/wiki/Well-defined"
		require
			object_1 ~ object_2
		do
			copy_from_other (object_1, other)
			copy_from_other (object_2, other)
		ensure
			object_1 ~ object_2
		end

end
