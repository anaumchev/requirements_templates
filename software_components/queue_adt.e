note
	description: "Reusable abstract data type specification of queue."
	description: "Found in ``The Algebraic Specification of Abstract Data Types'' by Guttag and Horning:"
	EIS: "src=https://link.springer.com/article/10.1007/BF00260922"
	description: "Found in ``The design of data type specifications'' by Guttag, Horowitz and Musser:"
	EIS: "src=http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.103.4685&rep=rep1&type=pdf"
	description: "Found in ``Implementing Algebraically Specified Abstract Data Types in an imperative Programming Language '' by Thomas:"
	EIS: "src=http://www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
	description: "Found in ``Abstract Data Types and the Development of Data Structures'' by Guttag:"
	EIS: "src=http://cecs.wright.edu/people/faculty/tkprasad/courses/cs784/guttag-cacm77.pdf"

deferred class
	QUEUE_ADT [Q, T]
	--	Queues ``Q'' contain ``T'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``Q'' and ``T''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	EQUALITY_ADT [Q]

feature
	-- Deferred definitions.

	newq: Q
			-- Define a new queue in terms of your concept.
		deferred
		end

	addq (q: Q; t: T)
			-- Define what it means to add a queue in terms of your concept.
		deferred
		end

	deleteq (q: Q)
			-- Define what it means to dequeue a queue in terms of your concept.
		deferred
		end

	frontq (q: Q): T
			-- Define a queue's front in terms of your concept.
		deferred
		end

	isnewq (q: Q): BOOLEAN
			-- Define a queue's emptyness in terms of your concept.
		deferred
		end

	size (q: Q): INTEGER
			-- Define a queue's size in terms of your concept.
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_3_empty (q_1, q_2: Q)
			-- Querying a queue for emptyness does not change its equivalence class.
		note
			EIS: "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		require
			q_1 ~ q_2
		local
			empty_: BOOLEAN
		do
			empty_ := isnewq (q_1)
		ensure
			q_1 ~ q_2
		end

	frozen a_3_size (q_1, q_2: Q)
			--	Querying a queue for size does not change its equivalence class.
		note
			EIS: "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		require
			q_1 ~ q_2
		local
			size_: INTEGER
		do
			size_ := size (q_1)
		ensure
			q_1 ~ q_2
		end

	frozen a_3_front (q_1, q_2: Q)
			--	Querying a queue for front does not change its equivalence class.
		note
			EIS: "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		require
			q_1 ~ q_2
		local
			front_: T
		do
			front_ := frontq (q_1)
		ensure
			q_1 ~ q_2
		end

	frozen a_4_if (q: Q)
			--	A queue is empty if its' size is zero.
		note
			EIS: "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		require
			size (q) ~ 0
		do
		ensure
			isnewq (q)
		end

	frozen a_4_only_if (q: Q)
			--	A queue is empty only if its' size is zero.
		note
			EIS: "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		require
			isnewq (q)
		do
		ensure
			size (q) ~ 0
		end

	frozen a_5 (q: Q; n: INTEGER; t: T)
			--	Suppose a queue's size is n and the next element to add is t;
			--	then, after n elements have been dequeued, t will become the queue's front.
		note
			EIS: "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		require
			size (q) ~ n
		local
			i: INTEGER
		do
			addq (q, t)
			from
				i := 0
			until
				i ~ n
			loop
				deleteq (q)
				i := i + 1
			end
		ensure
			frontq (q) ~ t
		end

	frozen a_6 (q: Q; t: T; old_size: INTEGER)
			--	Adding to a queue increases its size by 1.
		note
			EIS: "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		require
			size (q) ~ old_size
		do
			addq (q, t)
		ensure
			size (q) ~ old_size + 1
		end

	frozen a_7 (q: Q; t: T; old_size: INTEGER)
			--	Dequeueing a non-empty queue decreases its size by 1.
		note
			EIS: "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		require
			size (q) ~ old_size
			not isnewq (q)
		do
			deleteq (q)
		ensure
			size (q) ~ old_size - 1
		end

	frozen a_9 (q: Q; t: T)
			--	Adding to a queue makes it non-empty.
		note
			EIS: "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
			EIS: "src=www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		do
			addq (q, t)
		ensure
			not isnewq (q)
		end

	frozen a_10
			--	A newly created queue is empty.
		note
			EIS: "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
			EIS: "src=www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		local
			q: Q
		do
			q := newq
			check
				isnewq (q)
			end
		end

	frozen a_11
			--	A newly created queue has zero size.
		note
			EIS: "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		local
			q: Q
		do
			q := newq
			check
				size (q) ~ 0
			end
		end

	frozen a_12
		note
			EIS: "src=http://www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		local
			q_1, q_2: Q
		do
			q_1 := newq
			q_2 := newq
			deleteq (q_1)
			check
				q_1 ~ q_2
			end
		end

	frozen a_13 (t: T)
		note
			EIS: "src=http://www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		local
			q_1, q_2: Q
		do
			q_1 := newq
			q_2 := newq
			addq (q_1, t)
			deleteq (q_1)
			check
				q_1 ~ q_2
			end
		end

	frozen a_14 (q_1, q_2: Q; t_1, t_2: T)
		note
			EIS: "src=http://www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		require
			q_1 ~ q_2
			q_1 /= q_2
		do
			addq (q_1, t_1)
			addq (q_1, t_2)
			deleteq (q_1)
			addq (q_2, t_1)
			deleteq (q_2)
			addq (q_2, t_2)
		ensure
			q_1 ~ q_2
		end

	frozen a_15 (t: T)
		note
			EIS: "src=http://www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		local
			q: Q
		do
			q := newq
			addq (q, t)
			check
				frontq (q) ~ t
			end
		end

	frozen a_16 (q_1, q_2: Q; t_1, t_2: T)
		note
			EIS: "src=http://www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		require
			q_1 ~ q_2
			q_1 /= q_2
		do
			addq (q_1, t_1)
			addq (q_1, t_2)
			addq (q_2, t_1)
		ensure
			frontq (q_1) ~ frontq (q_2)
		end

	frozen a_17 (t: T)
		note
			EIS: "src=http://www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		local
			q: Q
		do
			q := newq
			check
				frontq (q) /~ t
			end
		end

