note
	description: "[
		P is true between Q and R;
		in LTL: ``[]((Q & !R & <>R) -> (P U R))''
	]"
	EIS: "protocol=URI", "src=https://onedrive.live.com/redir?resid=32E19ADBFB60CEC5!114988&authkey=!AA3WI_oulecl9Dg&page=View&wd=target(Requirement Patterns.one|/Universality Between|40f8ad24-fe5b-471a-929f-78bf41dafad0/)"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	UNIVERSALITY_BETWEEN [S, expanded P -> CONDITION [S], expanded Q -> CONDITION [S], expanded R -> CONDITION [S]]

inherit

	REQUIREMENT [S]

feature

	p: P

	q: Q

	r: R

	frozen p_is_true_between_q_and_r (system: S)
		require
			q_holds: q.holds (system)
			r_does_not_hold: not r.holds (system)
		do
			from
				timer := time_boundary
			invariant
				p_holds_or_else_r: p.holds (system) or else r.holds (system)
			until
				r.holds (system)
			loop
				iterate (system)
			variant
				timer
			end
		end

feature

	requirement_specific_output: STRING
		do
			Result := r.out + " occurs eventually after " + q.out + ", and " + p.out + " is observed in between"
		end

end
