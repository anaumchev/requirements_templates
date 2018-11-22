note
	description: "Reusable abstract data type specification of polynomial."
	description: "The signature is taken from ``The design of data type specifications'' article by Guttag, Horowitz and Musser, page 5."
	EIS: "protocol=URI", "src=http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.103.4685&rep=rep1&type=pdf"
	author: "Alexandr Naumchev"
	email: "anaumchev@gmail.com"

deferred class
	POLYNOMIAL_ADT [P, C, CS -> COMMUTATIVE_RING_ADT [C]]
	--	Polynomials ``P'' have coefficients from commutative ring ``C''.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``P'', ``C'', ``CS''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	COMMUTATIVE_RING_ADT [P]
		rename
			sum as add,
			product as mult
		end
	--	Polynomials form a commutative ring up to some renaming.

feature
	-- Deferred definitions.

	add_term (polynomial: P; coefficient: C; exponent: INTEGER)
			--	ADDTERM(Polynomial,Coef,Exp) --> Polynomial
		deferred
		end

	rem_term (polynomial: P; exponent: INTEGER)
			--	REMTERM(Polynomial,Exp) ~ Polynomial
		deferred
		end

	mult_term (polynomial: P; coefficient: C; exponent: INTEGER)
			--	MULTTERM(Polynomial,Coef,Exp) ~ Polynomial
		deferred
		end

	reductum (polynomial: P)
			--	REDUCTUM(Polynomial) --> Polynomial
		deferred
		end

	is_zero (polynomial: P): BOOLEAN
			--	ISZERO(Polynomial) --> Boolean
		deferred
		end

	coef (polynomial: P; exponent: INTEGER): C
			--	Coef(Polynomial,Exp) --> Coef
		deferred
		end

	degree (polynomial: P): INTEGER
			--	DEGREE(Polynomial) --> Exp
		deferred
		end

	ldcf (polynomial: P): C
			--	LDCF(Polynomial) --> Coef
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_11 (exponent: INTEGER)
			--	REMTERM(ZERO,f) = ZERO
		local
			polynomial_1, polynomial_2: P
		do
			polynomial_1 := zero
			polynomial_2 := zero
			rem_term (polynomial_1, exponent)
			check
				polynomial_1 ~ polynomial_2
			end
		end

	frozen a_12 (polynomial_1, polynomial_2: P; coefficient: C; exponent: INTEGER)
			--	REMTERM(ADDTERM(p,c,e),f) = if e=f then REMTERM(p,f) >>
		require
			polynomial_1 ~ polynomial_2
		do
			add_term (polynomial_1, coefficient, exponent)
			rem_term (polynomial_1, exponent)
			rem_term (polynomial_2, exponent)
		ensure
			polynomial_1 ~ polynomial_2
		end

	frozen a_13 (polynomial_1, polynomial_2: P; coefficient: C; exponent_1, exponent_2: INTEGER)
			--	>> else ADDTERM(REMTERM(p,f),c,e)
		require
			exponent_1 /~ exponent_2
			polynomial_1 ~ polynomial_2
		do
			add_term (polynomial_1, coefficient, exponent_1)
			rem_term (polynomial_1, exponent_2)
			rem_term (polynomial_2, exponent_2)
			add_term (polynomial_2, coefficient, exponent_1)
		ensure
			polynomial_1 ~ polynomial_2
		end

	frozen a_14 (coefficient: C; exponent: INTEGER)
			--	MULTTERM(ZERO,d,f) = ZERO
		local
			polynomial_1, polynomial_2: P
		do
			polynomial_1 := zero
			polynomial_2 := zero
			mult_term (polynomial_1, coefficient, exponent)
			check
				polynomial_1 ~ polynomial_2
			end
		end

	frozen a_15 (polynomial_1, polynomial_2: P; coefficient_1, coefficient_2: C; exponent_1, exponent_2: INTEGER)
			--	MULTTERM(ADDTERM(p,c,e),d,f) = ADDTERM(MULTTERM(p,d,f),c*d,e+f)
		require
			polynomial_1 ~ polynomial_2
		do
			add_term (polynomial_1, coefficient_1, exponent_1)
			mult_term (polynomial_1, coefficient_2, exponent_2)
			mult_term (polynomial_2, coefficient_2, exponent_2)
			add_term (polynomial_2, ({CS}).default.product (coefficient_1, coefficient_2), exponent_1 + exponent_2)
		ensure
			polynomial_1 ~ polynomial_2
		end

	frozen a_16 (polynomial: P)
			--	ADD(p,ZERO) = p
		local
			zero_p: P
		do
			zero_p := zero
			check
				add (polynomial, zero_p) ~ polynomial
			end
		end

	frozen a_17 (p, q, s: P; d: C; f: INTEGER)
			--	ADD(p,ADDTERM(q,d,f)) = ADDTERM(ADD(p,q),d,f)
		require
			add (p, q) ~ s
		do
			add_term (q, d, f)
			add_term (s, d, f)
		ensure
			add (p, q) ~ s
		end

	frozen a_18 (polynomial: P)
			--	MULT(p,ZERO) = ZERO
		local
			zero_p: P
		do
			zero_p := zero
			check
				mult (polynomial, zero_p) ~ zero_p
			end
		end

	frozen a_19 (p_1, p_2, p_3, q_1, q_2: P; d: C; f: INTEGER)
			--	MULT(p,ADDTERM(q,d,f)) = ADD(MULT(p,q),MULTTERM(p,d,f))
		require
			p_1 ~ p_2
			q_1 ~ q_2
		do
			add_term (q_1, d, f)
			mult_term (p_2, d, f)
		ensure
			mult (p_1, q_1) ~ add (mult (p_1, q_2), p_2)
		end

	frozen a_20 (polynomial_1, polynomial_2: P)
			--	REDUCTUM(p) = REMTERM(p,DEGREE(p))
		require
			polynomial_1 ~ polynomial_2
		do
			reductum (polynomial_1)
			rem_term (polynomial_2, degree (polynomial_2))
		ensure
			polynomial_1 ~ polynomial_2
		end

	frozen a_21
			--	ISZERO(ZERO) = true
		local
			polynomial: P
		do
			polynomial := zero
			check
				is_zero (polynomial)
			end
		end

	frozen a_22 (polynomial_1, polynomial_2: P; coefficient: C; exponent: INTEGER)
			--	ISZERO(ADDTERM(p,c,e)) = if COEF(p,e)=-c then ISZERO(REMTERM(p,e)) >>
		require
			coef (polynomial_1, exponent) ~ ({CS}).default.additive_inverse (coefficient)
			polynomial_1 ~ polynomial_2
		do
			add_term (polynomial_1, coefficient, exponent)
			rem_term (polynomial_2, exponent)
		ensure
			is_zero (polynomial_1) ~ is_zero (polynomial_2)
		end

	frozen a_23 (polynomial: P; coefficient: C; exponent: INTEGER)
			--	>> else false
		require
			coef (polynomial, exponent) /~ ({CS}).default.additive_inverse (coefficient)
		do
			add_term (polynomial, coefficient, exponent)
		ensure
			not is_zero (polynomial)
		end

	frozen a_24 (exponent: INTEGER)
			--	COEF(ZERO,e) = 0
		local
			polynomial: P
		do
			polynomial := zero
			check
				coef (polynomial, exponent) ~ ({CS}).default.zero
			end
		end

	frozen a_25 (polynomial: P; coefficient: C; exponent: INTEGER; old_coefficient: C)
			--	COEF(ADDTERM(p,c,e),f ) = if e=f then c+COEF(p,f) >>
		require
			coef (polynomial, exponent) ~ old_coefficient
		do
			add_term (polynomial, coefficient, exponent)
		ensure
			coef (polynomial, exponent) ~ ({CS}).default.sum (coefficient, old_coefficient)
		end

	frozen a_26 (polynomial: P; coefficient: C; exponent_1, exponent_2: INTEGER; old_coefficient: C)
			--	>> else COEF(p,f)
		require
			coef (polynomial, exponent_2) ~ old_coefficient
		do
			add_term (polynomial, coefficient, exponent_1)
		ensure
			coef (polynomial, exponent_2) ~ old_coefficient
		end

	frozen a_27
			--	DEGREE(ZERO) = 0
		local
			polynomial: P
		do
			polynomial := zero
			check
				degree (polynomial) ~ 0
			end
		end

	frozen a_28 (polynomial: P; coefficient: C; exponent: INTEGER)
			--	DEGREE(ADDTERM(p,c,e)) = if e > DEGREE(p) then e >>
		require
			exponent > degree (polynomial)
		do
			add_term (polynomial, coefficient, exponent)
		ensure
			degree (polynomial) ~ exponent
		end

	frozen a_29 (polynomial: P; coefficient: C; exponent: INTEGER; old_degree: INTEGER)
			--	>> else if e < DEGREE(p) then DEGREE(p) >>
		require
			exponent < degree (polynomial)
			degree (polynomial) ~ old_degree
		do
			add_term (polynomial, coefficient, exponent)
		ensure
			degree (polynomial) ~ old_degree
		end

	frozen a_30 (polynomial_1, polynomial_2: P; coefficient: C; exponent: INTEGER; old_degree: INTEGER)
			--	>> else if COEF(p,e) = -c then DEGREE(REDUCTUM(p))  >>
		require
			exponent = degree (polynomial_1)
			coef (polynomial_1, exponent) ~ ({CS}).default.additive_inverse (coefficient)
			polynomial_1 ~ polynomial_2
		do
			add_term (polynomial_1, coefficient, exponent)
			reductum (polynomial_2)
		ensure
			degree (polynomial_1) ~ degree (polynomial_2)
		end

	frozen a_31 (polynomial: P; coefficient: C; exponent: INTEGER; old_degree: INTEGER)
			--	>> else DEGREE(p)
		require
			exponent = degree (polynomial)
			coef (polynomial, exponent) /~ ({CS}).default.additive_inverse (coefficient)
			degree (polynomial) ~ old_degree
		do
			add_term (polynomial, coefficient, exponent)
		ensure
			degree (polynomial) ~ old_degree
		end

	frozen a_32 (polynomial: P)
			--	LDCF(p) = COEF(p,DEGREE(p))
		do
		ensure
			ldcf (polynomial) ~ coef (polynomial, degree (polynomial))
		end

