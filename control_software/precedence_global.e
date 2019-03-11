note
	description: "S precedes P globally"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y5rmuwef"
	EIS: "name=Location on GitHub", "src=http://tinyurl.com/y3d6xscj"

deferred class
	PRECEDENCE_GLOBAL [G, expanded S -> CONDITION [G], expanded P -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		do
			from
				timer := time_boundary
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
			Result := ({S}).name + " precedes " + ({P}).name + " globally"
		end

	time_boundary: INTEGER
		do
			Result := 100000
		end

end