feature
	-- Theorems.

	frozen theorem_1 (q: Q; t: T; k, n: INTEGER)
			--	Pushing a stack k times increases its size by k.
			--	Follow the EIS link below for details.
		note
			EIS: "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide08.html"
		require
			size (q) ~ n
			k >= 1
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i ~ k
			loop
				addq (q, t)
				i := i + 1
			end
		ensure
			size (q) ~ n + k
		end

	frozen theorem_2 (q: Q; k, n: INTEGER)
			--	Popping a stack k times decreases its size by k.
			--	Follow the EIS link below for details.
		note
			EIS: "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide08.html"
		require
			size (q) ~ n
			k >= 1
			k <= n
			not isnewq (q)
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i ~ k
			loop
				deleteq (q)
				i := i + 1
			end
		ensure
			size (q) ~ n - k
		end

feature
	-- Well-definedness axioms.

	frozen new_well_defined
		local
			q_1, q_2: Q
		do
			q_1 := newq
			q_2 := newq
			check
				q_1 ~ q_2
			end
		end

	frozen add_well_defined (q_1, q_2: Q; t: T)
		require
			q_1 ~ q_2
		do
			addq (q_1, t)
			addq (q_2, t)
		ensure
			q_1 ~ q_2
		end

	frozen dequeue_well_defined (q_1, q_2: Q)
		require
			q_1 ~ q_2
			q_1 /= q_2
			not isnewq (q_1)
			not isnewq (q_2)
		do
			deleteq (q_1)
			deleteq (q_2)
		ensure
			q_1 ~ q_2
		end

	frozen front_well_defined (q_1, q_2: Q)
		require
			q_1 ~ q_2
		do
		ensure
			frontq (q_1) ~ frontq (q_2)
		end

	frozen empty_well_defined (q_1, q_2: Q)
		require
			q_1 ~ q_2
		do
		ensure
			isnewq (q_1) ~ isnewq (q_2)
		end

	frozen size_well_defined (q_1, q_2: Q)
		require
			q_1 ~ q_2
		do
		ensure
			size (q_1) ~ size (q_2)
		end

end
