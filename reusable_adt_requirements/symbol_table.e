note
	description: "Reusable abstract data type specification of symbol table."
	description: "Taken from page 4 of the ``Abstract Data Types and the Development of Data Structures'' article by John Guttag."
	EIS: "protocol=URI", "src=http://cecs.wright.edu/people/faculty/tkprasad/courses/cs784/guttag-cacm77.pdf"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"
	date: "8/7/2018"

deferred class
	SYMBOL_TABLE [S, I, A]

inherit

	EQUALITY_ADT [S]

feature

	init: S
			--	Allocate and initialize the symbol table.
		deferred
		end

	enter_block (s_t: S)
			--	Prepare a new local naming scope.
		deferred
		end

	leave_block (s_t: S)
			--	Discard entries from the most recent scope entered,
			--	and reestablish the next outer scope.
		deferred
		end

	is_in_block (s_t: S; id: I): BOOLEAN
			--	Has a specified identifier already been declared in this scope?
			--	(Used to avoid duplicate declarations.)
		deferred
		end

	add (s_t: S; id: I; attr: A)
			--	Add an identifier and its attributes to the symbol table.
		deferred
		end

	retrieve (s_t: S; id: I): A
			--	Return the attributes associated (in the most local scope in which it occurs)
			--	with a specified identifier.
		deferred
		end

feature

	a_2 (s_t_1, s_t_2: S)
		require
			s_t_1 ~ s_t_2
		do
			enter_block (s_t_1)
			leave_block (s_t_1)
		ensure
			s_t_1 ~ s_t_2
		end

	a_3 (s_t_1, s_t_2: S; id: I; attr: A)
		require
			s_t_1 ~ s_t_2
			s_t_1 /= s_t_2
		do
			add (s_t_1, id, attr)
			leave_block (s_t_1)
			leave_block (s_t_2)
		ensure
			s_t_1 ~ s_t_2
		end

	a_4 (id: I)
		local
			s_t: S
		do
			s_t := init
			check
				not is_in_block (s_t, id)
			end
		end

	a_5 (symtab: S; id: I)
		do
			enter_block (symtab)
		ensure
			not is_in_block (symtab, id)
		end

	a_6_1 (symtab: S; id: I; attrs: A)
		do
			add (symtab, id, attrs)
		ensure
			is_in_block (symtab, id)
		end

	a_6_2 (symtab: S; id_1, id_2: I; attrs: A; old_is_in_block: BOOLEAN)
		require
			id_1 /~ id_2
			is_in_block (symtab, id_1) ~ old_is_in_block
		do
			add (symtab, id_1, attrs)
		ensure
			is_in_block (symtab, id_2) ~ old_is_in_block
		end

	a_8 (symtab: S; id: I; attrs: A)
		require
			retrieve (symtab, id) ~ attrs
		do
			enter_block (symtab)
		ensure
			retrieve (symtab, id) ~ attrs
		end

	a_9_1 (symtab: S; id: I; attrs: A)
		do
			add (symtab, id, attrs)
		ensure
			retrieve (symtab, id) ~ attrs
		end

	a_9_2 (symtab: S; id_1, id_2: I; attrs, old_retrieve: A)
		require
			id_1 /~ id_2
			retrieve (symtab, id_2) ~ old_retrieve
		do
			add (symtab, id_1, attrs)
		ensure
			retrieve (symtab, id_2) ~ old_retrieve
		end

feature

	init_well_defined
		local
			symtab_1, symtab_2: S
		do
			symtab_1 := init
			symtab_2 := init
			check
				symtab_1 ~ symtab_2
			end
		end

	enter_block_well_defined (symtab_1, symtab_2: S)
		require
			symtab_1 ~ symtab_2
		do
			enter_block (symtab_1)
			enter_block (symtab_2)
		ensure
			symtab_1 ~ symtab_2
		end

	leave_block_well_defined (symtab_1, symtab_2: S)
		require
			symtab_1 ~ symtab_2
		do
			leave_block (symtab_1)
			leave_block (symtab_2)
		ensure
			symtab_1 ~ symtab_2
		end

	is_in_block_well_defined (symtab_1, symtab_2: S; id: I)
		require
			symtab_1 ~ symtab_2
		do
		ensure
			is_in_block (symtab_1, id) ~ is_in_block (symtab_2, id)
		end

	add_well_defined (symtab_1, symtab_2: S; id: I; attr: A)
		require
			symtab_1 ~ symtab_2
		do
			add (symtab_1, id, attr)
			add (symtab_2, id, attr)
		ensure
			symtab_1 ~ symtab_2
		end

	retrieve_well_defined (symtab_1, symtab_2: S; id: I)
		require
			symtab_1 ~ symtab_2
		do
		ensure
			retrieve (symtab_1, id) ~ retrieve (symtab_2, id)
		end

end
