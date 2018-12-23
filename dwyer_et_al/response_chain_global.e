note
	description: "P responds to S, T globally."
	EIS: "name=Multirequirement", "protocol=URI", "src=https://onedrive.live.com/redir?resid=32E19ADBFB60CEC5!114988&authkey=!AA3WI_oulecl9Dg&page=View&wd=target(The Dweyer's Patterns.one|fcd1e8e5-8bf8-407b-9341-841fb4afc81f/Response Chain Global|093bfc14-b576-41ec-ab29-d12332d18b9b/)"
	EIS: "name=Location on GitHub", "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/response_chain_global.e"

deferred class
	RESPONSE_CHAIN_GLOBAL [G, expanded P -> CONDITION [G], expanded S -> CONDITION [G], expanded T -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		require
			({S}).default.holds (system)
		do
			from
				timer := time_boundary
				iterate (system)
			until
				({T}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
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
			Result := ({P}).name + " responds to " + ({S}).name + ", " + ({T}).name + " globally"
		end

	time_boundary: INTEGER
		do
			Result := {INTEGER}.max_value
		end

end
