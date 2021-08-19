note
	description: "P is false between Q and R"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y4nkt92q"
	EIS: "name=Location on GitHub", "src=http://tinyurl.com/y4ltn92p"

deferred class
	ABSENCE_BETWEEN [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S], expanded R -> CONDITION [S]]

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
				p_does_not_hold_or_else_r_holds: not ({P}).default.holds (system) or else ({R}).default.holds (system)
			until
				({R}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := "if " + ({P}).name + " remains false after " + ({Q}).name + " then the system will eventually reach " + ({R}).name
		end

	time_boundary: INTEGER
		do
			Result := {INTEGER}.max_value
		end

end
