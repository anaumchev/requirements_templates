note
	description: "P becomes true after Q"
	EIS: "name=Multirequirement", "src=https://onedrive.live.com/redir?resid=32E19ADBFB60CEC5!114988&authkey=!AA3WI_oulecl9Dg&page=View&wd=target(The Dweyer's Patterns.one|fcd1e8e5-8bf8-407b-9341-841fb4afc81f/Bounded Existence Between|15250b61-3492-4a73-97f5-e99635f22c11/)"
	EIS: "name=Location on GitHub", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/existence_after.e"

deferred class
	EXISTENCE_AFTER [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	frozen verify (system: S)
		do
			from
				timer := time_boundary
				init (system)
			until
				({Q}).default.holds (system)
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
			Result := ({P}).name + " becomes true after " + ({Q}).name
		end

	time_boundary: INTEGER
		do
			Result := {INTEGER}.max_value
		end

end
