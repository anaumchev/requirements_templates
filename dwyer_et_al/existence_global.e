note
	description: "P becomes true globally"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/existence_global.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	EXISTENCE_GLOBAL [S, expanded P -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	frozen verify (system: S)
		do
			from
				init (system)
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
			Result := ({P}).default.out + " becomes true globally"
		end

end
