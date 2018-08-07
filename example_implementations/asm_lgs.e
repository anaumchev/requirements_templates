note
	description: "Summary description for {ASM_LGS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ASM_LGS

feature

		-- Handle state range.

	up_position: INTEGER = 0

	down_position: INTEGER = 1

		-- Door state range.

	closed_position: INTEGER = 2

	opening_state: INTEGER = 3

	open_position: INTEGER = 4

	closing_state: INTEGER = 5

		-- Gear state range.

	retracting_state: INTEGER = 6

	retracted_position: INTEGER = 7

	extending_state: INTEGER = 8

	extended_position: INTEGER = 9

		-- State space.

	handle_status: INTEGER

	door_status: INTEGER

	gear_status: INTEGER

		-- Operations on the door.

feature {NONE}

		-- Closing the door.

	close_door
		do
			inspect door_status
			when open_position then
				door_status := closing_state
			when closing_state then
				door_status := closed_position
			when opening_state then
				door_status := closing_state
			end
		end

		-- Opening the door.

	open_door
		do
			inspect door_status
			when closed_position then
				door_status := opening_state
			when closing_state then
				door_status := opening_state
			when opening_state then
				door_status := open_position
			end
		end

		-- Operations on the gear.

feature {NONE}

		-- Retracting the gear.

	retract_gear
		do
			inspect gear_status
			when extended_position then
				gear_status := retracting_state
			when retracting_state then
				gear_status := retracted_position
			when extending_state then
				gear_status := retracting_state
			end
		end

		-- Extending the gear.

	extend_gear
		do
			inspect gear_status
			when retracted_position then
				gear_status := extending_state
			when extending_state then
				gear_status := extended_position
			when retracting_state then
				gear_status := extending_state
			end
		end

		-- Core procedures.

feature {NONE}

		-- Retraction logic.

	retract
		do
			if gear_status /= retracted_position then
				if door_status /= open_position then
					open_door
				else
					retract_gear
				end
			else
				close_door
			end
		end

		-- Extension logic.

	extend
		do
			if gear_status /= extended_position then
				if door_status /= open_position then
					open_door
				else
					extend_gear
				end
			else
				close_door
			end
		end

		-- The top-level logic.

feature

		-- The main routine that will infinitely react to the handle changes.

	main
		do
			if handle_status = up_position then
				retract
			elseif handle_status = down_position then
				extend
			end
		end

end
