note
	description: "[
		S responds to P after Q;
		in LTL: ``[](Q -> [](P -> <>S))''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Response"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Response"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	RESPONSE_AFTER_Q [S]

inherit

	CONTROL_SYSTEM [S]

feature

	q (system: S): BOOLEAN
		deferred
		end

	p (system: S): BOOLEAN
		deferred
		end

	s (system: S): BOOLEAN
		deferred
		end

feature

	frozen s_responds_to_p_after_q (system: S)
		require
			q_holds: q (system)
		do
			from
			until
				p (system) or else time_remaining (system) = 0
			loop
				iterate (system)
			variant
				time_remaining (system)
			end
			check
				assume: p (system)
			end
			from
			until
				s (system)
			loop
				iterate (system)
			variant
				time_remaining (system)
			end
		end

end
