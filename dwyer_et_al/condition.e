note
	description: "Summary description for {CONDITION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONDITION [S]

inherit

	ANY
		undefine
			out
		end

feature

	holds (system: S): BOOLEAN
		deferred
		end

end
