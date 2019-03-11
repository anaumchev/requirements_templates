note
	description: "Reusable abstract data type specification of graph."
	description: "Found in ``The design of data type specifications'' by Guttag, Horowitz and Musser:"
	EIS: "src=http://tinyurl.com/yxmnv23w"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/y5y6l6ax"

deferred class
	GRAPH_ADT [G, N, E, SN, SE, ES -> EDGE_ADT [E, N], SNS -> SET_WITH_ISEMPTYSET_ADT [SN, N], SES -> SET_WITH_ISEMPTYSET_ADT [SE, E]]
	--	Graphs ``G'' contain edges ``E'' connecting nodes ``N''
	--  conforming to the ``EDGE_ADT'' specification.
	--  They depend on sets ``SE'' of edges ``E'' conforming to the
	--  ``SET_WITH_ISEMPTYSET_ADT'' specification.
	--  They depend on sets ``SN'' of nodes ``N'' conforming to the
	--  ``SET_WITH_ISEMPTYSET_ADT'' specification.

inherit

	EQUALITY_ADT [G]

feature
	-- Deferred definitions.

	empty_graph: G
		deferred
		end

	add_node (graph: G; node: N)
		deferred
		end

	add_edge (graph: G; edge: E)
		deferred
		end

	nodes (graph: G): SN
		deferred
		end

	edges (graph: G): SE
		deferred
		end

	adjac (graph: G; node: N): SN
		deferred
		end

	nod_out (graph: G; node: N)
		deferred
		end

	edge_out (graph: G; edge: E)
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1
		local
			graph: G
			nodes_set: SN
		do
			graph := empty_graph
			nodes_set := ({SNS}).default.empty_set
			check
				nodes (graph) ~ nodes_set
			end
		end

	frozen a_2 (graph: G; node: N; nodes_set: SN)
		require
			nodes (graph) ~ nodes_set
		do
			add_node (graph, node)
			({SNS}).default.insert (nodes_set, node)
		ensure
			nodes (graph) ~ nodes_set
		end

	frozen a_3 (graph: G; node_1, node_2: N; edge: E; nodes_set: SN)
		require
			({ES}).default.rel (node_1, node_2) ~ edge
			nodes (graph) ~ nodes_set
		do
			add_edge (graph, edge)
			({SNS}).default.insert (nodes_set, node_1)
			({SNS}).default.insert (nodes_set, node_2)
		ensure
			nodes (graph) ~ nodes_set
		end

	frozen a_4
		local
			graph: G
			edges_set: SE
		do
			graph := empty_graph
			edges_set := ({SES}).default.empty_set
			check
				edges (graph) ~ edges_set
			end
		end

	frozen a_5 (graph: G; node: N; old_edges: SE)
		require
			edges (graph) ~ old_edges
		do
			add_node (graph, node)
		ensure
			edges (graph) ~ old_edges
		end

	frozen a_6 (graph: G; node_1, node_2: N; edge: E; old_edges: SE)
		require
			({ES}).default.rel (node_1, node_2) ~ edge
			edges (graph) ~ old_edges
		do
			add_edge (graph, edge)
			({SES}).default.insert (old_edges, edge)
		ensure
			edges (graph) ~ old_edges
		end

	frozen a_7 (node: N)
		local
			graph: G
			nodes_set: SN
		do
			graph := empty_graph
			nodes_set := ({SNS}).default.empty_set
			check
				adjac (graph, node) ~ nodes_set
			end
		end

	frozen a_8 (graph: G; node_1, node_2: N; old_adjac: SN)
		require
			adjac (graph, node_2) ~ old_adjac
		do
			add_node (graph, node_1)
		ensure
			adjac (graph, node_2) ~ old_adjac
		end

	frozen a_9 (graph: G; node_1, node_2: N; edge: E; old_adjac: SN)
		require
			({ES}).default.rel (node_1, node_2) ~ edge
			adjac (graph, node_1) ~ old_adjac
		do
			add_edge (graph, edge)
			({SNS}).default.insert (old_adjac, node_2)
		ensure
			adjac (graph, node_1) ~ old_adjac
		end

	frozen a_10 (graph: G; node_1, node_2: N; edge: E; old_adjac: SN)
		require
			({ES}).default.rel (node_1, node_2) ~ edge
			adjac (graph, node_2) ~ old_adjac
		do
			add_edge (graph, edge)
			({SNS}).default.insert (old_adjac, node_2)
		ensure
			adjac (graph, node_2) ~ old_adjac
		end

	frozen a_11 (graph: G; node_1, node_2: N; edge: E; old_adjac: SN)
		require
			({ES}).default.rel (node_1, node_2) ~ edge
			adjac (graph, node_2) ~ old_adjac
		do
			add_edge (graph, edge)
			({SNS}).default.insert (old_adjac, node_1)
		ensure
			adjac (graph, node_2) ~ old_adjac
		end

	frozen a_12 (graph: G; node_1, node_2, node_3: N; edge: E; old_adjac: SN)
		require
			node_3 /~ node_1
			node_3 /~ node_2;
			({ES}).default.rel (node_1, node_2) ~ edge
			adjac (graph, node_3) ~ old_adjac
		do
			add_edge (graph, edge)
			({SNS}).default.insert (old_adjac, node_1)
		ensure
			adjac (graph, node_3) ~ old_adjac
		end

	frozen a_13 (node: N)
		local
			graph_1, graph_2: G
		do
			graph_1 := empty_graph
			graph_2 := empty_graph
			nod_out (graph_1, node)
			check
				graph_1 ~ graph_2
			end
		end

	frozen a_14 (graph_1, graph_2: G; node: N)
		require
			graph_1 ~ graph_2
		do
			add_node (graph_1, node)
			nod_out (graph_1, node)
			nod_out (graph_2, node)
		ensure
			graph_1 ~ graph_2
		end

	frozen a_15 (graph_1, graph_2: G; node_1, node_2: N)
		require
			node_1 /~ node_2
			graph_1 ~ graph_2
		do
			add_node (graph_1, node_1)
			nod_out (graph_1, node_2)
			nod_out (graph_2, node_2)
			add_node (graph_2, node_1)
		ensure
			graph_1 ~ graph_2
		end

	frozen a_16 (graph_1, graph_2: G; node_1, node_2: N; edge: E)
		require
			({ES}).default.rel (node_1, node_2) ~ edge
			graph_1 ~ graph_2
		do
			add_edge (graph_1, edge)
			nod_out (graph_1, node_1)
			nod_out (graph_2, node_1)
		ensure
			graph_1 ~ graph_2
		end

	frozen a_17 (graph_1, graph_2: G; node_1, node_2: N; edge: E)
		require
			({ES}).default.rel (node_1, node_2) ~ edge
			graph_1 ~ graph_2
		do
			add_edge (graph_1, edge)
			nod_out (graph_1, node_2)
			nod_out (graph_2, node_2)
		ensure
			graph_1 ~ graph_2
		end

	frozen a_18 (graph_1, graph_2: G; node_1, node_2, node_3: N; edge: E)
		require
			node_3 /~ node_1
			node_3 /~ node_2;
			({ES}).default.rel (node_1, node_2) ~ edge
			graph_1 ~ graph_2
		do
			add_edge (graph_1, edge)
			nod_out (graph_1, node_3)
			nod_out (graph_2, node_3)
			add_edge (graph_2, edge)
		ensure
			graph_1 ~ graph_2
		end

	frozen a_19 (edge: E)
		local
			graph_1, graph_2: G
		do
			graph_1 := empty_graph
			graph_2 := empty_graph
			edge_out (graph_1, edge)
			check
				graph_1 ~ graph_2
			end
		end

	frozen a_20 (graph_1, graph_2: G; node: N; edge: E)
		require
			graph_1 ~ graph_2
		do
			add_node (graph_1, node)
			edge_out (graph_1, edge)
			edge_out (graph_2, edge)
			add_node (graph_2, node)
		ensure
			graph_1 ~ graph_2
		end

	frozen a_21 (graph_1, graph_2: G; edge: E)
		require
			graph_1 ~ graph_2
		do
			add_edge (graph_1, edge)
			edge_out (graph_1, edge)
		ensure
			graph_1 ~ graph_2
		end

	frozen a_22 (graph_1, graph_2: G; edge_1, edge_2: E)
		require
			edge_1 /~ edge_2
			graph_1 ~ graph_2
		do
			add_edge (graph_1, edge_1)
			edge_out (graph_1, edge_2)
			edge_out (graph_2, edge_2)
			add_edge (graph_2, edge_1)
		ensure
			graph_1 ~ graph_2
		end

