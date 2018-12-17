note
	description: "P becomes true after Q until R"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/existence_until.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	EXISTENCE_UNTIL [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S], expanded R -> CONDITION [S]]

inherit

	REQUIREMENT [S]

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
				({P}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({P}).default.out + " becomes true after " + ({Q}).default.out + " until " + ({R}).default.out
		end

end
