note
	description: "[
		P is false before R;
		in LTL: ``<>R -> (!P U R)''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Absence"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	ABSENCE_BEFORE [S]

inherit

	REQUIREMENT [S]

feature

	p (system: S): BOOLEAN
		deferred
		end

	r (system: S): BOOLEAN
		deferred
		end

feature

	frozen p_is_false_before_r (system: S)
		do
			from
			invariant
				p_does_not_hold_or_else_r_holds: not p (system) or else r (system)
			until
				r (system)
			loop
				iterate (system)
			variant
				timer
			end
		end

end
