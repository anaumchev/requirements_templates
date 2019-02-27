note
	description: "Reusable abstract data type specification of environment."
	description: "Found in ``An abstract data type for name analysis'' by Kastens and Waite:"
	EIS: "src=https://www.researchgate.net/profile/William_Waite/publication/220197497_An_Abstract_Data_Type_for_Name_Analysis/links/02e7e51eee56744a24000000.pdf"

deferred class
	ENVIRONMENT_ADT [E, I, D]
	--	E - The compiler's internal representation of a scope.
	--	I - The compiler's internal representatino of an identifier.
	--	D - The compiler's internal representation of a key.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``E'', ``I'' and ``D''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	EQUALITY_ADT [E]

feature
	-- Deferred definitions.

	new_env: E
		deferred
		end

	new_scope (env: E)
		deferred
		end

	add (env: E; id: I; key: D)
		deferred
		end

	key_in_scope (env: E; id: I): D
		deferred
		end

	key_in_env (env: E; id: I): D
		deferred
		end

	add_idn (env: E; id: I; key: D): BOOLEAN
		deferred
		end

	define_idn (env: E; id: I): D
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1 (id: I; key: D)
		local
			env: E
		do
			env := new_env
			check
				key_in_scope (env, id) /~ key
			end
		end

	frozen a_2 (env: E; id: I; key: D)
		do
			new_scope (env)
		ensure
			key_in_scope (env, id) /~ key
		end

	frozen a_3_1 (env: E; id: I; key: D)
		do
			add (env, id, key)
		ensure
			key_in_scope (env, id) ~ key
		end

	frozen a_3_2 (env: E; id_1, id_2: I; key, old_key_in_scope: D)
		require
			id_1 /~ id_2
			key_in_scope (env, id_2) ~ old_key_in_scope
		do
			add (env, id_1, key)
		ensure
			key_in_scope (env, id_2) ~ old_key_in_scope
		end

	frozen a_4 (id: I; key: D)
		local
			env: E
		do
			env := new_env
			check
				key_in_env (env, id) /~ key
			end
		end

	frozen a_5 (env: E; id: I; old_key_in_env: D)
		require
			key_in_env (env, id) ~ old_key_in_env
		do
			new_scope (env)
		ensure
			key_in_env (env, id) ~ old_key_in_env
		end

	frozen a_6_1 (env: E; id: I; key: D)
		do
			add (env, id, key)
		ensure
			key_in_env (env, id) ~ key
		end

	frozen a_6_2 (env: E; id_1, id_2: I; key, old_key_in_env: D)
		require
			id_1 /~ id_2
			key_in_env (env, id_2) ~ old_key_in_env
		do
			add (env, id_1, key)
		ensure
			key_in_env (env, id_2) ~ old_key_in_env
		end

feature
	-- Well-definedness axioms.

	frozen new_env_well_defined
		local
			env_1, env_2: E
		do
			env_1 := new_env
			env_2 := new_env
			check
				env_1 /= env_2
			end
			check
				env_1 ~ env_2
			end
		end

	frozen new_scope_well_defined (env_1, env_2: E)
		require
			env_1 ~ env_2
		do
			new_scope (env_1)
			new_scope (env_2)
		ensure
			env_1 ~ env_2
		end

	frozen add_well_defined (env_1, env_2: E; id: I; key: D)
		require
			env_1 ~ env_2
		do
			add (env_1, id, key)
			add (env_2, id, key)
		ensure
			env_1 ~ env_2
		end

	frozen key_in_scope_well_defined (env_1, env_2: E; id: I)
		require
			env_1 ~ env_2
		do
		ensure
			key_in_scope (env_1, id) ~ key_in_scope (env_2, id)
		end

	frozen key_in_env_well_defined (env_1, env_2: E; id: I)
		require
			env_1 ~ env_2
		do
		ensure
			key_in_env (env_1, id) ~ key_in_env (env_2, id)
		end

end
