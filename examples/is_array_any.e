note
	description: "Summary description for {ANY_SD_V_ARRAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IS_ARRAY_ANY [G]

inherit

	IS_ANY [ARRAY [G]]

feature

	are_equal (v_1, v_2: ARRAY [G]): BOOLEAN
		do
			Result := v_1.same_items (v_2)
		end

	copy_from_other (object, other: ARRAY [G])
		do
			object.copy (other)
		end

end
