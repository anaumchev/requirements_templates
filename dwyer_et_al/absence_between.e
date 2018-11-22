note
	description: "[
		P is false between Q and R;
		in LTL: ``[]((Q & !R & <>R) -> (!P U R))''
	]"
  EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/absence/absence_between_q_and_r.e"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Absence"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	ABSENCE_BETWEEN [S]

inherit

	REQUIREMENT [S]

feature

	p (system: S): BOOLEAN
		deferred
		end

	q (system: S): BOOLEAN
		deferred
		end

	r (system: S): BOOLEAN
		deferred
		end

feature

	frozen p_is_false_between_q_and_r (system: S)
		require
			q_holds: q (system)
			r_does_not_hold: not r (system)
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
