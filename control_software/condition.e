note
	description: "Condition over S."
	EIS: "name=Location on GitHub", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/condition.e"

deferred class
	CONDITION [S]

feature

	holds (system: S): BOOLEAN
		deferred
		end

end
