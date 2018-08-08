note
	description: "Reusable abstract data type specification of mapping."
	description: "From the ``Abstract Data Types and Software Validation'' article by Guttag, Horowitz and Musser, p. 17"
	description: "Follow the EIS link below for details."
	EIS: "protocol=URI", "src=https://pdfs.semanticscholar.org/372d/4f331d0a6cd5fb4ee0c04d4a0753b8eb659f.pdf"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"
	date: "8/8/2018"

deferred class
	MAPPING_ADT [M, D, R]
	--	Mappings ``M'' have ``D'' as domain and ``R'' as range.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``M'', ``D'', and ``R''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

feature
	--	Deferred definitions.

	new_map: M
		deferred
		end

	def_map (map: M; dval: D; rval: R)
		deferred
		end

	ev_map (map: M; dval: D): R
		deferred
		end

	is_defined (map: M; dval: D): BOOLEAN
		deferred
		end

feature
	--	Abstract data type axioms.

	a_1 (dval: D)
		local
			map: M
		do
			map := new_map
			check
				ev_map (map, dval) ~ ({R}).default
			end
		end

	a_2 (map: M; dval: D; rval: R)
		do
			def_map (map, dval, rval)
		ensure
			ev_map (map, dval) ~ rval
		end

	a_3 (map: M; dval_1, dval_2: D; rval, old_ev_map: R)
		require
			ev_map (map, dval_2) ~ old_ev_map
			dval_1 /~ dval_2
		do
			def_map (map, dval_1, rval)
		ensure
			ev_map (map, dval_2) ~ old_ev_map
		end

	a_4 (dval: D)
		local
			map: M
		do
			map := new_map
			check
				not is_defined (map, dval)
			end
		end

	a_5 (map: M; dval: D; rval: R)
		do
			def_map (map, dval, rval)
		ensure
			is_defined (map, dval)
		end

	a_6 (map: M; dval_1, dval_2: D; rval: R; old_is_defined: BOOLEAN)
		require
			is_defined (map, dval_2) ~ old_is_defined
			dval_1 /~ dval_2
		do
			def_map (map, dval_1, rval)
		ensure
			is_defined (map, dval_2) ~ old_is_defined
		end

feature
	--	Well-definedness definitions.

	new_map_well_defined
		local
			map_1, map_2: M
		do
			map_1 := new_map
			map_2 := new_map
			check
				map_1 /= map_2
			end
			check
				map_1 ~ map_2
			end
		end

	def_map_well_defined (map_1, map_2: M; dval: D; rval: R)
		require
			map_1 ~ map_2
		do
			def_map (map_1, dval, rval)
			def_map (map_2, dval, rval)
		ensure
			map_1 ~ map_2
		end

	ev_map_well_defined (map_1, map_2: M; dval: D)
		require
			map_1 ~ map_2
		do
		ensure
			ev_map (map_1, dval) ~ ev_map (map_2, dval)
		end

	is_defined_well_defined (map_1, map_2: M; dval: D)
		require
			map_1 ~ map_2
		do
		ensure
			is_defined (map_1, dval) ~ is_defined (map_2, dval)
		end

end
