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
	UNIVERSALITY_AFTER [S]

inherit

	REQUIREMENT [S]

feature

	q (system: S): BOOLEAN
		deferred
		end

	p (system: S): BOOLEAN
		deferred
		end

feature

	frozen p_is_true_after_q (system: S)
		require
			q_holds: q (system)
		do
			from
			invariant
				p_holds: p (system)
			until
				timer = 0
			loop
				iterate (system)
			variant
				timer
			end
		end

end
