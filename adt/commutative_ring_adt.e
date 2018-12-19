note
	description: "Reusable abstract data type specification of commutative ring."
	description: "Taken from Wikipedia."
	EIS: "protocol=URI", "src=https://en.wikipedia.org/wiki/Commutative_ring#Definition"
	EIS: "protocol=URI", "src=https://en.wikipedia.org/wiki/Ring_(mathematics)#Definition"

deferred class
	COMMUTATIVE_RING_ADT [R]
	--	R is a mathematical commutative ring.

inherit

	EQUALITY_ADT [R]

feature
	-- Deferred definitions.

	one: R
			--	Multiplicative identity.
		deferred
		end

	zero: R
			--	Additive identity.
		deferred
		end

	sum (summand_1, summand_2: R): R
		deferred
		end

	product (multiplier_1, multiplier_2: R): R
		deferred
		end

	additive_inverse (a: R): R
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1 (a, b, c: R)
		do
		ensure
			sum (sum (a, b), c) ~ sum (a, sum (b, c))
		end

	frozen a_2 (a, b: R)
		do
		ensure
			sum (a, b) ~ sum (b, a)
		end

	frozen a_3 (a: R)
		do
		ensure
			sum (a, zero) ~ a
		end

	frozen a_4 (a: R)
		do
		ensure
			sum (a, additive_inverse (a)) ~ zero
		end

	frozen a_5 (a, b, c: R)
		do
		ensure
			product (product (a, b), c) ~ product (a, product (b, c))
		end

	frozen a_6 (a: R)
		do
		ensure
			product (a, one) ~ a
			product (one, a) ~ a
		end

	frozen a_7 (a, b, c: R)
		do
		ensure
			product (a, sum (b, c)) ~ sum (product (a, b), product (a, c))
		end

	frozen a_8 (a, b, c: R)
		do
		ensure
			product (sum (b, c), a) ~ sum (product (b, a), product (c, a))
		end

	frozen a_9 (a, b: R)
		do
		ensure
			product (a, b) ~ product (b, a)
		end

feature
	-- Well-definedness axioms.

	frozen one_well_defined
		local
			r_1, r_2: R
		do
			r_1 := one
			r_2 := one
			check
				r_1 ~ r_2
			end
		end

	frozen zero_well_defined
		local
			r_1, r_2: R
		do
			r_1 := zero
			r_2 := zero
			check
				r_1 ~ r_2
			end
		end

	frozen sum_well_defined (summand_1, summand_2, other: R)
		require
			summand_1 ~ summand_2
		do
		ensure
			sum (summand_1, other) ~ sum (summand_2, other)
		end

	frozen product_well_defined (multiplier_1, multiplier_2, other: R)
		require
			multiplier_1 ~ multiplier_2
		do
		ensure
			product (multiplier_1, other) ~ product (multiplier_2, other)
		end

	frozen additive_inverse_well_defined (r_1, r_2: R)
		require
			r_1 ~ r_2
		do
		ensure
			additive_inverse (r_1) ~ additive_inverse (r_2)
		end

end
