note
	description: "P becomes true between Q and R"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/existence_between.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	EXISTENCE_BETWEEN [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S], expanded R -> CONDITION [S]]

inherit

	REQUIREMENT [S]
		undefine
			time_boundary
		end

feature

	frozen verify (system: S)
		require
			q_holds: ({Q}).default.holds (system)
			r_does_not_hold: not ({R}).default.holds (system)
		do
			from
			invariant
				r_does_not_hold: not ({R}).default.holds (system)
			until
				({P}).default.holds (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({P}).default.out + " becomes true between " + ({Q}).default.out + " and " + ({R}).default.out
		end

feature

	time_boundary: INTEGER
		do
			Result := 100000
		end

end
