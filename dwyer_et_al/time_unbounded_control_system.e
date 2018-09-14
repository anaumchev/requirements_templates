note
	description: "Summary description for {TIME_UNBOUNDED_CONTROL_SYSTEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TIME_UNBOUNDED_CONTROL_SYSTEM [S]

inherit

	TIME_BOUNDED_CONTROL_SYSTEM [S]

feature

	frozen time_boundary (system: S): INTEGER
		do
			Result := (0).max_value
		end

	frozen time_growth (system: S): INTEGER
		do
			Result := 1
		end

end
