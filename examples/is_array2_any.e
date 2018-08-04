note
	description: "Summary description for {ANY_SD_V_ARRAY2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IS_ARRAY2_ANY [G]

inherit

	IS_ANY [ARRAY2 [G]]

feature

	are_equal (v_1, v_2: ARRAY2 [G]): BOOLEAN
		do
			Result := v_1.same_items (v_2)
		end

	copy_from_other (object, other: ARRAY2 [G])
		do
			object.copy (other)
		end

end
