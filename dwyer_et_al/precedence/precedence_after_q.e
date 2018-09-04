note
	description: "[
		S precedes P after Q;
		in LTL: ``[]!Q | <>(Q & (!P W S))''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Precedence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Precedence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Precedence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Precedence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Precedence"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	PRECEDENCE_AFTER_Q [S]

inherit

	CONTROL_SYSTEM [S]

feature

	q (system: S): BOOLEAN
		deferred
		end

	p (system: S): BOOLEAN
		deferred
		end

	s (system: S): BOOLEAN
		deferred
		end

feature

	frozen s_precedes_p_after_q (system: S)
		require
			q (system)
		do
			from
			until
				s (system) or else p (system) or else verification_boundary_crossed (system)
			loop
				main (system)
			end
		ensure
			p (system) implies s (system)
		end

end
