note
	description: "Reusable abstract data type specification of stack."
	description: "Found in the ``Abstract Data Types and Software Validation '' article by Guttag, Horowitz and Musser, p. 17."
	EIS: "protocol=URI", "src=https://pdfs.semanticscholar.org/372d/4f331d0a6cd5fb4ee0c04d4a0753b8eb659f.pdf"
	description: "Follow the EIS link below for an example."
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/examples/is_linked_stack_stack.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"


deferred class
	UNBOUND_ARRAY_ADT [A, D, R]
	--	Arrays ``A'' contain ``R'' objects indexed by ``D'' objects.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``A'', ``D'' and ``R''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit {NONE}

	EQUALITY_ADT [A]

feature
	-- Deferred definitions.

	new_array: A
		deferred
		end

	set (array: A; domain: D; range: R)
		deferred
		end

	access (array: A; domain: D): R
		deferred
		end

feature
	-- Abstract data type axioms.

	a_1 (domain: D; range: R)
		local
			array: A
		do
			array := new_array
			check
				access (array, domain) /~ range
			end
		end

	a_2 (array: A; domain: D; range: R)
		do
			set (array, domain, range)
		ensure
			access (array, domain) ~ range
		end

	a_3 (array: A; domain_1, domain_2: D; range, old_access: R)
		require
			domain_1 /~ domain_2
			access (array, domain_2) ~ old_access
		do
			set (array, domain_1, range)
		ensure
			access (array, domain_2) ~ old_access
		end

feature
	-- Well-definedness axioms.

	new_array_well_defined
		local
			array_1, array_2: A
		do
			array_1 := new_array
			array_2 := new_array
			check
				array_1 /= array_2
			end
			check
				array_1 ~ array_2
			end
		end

	set_well_defined (array_1, array_2: A; domain: D; range: R)
		require
			array_1 ~ array_2
		do
			set (array_1, domain, range)
			set (array_2, domain, range)
		ensure
			array_1 ~ array_2
		end

	access_well_defined (array_1, array_2: A; domain: D)
		require
			array_1 ~ array_2
		do
		ensure
			access (array_1, domain) ~ access (array_2, domain)
		end

end
