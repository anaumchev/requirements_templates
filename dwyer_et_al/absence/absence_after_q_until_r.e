note
	description: "[
		P is always absent after Q and at least until R;
		in LTL: ``[](Q & !R -> (!P W R))''
	]"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ctl.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/ltl.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/qre.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/inca.shtml#Absence"
	EIS: "protocol=URI", "src=http://patterns.projects.cs.ksu.edu/documentation/patterns/gil.shtml#Absence"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	ABSENCE_AFTER_Q_UNTIL_R [S]

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

	main (system: S)
		deferred
		end

feature

	p_does_not_hold_after_q_weak_until_r (system: S)
		require
			q (system)
			not r (system)
		local
			i: INTEGER
		do
			from
				i := i.min_value
			until
				r (system) or else p (system) or else i = i.max_value
			loop
				main (system)
				i := i + 1
			end
		ensure
			p (system) implies r (system)
		end

end
