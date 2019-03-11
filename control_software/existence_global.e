note
	description: "P becomes true globally"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y5rrbsrk"
	EIS: "name=Location on GitHub", "src=http://tinyurl.com/yxgvkktt"

deferred class
	EXISTENCE_GLOBAL [S, expanded P -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	frozen verify (system: S)
		do
			from
				timer := time_boundary
				init (system)
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
			Result := ({P}).name + " becomes true globally"
		end

	time_boundary: INTEGER
		do
			Result := {INTEGER}.max_value
		end

end
