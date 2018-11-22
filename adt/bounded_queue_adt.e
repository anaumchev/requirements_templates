note
	description: "Reusable abstract data type specification of bounded queue."
	description: "The signature is taken from ``The design of data type specifications'' article by Guttag, Horowitz and Musser, page 6."
	EIS: "protocol=URI", "src=http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.103.4685&rep=rep1&type=pdf"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	BOUNDED_QUEUE_ADT [B, I]
	--	Bounded queues ``B'' contain ``I'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``B'' and ``I''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	EQUALITY_ADT [B]

feature
	-- Deferred definitions.

	newq (capacity: INTEGER): B
		deferred
		end

	addq (bounded_queue: B; item: I)
		deferred
		end

	deleteq (bounded_queue: B)
		deferred
		end

	frontq (bounded_queue: B): I
		deferred
		end

	isnewq (bounded_queue: B): BOOLEAN
		deferred
		end

	appendq (bounded_queue, other: B)
		deferred
		end

	size (bounded_queue: B): INTEGER
		deferred
		end

	limit (bounded_queue: B): INTEGER
		deferred
		end

	enq (bounded_queue: B; item: I)
		deferred
		end

	deq (bounded_queue: B): I
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1 (capacity: INTEGER)
			--	ISNEWQ(NEWQ(in)) = true
		local
			bounded_queue: B
		do
			bounded_queue := newq (capacity)
			check
				isnewq (bounded_queue)
			end
		end

	frozen a_2 (bounded_queue: B; item: I)
			--	ISNEWQ(ADDQ(q,i)) = false
		do
			addq (bounded_queue, item)
		ensure
			not isnewq (bounded_queue)
		end

	frozen a_3 (capacity: INTEGER)
			--	DELETEQ(NEWQ(in)) = NEWQ
		local
			bounded_queue_1, bounded_queue_2: B
		do
			bounded_queue_1 := newq (capacity)
			bounded_queue_2 := newq (capacity)
			deleteq (bounded_queue_1)
			check
				bounded_queue_1 ~ bounded_queue_2
			end
		end

	frozen a_4 (bounded_queue: B; item: I; capacity: INTEGER)
			--	DELETEQ(ADDQ(q,i)) = if ISNEWQ(q) then NEWQ >>
		require
			isnewq (bounded_queue)
		local
			new_queue: B
		do
			new_queue := newq (capacity)
			addq (bounded_queue, item)
			deleteq (bounded_queue)
			check
				bounded_queue ~ new_queue
			end
		end

	frozen a_5 (bounded_queue_1, bounded_queue_2: B; item: I)
			--	>> else ADDQ(DELETEQ(q),i)
		require
			bounded_queue_1 ~ bounded_queue_2
		do
			addq (bounded_queue_1, item)
			deleteq (bounded_queue_1)
			deleteq (bounded_queue_2)
			addq (bounded_queue_2, item)
		ensure
			bounded_queue_1 ~ bounded_queue_2
		end

	frozen a_6 (capacity: INTEGER; item: I)
			--	FRONTQ(NEWQ(in)) = UNDEFINED[underflow]
		local
			bounded_queue: B
		do
			bounded_queue := newq (capacity)
			check
				frontq (bounded_queue) /~ item
			end
		end

	frozen a_7 (bounded_queue: B; item: I)
			--	FRONTQ(ADDQ(q,i)) = if ISNEWQ(q) then i >>
		require
			isnewq (bounded_queue)
		do
			addq (bounded_queue, item)
		ensure
			frontq (bounded_queue) ~ item
		end

	frozen a_8 (bounded_queue: B; item: I; old_frontq: I)
			--	>> else FRONTQ(q)
		require
			not isnewq (bounded_queue)
			frontq (bounded_queue) ~ old_frontq
		do
			addq (bounded_queue, item)
		ensure
			frontq (bounded_queue) ~ old_frontq
		end

	frozen a_9 (bounded_queue_1, bounded_queue_2: B; capacity: INTEGER)
			--	APPENDQ(q,NEWQ(in)) = q
		require
			bounded_queue_1 ~ bounded_queue_2
		local
			new_queue: B
		do
			new_queue := newq (capacity)
			appendq (bounded_queue_1, new_queue)
		ensure
			bounded_queue_1 ~ bounded_queue_2
		end

	frozen a_10 (bounded_queue_1, bounded_queue_2, other_1, other_2: B; item: I)
			--	APPENDQ(r,ADDQ(q,i)) = ADDQ(APPENDQ(r,q),i)
		require
			bounded_queue_1 ~ bounded_queue_2
			other_1 ~ other_2
		do
			addq (other_1, item)
			appendq (bounded_queue_1, other_1)
			appendq (bounded_queue_2, other_2)
			addq (bounded_queue_2, item)
		ensure
			bounded_queue_1 ~ bounded_queue_2
		end

	frozen a_11 (capacity: INTEGER)
			--	LIMIT(NEWQ(in)) = in
		local
			new_queue: B
		do
			new_queue := newq (capacity)
			check
				limit (new_queue) ~ capacity
			end
		end

	frozen a_12 (bounded_queue: B; item: I; old_limit: INTEGER)
			--	LIMIT(ADDQ(q,i)) = LIMIT(q)
		require
			limit (bounded_queue) ~ old_limit
		do
			addq (bounded_queue, item)
		ensure
			limit (bounded_queue) ~ old_limit
		end

	frozen a_13 (bounded_queue_1, bounded_queue_2: B; item: I)
			--	ENQ(q,i) = if SIZE(q)<LIMIT(q) then q <-- ADDQ(q,i) >>
		require
			size (bounded_queue_1) < limit (bounded_queue_1)
			bounded_queue_1 ~ bounded_queue_2
		do
			enq (bounded_queue_1, item)
			addq (bounded_queue_2, item)
		ensure
			bounded_queue_1 ~ bounded_queue_2
		end

	frozen a_14 (bounded_queue_1, bounded_queue_2: B; item: I)
			--	>> else UNDEFINED[overflow]
		require
			size (bounded_queue_1) = limit (bounded_queue_1)
		do
			enq (bounded_queue_1, item)
		ensure
			bounded_queue_1 /~ bounded_queue_2
		end

	frozen a_15 (bounded_queue_1, bounded_queue_2: B)
			--	DEQ(q) = q <-- DELETEQ(q); FRONTQ(q)
		require
			bounded_queue_1 ~ bounded_queue_2
		local
			item: I
		do
			item := deq (bounded_queue_1)
			deleteq (bounded_queue_2)
			check
				item ~ frontq (bounded_queue_2)
			end
		end

	frozen a_16 (capacity: INTEGER)
			--	SIZE(NEWQ(in)) = 0
		local
			bounded_queue: B
		do
			bounded_queue := newq (capacity)
			check
				size (bounded_queue) ~ 0
			end
		end

	frozen a_17 (bounded_queue: B; item: I; old_size: INTEGER)
			--	SIZE(ADDQ(q,i)) = 1+SIZE(q)
		require
			size (bounded_queue) ~ old_size
		do
			addq (bounded_queue, item)
		ensure
			size (bounded_queue) ~ 1 + old_size
		end

