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

	p_becomes_true_after_q (system: S)
		do
			from
				init (system)
			until
				q (system)
			loop
				iterate (system)
			variant
				time_remaining (system)
			end
			from
			until
				p (system)
			loop
				iterate (system)
			variant
				time_remaining (system)
			end
		end

end
