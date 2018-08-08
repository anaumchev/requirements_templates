note
	description: "Summary description for {IS_ASM_LGS_LGS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IS_ASM_LGS_LGS

inherit

	LGS_ADT [ASM_LGS]

feature
	-- Definitions: handle state range.

	up_position (lgs: ASM_LGS): INTEGER
		do
			Result := lgs.up_position
		end

	down_position (lgs: ASM_LGS): INTEGER
		do
			Result := lgs.down_position
		end

feature
	-- Definitions: door state range.

	closed_position (lgs: ASM_LGS): INTEGER
		do
			Result := lgs.closed_position
		end

	opening_state (lgs: ASM_LGS): INTEGER
		do
			Result := lgs.opening_state
		end

	open_position (lgs: ASM_LGS): INTEGER
		do
			Result := lgs.open_position
		end

	closing_state (lgs: ASM_LGS): INTEGER
		do
			Result := lgs.closing_state
		end

feature
	-- Definitions: gear state range.

	retracting_state (lgs: ASM_LGS): INTEGER
		do
			Result := lgs.retracting_state
		end

	retracted_position (lgs: ASM_LGS): INTEGER
		do
			Result := lgs.retracted_position
		end

	extending_state (lgs: ASM_LGS): INTEGER
		do
			Result := lgs.extending_state
		end

	extended_position (lgs: ASM_LGS): INTEGER
		do
			Result := lgs.extended_position
		end

feature
	-- Definitions: state space.

	handle_status (lgs: ASM_LGS): INTEGER
		do
			Result := lgs.handle_status
		end

	door_status (lgs: ASM_LGS): INTEGER
		do
			Result := lgs.door_status
		end

	gear_status (lgs: ASM_LGS): INTEGER
		do
			Result := lgs.gear_status
		end

feature
	--	Definitions: constants for timing constraints.

	door_open_to_closed (lgs: ASM_LGS): INTEGER
		do
			Result := 8
		end

	door_closed_to_open (lgs: ASM_LGS): INTEGER
		do
			Result := 12
		end

	gear_extended_to_retracted (lgs: ASM_LGS): INTEGER
		do
			Result := 10
		end

	gear_retracted_to_extended (lgs: ASM_LGS): INTEGER
		do
			Result := 5
		end

	max_extension_time (lgs: ASM_LGS): INTEGER
		do
			Result := 25
		end

	max_retraction_time (lgs: ASM_LGS): INTEGER
		do
			Result := 30
		end

feature
	-- Definitions: control procedure

	main (lgs: ASM_LGS)
		do
			lgs.main
		end

end
