note
	description: "P is false before R"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y28f8xxg"
	EIS: "name=Location on GitHub", "src=http://tinyurl.com/yykmrtwe"

deferred class
	ABSENCE_BEFORE [S, expanded P -> CONDITION [S], expanded R -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	frozen verify (system: S)
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
			Result := ({P}).name + " is false before " + ({R}).name
		end

	time_boundary: INTEGER
		do
			Result := {INTEGER}.max_value
		end

end
