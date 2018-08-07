note
	description: "Summary description for {ANY_SD_V_ARRAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IS_ARRAY_WITH_COPY [G]

inherit

	IS_WITH_COPY [ARRAY [G]]

feature

	copy_from_other (object, other: ARRAY [G])
		do
			object.copy (other)
		end

end
