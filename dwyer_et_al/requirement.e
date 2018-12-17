note
	description: "Verifiable requirement over S."
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/requirement.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	REQUIREMENT [S]

inherit

	ANY
		undefine
			out
		end

feature

	init (system: S)
		deferred
		end

	main (system: S)
		deferred
		end

	iterate (system: S)
		do
			main (system)
			timer := timer - time_growth
		end

	out: STRING
		do
			Result := ({S}).name + " " + requirement_specific_output + ". "
			if time_boundary /= {INTEGER}.max_value then
				Result := Result + "The effect should be observed within " + time_boundary.out + " " + time_unit
				if time_boundary > 1 then
					Result := Result + "s"
				end
				Result := Result + "."
			end
			Result := Result + "%N"
		end

	requirement_specific_output: STRING
		deferred
		end

feature

	timer: INTEGER

	time_boundary: INTEGER
		do
			Result := {INTEGER}.max_value
		end

	time_growth: INTEGER
		do
			Result := 1
		end

	time_unit: STRING
		do
			Result := "iteration"
		end

end
