note
	description: "Reusable abstract data type specification of queue with the ``append'' operation."
	description: "The signature is taken from ``The design of data type specifications'' article by Guttag, Horowitz and Musser, page 3."
	EIS: "protocol=URI", "src=http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.103.4685&rep=rep1&type=pdf"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	QUEUE_WITH_APPEND_ADT [Q, T]
	--	Queues ``Q'' contain ``T'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``Q'' and ``T''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	QUEUE_ADT [Q, T]
		rename
			eq as newq,
			add as addq,
			dequeue as deleteq,
			front as frontq,
			isempty as isnewq
		end
	-- The above article uses its own names for some of the operations.

feature
	-- Deferred definitions.

	appendq (queue, other: Q)
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_18 (queue_1, queue_2: Q)
		require
			queue_1 ~ queue_2
		local
			other: Q
		do
			other := newq
			appendq (queue_1, other)
		ensure
			queue_1 ~ queue_2
		end

	frozen a_19 (queue_1, queue_2, other_1, other_2: Q; element: T)
		require
			queue_1 ~ queue_2
			other_1 ~ other_2
		do
			addq (other_1, element)
			appendq (queue_1, other_1)
			appendq (queue_2, other_2)
			addq (queue_2, element)
		ensure
			queue_1 ~ queue_2
		end

feature
	-- Well-definedness axioms.

	frozen appendq_well_defined (queue_1, queue_2, other: Q)
		require
			queue_1 ~ queue_2
		do
			appendq (queue_1, other)
			appendq (queue_2, other)
		ensure
			queue_1 ~ queue_2
		end

end
