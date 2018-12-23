note
	description: "S precedes P globally"
	EIS: "name=Multirequirement", "protocol=URI", "src=https://onedrive.live.com/redir?resid=32E19ADBFB60CEC5!114988&authkey=!AA3WI_oulecl9Dg&page=View&wd=target(The Dweyer's Patterns.one|fcd1e8e5-8bf8-407b-9341-841fb4afc81f/Precedence Global|ad5a6285-784b-455e-b427-a6aebe7e0c76/)"
	EIS: "name=Location on GitHub", "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/precedence_global.e"

deferred class
	PRECEDENCE_GLOBAL [G, expanded P -> CONDITION [G], expanded S -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		do
			from
				timer := time_boundary
				init (system)
			invariant
				p_does_not_hold_or_else_s_holds: not ({P}).default.holds (system) or else ({S}).default.holds (system)
			until
				({S}).default.holds (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({S}).name + " precedes " + ({P}).name + " globally"
		end

	time_boundary: INTEGER
		do
			Result := 100000
		end

end
