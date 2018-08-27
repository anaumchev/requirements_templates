note
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	EVENTUALLY_RESPONSE_UNDER_STIMULUS [S]

feature

	stimulus (system: S): BOOLEAN
		deferred
		end

	response (system: S): BOOLEAN
		deferred
		end

	main (system: S)
		deferred
		end

feature

	frozen response_eventually_holds_under_stimulus (system: S)
		require
			stimulus_holds: stimulus (system)
		do
			from
			invariant
				stimulus_holds: stimulus (system)
			until
				response (system)
			loop
				main (system)
			end
		ensure
			response_holds: response (system)
		end

end
