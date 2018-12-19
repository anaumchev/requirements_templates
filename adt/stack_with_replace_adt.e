note
	description: "Reusable abstract data type specification of stack with ``replace'' operation."
	description: "From the ``Abstract Data Types and Software Validation '' article by Guttag, Horowitz and Musser, page 8."
	description: "Follow the EIS link below for details."
	EIS: "protocol=URI", "src=https://pdfs.semanticscholar.org/372d/4f331d0a6cd5fb4ee0c04d4a0753b8eb659f.pdf"

deferred class
	STACK_WITH_REPLACE_ADT [S, E]
	--	Stacks ``S'' contain ``E'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``S'' and ``E''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	STACK_ADT [S, E]
		rename
			new as new_stack,
			empty as is_new
		end
	--	The above article uses different names of the ``new'' and ``empty'' operations.

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
			stk_1 := new_stack
			stk_2 := new_stack
			pop (stk_1)
			check
				stk_1 ~ stk_2
			end
		end

	frozen a_13 (elm: E)
		local
			stk: S
		do
			stk := new_stack
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
