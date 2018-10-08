note
	description: "[
		S precedes P globally;
		in LTL: ``!P W S''
	]"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/precedence/precedence_globally.e"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Precedence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Precedence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Precedence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Precedence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Precedence"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	PRECEDENCE_GLOBALLY [S]

inherit

	CONTROL_SYSTEM [S]

feature

	p (system: S): BOOLEAN
		deferred
		end

	s (system: S): BOOLEAN
		deferred
		end

feature

	frozen s_precedes_p_globally (system: S)
		do
			from
				init (system)
			invariant
				p_does_not_hold_or_else_s_holds: not p (system) or else s (system)
			until
				s (system) or else time_remaining (system) = 0
			loop
				iterate (system)
			variant
				time_remaining (system)
			end
		end

end
