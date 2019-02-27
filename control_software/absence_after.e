note
	description: "P is false after Q"
	EIS: "name=Multirequirement", "src=https://onedrive.live.com/redir?resid=32E19ADBFB60CEC5!114988&authkey=!AA3WI_oulecl9Dg&page=View&wd=target(The Dweyer's Patterns.one|fcd1e8e5-8bf8-407b-9341-841fb4afc81f/Absence After|90efb881-6a8e-41fe-add3-3e1faddd8d2d/)"
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
