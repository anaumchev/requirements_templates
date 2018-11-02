note
	description: "Summary description for {PRECEDENCE_CHAIN_GLOBAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PRECEDENCE_CHAIN_GLOBAL [G, expanded S -> CONDITION [G], expanded T -> CONDITION [G], expanded P -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	s: S

	t: T

	p: P

	s_t_precedes_p (system: G)
		do
			from
				init (system)
			invariant
			  not p.holds (system)
			until
			  s.holds (system)
			loop
				iterate (system)
			variant
			  timer
			end
			from
			  iterate (system)
			invariant
			  not p.holds (system) or else t.holds (system)
			until
				t.holds (system)
			loop
				iterate (system)
			variant
			  timer
			end
			from
			until
			  p.holds (system)
			loop
				iterate (system)
			variant
			  timer
			end
		end

end
