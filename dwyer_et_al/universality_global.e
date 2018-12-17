note
	description: "P is true globally"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/universality_global.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	UNIVERSALITY_GLOBAL [S, expanded P -> CONDITION [S]]

inherit

	REQUIREMENT [S]
		undefine
			time_boundary
		end

feature

	frozen verify (system: S)
		do
			from
				init (system)
				timer := time_boundary
			invariant
				p_holds: ({P}).default.holds (system)
			until
				timer = 0
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({P}).default.out + " is true globally"
		end

feature

	time_boundary: INTEGER
		do
			Result := 1
		end

end
