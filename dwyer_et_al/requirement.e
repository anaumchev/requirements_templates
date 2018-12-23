note
	description: "Verifiable requirement over S."
	EIS: "name=Location on GitHub", "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/requirement.e"

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
--			if time_boundary /= {INTEGER}.max_value then
--				Result := Result + "The effect should be observed within " + time_boundary.out + " " + time_unit
--				if time_boundary > 1 then
--					Result := Result + "s"
--				end
--				Result := Result + "."
--			end
			Result := Result + "%N"
		end

	requirement_specific_output: STRING
		deferred
		end

feature

	timer: INTEGER

	time_boundary: INTEGER
		deferred
		end

	time_growth: INTEGER
		deferred
		end

	time_unit: STRING
		deferred
		end

end
