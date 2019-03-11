note
	description: "P responds to S, T globally."
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y32tgtcm"
	EIS: "name=Location on GitHub", "src=http://tinyurl.com/yyr8xw2b"

deferred class
	RESPONSE_CHAIN_GLOBAL [G, expanded P -> CONDITION [G], expanded S -> CONDITION [G], expanded T -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		require
			({S}).default.holds (system)
		do
			from
				timer := time_boundary
				iterate (system)
			until
				({T}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
			until
				({P}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := ({P}).name + " responds to " + ({S}).name + ", " + ({T}).name + " globally"
		end

	time_boundary: INTEGER
		do
			Result := {INTEGER}.max_value
		end

end
