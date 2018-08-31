note
	description: "Summary description for {TIME_BOUNDED_SYSTEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TIME_BOUNDED_SYSTEM [S]

inherit

	CONTROL_SYSTEM [S]

feature

	time: INTEGER

	bound (system: S): INTEGER
		deferred
		end

	verification_boundary_reached (system: S): BOOLEAN
		do
			Result := time >= bound (system)
		end

end
