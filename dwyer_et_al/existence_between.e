note
	description: "P becomes true between Q and R"
	EIS: "protocol=URI", "src=https://onedrive.live.com/redir?resid=32E19ADBFB60CEC5!114988&authkey=!AA3WI_oulecl9Dg&page=View&wd=target(The Dweyer's Patterns.one|fcd1e8e5-8bf8-407b-9341-841fb4afc81f/Existence Between|03b06131-fbf3-4fd9-8995-dbf46fffef6d/)"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/existence_between.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	EXISTENCE_BETWEEN [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S], expanded R -> CONDITION [S]]

inherit

	REQUIREMENT [S]
		undefine
			time_boundary
		end

feature

	frozen verify (system: S)
		require
			q_holds: ({Q}).default.holds (system)
			r_does_not_hold: not ({R}).default.holds (system)
		do
			from
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
			Result := ({P}).default.out + " becomes true between " + ({Q}).default.out + " and " + ({R}).default.out
		end

feature

	time_boundary: INTEGER
		do
			Result := 100000
		end

end
