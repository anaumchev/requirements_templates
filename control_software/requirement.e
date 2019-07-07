note
	description: "Verifiable requirement over S."
	EIS: "name=Location on GitHub", "src=http://tinyurl.com/y5rqwzs9"

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
			Result := Current.generating_type.name + ": in "
			Result := Result + ({S}).name + ", "
			Result := Result + requirement_specific_output + ". "
--			Result := Result + "The effect should be observed within " + time_boundary.out + " "
--			Result := Result + time_unit
--			if time_boundary > 1 then
--				Result := Result + "s"
--			end
--			Result := Result + ".%N"
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
		do
		  Result := 1
		end

	time_unit: STRING
		do
		  Result := "time unit"
		end

end











