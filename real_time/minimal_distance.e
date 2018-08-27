note
	description: "[
		Minimal distance between events, for example, two consecutive As are at least 5 time
		units apart (assumption about the rate of input from the environment).
	]"
	EIS: "protocol=URI", "src=https://link.springer.com/article/10.1007/BF01995674"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	MINIMAL_DISTANCE [S]

feature

	event (system: S): BOOLEAN
		deferred
		end

	minimal_distance (system: S): INTEGER
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
			min_distance: INTEGER
		do
			from
				main (system)
				distance := 0
				min_distance := minimal_distance (system)
			invariant
				no_event_before_min_distance: not event (system) or else distance >= min_distance
			until
				distance >= min_distance
			loop
				main (system)
				distance := distance + distance_growth (system)
			end
		end

end