feature
	-- Well-definedness axioms.

	frozen add_term_well_defined (polynomial_1, polynomial_2: P; coefficient: C; exponent: INTEGER)
		require
			polynomial_1 ~ polynomial_2
		do
			add_term (polynomial_1, coefficient, exponent)
			add_term (polynomial_2, coefficient, exponent)
		ensure
			polynomial_1 ~ polynomial_2
		end

	frozen rem_term_well_defined (polynomial_1, polynomial_2: P; exponent: INTEGER)
		require
			polynomial_1 ~ polynomial_2
		do
			rem_term (polynomial_1, exponent)
			rem_term (polynomial_2, exponent)
		ensure
			polynomial_1 ~ polynomial_2
		end

	frozen mult_term_well_defined (polynomial_1, polynomial_2: P; coefficient: C; exponent: INTEGER)
		require
			polynomial_1 ~ polynomial_2
		do
			mult_term (polynomial_1, coefficient, exponent)
			mult_term (polynomial_2, coefficient, exponent)
		ensure
			polynomial_1 ~ polynomial_2
		end

	frozen reductum_well_defined (polynomial_1, polynomial_2: P)
		require
			polynomial_1 ~ polynomial_2
		do
			reductum (polynomial_1)
			reductum (polynomial_2)
		ensure
			polynomial_1 ~ polynomial_2
		end

	frozen is_zero_well_defined (polynomial_1, polynomial_2: P)
		require
			polynomial_1 ~ polynomial_2
		do
		ensure
			is_zero (polynomial_1) ~ is_zero (polynomial_2)
		end

	frozen coef_well_defined (polynomial_1, polynomial_2: P; exponent: INTEGER)
		require
			polynomial_1 ~ polynomial_2
		do
		ensure
			coef (polynomial_1, exponent) ~ coef (polynomial_2, exponent)
		end

	frozen degree_well_defined (polynomial_1, polynomial_2: P)
		require
			polynomial_1 ~ polynomial_2
		do
		ensure
			degree (polynomial_1) ~ degree (polynomial_2)
		end

	frozen ldcf_well_defined (polynomial_1, polynomial_2: P)
		require
			polynomial_1 ~ polynomial_2
		do
		ensure
			ldcf (polynomial_1) ~ ldcf (polynomial_2)
		end

end
