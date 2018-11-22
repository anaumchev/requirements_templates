note
	description: "[
		S responds to P globally;
		in LTL: ``[](P -> <>S)''
	]"
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/response/response_globally.e"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Response"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	RESPONSE_GLOBAL [G, expanded P -> CONDITION [G], expanded S -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	p: P

	s: S

feature

	frozen s_responds_to_p_globally (system: G)
		require
			p_holds: p.holds (system)
		do
			from
				timer := time_boundary
			until
				s.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := s.out + " responds to " + p.out
		end
end
