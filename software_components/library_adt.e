note
	description: "Reusable abstract data type specification of library."
	description: "Found in ``Requirements engineering: From system goals to UML models to software.'' by van Lamsweerde:"
	EIS: "src=http://tinyurl.com/yxd3zxd2"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/y4jnocr4"

deferred class
	LIBRARY_ADT [L, B]
	--	Libraries ``L'' contain books ``B''.

inherit

	EQUALITY_ADT [L]

feature
	-- Deferred definitions.

	empty_lib: L
		deferred
		end

	add_copy (l: L; b: B)
		deferred
		end

	remove_copy (l: L; b: B)
		deferred
		end

	check_out (l: L; b: B)
		deferred
		end

	return (l: L; b: B)
		deferred
		end

	copy_exists (l: L; b: B): BOOLEAN
		deferred
		end

	copy_borrowed (l: L; b: B): BOOLEAN
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1 (lib: L; bc: B)
		local
			new_lib: L
		do
			new_lib := empty_lib
			check
				not copy_exists (new_lib, bc)
			end
		end

	frozen a_2 (lib: L; bc: B)
		do
			add_copy (lib, bc)
		ensure
			copy_exists (lib, bc)
		end

	frozen a_3 (lib: L; bc_1, bc_2: B; bc_2_exists: BOOLEAN)
		require
			bc_1 /~ bc_2
			copy_exists (lib, bc_2) ~ bc_2_exists
		do
			add_copy (lib, bc_1)
		ensure
			copy_exists (lib, bc_2) ~ bc_2_exists
		end

	frozen a_4 (lib: L; bc_1, bc_2: B; bc_2_exists: BOOLEAN)
		require
			copy_exists (lib, bc_2) ~ bc_2_exists
			not copy_borrowed (lib, bc_1)
		do
			check_out (lib, bc_1)
		ensure
			copy_exists (lib, bc_2) ~ bc_2_exists
		end

	frozen a_5 (lib: L; bc: B)
		local
			new_lib: L
		do
			new_lib := empty_lib
			check
				not copy_borrowed (lib, bc)
			end
		end

	frozen a_6 (lib: L; bc_1, bc_2: B; bc_2_borrowed: BOOLEAN)
		require
			copy_borrowed (lib, bc_2) ~ bc_2_borrowed
		do
			add_copy (lib, bc_1)
		ensure
			copy_borrowed (lib, bc_2) ~ bc_2_borrowed
		end

	frozen a_7 (lib: L; bc: B)
		require
			not copy_borrowed (lib, bc)
		do
			check_out (lib, bc)
		ensure
			copy_borrowed (lib, bc)
		end

	frozen a_8 (lib: L; bc_1, bc_2: B; bc_2_borrowed: BOOLEAN)
		require
			bc_1 /~ bc_2
			copy_borrowed (lib, bc_2) ~ bc_2_borrowed
			not copy_borrowed (lib, bc_1)
		do
			check_out (lib, bc_1)
		ensure
			copy_borrowed (lib, bc_2) ~ bc_2_borrowed
		end

	frozen a_9 (lib_1, lib_2: L; bc: B)
		require
			lib_1 ~ lib_2
		do
			add_copy (lib_1, bc)
			remove_copy (lib_1, bc)
		ensure
			lib_1 ~ lib_2
		end

	frozen a_10 (lib_1, lib_2: L; bc_1, bc_2: B)
		require
			lib_1 /= lib_2
			lib_1 ~ lib_2
			bc_1 /~ bc_2
			copy_exists (lib_1, bc_2)
			copy_exists (lib_2, bc_2)
		do
			add_copy (lib_1, bc_1)
			remove_copy (lib_1, bc_2)
			remove_copy (lib_2, bc_2)
			add_copy (lib_2, bc_1)
		ensure
			lib_1 ~ lib_2
		end

	frozen a_11 (lib_1, lib_2: L; bc: B)
		require
			lib_1 /= lib_2
			lib_1 ~ lib_2
			not copy_borrowed (lib_1, bc)
			copy_exists (lib_1, bc)
			copy_exists (lib_2, bc)
		do
			check_out (lib_1, bc)
			remove_copy (lib_1, bc)
			remove_copy (lib_2, bc)
		ensure
			lib_1 ~ lib_2
		end

	frozen a_12 (lib_1, lib_2: L; bc_1, bc_2: B)
		require
			lib_1 /= lib_2
			lib_1 ~ lib_2
			bc_1 /~ bc_2
			not copy_borrowed (lib_1, bc_1)
			copy_exists (lib_1, bc_2)
			copy_exists (lib_2, bc_2)
			not copy_borrowed (lib_2, bc_1)
		do
			check_out (lib_1, bc_1)
			remove_copy (lib_1, bc_2)
			remove_copy (lib_2, bc_2)
			check_out (lib_2, bc_1)
		ensure
			lib_1 ~ lib_2
		end

	frozen a_13 (lib_1, lib_2: L; bc: B)
		require
			lib_1 ~ lib_2
			not copy_borrowed (lib_1, bc)
		do
			check_out (lib_1, bc)
			return (lib_1, bc)
		ensure
			lib_1 ~ lib_2
		end

	frozen a_14 (lib_1, lib_2: L; bc_1, bc_2: B)
		require
			lib_1 /= lib_2
			lib_1 ~ lib_2
			bc_1 /~ bc_2
			not copy_borrowed (lib_1, bc_1)
			copy_borrowed (lib_1, bc_2)
			copy_borrowed (lib_2, bc_2)
			not copy_borrowed (lib_2, bc_1)
		do
			check_out (lib_1, bc_1)
			return (lib_1, bc_2)
			return (lib_2, bc_2)
			check_out (lib_2, bc_1)
		ensure
			lib_1 ~ lib_2
		end

	frozen a_15 (lib_1, lib_2: L; bc_1, bc_2: B)
		require
			lib_1 /= lib_2
			lib_1 ~ lib_2
			bc_1 /~ bc_2
			copy_borrowed (lib_1, bc_2)
			copy_borrowed (lib_2, bc_2)
		do
			add_copy (lib_1, bc_1)
			return (lib_1, bc_2)
			return (lib_2, bc_2)
			add_copy (lib_2, bc_1)
		ensure
			lib_1 ~ lib_2
		end

