note
	description: "P becomes true after Q until R"
	EIS: "name=Multirequirement", "src=https://onedrive.live.com/redir?resid=32E19ADBFB60CEC5!114988&authkey=!AA3WI_oulecl9Dg&page=View&wd=target(The Dweyer's Patterns.one|fcd1e8e5-8bf8-407b-9341-841fb4afc81f/Existence Until|17bdb2b6-ea9c-48fa-8996-1b99d0390ad7/)"
	EIS: "name=Location on GitHub", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/existence_until.e"

deferred class
	EXISTENCE_UNTIL [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S], expanded R -> CONDITION [S]]

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
				r_does_not_hold: not ({R}).default.holds (system)
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
			Result := ({P}).name + " becomes true after " + ({Q}).name + " until " + ({R}).name
		end

	time_boundary: INTEGER
		do
			Result := {INTEGER}.max_value
		end

end
