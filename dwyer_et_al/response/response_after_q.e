note
	description: "[
		S always eventually responds to P after Q;
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

	main (system: S)
		deferred
		end

feature

	frozen s_always_eventually_responds_to_p_after_q (system: S; steps: INTEGER)
		require
			q (system)
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i = steps or else p (system)
			loop
				main (system)
				i := i + 1
			variant
				steps - i
			end
			check
				assume: p (system)
			end
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