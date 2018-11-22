note
	description: "Structuring a control system."
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/control_system.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	REQUIREMENT [S]

inherit

	ANY
		redefine
			out
		end

feature

	timer: INTEGER

	time_boundary: INTEGER
		deferred
		end

	time_growth (system: S): INTEGER
		deferred
		end

	init (system: S)
		deferred
		end

	main (system: S)
		deferred
		end

	iterate (system: S)
		do
			main (system)
			timer := timer - time_growth (system)
		end

	out: STRING
		do
			Result := "For " + ({S}).name + ", the following should hold: " + requirement_specific_output + ". "
			Result := Result + "The effect should be observed within " + time_boundary.out + " " + time_unit
			if time_boundary > 1 then
				Result := Result + "s"
			end
			Result := Result + "."
			Result := Result + "%N"
		end

	time_unit: STRING
		deferred
		end

	requirement_specific_output: STRING
		deferred
		end

end
