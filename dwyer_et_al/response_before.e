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
	RESPONSE_BEFORE [S]

inherit

	REQUIREMENT [S]

feature

	s (system: S): BOOLEAN
		deferred
		end

	p (system: S): BOOLEAN
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
				s (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				r (system)
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	s_out: STRING
		deferred
		end

	p_out: STRING
		deferred
		end

	r_out: STRING
		deferred
		end

	requirement_specific_output: STRING
		do
			Result := s_out + " occurs after " + p_out + " before " + r_out
		end

end
