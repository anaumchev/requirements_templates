note
	description: "P becomes true after Q"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/existence_after.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	EXISTENCE_AFTER [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	frozen verify (system: S)
		do
			from
				init (system)
			until
				({Q}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
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
			Result := ({P}).default.out + " becomes true after " + ({Q}).default.out
		end

end
