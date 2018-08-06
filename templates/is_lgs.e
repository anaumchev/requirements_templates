note
	description: "Behavioral description of a concept that behaves like the Landing Gear System."
	description: "Find a detailed description by the EIS linke below."
	EIS: "protocol=URI", "src=https://www.irit.fr/ABZ2014/landing_system.pdf"
	description: "Follow the EIS link below for an example."
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/examples/is_asm_lgs_lgs.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"
	date: "8/6/2018"

deferred class
	IS_LGS [L]
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``L''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

feature
	-- Definitions: handle state range.

	up_position (lgs: L): INTEGER
		deferred
		end

	down_position (lgs: L): INTEGER
		deferred
		end

feature
	-- Definitions: door state range.

	closed_position (lgs: L): INTEGER
		deferred
		end

	opening_state (lgs: L): INTEGER
		deferred
		end

	open_position (lgs: L): INTEGER
		deferred
		end

	closing_state (lgs: L): INTEGER
		deferred
		end

feature
	-- Definitions: gear state range.

	retracting_state (lgs: L): INTEGER
		deferred
		end

	retracted_position (lgs: L): INTEGER
		deferred
		end

	extending_state (lgs: L): INTEGER
		deferred
		end

	extended_position (lgs: L): INTEGER
		deferred
		end

feature
	-- Definitions: state space.

	handle_status (lgs: L): INTEGER
		deferred
		end

	door_status (lgs: L): INTEGER
		deferred
		end

	gear_status (lgs: L): INTEGER
		deferred
		end

feature
	--	Definitions: constants for timing constraints.

	door_open_to_closed (lgs: L): INTEGER
		deferred
		end

	door_closed_to_open (lgs: L): INTEGER
		deferred
		end

	gear_extended_to_retracted (lgs: L): INTEGER
		deferred
		end

	gear_retracted_to_extended (lgs: L): INTEGER
		deferred
		end

feature
	-- Definitions: control procedure

	main (lgs: L)
		deferred
		end

feature -- Temporal assumptions.

		-- Assume the system is

	run_with_handle_down (lgs: L)
		do
			check
				assume: handle_status (lgs) = down_position (lgs)
			end
			from_retracted_to_extended (lgs)
		end

		-- Assume the system is

	run_with_handle_up (lgs: L)
		do
			check
				assume: handle_status (lgs) = up_position (lgs)
			end
			from_retracted_to_extended (lgs)
		end
			-- Assume the system is

	run_in_normal_mode (lgs: L)
		do
				-- the handle status range:
			check
				assume: handle_status (lgs) = up_position (lgs) or handle_status (lgs) = down_position (lgs)
			end
				-- the door status range:
			check
				assume: door_status (lgs) = closed_position (lgs) or door_status (lgs) = opening_state (lgs) or door_status (lgs) = open_position (lgs) or door_status (lgs) = closing_state (lgs)
			end
				-- the gear status range:
			check
				assume: gear_status (lgs) = extended_position (lgs) or gear_status (lgs) = extending_state (lgs) or gear_status (lgs) = retracted_position (lgs) or gear_status (lgs) = retracting_state (lgs)
			end
				-- the gear may extend or retract
				-- only with the door open:
			check
				assume: (gear_status (lgs) = extending_state (lgs) or gear_status (lgs) = retracting_state (lgs)) implies door_status (lgs) = open_position (lgs)
			end
				-- closed door assumes
				-- retracted or extended gear:
			check
				assume: door_status (lgs) = closed_position (lgs) implies (gear_status (lgs) = extended_position (lgs) or gear_status (lgs) = retracted_position (lgs))
			end
				-- after all the assumptions are made, run:
			main (lgs)
		end

