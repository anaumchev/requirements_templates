note
	description: "Reusable abstract data type specification of searchable book directory."
	description: "Found in ``Requirements engineering: From system goals to UML models to software.'' by van Lamsweerde:"
	EIS: "src=http://tinyurl.com/yxd3zxd2"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/y6ft5d3a"

deferred class
	BOOK_DIRECTORY_ADT [D, B, BC, T, L, LS -> LIST_ADT [L, B]]
	--	Book directories ``D'' contain books ``B'' with topics ``T'' and book copies ``BC''.
	--	Searching by topics returns lists ``L'' of books ``B'' conforming to the
	--  ``LIST_ADT'' specification.

inherit

	EQUALITY_ADT [D]

feature
	-- Deferred definitions.

	empty_dir: D
		deferred
		end

	add_entry (d: D; b: B; bc: BC; t: T)
		deferred
		end

	biblio_search (d: D; t: T): L
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1 (tp: T)
		local
			dir: D
		do
			dir := empty_dir
			check
				biblio_search (dir, tp) ~ ({LS}).default.nil
			end
		end

	frozen a_2 (dir: D; b: B; bc: BC; tp: T; bs: L)
		require
			biblio_search (dir, tp) ~ bs
		do
			({LS}).default.cons (bs, b)
			add_entry (dir, b, bc, tp)
		ensure
			biblio_search (dir, tp) ~ bs
		end

	frozen a_3 (dir: D; b: B; bc: BC; tp_1, tp_2: T; bs: L)
		require
			biblio_search (dir, tp_1) ~ bs
		do
			add_entry (dir, b, bc, tp_2)
		ensure
			biblio_search (dir, tp_1) ~ bs
		end

feature
	-- Well-definedness axioms

	frozen empty_dir_well_defined
		local
			d_1, d_2: D
		do
			d_1 := empty_dir
			d_2 := empty_dir
			check
				d_1 /= d_2
			end
			check
				d_1 ~ d_2
			end
		end

	frozen add_entry_well_defined (dir_1, dir_2: D; b: B; bc: BC; tp: T)
		require
			dir_1 ~ dir_2
		do
			add_entry (dir_1, b, bc, tp)
			add_entry (dir_2, b, bc, tp)
		ensure
			dir_1 ~ dir_2
		end

	frozen biblio_search_well_defined (dir_1, dir_2: D; tp: T)
		require
			dir_1 ~ dir_2
		do
		ensure
			biblio_search (dir_1, tp) ~ biblio_search (dir_2, tp)
		end

end
