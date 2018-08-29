note
	description: "Summary description for {CONTROL_SYSTEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONTROL_SYSTEM [S]

feature

	verification_boundary_reached (system: S): BOOLEAN
		deferred
		end

	init: S
		deferred
		end

	main (system: S)
		deferred
		end

end
