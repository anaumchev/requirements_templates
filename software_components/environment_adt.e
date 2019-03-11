note
	description: "Reusable abstract data type specification of environment."
	description: "Found in ``An abstract data type for name analysis'' by Kastens and Waite:"
	EIS: "src=http://tinyurl.com/y2ghqjq7"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/yyb6uwxy"

deferred class
	ENVIRONMENT_ADT [E, I, D]
	--	Environments ``E'' contain keys ``D'' inentified by elements of ``I''.

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
