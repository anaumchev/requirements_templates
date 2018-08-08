note
	description: "Reusable abstract data type specification of searchable book directory."
	description: "Taken from page 171 of the ``Requirements Engineering'' book by Axel van Lamsweerde."
	EIS: "protocol=URI", "src=https://www.amazon.com/Requirements-Engineering-System-Software-Specifications/dp/0470012706"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"
	date: "8/7/2018"

deferred class
	BOOK_DIRECTORY_ADT [D, B, BC, T, L, LS -> LIST_ADT [L, B]]
	--	Book directories ``D'' contain books ``B'' with topics ``T'' and book copies ``BC''.
	--	Searching by topics returns lists of books ``L''.
	--	To apply this template to your concepts,
	--	inherit from this class with your concepts for the generic types above.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.


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
	
	a_1 (tp: T)
		local
			dir: D
		do
			dir := empty_dir
			check
				biblio_search (dir, tp) ~ ({LS}).default.nil
			end
		end

	a_2 (dir: D; b: B; bc: BC; tp: T; bs: L)
		require
			biblio_search (dir, tp) ~ bs
		do
			({LS}).default.cons (bs, b)
			add_entry (dir, b, bc, tp)
		ensure
			biblio_search (dir, tp) ~ bs
		end

	a_3 (dir: D; b: B; bc: BC; tp_1, tp_2: T; bs: L)
		require
			biblio_search (dir, tp_1) ~ bs
		do
			add_entry (dir, b, bc, tp_2)
		ensure
			biblio_search (dir, tp_1) ~ bs
		end

feature

	empty_dir_well_defined
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

	add_entry_well_defined (dir_1, dir_2: D; b: B; bc: BC; tp: T)
		require
			dir_1 ~ dir_2
		do
			add_entry (dir_1, b, bc, tp)
			add_entry (dir_2, b, bc, tp)
		ensure
			dir_1 ~ dir_2
		end

	biblio_search_well_defined (dir_1, dir_2: D; tp: T)
		require
			dir_1 ~ dir_2
		do
		ensure
			biblio_search (dir_1, tp) ~ biblio_search (dir_2, tp)
		end

end
