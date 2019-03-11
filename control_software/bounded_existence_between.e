note
	description: "Transitions to P occur at most 2 times between Q and R."
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y4nr2h8x"
	EIS: "name=Location on GitHub", "src=http://tinyurl.com/yypy2pgb"

deferred class
	BOUNDED_EXISTENCE_BETWEEN [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S], expanded R -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	frozen verify (system: S)
		require
			q_holds: ({Q}).default.holds (system)
		do
			from
				timer := time_boundary
			until
				({R}).default.holds (system) or else not ({P}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				({R}).default.holds (system) or else ({P}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				({R}).default.holds (system) or else not ({P}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				({R}).default.holds (system) or else ({P}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				({R}).default.holds (system) or else not ({P}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
			invariant
				({R}).default.holds (system) or else not ({P}).default.holds (system)
			until
				({R}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
		ensure
			r_holds: ({R}).default.holds (system)
		end

feature

	requirement_specific_output: STRING
		do
			Result := "transitions to " + ({P}).name + " occur at most 2 times between " + ({Q}).name + " and " + ({R}).name
		end

	time_boundary: INTEGER
		do
			Result := {INTEGER}.max_value
		end

end
