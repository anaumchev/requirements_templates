note
	description: "Summary description for {BOUNDED_EXISTENCE_GLOBAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BOUNDED_EXISTENCE_GLOBAL [S, expanded P -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	p: P

	transition_to_p_n_times (system: S)
		do
			init (system)
			check
			  not p.holds (system)
			end
			from
			until
				p.holds (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				not p.holds (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				p.holds (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				not p.holds (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
			from
			invariant
			  not p.holds (system)
			until
				timer = 0
			loop
				iterate (system)
			variant
				timer
			end
		end

end