feature
	-- Well-definedness axioms.

	frozen newq_well_defined (capacity: INTEGER)
		local
			bounded_queue_1, bounded_queue_2: B
		do
			bounded_queue_1 := newq (capacity)
			bounded_queue_2 := newq (capacity)
			check
				bounded_queue_1 ~ bounded_queue_2
			end
		end

	frozen addq_well_defined (bounded_queue_1, bounded_queue_2: B; item: I)
		require
			bounded_queue_1 ~ bounded_queue_2
		do
			addq (bounded_queue_1, item)
			addq (bounded_queue_2, item)
		ensure
			bounded_queue_1 ~ bounded_queue_2
		end

	frozen deleteq_well_defined (bounded_queue_1, bounded_queue_2: B)
		require
			bounded_queue_1 ~ bounded_queue_2
			bounded_queue_1 /= bounded_queue_2
			not isnewq (bounded_queue_1)
			not isnewq (bounded_queue_2)
		do
			deleteq (bounded_queue_1)
			deleteq (bounded_queue_2)
		ensure
			bounded_queue_1 ~ bounded_queue_2
		end

	frozen frontq_well_defined (bounded_queue_1, bounded_queue_2: B)
		require
			bounded_queue_1 ~ bounded_queue_2
		do
		ensure
			frontq (bounded_queue_1) ~ frontq (bounded_queue_2)
		end

	frozen isnewq_well_defined (bounded_queue_1, bounded_queue_2: B)
		require
			bounded_queue_1 ~ bounded_queue_2
		do
		ensure
			isnewq (bounded_queue_1) ~ isnewq (bounded_queue_2)
		end

	frozen appendq_well_defined (bounded_queue_1, bounded_queue_2, other: B)
		require
			bounded_queue_1 ~ bounded_queue_2
		do
			appendq (bounded_queue_1, other)
			appendq (bounded_queue_2, other)
		ensure
			bounded_queue_1 ~ bounded_queue_2
		end

	frozen size_well_defined (bounded_queue_1, bounded_queue_2: B)
		require
			bounded_queue_1 ~ bounded_queue_2
		do
		ensure
			size (bounded_queue_1) ~ size (bounded_queue_2)
		end

	frozen limit_well_defined (bounded_queue_1, bounded_queue_2: B)
		require
			bounded_queue_1 ~ bounded_queue_2
		do
		ensure
			limit (bounded_queue_1) ~ limit (bounded_queue_2)
		end

	frozen enq_well_defined (bounded_queue_1, bounded_queue_2: B; item: I)
		require
			bounded_queue_1 ~ bounded_queue_2
			size (bounded_queue_1) < limit (bounded_queue_1)
			size (bounded_queue_2) < limit (bounded_queue_2)
		do
			enq (bounded_queue_1, item)
			enq (bounded_queue_2, item)
		ensure
			bounded_queue_1 ~ bounded_queue_2
		end

	frozen deq_well_defined (bounded_queue_1, bounded_queue_2: B)
		require
			bounded_queue_1 ~ bounded_queue_2
		local
			item_1, item_2: I
		do
			item_1 := deq (bounded_queue_1)
			item_2 := deq (bounded_queue_2)
			check
				item_1 ~ item_2
			end
		ensure
			bounded_queue_1 ~ bounded_queue_2
		end

end
