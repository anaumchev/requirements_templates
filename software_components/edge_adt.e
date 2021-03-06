note
	description: "Reusable abstract data type specification of graph edge."
	description: "Found in ``The design of data type specifications'' by Guttag, Horowitz and Musser:"
	EIS: "src=http://tinyurl.com/yxmnv23w"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/y4g93wpo"

deferred class
	EDGE_ADT [E, N]
	--	Edges ``E'' connect nodes ``N''.

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
