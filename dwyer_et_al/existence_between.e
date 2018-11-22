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
	EXISTENCE_BETWEEN [S]

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

	p_becomes_true_between_q_and_r (system: S)
		require
			q_holds: q (system)
			r_does_not_hold: not r (system)
		do
			from
			invariant
				r_does_not_hold: not r (system)
			until
				p (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
		end

end
