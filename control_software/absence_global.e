note
	description: "P is false globally"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y5a6bb8u"
	EIS: "name=Location on GitHub", "src=http://tinyurl.com/yx9cd6va"

deferred class
	ABSENCE_GLOBAL [S, expanded P -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	frozen verify (system: S)
		do
			from
				timer := time_boundary
				init (system)
			invariant
				p_does_not_hold: not ({P}).default.holds (system)
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
			Result := ({P}).name + " is false globally"
		end

feature

	time_boundary: INTEGER
		do
			Result := 1
		end

end
