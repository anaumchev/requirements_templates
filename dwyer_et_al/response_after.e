note
	description: "S responds to P after Q"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	RESPONSE_AFTER [G, expanded S -> CONDITION [G], expanded P -> CONDITION [G], expanded Q -> CONDITION [G]]

inherit

	REQUIREMENT [G]
		undefine
			time_boundary
		end

feature

	frozen verify (system: G)
		require
			q_holds: ({Q}).default.holds (system)
		do
			from
			until
				({P}).default.holds (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
			check
				assume: ({P}).default.holds (system)
			end
			from
			until
				({S}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({S}).default.out + " responds to " + ({P}).default.out + " after " + ({Q}).default.out + "."
		end

feature

	time_boundary: INTEGER
		do
			Result := 100000
		end

end
