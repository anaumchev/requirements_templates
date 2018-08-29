note
	description: "[
		P is always absent after Q;
		in LTL: ``[](Q -> [](!P))''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Absence"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	ABSENCE_AFTER_Q [S]

feature

	q (system: S): BOOLEAN
		deferred
		end

	p (system: S): BOOLEAN
		deferred
		end

	main (system: S)
		deferred
		end

feature

	frozen p_never_holds_after_q (system: S; steps: INTEGER)
		require
			q (system)
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i = steps
			loop
				main (system)
				i := i + 1
			variant
				steps - i
			end
			check
				not p (system)
			end
		end

end
