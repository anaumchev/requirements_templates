note
	description: "P becomes true before R"
	EIS: "name=Multirequirement", "protocol=URI", "src=https://onedrive.live.com/redir?resid=32E19ADBFB60CEC5!114988&authkey=!AA3WI_oulecl9Dg&page=View&wd=target(The Dweyer's Patterns.one|fcd1e8e5-8bf8-407b-9341-841fb4afc81f/Existence Before|d4c53be2-e6b2-47b7-a7c2-85051782de1d/)"
	EIS: "name=Location on GitHub", "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/existence_before.e"

deferred class
	EXISTENCE_BEFORE [S, expanded P -> CONDITION [S], expanded R -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	frozen verify (system: S)
		do
			from
				timer := time_boundary
			invariant
				r_does_not_hold: not ({R}).default.holds (system)
			until
				({P}).default.holds (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({P}).name + " becomes true before " + ({R}).name
		end

	time_boundary: INTEGER
		do
			Result := 100000
		end

end