feature
	-- Well-definedness axioms.

	frozen empty_graph_well_defined
		local
			graph_1, graph_2: G
		do
			graph_1 := empty_graph
			graph_2 := empty_graph
			check
				graph_1 /= graph_2
			end
			check
				graph_1 ~ graph_2
			end
		end

	frozen add_node_well_defined (graph_1, graph_2: G; node: N)
		require
			graph_1 ~ graph_2
		do
			add_node (graph_1, node)
			add_node (graph_2, node)
		ensure
			graph_1 ~ graph_2
		end

	frozen add_edge_well_defined (graph_1, graph_2: G; edge: E)
		require
			graph_1 ~ graph_2
		do
			add_edge (graph_1, edge)
			add_edge (graph_2, edge)
		ensure
			graph_1 ~ graph_2
		end

	frozen nodes_well_defined (graph_1, graph_2: G)
		require
			graph_1 ~ graph_2
		do
		ensure
			nodes (graph_1) ~ nodes (graph_2)
		end

	frozen edges_well_defined (graph_1, graph_2: G)
		require
			graph_1 ~ graph_2
		do
		ensure
			edges (graph_1) ~ edges (graph_2)
		end

	frozen adjac_well_defined (graph_1, graph_2: G; node: N)
		require
			graph_1 ~ graph_2
		do
		ensure
			adjac (graph_1, node) ~ adjac (graph_2, node)
		end

	frozen nod_out_well_defined (graph_1, graph_2: G; node: N)
		require
			graph_1 ~ graph_2
		do
			nod_out (graph_1, node)
			nod_out (graph_2, node)
		ensure
			graph_1 ~ graph_2
		end

	frozen edge_out_well_defined (graph_1, graph_2: G; edge: E)
		require
			graph_1 ~ graph_2
		do
			edge_out (graph_1, edge)
			edge_out (graph_2, edge)
		ensure
			graph_1 ~ graph_2
		end

end
