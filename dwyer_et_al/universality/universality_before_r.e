note
	description: "[
		P is true before R;
		in LTL: ``<>R -> (P U R)''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Universality"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	UNIVERSALITY_BEFORE_R [S]

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

	frozen p_is_true_before_r (system: S)
		do
			from
			until
				r (system) or else not p (system) or else verification_boundary_crossed (system)
			loop
				main (system)
			end
		ensure
			not verification_boundary_crossed (system)
			r (system)
		end

end
