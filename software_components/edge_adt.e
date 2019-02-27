note
	description: "Reusable abstract data type specification of graph edge."
	description: "Found in ``The design of data type specifications'' by Guttag, Horowitz and Musser:"
	EIS: "src=http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.103.4685&rep=rep1&type=pdf"

deferred class
	EDGE_ADT [E, N]
	--	Edges ``E'' consist of nodes ``N''.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``E'' and ``N''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	EQUALITY_ADT [E]

feature
	-- Deferred definitions.

	rel (node_1, node_2: N): E
		deferred
		end

feature
	-- Well-definedness axioms.

	frozen rel_well_defined (node_1, node_2: N)
		local
			edge_1, edge_2: E
		do
			edge_1 := rel (node_1, node_2)
			edge_2 := rel (node_1, node_2)
			check
				edge_1 ~ edge_2
			end
		end

end
