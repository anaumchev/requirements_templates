note
	description: "Summary description for {IS_V_LINKED_STACK_STACK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IS_LINKED_STACK_STACK [G]

inherit

	IS_STACK [LINKED_STACK [G], G]

feature

	new: LINKED_STACK [G]
		do
			create Result.make
		end

	empty (v: LINKED_STACK [G]): BOOLEAN
		do
			Result := v.is_empty
		end

	top (v: LINKED_STACK [G]): G
		do
			Result := v.item
		end

	push (v: LINKED_STACK [G]; x: G)
		do
			v.extend (x)
		end

	pop (v: LINKED_STACK [G])
		do
			v.remove
		end

	are_equal (v_1, v_2: LINKED_STACK [G]): BOOLEAN
		do
			Result := v_1.linear_representation.to_array.same_items (v_2.linear_representation.to_array)
		end

	copy_from_other (object, other: LINKED_STACK [G])
		do
			object.copy (other)
		end

	size (object: LINKED_STACK [G]): INTEGER
		do
			Result := object.count
		end

end
