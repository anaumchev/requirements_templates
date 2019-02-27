note
	description: "S responds to P globally"
	EIS: "name=Multirequirement", "src=https://onedrive.live.com/redir?resid=32E19ADBFB60CEC5!114988&authkey=!AA3WI_oulecl9Dg&page=View&wd=target(The Dweyer's Patterns.one|fcd1e8e5-8bf8-407b-9341-841fb4afc81f/Response Global|3c5b73db-00a7-4092-b271-44016956292c/)"
	EIS: "name=Location on GitHub", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/response_global.e"

deferred class
	RESPONSE_GLOBAL [G, expanded S -> CONDITION [G], expanded P -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		require
			p_holds: ({P}).default.holds (system)
		do
			from
				timer := time_boundary
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
			Result := ({S}).name + " responds to " + ({P}).name + " globally"
		end

	time_boundary: INTEGER
		do
			Result := {INTEGER}.max_value
		end

end




