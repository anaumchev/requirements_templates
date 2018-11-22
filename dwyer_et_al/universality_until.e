note
	description: "[
		P is true after Q until R;
		in LTL: ``[](Q & !R -> (P W R))''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Universality"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	UNIVERSALITY_UNTIL [S]

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

	frozen p_is_true_after_q_until_r (system: S)
		require
			q_holds: q (system)
			r_does_not_hold: not r (system)
		do
			from
			invariant
				p_holds_or_else_r_holds: p (system) or else r (system)
			until
				r (system) or else timer = 0
			loop
				iterate (system)
			variant
				timer
			end
		end

end
