note
	description: "Reusable abstract data type specification of door with a lock."
	description: "Find a detailed description by the EIS link below."
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/templates/41_1.pdf"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	DOOR_WITH_LOCK_ADT [D]
	--	To apply this template to your concept,
	--	inherit from this class with your concept for ``D''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

feature
	-- Deferred definitions.

	is_open (d: D): BOOLEAN
		deferred
		end

	is_closed (d: D): BOOLEAN
		deferred
		end

	is_locked (d: D): BOOLEAN
		deferred
		end

	is_unlocked (d: D): BOOLEAN
		deferred
		end

	open (d: D)
		deferred
		end

	close (d: D)
		deferred
		end

	lock (d: D)
		deferred
		end

	unlock (d: D)
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1 (d: D)
		require
			is_open (d)
			is_unlocked (d)
		do
			unlock (d)
		ensure
			is_open (d)
			is_unlocked (d)
		end

	frozen a_2 (d: D)
		require
			is_open (d)
			is_unlocked (d)
		do
			lock (d)
		ensure
			is_open (d)
			is_locked (d)
		end

	frozen a_3 (d: D)
		require
			is_open (d)
			is_unlocked (d)
		do
			close (d)
		ensure
			is_closed (d)
			is_unlocked (d)
		end

	frozen a_4 (d: D)
		require
			is_open (d)
			is_locked (d)
		do
			unlock (d)
		ensure
			is_open (d)
			is_unlocked (d)
		end

	frozen a_5 (d: D)
		require
			is_open (d)
			is_locked (d)
		do
			lock (d)
		ensure
			is_open (d)
			is_locked (d)
		end

	frozen a_6 (d: D)
		require
			is_open (d)
			is_locked (d)
		do
			close (d)
		ensure
			is_closed (d)
			is_locked (d)
		end

	frozen a_7 (d: D)
		require
			is_closed (d)
			is_locked (d)
		do
			lock (d)
		ensure
			is_closed (d)
			is_locked (d)
		end

	frozen a_8 (d: D)
		require
			is_closed (d)
			is_locked (d)
		do
			unlock (d)
		ensure
			is_closed (d)
			is_unlocked (d)
		end

	frozen a_9 (d: D)
		require
			is_closed (d)
			is_unlocked (d)
		do
			unlock (d)
		ensure
			is_closed (d)
			is_unlocked (d)
		end

	frozen a_10 (d: D)
		require
			is_closed (d)
			is_unlocked (d)
		do
			lock (d)
		ensure
			is_closed (d)
			is_locked (d)
		end

	frozen a_11 (d: D)
		require
			is_closed (d)
			is_unlocked (d)
		do
			open (d)
		ensure
			is_open (d)
			is_unlocked (d)
		end

end
