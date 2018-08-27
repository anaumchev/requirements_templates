note
	description: "[
		Periodicity, for example, event E occurs regularly with a period of 4 time units.
	]"
	EIS: "protocol=URI", "src=https://link.springer.com/article/10.1007/BF01995674"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	PERIODICITY [S]

feature

	event (system: S): BOOLEAN
		deferred
		end

	period (system: S): INTEGER
		deferred
		end

	distance_growth (system: S): INTEGER
		deferred
		end

	main (system: S)
		deferred
		end

feature

	frozen response_holds_in_maximal_distance_steps (system: S)
		require
			event_arrived: event (system)
		local
			distance: INTEGER
			period_: INTEGER
		do
			from
				main (system)
				distance := 0
				period_ := period (system)
			invariant
				no_event_before_min_distance: not event (system) or else distance = period_
			until
				distance = period_
			loop
				main (system)
				distance := distance + distance_growth (system)
			end
		end

end
