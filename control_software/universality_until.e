note
	description: "P is true after Q until R"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y3mgklvw"
	EIS: "name=Location on GitHub", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/universality_until.e"

deferred class
	UNIVERSALITY_UNTIL [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S], expanded R -> CONDITION [S]]

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
				p_holds_or_else_r_holds: ({P}).default.holds (system) or else ({R}).default.holds (system)
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
			Result := ({P}).name + " is true after " + ({Q}).name + " until " + ({R}).name
		end

	time_boundary: INTEGER
		do
			Result := 100000
		end

end
