note
	description: "P is true after Q"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/universality_after.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	UNIVERSALITY_AFTER [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S]]

inherit

	REQUIREMENT [S]
		undefine
			time_boundary
		end

feature

	frozen verify (system: S)
		require
			q_holds: ({Q}).default.holds (system)
		do
			from
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
			Result := ({P}).default.out + " is true after " + ({Q}).default.out
		end

feature

	time_boundary: INTEGER
		do
			Result := 1
		end

end
