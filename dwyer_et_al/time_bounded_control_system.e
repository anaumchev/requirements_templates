note
	description: "Summary description for {CONTROL_SYSTEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TIME_BOUNDED_CONTROL_SYSTEM [S]

inherit

	CONTROL_SYSTEM [S]

feature

	main (system: S)
		deferred
		end

	time_boundary (system: S): INTEGER
		deferred
		end

	time_growth (system: S): INTEGER
		deferred
		end

	frozen time: INTEGER

	frozen iterate (system: S)
		do
			main (system)
			time := time + time_growth (system)
		end

	frozen time_remaining (system: S): INTEGER
		do
			Result := time_boundary (system) - time
		end

end