feature
	-- Well-definedness axioms.

	frozen empty_lib_well_defined
		local
			lib_1, lib_2: L
		do
			lib_1 := empty_lib
			lib_2 := empty_lib
			check
				lib_1 /= lib_2
			end
			check
				lib_1 ~ lib_2
			end
		end

	frozen add_copy_well_defined (lib_1, lib_2: L; bc: B)
		require
			lib_1 ~ lib_2
		do
			add_copy (lib_1, bc)
			add_copy (lib_2, bc)
		ensure
			lib_1 ~ lib_2
		end

	frozen remove_copy_well_defined (lib_1, lib_2: L; bc: B)
		require
			lib_1 ~ lib_2
			lib_1 /= lib_2
			copy_exists (lib_1, bc)
			copy_exists (lib_2, bc)
		do
			remove_copy (lib_1, bc)
			remove_copy (lib_2, bc)
		ensure
			lib_1 ~ lib_2
		end

	frozen check_out_well_defined (lib_1, lib_2: L; bc: B)
		require
			lib_1 ~ lib_2
			lib_1 /= lib_2
			not copy_borrowed (lib_1, bc)
			not copy_borrowed (lib_2, bc)
		do
			check_out (lib_1, bc)
			check_out (lib_2, bc)
		ensure
			lib_1 ~ lib_2
		end

	frozen return_well_defined (lib_1, lib_2: L; bc: B)
		require
			lib_1 ~ lib_2
			lib_1 /= lib_2
			copy_borrowed (lib_1, bc)
			copy_borrowed (lib_2, bc)
		do
			return (lib_1, bc)
			return (lib_2, bc)
		ensure
			lib_1 ~ lib_2
		end

	frozen copy_exists_well_defined (lib_1, lib_2: L; bc: B)
		require
			lib_1 ~ lib_2
		do
		ensure
			copy_exists (lib_1, bc) ~ copy_exists (lib_2, bc)
		end

	frozen copy_borrowed_well_defined (lib_1, lib_2: L; bc: B)
		require
			lib_1 ~ lib_2
		do
		ensure
			copy_borrowed (lib_1, bc) ~ copy_borrowed (lib_2, bc)
		end

end
