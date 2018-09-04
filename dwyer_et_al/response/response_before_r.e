note
	description: "[
		S responds to P before R;
		in LTL: ``<>R -> (P -> (!R U (S & !R))) U R''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Response"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	RESPONSE_BEFORE_R [S]

inherit

	CONTROL_SYSTEM [S]

feature

	p (system: S): BOOLEAN
		deferred
		end

	s (system: S): BOOLEAN
		deferred
		end

	r (system: S): BOOLEAN
		deferred
		end

feature

	frozen s_responds_to_p_before_r (system: S)
		require
			p_holds: p (system)
		do
			from
			invariant
				r_does_not_hold: not r (system)
			until
				s (system) or else verification_boundary_crossed (system)
			loop
				main (system)
			end
			check
				verification_boundary_is_not_crossed: not verification_boundary_crossed (system)
			end
			check
				s_holds: s (system)
			end
			from
			until
				r (system) or else verification_boundary_crossed (system)
			loop
				main (system)
			end
		ensure
			verification_boundary_is_not_crossed: not verification_boundary_crossed (system)
			r_holds: r (system)
		end

end
