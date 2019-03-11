note
	description: "P becomes true between Q and R"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y2prdopt"
	EIS: "name=Location on GitHub", "src=http://tinyurl.com/y5vq9hg9"

deferred class
	EXISTENCE_BETWEEN [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S], expanded R -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	frozen verify (system: S)
		require
			q_holds: ({Q}).default.holds (system)
			r_does_not_hold: not ({R}).default.holds (system)
		do
			from
				timer := time_boundary
			invariant
				r_does_not_hold: not ({R}).default.holds (system)
			until
				({P}).default.holds (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({P}).name + " becomes true between " + ({Q}).name + " and " + ({R}).name
		end

	time_boundary: INTEGER
		do
			Result := 100000
		end

end
