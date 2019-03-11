note
	description: "Reusable abstract data type specification of queue."
	description: "Found in ``The Algebraic Specification of Abstract Data Types'' by Guttag and Horning:"
	EIS: "src=https://link.springer.com/article/10.1007/BF00260922"
	description: "Found in ``The design of data type specifications'' by Guttag, Horowitz and Musser:"
	EIS: "src=http://tinyurl.com/yxmnv23w"
	description: "Found in ``Implementing Algebraically Specified Abstract Data Types in an imperative Programming Language '' by Thomas:"
	EIS: "src=http://www.dcs.gla.ac.uk/~muffy/papers/Tapsoft_87.pdf"
	description: "Found in ``Abstract Data Types and the Development of Data Structures'' by Guttag:"
	EIS: "src=http://tinyurl.com/y45o32hq"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/y4qv86kz"

deferred class
	QUEUE_ADT [Q, T]
	--	Queues ``Q'' contain elements of ``T''.

inherit

	EQUALITY_ADT [Q]

feature
	-- Deferred definitions.

	newq: Q
		deferred
		end

	addq (q: Q; t: T)
		deferred
		end

	deleteq (q: Q)
		deferred
		end

	frontq (q: Q): T
		deferred
		end

	isnewq (q: Q): BOOLEAN
		deferred
		end

	size (q: Q): INTEGER
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_3_empty (q_1, q_2: Q)
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
		require
			size (q) ~ 0
		do
		ensure
			isnewq (q)
		end

	frozen a_4_only_if (q: Q)
		require
			isnewq (q)
		do
		ensure
			size (q) ~ 0
		end

	frozen a_5 (q: Q; n: INTEGER; t: T)
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
		require
			size (q) ~ old_size
		do
			addq (q, t)
		ensure
			size (q) ~ old_size + 1
		end

	frozen a_7 (q: Q; t: T; old_size: INTEGER)
		require
			size (q) ~ old_size
			not isnewq (q)
		do
			deleteq (q)
		ensure
			size (q) ~ old_size - 1
		end

	frozen a_9 (q: Q; t: T)
		do
			addq (q, t)
		ensure
			not isnewq (q)
		end

	frozen a_10
		local
			q: Q
		do
			q := newq
			check
				isnewq (q)
			end
		end

	frozen a_11
		local
			q: Q
		do
			q := newq
			check
				size (q) ~ 0
			end
		end

	frozen a_12
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
		local
			q: Q
		do
			q := newq
			check
				frontq (q) /~ t
			end
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
