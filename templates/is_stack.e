note
	description: "Behavioral description of a concept that behaves like stack."
	description: "Find a detailed description by the EIS linke below."
	EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide02.html"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"
	date: "8/3/2018"

deferred class
	IS_STACK [S, T]
	--	Stacks ``S'' contain ``T'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``S'' and ``T''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	IS_ANY [S]
	--	Stacks feature an equality relation and a copy operation.

feature
	--	Deferred definitions to effect based on your concept.

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
	-- Stack axioms.

	a_3_empty (s_1, s_2: S)
			-- Querying a stack for emptyness does not change its equivalence class.
		require
			are_equal (s_1, s_2)
		local
			empty_: BOOLEAN
		do
			empty_ := empty (s_1)
		ensure
			are_equal (s_1, s_2)
		end

	a_3_size (s_1, s_2: S)
			--	Querying a stack for size does not change its equivalence class.
		require
			are_equal (s_1, s_2)
		local
			size_: INTEGER
		do
			size_ := size (s_1)
		ensure
			are_equal (s_1, s_2)
		end

	a_3_top (s_1, s_2: S)
			--	Querying a stack for top does not change its equivalence class.
		require
			are_equal (s_1, s_2)
		local
			top_: T
		do
			top_ := top (s_1)
		ensure
			are_equal (s_1, s_2)
		end

	a_4_if (s: S)
			--	A stack is empty if its' size is zero.
		require
			size (s) = 0
		do
		ensure
			empty (s)
		end

	a_4_only_if (s: S)
			--	A stack is empty only if its' size is zero.
		require
			empty (s)
		do
		ensure
			size (s) = 0
		end

	a_5 (s_1, s_2: S; t: T)
			--	Pushing and then popping a stack does not change its' equivalence class.
		require
			are_equal (s_1, s_2)
		do
			push (s_1, t)
			pop (s_1)
		ensure
			are_equal (s_1, s_2)
		end

	a_6 (s: S; t: T)
			--	Pushing an element on a stack makes it the top element.
		do
			push (s, t)
		ensure
			top (s) = t
		end

	a_7 (s: S; t: T; old_size: INTEGER)
			--	Pushing a stack increases its size by 1.
		require
			size (s) = old_size
		do
			push (s, t)
		ensure
			size (s) = old_size + 1
		end

	a_8 (s: S; t: T; old_size: INTEGER)
			--	Popping a non-empty stack decreases its size by 1.
		require
			size (s) = old_size
			not empty (s)
		do
			pop (s)
		ensure
			size (s) = old_size - 1
		end

	a_9 (s: S; t: T)
			--	Pushing a stack makes it non-empty.
		do
			push (s, t)
		ensure
			not empty (s)
		end

	a_10
			--	A newly created stack is empty.
		local
			s: S
		do
			s := new
			check
				empty (s)
			end
		end

	a_11
			--	A newly created stack has zero size.
		local
			s: S
		do
			s := new
			check
				size (s) = 0
			end
		end

feature
	--	Stack theorems.

	theorem_1 (s: S; t: T; k, n: INTEGER)
			--	Pushing a stack k times increases its size by k.
			--	Follow the EIS link below for details.
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide04.html"
		require
			size (s) = n
			k >= 1
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i = k
			loop
				push (s, t)
				i := i + 1
			end
		ensure
			size (s) = n + k
		end

	theorem_2 (s: S; k, n: INTEGER)
			--	Popping a stack k times decreases its size by k.
			--	Follow the EIS link below for details.
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide04.html"
		require
			size (s) = n
			k >= 1
			k <= n
			not empty (s)
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i = k
			loop
				pop (s)
				i := i + 1
			end
		ensure
			size (s) = n - k
		end

feature
	-- Well-definedness axioms.

	new_well_defined
		local
			s_1, s_2: S
		do
			s_1 := new
			s_2 := new
			check
				are_equal (s_1, s_2)
			end
		end

	push_well_defined (s_1, s_2: S; t: T)
		require
			are_equal (s_1, s_2)
		do
			push (s_1, t)
			push (s_2, t)
		ensure
			are_equal (s_1, s_2)
		end

	pop_well_defined (s_1, s_2: S)
		require
			are_equal (s_1, s_2)
			s_1 /= s_2
			not empty (s_1)
			not empty (s_2)
		do
			pop (s_1)
			pop (s_2)
		ensure
			are_equal (s_1, s_2)
		end

	top_well_defined (s_1, s_2: S)
		require
			are_equal (s_1, s_2)
		do
		ensure
			top (s_1) = top (s_2)
		end

	empty_well_defined (s_1, s_2: S)
		require
			are_equal (s_1, s_2)
		do
		ensure
			empty (s_1) = empty (s_2)
		end

	size_well_defined (s_1, s_2: S)
		require
			are_equal (s_1, s_2)
		do
		ensure
			size (s_1) = size (s_2)
		end

end
