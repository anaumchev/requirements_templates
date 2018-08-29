note
	description: "[
		Globally P does not hold;
		in LTL: ``[](!P)''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Absence"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	ABSENCE_GLOBALLY [S]

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

	frozen init_not_p
		local
			system: S
		do
			system := init
			check
				not p (system)
			end
		end

	frozen maintain_not_p (system: S)
		do
			main (system)
		ensure
			not p (system)
		end

end
