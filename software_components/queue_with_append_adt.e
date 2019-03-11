note
	description: "Reusable abstract data type specification of queue with the ``append'' operation."
	description: "Found in ``The design of data type specifications'' by Guttag, Horowitz and Musser:"
	EIS: "src=http://tinyurl.com/yxmnv23w"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/y44w738n"

deferred class
	QUEUE_WITH_APPEND_ADT [Q, T]
	--	Queues ``Q'' with appending other queues contain elements of ``T''.

inherit

	QUEUE_ADT [Q, T]

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




















