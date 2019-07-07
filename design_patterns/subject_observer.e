note
	description: "Reusable abstract data type specification of the observer pattern."
	description: "Found in ``Flexible Invariants Through Semantic Collaboration'' by Polikarpova et al."
	EIS: "src=https://cseweb.ucsd.edu/~npolikarpova/publications/fm14.pdf"
	EIS: "name=Location on GitHub", "src=http://tinyurl.com/y65zzxke"

deferred class
	SUBJECT_OBSERVER [S, O, V]
	-- Types ``S'' and ``O'' form an observer pattern with shared state of type ``V''.

feature -- Deferred definitions.

	value (s: S): V
		deferred
		end

	subscribers (s: S): LIST [O]
		deferred
		end

	update (s: S; v: V)
		deferred
		end

	register (s: S; o: O)
		deferred
		end

	subject (o: O): S
		deferred
		end

	cache (o: O): V
		deferred
		end

	make (o: O; s: S)
		deferred
		end

	notify (o: O)
		deferred
		end

feature -- Abstract data type axioms.

	update_axiom (s: S; v: V; o: O)
		require
			subscribers (s).has (o)
			subject (o) = s
		do
			update (s, v)
		ensure
			subscribers (s).has (o)
			subject (o) = s
			value (s) = v
			cache (o) = v
		end

	register_axiom (s: S; o: O)
		require
			not subscribers (s).has (o)
			subject (o) = s
		do
			register (s, o)
		ensure
			subscribers (s).has (o)
			subject (o) = s
		end

	make_axiom (o: O; s: S)
		require
			not subscribers (s).has (o)
		do
			make (o, s)
		ensure
			subject (o) = s
			subscribers (s).has (o)
			cache (o) = value (s)
		end

	notify_axiom (o: O; s: S)
		require
			subscribers (s).has (o)
			subject (o) = s
		do
			notify (o)
		ensure
			subscribers (s).has (o)
			subject (o) = s
			cache (o) = value (s)
		end

end
