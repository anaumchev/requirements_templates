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
			p_accumulated: BOOLEAN
		do
			from
				p_accumulated := False
			until
				r (system)
			loop
				p_accumulated := p_accumulated or p (system)
				main (system)
			end
			check
				not p_accumulated
			end
		end

end
