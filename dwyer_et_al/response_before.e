note
	description: "S responds to P before R"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/response_before.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	RESPONSE_BEFORE [G, expanded S -> CONDITION [G], expanded P -> CONDITION [G], expanded R -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		require
			p_holds: ({P}).default.holds (system)
		do
			from
			invariant
				r_does_not_hold: not ({R}).default.holds (system)
			until
				({S}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				({R}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({S}).default.out + " responds to " + ({P}).default.out + " before " + ({R}).default.out
		end

end
