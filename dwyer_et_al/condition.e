note
	description: "Condition over S."
	EIS: "name=Location on GitHub", "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/condition.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	CONDITION [S]

inherit

	ANY
		undefine
			out
		end

feature

	holds (system: S): BOOLEAN
		deferred
		end

end
