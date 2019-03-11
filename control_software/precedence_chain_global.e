note
	description: "S, T precedes P globally."
	EIS: "name=Multirequirement", "src=http://tinyurl.com/y22s7fed"
	EIS: "name=Location on GitHub", "src=http://tinyurl.com/yxgqazkn"

deferred class
	PRECEDENCE_CHAIN_GLOBAL [G, expanded S -> CONDITION [G], expanded T -> CONDITION [G], expanded P -> CONDITION [G]]

inherit

	REQUIREMENT [G]

feature

	frozen verify (system: G)
		do
			from
				timer := time_boundary
				init (system)
			invariant
				not ({P}).default.holds (system)
			until
				({S}).default.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
			from
				iterate (system)
			invariant
				not ({P}).default.holds (system) or else ({T}).default.holds (system)
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
			Result := ({S}).name + ", " + ({T}).name + " precedes " + ({P}).name + " globally"
		end

	time_boundary: INTEGER
		do
			Result := {INTEGER}.max_value
		end

end
