note
	description: "Summary description for {RESPONSE_CHAIN_GLOBAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RESPONSE_CHAIN_GLOBAL [G, expanded S -> CONDITION [G], expanded T -> CONDITION [G], expanded P -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	s: S

	t: T

	p: P

	p_responds_to_s_t (system: G)
		require
			s.holds (system)
		do
			from
				iterate (system)
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
