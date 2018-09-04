note
	description: "[
		P is true globally;
		in LTL: ``[](P)''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Universality"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Universality"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	UNIVERSALITY_GLOBALLY [S]

inherit

	CONTROL_SYSTEM [S]

feature

	p (system: S): BOOLEAN
		deferred
		end

feature

	frozen p_is_true_globally
		local
			system: S
		do
			from
				system := init
			until
				not p (system) or else verification_boundary_crossed (system)
			loop
				main (system)
			end
			check
				p (system)
			end
		end

end
