note
	description: "Reusable abstract data type specification of queue."
	description: "The signature is taken from the article by the EIS link below."
	EIS: "protocol=URI", "src=http://www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
	description: "The operations' names are changed to the more traditional ones: push -> enqueue, pop -> dequeue, top -> front."
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"
	date: "8/6/2018"

deferred class
	QUEUE_ADT [Q, T]
	--	Queues ``Q'' contain ``T'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``Q'' and ``T''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	EQUALITY_ADT [Q]
	--	Queues feature an equality relation.

feature
	--	Deferred definitions.

	eq: Q
			-- Define a new queue in terms of your concept.
		deferred
		end

	add (q: Q; t: T)
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

	isempty (q: Q): BOOLEAN
			-- Define a queue's emptyness in terms of your concept.
		deferred
		end

	size (q: Q): INTEGER
			-- Define a queue's size in terms of your concept.
		deferred
		end

feature
	--	Abstract data type axioms.

	a_3_empty (q_1, q_2: Q)
			-- Querying a queue for emptyness does not change its equivalence class.
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		require
			q_1 ~ q_2
		local
			empty_: BOOLEAN
		do
			empty_ := isempty (q_1)
		ensure
			q_1 ~ q_2
		end

	a_3_size (q_1, q_2: Q)
			--	Querying a queue for size does not change its equivalence class.
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
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
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
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
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		require
			size (q) ~ 0
		do
		ensure
			isempty (q)
		end

	a_4_only_if (q: Q)
			--	A queue is empty only if its' size is zero.
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		require
			isempty (q)
		do
		ensure
			size (q) ~ 0
		end

	a_5 (q: Q; n: INTEGER; t: T)
			--	Suppose a queue's size is n and the next element to enqueue is t;
			--	then, after n elements have been dequeued, t will become the queue's front.
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		require
			size (q) ~ n
		local
			i: INTEGER
		do
			add (q, t)
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
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		require
			size (q) ~ old_size
		do
			add (q, t)
		ensure
			size (q) ~ old_size + 1
		end

	a_7 (q: Q; t: T; old_size: INTEGER)
			--	Dequeueing a non-empty queue decreases its size by 1.
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		require
			size (q) ~ old_size
			not isempty (q)
		do
			dequeue (q)
		ensure
			size (q) ~ old_size - 1
		end

	a_9 (q: Q; t: T)
			--	Enqueueing a queue makes it non-empty.
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
			EIS: "protocol=URI", "src=www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		do
			add (q, t)
		ensure
			not isempty (q)
		end

	a_10
			--	A newly created queue is empty.
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
			EIS: "protocol=URI", "src=www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		local
			q: Q
		do
			q := eq
			check
				isempty (q)
			end
		end

	a_11
			--	A newly created queue has zero size.
		note
			EIS: "protocol=URI", "src=http://www.cs.fsu.edu/~lacher/lectures/Output/adts/slide06.html"
		local
			q: Q
		do
			q := eq
			check
				size (q) ~ 0
			end
		end

	a_12
		note
			EIS: "protocol=URI", "src=http://www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		local
			q_1, q_2: Q
		do
			q_1 := eq
			q_2 := eq
			dequeue (q_1)
			check
				q_1 ~ q_2
			end
		end

	a_13 (t: T)
		note
			EIS: "protocol=URI", "src=http://www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		local
			q_1, q_2: Q
		do
			q_1 := eq
			q_2 := eq
			add (q_1, t)
			dequeue (q_1)
			check
				q_1 ~ q_2
			end
		end

	a_14 (q_1, q_2: Q; t_1, t_2: T)
		note
			EIS: "protocol=URI", "src=http://www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		require
			q_1 ~ q_2
			q_1 /= q_2
		do
			add (q_1, t_1)
			add (q_1, t_2)
			dequeue (q_1)
			add (q_2, t_1)
			dequeue (q_2)
			add (q_2, t_2)
		ensure
			q_1 ~ q_2
		end

	a_15 (t: T)
		note
			EIS: "protocol=URI", "src=http://www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		local
			q: Q
		do
			q := eq
			add (q, t)
			check
				front (q) ~ t
			end
		end

	a_16 (q_1, q_2: Q; t_1, t_2: T)
		note
			EIS: "protocol=URI", "src=http://www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
		require
			q_1 ~ q_2
			q_1 /= q_2
		do
			add (q_1, t_1)
			add (q_1, t_2)
			add (q_2, t_1)
		ensure
			front (q_1) ~ front (q_2)
		end

feature
	--	Theorems.

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
				add (q, t)
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
			not isempty (q)
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
			q_1 := eq
			q_2 := eq
			check
				q_1 ~ q_2
			end
		end

	enqueue_well_defined (q_1, q_2: Q; t: T)
		require
			q_1 ~ q_2
		do
			add (q_1, t)
			add (q_2, t)
		ensure
			q_1 ~ q_2
		end

	dequeue_well_defined (q_1, q_2: Q)
		require
			q_1 ~ q_2
			q_1 /= q_2
			not isempty (q_1)
			not isempty (q_2)
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
			isempty (q_1) ~ isempty (q_2)
		end

	size_well_defined (q_1, q_2: Q)
		require
			q_1 ~ q_2
		do
		ensure
			size (q_1) ~ size (q_2)
		end

end
