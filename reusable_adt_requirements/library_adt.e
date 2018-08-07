note
	description: "Reusable abstract data type specification of library."
	description: "Taken from page 170 of the ``Requirements Engineering'' book by Axel van Lamsweerde."
	EIS: "protocol=URI", "src=https://www.amazon.com/Requirements-Engineering-System-Software-Specifications/dp/0470012706"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"
	date: "8/7/2018"

deferred class
	LIBRARY_ADT [L, B]
	--	Libraries ``L'' contain books ``B''.
	--	To apply this template to your concepts,
	--	inherit from this class with your concepts for ``L'' and ``B''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	EQUALITY_ADT [L]
	--	Libraries feature an equality relation.

feature
	--	Deferred definitions to be effected.

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
	--	Library axioms to model check or test.

	a_1 (lib: L; bc: B)
		local
			new_lib: L
		do
			new_lib := empty_lib
			check
				not copy_exists (new_lib, bc)
			end
		end

	a_2 (lib: L; bc: B)
		do
			add_copy (lib, bc)
		ensure
			copy_exists (lib, bc)
		end

	a_3 (lib: L; bc_1, bc_2: B; bc_2_exists: BOOLEAN)
		require
			bc_1 /~ bc_2
			copy_exists (lib, bc_2) ~ bc_2_exists
		do
			add_copy (lib, bc_1)
		ensure
			copy_exists (lib, bc_2) ~ bc_2_exists
		end

	a_4 (lib: L; bc_1, bc_2: B; bc_2_exists: BOOLEAN)
		require
			copy_exists (lib, bc_2) ~ bc_2_exists
			not copy_borrowed (lib, bc_1)
		do
			check_out (lib, bc_1)
		ensure
			copy_exists (lib, bc_2) ~ bc_2_exists
		end

	a_5 (lib: L; bc: B)
		local
			new_lib: L
		do
			new_lib := empty_lib
			check
				not copy_borrowed (lib, bc)
			end
		end

	a_6 (lib: L; bc_1, bc_2: B; bc_2_borrowed: BOOLEAN)
		require
			copy_borrowed (lib, bc_2) ~ bc_2_borrowed
		do
			add_copy (lib, bc_1)
		ensure
			copy_borrowed (lib, bc_2) ~ bc_2_borrowed
		end

	a_7 (lib: L; bc: B)
		require
			not copy_borrowed (lib, bc)
		do
			check_out (lib, bc)
		ensure
			copy_borrowed (lib, bc)
		end

	a_8 (lib: L; bc_1, bc_2: B; bc_2_borrowed: BOOLEAN)
		require
			bc_1 /~ bc_2
			copy_borrowed (lib, bc_2) ~ bc_2_borrowed
			not copy_borrowed (lib, bc_1)
		do
			check_out (lib, bc_1)
		ensure
			copy_borrowed (lib, bc_2) ~ bc_2_borrowed
		end

	a_9 (lib_1, lib_2: L; bc: B)
		require
			lib_1 ~ lib_2
		do
			add_copy (lib_1, bc)
			remove_copy (lib_1, bc)
		ensure
			lib_1 ~ lib_2
		end

	a_10 (lib_1, lib_2: L; bc_1, bc_2: B)
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

	a_11 (lib_1, lib_2: L; bc: B)
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

	a_12 (lib_1, lib_2: L; bc_1, bc_2: B)
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

	a_13 (lib_1, lib_2: L; bc: B)
		require
			lib_1 ~ lib_2
			not copy_borrowed (lib_1, bc)
		do
			check_out (lib_1, bc)
			return (lib_1, bc)
		ensure
			lib_1 ~ lib_2
		end

	a_14 (lib_1, lib_2: L; bc_1, bc_2: B)
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

	a_15 (lib_1, lib_2: L; bc_1, bc_2: B)
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
	--	Well-definedness axioms to model check or test.

	empty_lib_well_defined
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

	add_copy_well_defined (lib_1, lib_2: L; bc: B)
		require
			lib_1 ~ lib_2
		do
			add_copy (lib_1, bc)
			add_copy (lib_2, bc)
		ensure
			lib_1 ~ lib_2
		end

	remove_copy_well_defined (lib_1, lib_2: L; bc: B)
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

	check_out_well_defined (lib_1, lib_2: L; bc: B)
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

	return_well_defined (lib_1, lib_2: L; bc: B)
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

	copy_exists_well_defined (lib_1, lib_2: L; bc: B)
		require
			lib_1 ~ lib_2
		do
		ensure
			copy_exists (lib_1, bc) ~ copy_exists (lib_2, bc)
		end

	copy_borrowed_well_defined (lib_1, lib_2: L; bc: B)
		require
			lib_1 ~ lib_2
		do
		ensure
			copy_borrowed (lib_1, bc) ~ copy_borrowed (lib_2, bc)
		end

end