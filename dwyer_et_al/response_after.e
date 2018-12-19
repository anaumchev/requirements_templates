note
	description: "S responds to P after Q"
	EIS: "name=Multirequirement", "protocol=URI", "src=https://onedrive.live.com/redir?resid=32E19ADBFB60CEC5!114988&authkey=!AA3WI_oulecl9Dg&page=View&wd=target(The Dweyer's Patterns.one|fcd1e8e5-8bf8-407b-9341-841fb4afc81f/Response After|4aedea20-b23d-4f88-82b2-f1b74857fd53/)"
	EIS: "name=Location on GitHub", "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/response_after.e"

deferred class
	RESPONSE_AFTER [G, expanded S -> CONDITION [G], expanded P -> CONDITION [G], expanded Q -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		require
			q_holds: ({Q}).default.holds (system)
		do
			from
				timer := time_boundary
			until
				({P}).default.holds (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
			check
				assume: ({P}).default.holds (system)
			end
			from
			until
				({S}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({S}).default.out + " responds to " + ({P}).default.out + " after " + ({Q}).default.out + "."
		end

	time_boundary: INTEGER
		do
			Result := 100000
		end

end
