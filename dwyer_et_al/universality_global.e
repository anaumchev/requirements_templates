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
	UNIVERSALITY_GLOBAL [S, expanded P -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	p: P

feature

	frozen p_is_true_globally (system: S)
		do
			from
				init (system)
				timer := time_boundary
			invariant
				p_holds: p.holds (system)
			until
				timer = 0
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := p.out + " globally"
		end

end
