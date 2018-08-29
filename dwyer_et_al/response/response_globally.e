note
	description: "[
		Globally S eventually responds to P;
		in LTL: ``[](P -> <>S)''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Response"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	RESPONSE_GLOBALLY [S]

feature

	p (system: S): BOOLEAN
		deferred
		end

	s (system: S): BOOLEAN
		deferred
		end

	main (system: S)
		deferred
		end

feature

	frozen globally_s_eventually_responds_to_p (system: S)
		require
			p (system)
		local
			i: INTEGER
		do
			from
				i := i.min_value
			until
				s (system) or else i = i.max_value
			loop
				main (system)
				i := i + 1
			end
		ensure
			s (system)
		end

end