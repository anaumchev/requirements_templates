note
	description: "Transitions to P occur at most 2 times between Q and R."
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/bounded_existence_between.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	BOUNDED_EXISTENCE_BETWEEN [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S], expanded R -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	frozen verify (system: S)
		require
			q_holds: ({Q}).default.holds (system)
		do
			from
			until
				({R}).default.holds (system) or else not ({P}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				({R}).default.holds (system) or else ({P}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				({R}).default.holds (system) or else not ({P}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				({R}).default.holds (system) or else ({P}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				({R}).default.holds (system) or else not ({P}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
			invariant
				({R}).default.holds (system) or else not ({P}).default.holds (system)
			until
				({R}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
		ensure
			r_holds: ({R}).default.holds (system)
		end

feature

	requirement_specific_output: STRING
		do
			Result := "transitions to " + ({P}).default.out + " occur at most 2 times between " + ({Q}).default.out + " and " + ({R}).default.out
		end

end
