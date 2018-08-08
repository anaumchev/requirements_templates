note
	description: "Reusable abstract data type specification of Landing Gear System."
	description: "Find a detailed description by the EIS linke below."
	EIS: "protocol=URI", "src=https://www.irit.fr/ABZ2014/landing_system.pdf"
	description: "Follow the EIS link below for an example."
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/examples/is_asm_lgs_lgs.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"
	date: "8/6/2018"

deferred class
	LGS_ADT [L]
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``L''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

feature
	--	Deferred definitions: handle state range.

	up_position (lgs: L): INTEGER
		deferred
		end

	down_position (lgs: L): INTEGER
		deferred
		end

feature
	--	Deferred definitions: door state range.

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
	--	Deferred definitions: gear state range.

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
	--	Deferred definitions: state space.

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
	--	Deferred definitions: constants for timing constraints.

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

	max_retraction_time (lgs: L): INTEGER
		deferred
		end

	max_extension_time (lgs: L): INTEGER
		deferred
		end

feature
	--	Deferred definitions: control procedure

	main (lgs: L)
		deferred
		end

feature {NONE}
	-- Temporal assumptions.

	run_with_handle_down (lgs: L)
		do
			check
				assume: handle_status (lgs) = down_position (lgs)
			end
			from_retracted_to_extended (lgs)
		end

	run_with_handle_up (lgs: L)
		do
			check
				assume: handle_status (lgs) = up_position (lgs)
			end
			from_retracted_to_extended (lgs)
		end

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

feature {NONE}
	-- Timing assumptions.

	distance: INTEGER

		-- Assume it takes ``door_open_to_closed'' time units
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
					-- takes up to ``door_open_to_closed'' time units:
				distance := distance + door_open_to_closed (lgs)
			end
		end

		-- Assume it takes ``door_closed_to_open'' time units
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
					-- takes up to ``door_closed_to_open'' time units:
				distance := distance + door_closed_to_open (lgs)
			end
		end

		-- Assume it takes ``gear_extended_to_retracted'' time units
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
					-- takes up to ``gear_extended_to_retracted'' time units:
				distance := distance + gear_extended_to_retracted (lgs)
			end
		end

		-- Assume it takes ``gear_retracted_to_extended'' time units
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
					-- takes up to ``gear_retracted_to_extended'' time units:
				distance := distance + gear_retracted_to_extended (lgs)
			end
		end

feature
	-- Temporal requirements.

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

feature
	-- Timing requirements.

		-- Require that

	extension_duration (lgs: L)
			-- never takes more than
			-- ``max_extension_time'' time units:
		local
			old_distance: INTEGER
		do
			from
				old_distance := distance
				never_retract_with_handle_down (lgs)
			until
				gear_status (lgs) = extended_position (lgs) and door_status (lgs) = closed_position (lgs) or (distance - old_distance) = max_extension_time (lgs)
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
			-- ``max_retraction_time'' time units:
		local
			old_distance: INTEGER
		do
			from
				old_distance := distance
				never_extend_with_handle_up (lgs)
			until
				gear_status (lgs) = retracted_position (lgs) and door_status (lgs) = closed_position (lgs) or (distance - old_distance) = max_retraction_time (lgs)
			loop
				run_with_handle_up (lgs)
			end
			check
				assert: gear_status (lgs) = retracted_position (lgs)
			end
			check
				assert: door_status (lgs) = closed_position (lgs)
			end
		end

end
