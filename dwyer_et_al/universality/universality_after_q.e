note
	description: "[
		P is true after Q;
		in LTL: ``[](Q -> [](P))''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Universality"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	UNIVERSALITY_AFTER_Q [S]

feature

	q (system: S): BOOLEAN
		deferred
		end

	p (system: S): BOOLEAN
		deferred
		end

	verification_boundary_reached (system: S): BOOLEAN
		deferred
		end

	main (system: S)
		deferred
		end

feature

	p_is_true_after_q (system: S)
		require
			q (system)
		do
			from
			until
				verification_boundary_reached (system) or else not p (system)
			loop
				main (system)
			end
		ensure
			p (system)
		end

end
