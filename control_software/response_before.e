note
	description: "S responds to P before R"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y2b69k9o"
	EIS: "name=Location on GitHub", "src=https://github.com/anaumchev/requirements_templates/blob/master/control_software/response_before.e"

deferred class
	RESPONSE_BEFORE [G, expanded S -> CONDITION [G], expanded P -> CONDITION [G], expanded R -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		require
			p_holds: ({P}).default.holds (system)
		do
			from
				timer := time_boundary
			invariant
				r_does_not_hold: not ({R}).default.holds (system)
			until
				({S}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
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
			Result := ({S}).name + " responds to " + ({P}).name + " before " + ({R}).name
		end

	time_boundary: INTEGER
		do
			Result := {INTEGER}.max_value
		end

end
