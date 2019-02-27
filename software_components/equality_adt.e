note
	description: "Reusable abstract data type specification of a type with equality."

deferred class
	EQUALITY_ADT [G]
	--	To apply this template to your concept,
	--	inherit from this class with your concept for ``G''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

feature
	-- Abstract data type axioms.

	frozen equality_reflexivity (v: G)
			--	Equality is reflexive.
		note
			EIS: "src=http://www.mathwords.com/r/reflexive_property.htm"
		do
		ensure
			v ~ v
		end

	frozen equality_commutativity (v_1, v_2: G)
			--	Equality is symmetric.
		note
			EIS: "src=http://www.mathwords.com/s/symmetric_property.htm"
		require
			v_1 ~ v_2
		do
		ensure
			v_2 ~ v_1
		end

	frozen equality_transitivity (v_1, v_2, v_3: G)
			--	Equality is transitive.
		note
			EIS: "src=http://www.mathwords.com/t/transitive_property.htm"
		require
			v_1 ~ v_2
			v_2 ~ v_3
		do
		ensure
			v_1 ~ v_3
		end

end
