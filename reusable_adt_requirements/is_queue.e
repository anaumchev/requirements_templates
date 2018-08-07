note
	description: "Reusable abstract data type specification of queue."
	description: "Find a detailed description by the EIS linke below."
	EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
	description: "The operations' names are changed to the more traditional ones: push -> enqueue, pop -> dequeue, top -> front."
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"
	date: "8/6/2018"

deferred class
	IS_QUEUE [Q, T]
	--	Queues ``Q'' contain ``T'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``Q'' and ``T''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	IS_WITH_EQUALITY [Q]
	--	Queues feature an equality relation.

feature
	--	Deferred definitions to effect based on your concept.

	new: Q
			-- Define a new queue in terms of your concept.
		deferred
		end

	enqueue (q: Q; t: T)
			-- Define what it means to enqueue a queue in terms of your concept.
		deferred
		end

	dequeue (q: Q)
			-- Define what it means to dequeue a queue in terms of your concept.
		deferred
		end

	front (q: Q): T
			-- Define a queue's front in terms of your concept.
		deferred
		end

	empty (q: Q): BOOLEAN
			-- Define a queue's emptyness in terms of your concept.
		deferred
		end

	size (q: Q): INTEGER
			-- Define a queue's size in terms of your concept.
		deferred
		end

feature
	-- Queue ADT axioms.

	a_3_empty (q_1, q_2: Q)
			-- Querying a queue for emptyness does not change its equivalence class.
		require
			q_1 ~ q_2
		local
			empty_: BOOLEAN
		do
			empty_ := empty (q_1)
		ensure
			q_1 ~ q_2
		end

	a_3_size (q_1, q_2: Q)
			--	Querying a queue for size does not change its equivalence class.
		require
			q_1 ~ q_2
		local
			size_: INTEGER
		do
			size_ := size (q_1)
		ensure
			q_1 ~ q_2
		end

	a_3_front (q_1, q_2: Q)
			--	Querying a queue for front does not change its equivalence class.
		require
			q_1 ~ q_2
		local
			front_: T
		do
			front_ := front (q_1)
		ensure
			q_1 ~ q_2
		end

	a_4_if (q: Q)
			--	A queue is empty if its' size is zero.
		require
			size (q) ~ 0
		do
		ensure
			empty (q)
		end

	a_4_only_if (q: Q)
			--	A queue is empty only if its' size is zero.
		require
			empty (q)
		do
		ensure
			size (q) ~ 0
		end

	a_5 (q: Q; n: INTEGER; t: T)
			--	Suppose a queue's size is n and the next element to enqueue is t;
			--	then, after n elements have been dequeued, t will become the queue's front.
		require
			size (q) ~ n
		local
			i: INTEGER
		do
			enqueue (q, t)
			from
				i := 0
			until
				i ~ n
			loop
				dequeue (q)
				i := i + 1
			end
		ensure
			front (q) ~ t
		end

	a_6 (q: Q; t: T; old_size: INTEGER)
			--	Enqueueing a queue increases its size by 1.
		require
			size (q) ~ old_size
		do
			enqueue (q, t)
		ensure
			size (q) ~ old_size + 1
		end

	a_7 (q: Q; t: T; old_size: INTEGER)
			--	Dequeueing a non-empty queue decreases its size by 1.
		require
			size (q) ~ old_size
			not empty (q)
		do
			dequeue (q)
		ensure
			size (q) ~ old_size - 1
		end

	a_9 (q: Q; t: T)
			--	Enqueueing a queue makes it non-empty.
		do
			enqueue (q, t)
		ensure
			not empty (q)
		end

	a_10
			--	A newly created queue is empty.
		local
			q: Q
		do
			q := new
			check
				empty (q)
			end
		end

	a_11
			--	A newly created queue has zero size.
		local
			q: Q
		do
			q := new
			check
				size (q) ~ 0
			end
		end

feature
	--	Stack theorems.

	theorem_1 (q: Q; t: T; k, n: INTEGER)
			--	Pushing a stack k times increases its size by k.
			--	Follow the EIS link below for details.
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide08.html"
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
				enqueue (q, t)
				i := i + 1
			end
		ensure
			size (q) ~ n + k
		end

	theorem_2 (q: Q; k, n: INTEGER)
			--	Popping a stack k times decreases its size by k.
			--	Follow the EIS link below for details.
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide08.html"
		require
			size (q) ~ n
			k >= 1
			k <= n
			not empty (q)
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i ~ k
			loop
				dequeue (q)
				i := i + 1
			end
		ensure
			size (q) ~ n - k
		end

feature
	-- Well-definedness axioms.

	new_well_defined
		local
			q_1, q_2: Q
		do
			q_1 := new
			q_2 := new
			check
				q_1 ~ q_2
			end
		end

	enqueue_well_defined (q_1, q_2: Q; t: T)
		require
			q_1 ~ q_2
		do
			enqueue (q_1, t)
			enqueue (q_2, t)
		ensure
			q_1 ~ q_2
		end

	dequeue_well_defined (q_1, q_2: Q)
		require
			q_1 ~ q_2
			q_1 /= q_2
			not empty (q_1)
			not empty (q_2)
		do
			dequeue (q_1)
			dequeue (q_2)
		ensure
			q_1 ~ q_2
		end

	front_well_defined (q_1, q_2: Q)
		require
			q_1 ~ q_2
		do
		ensure
			front (q_1) ~ front (q_2)
		end

	empty_well_defined (q_1, q_2: Q)
		require
			q_1 ~ q_2
		do
		ensure
			empty (q_1) ~ empty (q_2)
		end

	size_well_defined (q_1, q_2: Q)
		require
			q_1 ~ q_2
		do
		ensure
			size (q_1) ~ size (q_2)
		end

end
