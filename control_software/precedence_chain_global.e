note
	description: "S, T precedes P globally."
	EIS: "name=Multirequirement", "src=https://onedrive.live.com/redir?resid=32E19ADBFB60CEC5!114988&authkey=!AA3WI_oulecl9Dg&page=View&wd=target(The Dweyer's Patterns.one|fcd1e8e5-8bf8-407b-9341-841fb4afc81f/Precedence Chain Global|8a34a92c-06a7-4121-a5cc-a06851af366a/)"
	EIS: "name=Location on GitHub", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/precedence_chain_global.e"

deferred class
	PRECEDENCE_CHAIN_GLOBAL [G, expanded S -> CONDITION [G], expanded T -> CONDITION [G], expanded P -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		do
			from
				timer := time_boundary
				init (system)
			invariant
				not ({P}).default.holds (system)
			until
				({S}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
				iterate (system)
			invariant
				not ({P}).default.holds (system) or else ({T}).default.holds (system)
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
			Result := ({S}).name + ", " + ({T}).name + " precedes " + ({P}).name + " globally"
		end

	time_boundary: INTEGER
		do
			Result := {INTEGER}.max_value
		end

end
