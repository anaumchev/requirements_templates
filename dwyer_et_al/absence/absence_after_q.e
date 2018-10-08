note
	description: "[
		P is false after Q;
		in LTL: ``[](Q -> [](!P))''
	]"
  EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/absence/absence_after_q.e"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Absence"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	ABSENCE_AFTER_Q [S]

inherit

	CONTROL_SYSTEM [S]

feature

	q (system: S): BOOLEAN
		deferred
		end

	p (system: S): BOOLEAN
		deferred
		end

	frozen p_is_false_after_q (system: S)
		require
			q_holds: q (system)
		do
			from
			invariant
				p_does_not_hold: not p (system)
			until
				time_remaining (system) = 0
			loop
				iterate (system)
			variant
				time_remaining (system)
			end
		end

end
