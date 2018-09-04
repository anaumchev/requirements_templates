note
	description: "Summary description for {CONTROL_SYSTEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONTROL_SYSTEM [S]

feature

	init: S
		deferred
		end

	main (system: S)
		deferred
		end

	verification_boundary_crossed (system: S): BOOLEAN
		deferred
		end

end
