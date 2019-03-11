note
	description: "Reusable abstract data type specification of polynomial."
	description: "Found in ``The design of data type specifications'' by Guttag, Horowitz and Musser:"
	EIS: "src=http://tinyurl.com/yxmnv23w"
	EIS: "name=Location on GitHub", "src=https://tinyurl.com/y5u8hubc"

deferred class
	POLYNOMIAL_ADT [P, C, CS -> COMMUTATIVE_RING_ADT [C]]
	--	Polynomials ``P'' have coefficients from the commutative ring ``C''.

inherit

	COMMUTATIVE_RING_ADT [P]
		rename
			sum as add,
			product as mult
		end

feature
	-- Deferred definitions.

	add_term (polynomial: P; coefficient: C; exponent: INTEGER)
		deferred
		end

	rem_term (polynomial: P; exponent: INTEGER)
		deferred
		end

	mult_term (polynomial: P; coefficient: C; exponent: INTEGER)
		deferred
		end

	reductum (polynomial: P)
		deferred
		end

	is_zero (polynomial: P): BOOLEAN
		deferred
		end

	coef (polynomial: P; exponent: INTEGER): C
		deferred
		end

	degree (polynomial: P): INTEGER
		deferred
		end

	ldcf (polynomial: P): C
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_11 (exponent: INTEGER)
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
		local
			zero_p: P
		do
			zero_p := zero
			check
				add (polynomial, zero_p) ~ polynomial
			end
		end

	frozen a_17 (p, q, s: P; d: C; f: INTEGER)
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
		require
			polynomial_1 ~ polynomial_2
		do
			reductum (polynomial_1)
			rem_term (polynomial_2, degree (polynomial_2))
		ensure
			polynomial_1 ~ polynomial_2
		end

	frozen a_21
		local
			polynomial: P
		do
			polynomial := zero
			check
				is_zero (polynomial)
			end
		end

	frozen a_22 (polynomial_1, polynomial_2: P; coefficient: C; exponent: INTEGER)
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
		require
			coef (polynomial, exponent) /~ ({CS}).default.additive_inverse (coefficient)
		do
			add_term (polynomial, coefficient, exponent)
		ensure
			not is_zero (polynomial)
		end

	frozen a_24 (exponent: INTEGER)
		local
			polynomial: P
		do
			polynomial := zero
			check
				coef (polynomial, exponent) ~ ({CS}).default.zero
			end
		end

	frozen a_25 (polynomial: P; coefficient: C; exponent: INTEGER; old_coefficient: C)
		require
			coef (polynomial, exponent) ~ old_coefficient
		do
			add_term (polynomial, coefficient, exponent)
		ensure
			coef (polynomial, exponent) ~ ({CS}).default.sum (coefficient, old_coefficient)
		end

	frozen a_26 (polynomial: P; coefficient: C; exponent_1, exponent_2: INTEGER; old_coefficient: C)
		require
			coef (polynomial, exponent_2) ~ old_coefficient
		do
			add_term (polynomial, coefficient, exponent_1)
		ensure
			coef (polynomial, exponent_2) ~ old_coefficient
		end

	frozen a_27
		local
			polynomial: P
		do
			polynomial := zero
			check
				degree (polynomial) ~ 0
			end
		end

	frozen a_28 (polynomial: P; coefficient: C; exponent: INTEGER)
		require
			exponent > degree (polynomial)
		do
			add_term (polynomial, coefficient, exponent)
		ensure
			degree (polynomial) ~ exponent
		end

	frozen a_29 (polynomial: P; coefficient: C; exponent: INTEGER; old_degree: INTEGER)
		require
			exponent < degree (polynomial)
			degree (polynomial) ~ old_degree
		do
			add_term (polynomial, coefficient, exponent)
		ensure
			degree (polynomial) ~ old_degree
		end

	frozen a_30 (polynomial_1, polynomial_2: P; coefficient: C; exponent: INTEGER; old_degree: INTEGER)
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
