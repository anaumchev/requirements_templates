note
	description: "Summary description for {TIME_UNBOUNDED_CONTROL_SYSTEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TIME_UNBOUNDED_CONTROL_SYSTEM [S]

inherit

	CONTROL_SYSTEM [S]

feature

	main (system: S)
		deferred
		end

	frozen time: INTEGER

	frozen iterate (system: S)
		do
			main (system)
			time := time + 1
		end

	frozen time_remaining (system: S): INTEGER
		do
			Result := (0).max_value - time
		end

end
