note
	description: "Reusable abstract data type specification of door with a lock."
	description: "Find a detailed description by the EIS linke below."
	EIS: "protocol=URI", "src=https://github.com/anaumchev/requirements_templates/blob/master/templates/41_1.pdf"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"
	date: "8/6/2018"

deferred class
	IS_DOOR_WITH_LOCK [D]
	--	To apply this template to your concept,
	--	inherit from this class with your concept for ``D''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

feature

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
	--	ADT axioms.

	a_1 (d: D)
		require
			is_open (d)
			is_unlocked (d)
		do
			unlock (d)
		ensure
			is_open (d)
			is_unlocked (d)
		end

	a_2 (d: D)
		require
			is_open (d)
			is_unlocked (d)
		do
			lock (d)
		ensure
			is_open (d)
			is_locked (d)
		end

	a_3 (d: D)
		require
			is_open (d)
			is_unlocked (d)
		do
			close (d)
		ensure
			is_closed (d)
			is_unlocked (d)
		end

	a_4 (d: D)
		require
			is_open (d)
			is_locked (d)
		do
			unlock (d)
		ensure
			is_open (d)
			is_unlocked (d)
		end

	a_5 (d: D)
		require
			is_open (d)
			is_locked (d)
		do
			lock (d)
		ensure
			is_open (d)
			is_locked (d)
		end

	a_6 (d: D)
		require
			is_open (d)
			is_locked (d)
		do
			close (d)
		ensure
			is_closed (d)
			is_locked (d)
		end

	a_7 (d: D)
		require
			is_closed (d)
			is_locked (d)
		do
			lock (d)
		ensure
			is_closed (d)
			is_locked (d)
		end

	a_8 (d: D)
		require
			is_closed (d)
			is_locked (d)
		do
			unlock (d)
		ensure
			is_closed (d)
			is_unlocked (d)
		end

	a_9 (d: D)
		require
			is_closed (d)
			is_unlocked (d)
		do
			unlock (d)
		ensure
			is_closed (d)
			is_unlocked (d)
		end

	a_10 (d: D)
		require
			is_closed (d)
			is_unlocked (d)
		do
			lock (d)
		ensure
			is_closed (d)
			is_locked (d)
		end

	a_11 (d: D)
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