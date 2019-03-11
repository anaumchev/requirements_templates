note
	description: "Reusable abstract data type specification of stack with ``replace'' operation."
	description: "Found in ``Abstract Data Types and Software Validation '' by Guttag, Horowitz and Musser:"
	EIS: "src=https://pdfs.semanticscholar.org/372d/4f331d0a6cd5fb4ee0c04d4a0753b8eb659f.pdf"
	description: "Found in ``Abstract Data Types and the Development of Data Structures'' by Guttag:"
	EIS: "src=http://tinyurl.com/y45o32hq"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/y4ql2lgn"

deferred class
	STACK_WITH_REPLACE_ADT [S, E]
	--	Stacks ``S'' with replacing contain elements of ``E''.

inherit

	STACK_ADT [S, E]

feature
	-- Deferred definitions.

	replace (stk: S; elm: E)
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_12
		local
			stk_1, stk_2: S
		do
			stk_1 := new
			stk_2 := new
			pop (stk_1)
			check
				stk_1 ~ stk_2
			end
		end

	frozen a_13 (elm: E)
		local
			stk: S
		do
			stk := new
			check
				top (stk) /~ elm
			end
		end

	frozen a_14 (stk_1, stk_2: S; elm: E)
		require
			stk_1 ~ stk_2
		do
			replace (stk_1, elm)
			pop (stk_2)
			push (stk_2, elm)
		ensure
			stk_1 ~ stk_2
		end

feature
	-- Well-definedness axioms.

	frozen replace_well_defined (stk_1, stk_2: S; elm: E)
		require
			stk_1 ~ stk_2
		do
			replace (stk_1, elm)
			replace (stk_2, elm)
		ensure
			stk_1 ~ stk_2
		end

end
