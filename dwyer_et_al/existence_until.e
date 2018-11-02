note
	description: "[
		P becomes true after Q until R;
		in LTL: ``[](Q & !R -> (!R U (P & !R)))''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Existence"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	EXISTENCE_UNTIL [S]

inherit

	REQUIREMENT [S]

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

	p_becomes_true_after_q_until_r (system: S)
		require
			q_holds: q (system)
			r_does_not_hold: not r (system)
		do
			from
			invariant
				r_does_not_hold: not r (system)
			until
				p (system)
			loop
				iterate (system)
			variant
				timer
			end
		end

end
