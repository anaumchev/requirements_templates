note
	description: "S precedes P after Q"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y54958zw"
	EIS: "name=Location on GitHub", "src=https://github.com/anaumchev/requirements_templates/blob/master/control_software/precedence_after.e"

deferred class
	PRECEDENCE_AFTER [G, expanded S -> CONDITION [G], expanded P -> CONDITION [G], expanded Q -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		require
			q_holds: ({Q}).default.holds (system)
		do
			from
				timer := time_boundary
			invariant
				p_does_not_hold_or_else_s: not ({P}).default.holds (system) or else ({S}).default.holds (system)
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
			Result := ({S}).name + " precedes " + ({P}).name + " after " + ({Q}).name
		end

	time_boundary: INTEGER
		do
			Result := 100000
		end

end
