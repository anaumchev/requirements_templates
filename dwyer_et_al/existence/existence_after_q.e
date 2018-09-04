note
	description: "[
		P becomes true after Q;
		in LTL: ``[](!Q) | <>(Q & <>P))''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Existence"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	EXISTENCE_AFTER_Q [S]

inherit

	CONTROL_SYSTEM [S]

feature

	p (system: S): BOOLEAN
		deferred
		end

	q (system: S): BOOLEAN
		deferred
		end

feature

	p_becomes_true_after_q
		local
			system: S
		do
			from
				system := init
			until
				q (system) or else verification_boundary_crossed (system)
			loop
				main (system)
			end
			check
				q (system)
			end
			check
				not verification_boundary_crossed (system)
			end
			from
			until
				p (system) or else verification_boundary_crossed (system)
			loop
				main (system)
			end
			check
				p (system)
			end
			check
				not verification_boundary_crossed (system)
			end
		end

end
