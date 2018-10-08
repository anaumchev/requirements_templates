note
	description: "Structuring a control system."
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/dwyer_et_al/control_system.e"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	CONTROL_SYSTEM [S]

feature

	init (system: S)
		deferred
		end

	iterate (system: S)
		deferred
		end

	time_remaining (system: S): INTEGER
		deferred
		end

end
