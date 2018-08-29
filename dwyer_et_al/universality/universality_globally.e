note
	description: "[
		Globally P unversally holds;
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

feature

	p (system: S): BOOLEAN
		deferred
		end

	init: S
		deferred
		end

	main (system: S)
		deferred
		end

feature

	frozen p_holds_after_initialization
		local
			system: S
		do
			system := init
			check
				p (system)
			end
		end

	frozen p_holds_throughout_execution (system: S)
		do
			main (system)
		ensure
			p (system)
		end

end
