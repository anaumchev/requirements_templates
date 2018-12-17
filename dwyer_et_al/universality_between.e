note
	description: "P is true between Q and R"
	EIS: "protocol=URI", "src=https://onedrive.live.com/redir?resid=32E19ADBFB60CEC5!114988&authkey=!AA3WI_oulecl9Dg&page=View&wd=target(Requirement Patterns.one|/Universality Between|40f8ad24-fe5b-471a-929f-78bf41dafad0/)"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/universality_between.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	UNIVERSALITY_BETWEEN [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S], expanded R -> CONDITION [S]]

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
				p_holds_or_else_r: ({P}).default.holds (system) or else ({R}).default.holds (system)
			until
				({R}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({P}).default.out + " is true between " + ({Q}).default.out + " and " + ({R}).default.out
		end

end
