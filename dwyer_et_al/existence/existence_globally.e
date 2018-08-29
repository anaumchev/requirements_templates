note
	description: "[
		Globally P exists;
		in LTL: ``<>(P)''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Existence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Existence"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	EXISTENCE_GLOBALLY [S]

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

	frozen globally_p_exists
		local
			i: INTEGER
			system: S
		do
			system := init
			from
				i := i.min_value
			until
				p (system) or else i = i.max_value
			loop
				main (system)
				i := i + 1
			end
			check
				p (system)
			end
		end

end
