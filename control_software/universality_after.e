note
	description: "P is true after Q"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y3e7vrvx"
	EIS: "name=Location on GitHub", "src=http://tinyurl.com/y35pz34n"

deferred class
	UNIVERSALITY_AFTER [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	frozen verify (system: S)
		require
			q_holds: ({Q}).default.holds (system)
		do
			from
				timer := time_boundary
			invariant
				p_holds: ({P}).default.holds (system)
			until
				timer = 0
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({P}).name + " is true after " + ({Q}).name
		end

	time_boundary: INTEGER
		do
			Result := 1
		end

end
