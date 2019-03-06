note
	description: "S responds to P after Q"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/yyso3qn8"
	EIS: "name=Location on GitHub", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/response_after.e"

deferred class
	RESPONSE_AFTER [G, expanded S -> CONDITION [G], expanded P -> CONDITION [G], expanded Q -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		require
			q_holds: ({Q}).default.holds (system)
		do
			from
				timer := time_boundary
			until
				({P}).default.holds (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
			check
				assume: ({P}).default.holds (system)
			end
			from
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
			Result := ({S}).name + " responds to " + ({P}).name + " after " + ({Q}).name + "."
		end

	time_boundary: INTEGER
		do
			Result := 100000
		end

end
