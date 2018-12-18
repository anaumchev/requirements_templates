note
	description: "S precedes P after Q"
	EIS: "name=Multirequirement", "protocol=URI", "src=https://onedrive.live.com/redir?resid=32E19ADBFB60CEC5!114988&authkey=!AA3WI_oulecl9Dg&page=View&wd=target(The Dweyer's Patterns.one|fcd1e8e5-8bf8-407b-9341-841fb4afc81f/Precedence After|6741c6cc-e94f-43a0-924d-6d9cddce3f47/)"
	EIS: "name=Location on GitHub", "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/precedence_after.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	PRECEDENCE_AFTER [G, expanded S -> CONDITION [G], expanded P -> CONDITION [G], expanded Q -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		require
			q_holds: ({Q}).default.holds (system)
		do
			from
				timer := time_boundary
			invariant
				p_does_not_hold_or_else_s: not ({P}).default.holds (system) or else ({S}).default.holds (system)
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
			Result := ({S}).default.out + " precedes " + ({P}).default.out + " after " + ({Q}).default.out
		end

	time_boundary: INTEGER
		do
			Result := 100000
		end

end
