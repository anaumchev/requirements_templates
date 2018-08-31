note
	description: "[
		Exact distance between events, for example, every A is followed by a B in exactly 7
		time units (as with the setting of a timer and its time-out).
	]"
	EIS: "protocol=URI", "src=https://link.springer.com/article/10.1007/BF01995674"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	EXACT_DISTANCE [S]

feature

	event (system: S): BOOLEAN
		deferred
		end

	reaction (system: S): BOOLEAN
		deferred
		end

	exact_distance (system: S): INTEGER
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
			max_distance: INTEGER
		do
			from
				distance := 0
				max_distance := exact_distance (system)
			invariant
				no_timeout: distance <= max_distance
				exactness: not reaction (system) or else (distance = max_distance)
			until
				reaction (system)
			loop
				main (system)
				distance := distance + distance_growth (system)
			end
		ensure
			reaction_appears: reaction (system)
		end

end
