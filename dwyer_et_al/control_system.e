note
	description: "Summary description for {CONTROL_SYSTEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONTROL_SYSTEM [S]

feature

	init (system: S)
		deferred
		end

	iterate (system: S)
		deferred
		end

	time_remaining (system: S): INTEGER
		deferred
		end

end
