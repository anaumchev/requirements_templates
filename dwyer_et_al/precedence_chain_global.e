note
	description: "S, T precedes P globally."
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/precedence_chain_global.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	PRECEDENCE_CHAIN_GLOBAL [G, expanded S -> CONDITION [G], expanded T -> CONDITION [G], expanded P -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		do
			from
				init (system)
			invariant
				not ({P}).default.holds (system)
			until
				({S}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
				iterate (system)
			invariant
				not ({P}).default.holds (system) or else ({T}).default.holds (system)
			until
				({T}).default.holds (system)
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
			Result := ({S}).default.out + ", " + ({T}).default.out + " precedes " + ({P}).default.out + " globally"
		end

end
