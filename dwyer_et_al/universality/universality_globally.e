note
	description: "[
		P is true globally;
		in LTL: ``[](P)''
	]"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/universality/universality_globally.e"
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

	frozen p_is_true_globally (system: S)
		do
			from
				init (system)
			invariant
				p_holds: p (system)
			until
				time_remaining (system) = 0
			loop
				iterate (system)
			variant
				time_remaining (system)
			end
		end

end
