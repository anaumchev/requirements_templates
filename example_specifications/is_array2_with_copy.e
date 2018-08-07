note
	description: "Summary description for {ANY_SD_V_ARRAY2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IS_ARRAY2_WITH_COPY [G]

inherit

	COPY_ADT [ARRAY2 [G]]

feature

	copy_from_other (object, other: ARRAY2 [G])
		do
			object.copy (other)
		end

end
