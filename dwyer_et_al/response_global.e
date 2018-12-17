note
	description: "S responds to P globally"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/response/response_globally.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	RESPONSE_GLOBAL [G, expanded P -> CONDITION [G], expanded S -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		require
			p_holds: ({P}).default.holds (system)
		do
			from
				timer := time_boundary
			until
				({S}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({S}).default.out + " responds to " + ({P}).default.out + " globally"
		end

end
