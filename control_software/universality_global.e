note
	description: "P is true globally"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y3hrpltn"
	EIS: "name=Location on GitHub", "src=http://tinyurl.com/y46rbz87"

deferred class
	UNIVERSALITY_GLOBAL [S, expanded P -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	frozen verify (system: S)
		do
			from
				timer := time_boundary
				init (system)
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
			Result := ({P}).name + " is true globally"
		end

	time_boundary: INTEGER
		do
			Result := 1
		end

end
