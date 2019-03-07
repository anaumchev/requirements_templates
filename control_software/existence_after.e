note
	description: "P becomes true after Q"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y644k9hl"
	EIS: "name=Location on GitHub", "src=https://github.com/anaumchev/requirements_templates/blob/master/control_software/existence_after.e"

deferred class
	EXISTENCE_AFTER [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	frozen verify (system: S)
		do
			from
				timer := time_boundary
				init (system)
			until
				({Q}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				({P}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({P}).name + " becomes true after " + ({Q}).name
		end

	time_boundary: INTEGER
		do
			Result := {INTEGER}.max_value
		end

end
