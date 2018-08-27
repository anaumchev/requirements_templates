note
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	STABLE_RESPONSE_UNDER_STIMULUS [S]

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

	frozen stimulus_preserves_response (system: S)
		require
			stimulus_holds: stimulus (system)
			response_holds: response (system)
		do
			main (system)
		ensure
			response_holds: response (system)
		end

end
