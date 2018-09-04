note
	description: "[
		P becomes true before R;
		in LTL: ``!R W (P & !R)''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Existence"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	EXISTENCE_BEFORE_R [S]

inherit

	CONTROL_SYSTEM [S]

feature

	p (system: S): BOOLEAN
		deferred
		end

	r (system: S): BOOLEAN
		deferred
		end

feature

	p_becomes_true_before_r (system: S)
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
