note
	description: "Reusable abstract data type specification of bounded stack."
	description: "Dound in the ``Abstract Data Types and Software Validation '' article by Guttag, Horowitz and Musser, p. 44."
	EIS: "protocol=URI", "src=https://pdfs.semanticscholar.org/372d/4f331d0a6cd5fb4ee0c04d4a0753b8eb659f.pdf"
	description: "Replaced errors with identity transformations."

deferred class
	BOUNDED_STACK_ADT [B, E]
	--	Bounded stacks ``B'' contain ``E'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``B'' and ``E''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	EQUALITY_ADT [B]

feature
	-- Deferred definitions.

	new_stack (lim: INTEGER): B
		deferred
		end

	push (stack: B; element: E)
		deferred
		end

	pop (stack: B)
		deferred
		end

	top (stack: B): E
		deferred
		end

	size (stack: B): INTEGER
		deferred
		end

	limit (stack: B): INTEGER
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1 (lim: INTEGER)
		local
			stack_1, stack_2: B
		do
			stack_1 := new_stack (lim)
			stack_2 := new_stack (lim)
			pop (stack_1)
			check
				stack_1 ~ stack_2
			end
		end

	frozen a_2 (stack_1, stack_2: B; element: E)
		require
			stack_1 ~ stack_2
			size (stack_1) < limit (stack_1)
		do
			push (stack_1, element)
			pop (stack_1)
		ensure
			stack_1 ~ stack_2
		end

	frozen a_3 (stack_1, stack_2: B; element: E)
		require
			stack_1 ~ stack_2
			size (stack_1) ~ limit (stack_1)
		do
			push (stack_1, element)
		ensure
			stack_1 ~ stack_2
		end

	frozen a_4 (lim: INTEGER; element: E)
		local
			stack: B
		do
			stack := new_stack (lim)
			check
				top (stack) /~ element
			end
		end

	frozen a_5 (stack: B; element: E)
		require
			size (stack) < limit (stack)
		do
			push (stack, element)
		ensure
			top (stack) ~ element
		end

	frozen a_6 (stack: B; element_1, element_2: E)
		require
			top (stack) ~ element_2
			size (stack) ~ limit (stack)
		do
			push (stack, element_1)
		ensure
			top (stack) ~ element_2
		end

	frozen a_7 (lim: INTEGER)
		local
			stack: B
		do
			stack := new_stack (lim)
			check
				limit (stack) ~ lim
			end
		end

	frozen a_8 (stack: B; element: E; old_limit: INTEGER)
		require
			limit (stack) ~ old_limit
			size (stack) ~ limit (stack)
		do
			push (stack, element)
		ensure
			limit (stack) ~ old_limit
		end

	frozen a_9 (lim: INTEGER)
		local
			stack: B
		do
			stack := new_stack (lim)
			check
				size (stack) ~ 0
			end
		end

	frozen a_10 (stack: B; element: E; old_size: INTEGER)
		require
			size (stack) ~ old_size
			size (stack) < limit (stack)
		do
			push (stack, element)
		ensure
			size (stack) ~ old_size + 1
		end

	frozen a_11 (stack: B; element: E; old_size: INTEGER)
		require
			size (stack) ~ old_size
			size (stack) ~ limit (stack)
		do
			push (stack, element)
		ensure
			size (stack) ~ old_size
		end

feature
	-- Well-definedness axioms.

	frozen new_stack_well_defined (lim: INTEGER)
		local
			stack_1, stack_2: B
		do
			stack_1 := new_stack (lim)
			stack_2 := new_stack (lim)
			check
				stack_1 /= stack_2
			end
			check
				stack_1 ~ stack_2
			end
		end

	frozen push_well_defined (stack_1, stack_2: B; element: E)
		require
			stack_1 ~ stack_2
		do
			push (stack_1, element)
			push (stack_2, element)
		ensure
			stack_1 ~ stack_2
		end

	frozen pop_well_defined (stack_1, stack_2: B)
		require
			stack_1 ~ stack_2
			stack_1 /= stack_2
		do
			pop (stack_1)
			pop (stack_2)
		ensure
			stack_1 ~ stack_2
		end

	frozen top_well_defined (stack_1, stack_2: B)
		require
			stack_1 ~ stack_2
		do
		ensure
			top (stack_1) ~ top (stack_2)
		end

	frozen size_well_defined (stack_1, stack_2: B)
		require
			stack_1 ~ stack_2
		do
		ensure
			size (stack_1) ~ size (stack_2)
		end

	frozen limit_well_defined (stack_1, stack_2: B)
		require
			stack_1 ~ stack_2
		do
		ensure
			limit (stack_1) ~ limit (stack_2)
		end

end
