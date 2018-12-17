note
	description: "P is false after Q"
	EIS: "protocol=URI", "src=https://onedrive.live.com/redir?resid=32E19ADBFB60CEC5!114988&authkey=!AA3WI_oulecl9Dg&page=View&wd=target(The Dweyer's Patterns.one|fcd1e8e5-8bf8-407b-9341-841fb4afc81f/Absence Between|3c2fa25d-ccbd-4adb-9c9c-5bb19e6a6d4a/)"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/absence_after.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	ABSENCE_AFTER [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S]]

inherit

	REQUIREMENT [S]
		undefine
			time_boundary
		end

feature

	frozen verify (system: S)
		require
			q_holds: ({Q}).default.holds (system)
		do
			from
			invariant
				p_does_not_hold: not ({P}).default.holds (system)
			until
				timer = 0
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({P}).default.out + " is false after " + ({Q}).default.out
		end

feature

	time_boundary: INTEGER
		do
			Result := 1
		end

end
