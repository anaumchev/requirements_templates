note
	description: "Reusable abstract data type specification of stack."
	description: "Find a detailed description by the EIS link below."
	EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide02.html"
	description: "Also found in the ``Abstract Data Types and the Development of Data Structures'' article by John Guttag, page 2."
	EIS: "protocol=URI", "src=http://www.unc.edu/~stotts/comp723/guttagADT77.pdf"
	description: "Also found in the ``Abstract Data Types and Software Validation '' article by Guttag, Horowitz and Musser, p. 17."
	EIS: "protocol=URI", "src=https://pdfs.semanticscholar.org/372d/4f331d0a6cd5fb4ee0c04d4a0753b8eb659f.pdf"
	description: "Also found in ``THE DESIGN OF DATA TYPE SPECIFICATIONS'' article by Guttag, Horowitz and Musser, p. 17."
	EIS: "protocol=URI", "src=http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.103.4685&rep=rep1&type=pdf"
	description: "Follow the EIS link below for an example."
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/examples/is_linked_stack_stack.e"

deferred class
	STACK_ADT [S, T]
	--	Stacks ``S'' contain ``T'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``S'' and ``T''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	EQUALITY_ADT [S]

feature
	-- Deferred definitions.

	new: S
			-- Define a new stack in terms of your concept.
		deferred
		end

	push (s: S; t: T)
			-- Define what it means to push a stack in terms of your concept.
		deferred
		end

	pop (s: S)
			-- Define what it means to pop a stack in terms of your concept.
		deferred
		end

	top (s: S): T
			-- Define a stack's top in terms of your concept.
		deferred
		end

	empty (s: S): BOOLEAN
			-- Define a stack's emptyness in terms of your concept.
		deferred
		end

	size (s: S): INTEGER
			-- Define a stack's size in terms of your concept.
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1 (t: T; other: S)
		note
			EIS: "protocol=URI", "src=http://www.unc.edu/~stotts/comp723/guttagADT77.pdf"
		local
			s: S
		do
			s := new
			pop (s)
			check
				s /~ other
			end
		end

	frozen a_2 (t: T)
		note
			EIS: "protocol=URI", "src=http://www.unc.edu/~stotts/comp723/guttagADT77.pdf"
		local
			s: S
		do
			s := new
			check
				top (s) /~ t
			end
		end

	frozen a_3_empty (s_1, s_2: S)
			-- Querying a stack for emptyness does not change its equivalence class.
		require
			s_1 ~ s_2
		local
			empty_: BOOLEAN
		do
			empty_ := empty (s_1)
		ensure
			s_1 ~ s_2
		end

	frozen a_3_size (s_1, s_2: S)
			--	Querying a stack for size does not change its equivalence class.
		require
			s_1 ~ s_2
		local
			size_: INTEGER
		do
			size_ := size (s_1)
		ensure
			s_1 ~ s_2
		end

	frozen a_3_top (s_1, s_2: S)
			--	Querying a stack for top does not change its equivalence class.
		require
			s_1 ~ s_2
		local
			top_: T
		do
			top_ := top (s_1)
		ensure
			s_1 ~ s_2
		end

	frozen a_4_if (s: S)
			--	A stack is empty if its' size is zero.
		require
			size (s) ~ 0
		do
		ensure
			empty (s)
		end

	frozen a_4_only_if (s: S)
			--	A stack is empty only if its' size is zero.
		require
			empty (s)
		do
		ensure
			size (s) ~ 0
		end

	frozen a_5 (s_1, s_2: S; t: T)
			--	Pushing and then popping a stack does not change its' equivalence class.
		require
			s_1 ~ s_2
		do
			push (s_1, t)
			pop (s_1)
		ensure
			s_1 ~ s_2
		end

	frozen a_6 (s: S; t: T)
			--	Pushing an element on a stack makes it the top element.
		do
			push (s, t)
		ensure
			top (s) ~ t
		end

	frozen a_7 (s: S; t: T; old_size: INTEGER)
			--	Pushing a stack increases its size by 1.
		require
			size (s) ~ old_size
		do
			push (s, t)
		ensure
			size (s) ~ old_size + 1
		end

	frozen a_8 (s: S; t: T; old_size: INTEGER)
			--	Popping a non-empty stack decreases its size by 1.
		require
			size (s) ~ old_size
			not empty (s)
		do
			pop (s)
		ensure
			size (s) ~ old_size - 1
		end

	frozen a_9 (s: S; t: T)
			--	Pushing a stack makes it non-empty.
		do
			push (s, t)
		ensure
			not empty (s)
		end

	frozen a_10
			--	A newly created stack is empty.
		local
			s: S
		do
			s := new
			check
				empty (s)
			end
		end

	frozen a_11
			--	A newly created stack has zero size.
		local
			s: S
		do
			s := new
			check
				size (s) ~ 0
			end
		end

feature
	-- Theorems.

	frozen theorem_1 (s: S; t: T; k, n: INTEGER)
			--	Pushing a stack k times increases its size by k.
			--	Follow the EIS link below for details.
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide04.html"
		require
			size (s) ~ n
			k >= 1
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i ~ k
			loop
				push (s, t)
				i := i + 1
			end
		ensure
			size (s) ~ n + k
		end

	frozen theorem_2 (s: S; k, n: INTEGER)
			--	Popping a stack k times decreases its size by k.
			--	Follow the EIS link below for details.
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide04.html"
		require
			size (s) ~ n
			k >= 1
			k <= n
			not empty (s)
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i ~ k
			loop
				pop (s)
				i := i + 1
			end
		ensure
			size (s) ~ n - k
		end

feature
	-- Well-definedness axioms.

	frozen new_well_defined
		local
			s_1, s_2: S
		do
			s_1 := new
			s_2 := new
			check
				s_1 ~ s_2
			end
		end

	frozen push_well_defined (s_1, s_2: S; t: T)
		require
			s_1 ~ s_2
		do
			push (s_1, t)
			push (s_2, t)
		ensure
			s_1 ~ s_2
		end

	frozen pop_well_defined (s_1, s_2: S)
		require
			s_1 ~ s_2
			s_1 /= s_2
			not empty (s_1)
			not empty (s_2)
		do
			pop (s_1)
			pop (s_2)
		ensure
			s_1 ~ s_2
		end

	frozen top_well_defined (s_1, s_2: S)
		require
			s_1 ~ s_2
		do
		ensure
			top (s_1) ~ top (s_2)
		end

	frozen empty_well_defined (s_1, s_2: S)
		require
			s_1 ~ s_2
		do
		ensure
			empty (s_1) ~ empty (s_2)
		end

	frozen size_well_defined (s_1, s_2: S)
		require
			s_1 ~ s_2
		do
		ensure
			size (s_1) ~ size (s_2)
		end

end