feature -- Timing assumptions.

		-- Assume an axiomatically defined

	distance: INTEGER

		-- Assume it takes 8 time units
		-- to take the door

	from_open_to_closed (lgs: L)
			-- position:
			-- consider
		local
				-- variable:
			old_door_status: INTEGER
		do
				-- that stores initial door status:
			old_door_status := door_status (lgs)
				-- run the system in the normal mode:
			run_in_normal_mode (lgs)
				-- changing the door status to 'closed_position':
			if (old_door_status /= closed_position (lgs) and door_status (lgs) = closed_position (lgs)) then
					-- takes up to 8 time units:
				distance := distance + door_open_to_closed (lgs)
			end
		end

		-- Assume it takes 12 time units
		-- to take the door

	from_closed_to_open (lgs: L)
			-- position:
			-- consider
		local
				-- variable:
			old_door_status: INTEGER
		do
				-- that stores initial door status:
			old_door_status := door_status (lgs)
			from_open_to_closed (lgs)
				-- changing the door status to 'open_position':
			if (old_door_status /= open_position (lgs) and door_status (lgs) = open_position (lgs)) then
					-- takes up to 12 time units:
				distance := distance + door_closed_to_open (lgs)
			end
		end

		-- Assume it takes 10 time units
		-- to take the gear

	from_extended_to_retracted (lgs: L)
			-- position:
			-- consider
		local
				-- variable:
			old_gear_status: INTEGER
		do
				-- that stores initial gear status:
			old_gear_status := gear_status (lgs)
			from_closed_to_open (lgs)
				-- changing the gear status
				-- to 'retracted_position':
			if (old_gear_status /= retracted_position (lgs) and gear_status (lgs) = retracted_position (lgs)) then
					-- takes up to 10 time units:
				distance := distance + gear_extended_to_retracted (lgs)
			end
		end

		-- Assume it takes 5 time units
		-- to take the gear

	from_retracted_to_extended (lgs: L)
			-- position:
			-- consider
		local
				-- variable:
			old_gear_status: INTEGER
		do
				-- that stores initial gear status:
			old_gear_status := gear_status (lgs)
			from_extended_to_retracted (lgs)
				-- changing the gear status
				-- to 'extended_position':
			if (old_gear_status /= extended_position (lgs) and gear_status (lgs) = extended_position (lgs)) then
					-- takes up to 5 time units:
				distance := distance + gear_retracted_to_extended (lgs)
			end
		end

feature -- Temporal requirements.

		-- Require the system to

	never_retract_with_handle_down (lgs: L)
		do
			run_with_handle_down (lgs)
			check
				assert: gear_status (lgs) /= retracting_state (lgs)
			end
		end

		-- Require the system to

	never_extend_with_handle_up (lgs: L)
		do
			run_with_handle_up (lgs)
			check
				assert: gear_status (lgs) /= extending_state (lgs)
			end
		end

		-- Require that

	retraction (lgs: L)
			-- never takes more than
			-- 6 steps:
		local
			steps: INTEGER
		do
			from
				steps := 0
				never_extend_with_handle_up (lgs)
			until
				steps = 5
			loop
				run_with_handle_up (lgs)
				steps := steps + 1
			end
			check
				assert: gear_status (lgs) = retracted_position (lgs)
			end
			check
				assert: door_status (lgs) = closed_position (lgs)
			end
		end

		-- Require the system to have the following

	stable_state_with_handle_down (lgs: L)
		do
			check
				assume: gear_status (lgs) = extended_position (lgs)
			end
			check
				assume: door_status (lgs) = closed_position (lgs)
			end
			run_with_handle_down (lgs)
			check
				assert: gear_status (lgs) = extended_position (lgs)
			end
			check
				assert: door_status (lgs) = closed_position (lgs)
			end
		end

		-- Require the system to have the following

	stable_state_with_handle_up (lgs: L)
		do
			check
				assume: gear_status (lgs) = retracted_position (lgs)
			end
			check
				assume: door_status (lgs) = closed_position (lgs)
			end
			run_with_handle_up (lgs)
			check
				assert: gear_status (lgs) = retracted_position (lgs)
			end
			check
				assert: door_status (lgs) = closed_position (lgs)
			end
		end

feature -- Timing requirements.

		-- Require that

	extension_duration (lgs: L)
			-- never takes more than
			-- 25 time units:
		local
			old_distance: INTEGER
		do
			from
				old_distance := distance
				never_retract_with_handle_down (lgs)
			until
				gear_status (lgs) = extended_position (lgs) and door_status (lgs) = closed_position (lgs) or (distance - old_distance) = 25
			loop
				run_with_handle_down (lgs)
			end
			check
				assert: gear_status (lgs) = extended_position (lgs)
			end
			check
				assert: door_status (lgs) = closed_position (lgs)
			end
		end

		-- Require that

	retraction_duration (lgs: L)
			-- never takes more than
			-- 30 time units:
		local
			old_distance: INTEGER
		do
			old_distance := distance
			retraction (lgs)
			check
				assert: (distance - old_distance) <= 30
			end
		end

end
