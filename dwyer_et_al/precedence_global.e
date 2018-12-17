note
	description: "S precedes P globally"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/precedence_global.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	PRECEDENCE_GLOBAL [G, expanded P -> CONDITION [G], expanded S -> CONDITION [G]]

inherit

	REQUIREMENT [G]
		undefine
			time_boundary
		end

feature

	frozen verify (system: G)
		do
			from
				init (system)
			invariant
				p_does_not_hold_or_else_s_holds: not ({P}).default.holds (system) or else ({S}).default.holds (system)
			until
				({S}).default.holds (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({S}).default.out + " precedes " + ({P}).default.out + " globally"
		end

feature

	time_boundary: INTEGER
		do
			Result := 100000
		end

end
