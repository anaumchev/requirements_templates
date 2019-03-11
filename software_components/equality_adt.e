note
	description: "Reusable abstract data type specification of a type with equality."
	description: "Found in Wikipedia:"
	EIS: "src=http://tinyurl.com/pfafsvd"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/yxb98wrq"

deferred class
	EQUALITY_ADT [G]
	-- Elements of ``G'' form an equivalence relation.

feature
	-- Abstract data type axioms.

	frozen equality_reflexivity (v: G)
		do
		ensure
			v ~ v
		end

	frozen equality_commutativity (v_1, v_2: G)
		require
			v_1 ~ v_2
		do
		ensure
			v_2 ~ v_1
		end

	frozen equality_transitivity (v_1, v_2, v_3: G)
		require
			v_1 ~ v_2
			v_2 ~ v_3
		do
		ensure
			v_1 ~ v_3
		end

end
