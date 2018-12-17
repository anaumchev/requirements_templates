note
	description: "P responds to S, T globally."
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/response_chain_global.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

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
  	  Result := ({P}).default.out + " responds to " + ({S}).default.out + ", " + ({T}).default.out + " globally"
  	end
end
