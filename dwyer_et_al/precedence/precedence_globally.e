note
	description: "[
		Globally S precedes P;
		in LTL: ``!P W S''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Precedence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Precedence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Precedence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Precedence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Precedence"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	PRECEDENCE_GLOBALLY [S]

feature

	p (system: S): BOOLEAN
		deferred
		end

	s (system: S): BOOLEAN
		deferred
		end

	init: S
		deferred
		end

	main (system: S)
		deferred
		end

feature

	if_not_s_then_not_p_after_initialization
		local
			system: S
		do
			system := init
			check
				assume: not s (system)
			end
			check
				not p (system)
			end
		end

	s_precedes_p_throughout_execution (system: S)
		do
			main (system)
			check
				assume: not s (system)
			end
		ensure
			not p (system)
		end

end
