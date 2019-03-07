note
	description: "P is false after Q until R"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y3onr2bn"
	EIS: "name=Location on GitHub", "src=https://github.com/anaumchev/requirements_templates/blob/master/control_software/absence_until.e"

deferred class
	ABSENCE_UNTIL [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S], expanded R -> CONDITION [S]]

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
				({R}).default.holds (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({P}).name + " is false after " + ({Q}).name + " until " + ({R}).name
		end

	time_boundary: INTEGER
		do
			Result := 100000
		end

end
