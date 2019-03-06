note
	description: "P is false after Q"
	EIS: "name=Multirequirement", "src=http://tinyurl.com/yxcwu8vw"
	EIS: "name=Location on GitHub", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/absence_after.e"

deferred class
	ABSENCE_AFTER [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	frozen verify (system: S)
		require
			q_holds: ({Q}).default.holds (system)
		do
			from
				timer := time_boundary
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
			Result := ({P}).name + " is false after " + ({Q}).name
		end

	time_boundary: INTEGER
		do
			Result := 1
		end

end
