note
	description: "[
		P becomes true between Q and R;
		in LTL: ``[](Q & !R -> (!R W (P & !R)))''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Existence"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	EXISTENCE_BETWEEN_Q_AND_R [S]

inherit

	CONTROL_SYSTEM [S]

feature

	p (system: S): BOOLEAN
		deferred
		end

	q (system: S): BOOLEAN
		deferred
		end

	r (system: S): BOOLEAN
		deferred
		end

feature

	p_becomes_true_between_q_and_r (system: S)
			--	Does not have to terminate.
		require
			q (system)
			not r (system)
		do
			from
			invariant
				not r (system)
			until
				p (system) or else verification_boundary_crossed (system)
			loop
				main (system)
			end
		end

end
