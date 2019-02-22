note
	description: "Reusable abstract data type specification of file."
	description: "The signature is taken from ``The design of data type specifications'' article by Guttag, Horowitz and Musser, page 5."
	EIS: "protocol=URI", "src=http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.103.4685&rep=rep1&type=pdf"

deferred class
	FILE_ADT [F, R]
	--	Files ``F'' contain records ``R''.
	--	To apply this template to your concept,
	--	inherit from this class with your concepts for ``F'' and ``R''.
	--	The resulting class has to be effective (non-deferred).
	--	Test or model check the resulting class.

inherit

	EQUALITY_ADT [F]

feature
	-- Deferred definitions.

	empty_file: F
		deferred
		end

	write (file: F; record: R)
		deferred
		end

	skip (file: F; gap: INTEGER)
		deferred
		end

	reset (file: F)
		deferred
		end

	is_eof (file: F): BOOLEAN
		deferred
		end

	read (file: F): R
		deferred
		end

feature
	-- Abstract data type axioms.

	frozen a_1 (gap: INTEGER)
		local
			file_1, file_2: F
		do
			file_1 := empty_file
			file_2 := empty_file
			skip (file_1, gap)
			check
				file_1 ~ file_2
			end
		end

	frozen a_2 (file_1, file_2: F; gap_1, gap_2: INTEGER)
		require
			file_1 ~ file_2
		do
			skip (file_1, gap_1)
			skip (file_1, gap_2)
			skip (file_2, gap_1 + gap_2)
		ensure
			file_1 ~ file_2
		end

	frozen a_3
		local
			file_1, file_2: F
		do
			file_1 := empty_file
			file_2 := empty_file
			reset (file_1)
			check
				file_1 ~ file_2
			end
		end

	frozen a_4 (file_1, file_2: F; record: R)
		require
			file_1 ~ file_2
		do
			write (file_1, record)
			reset (file_1)
			write (file_2, record)
			skip (file_2, 0)
		ensure
			file_1 ~ file_2
		end

	frozen a_5 (file_1, file_2: F; record: R; gap: INTEGER)
		require
			file_1 ~ file_2
		do
			write (file_1, record)
			skip (file_1, gap)
			reset (file_1)
			write (file_2, record)
			skip (file_2, 0)
		ensure
			file_1 ~ file_2
		end

	frozen a_6
		local
			file: F
		do
			file := empty_file
			check
				is_eof (file)
			end
		end

	frozen a_7 (file: F; record: R)
		do
			write (file, record)
		ensure
			is_eof (file)
		end

	frozen a_8 (file: F; record: R)
		do
			write (file, record)
			skip (file, 0)
		ensure
			not is_eof (file)
		end

	frozen a_9 (file_1, file_2: F; record: R; gap: INTEGER)
		require
			gap /~ 0
			file_1 ~ file_2
		do
			write (file_1, record)
			skip (file_1, gap)
			skip (file_2, gap - 1)
		ensure
			file_1 ~ file_2
		end

	frozen a_10 (file_1, file_2: F; record: R; gap: INTEGER)
		require
			file_1 ~ file_2
		do
			write (file_1, record)
			skip (file_1, gap)
			skip (file_2, gap)
			check
				assume: is_eof (file_2)
			end
		ensure
			read (file_1) ~ record
		end

	frozen a_11 (file_1, file_2: F; record: R; gap: INTEGER)
		require
			file_1 ~ file_2
		do
			write (file_1, record)
			skip (file_1, gap)
			skip (file_2, gap)
			check
				assume: not is_eof (file_2)
			end
		ensure
			read (file_1) ~ read (file_2)
		end

	frozen a_12 (file_1, file_2, file_3: F; record_1, record_2: R; gap: INTEGER)
		require
			file_1 ~ file_2
			file_2 ~ file_3
		do
			write (file_1, record_1)
			skip (file_1, gap)
			write (file_1, record_2)
			skip (file_2, gap)
			check
				assume: is_eof (file_2)
			end
			write (file_3, record_2)
		ensure
			file_1 ~ file_3
		end

	frozen a_13 (file_1, file_2: F; record_1, record_2: R; gap: INTEGER)
		require
			file_1 ~ file_2
		do
			write (file_1, record_1)
			skip (file_1, gap)
			write (file_1, record_2)
			skip (file_2, gap)
			check
				assume: not is_eof (file_2)
			end
			write (file_2, record_2)
		ensure
			file_1 ~ file_2
		end

feature
	-- Well-definedness axioms.

	frozen empty_file_well_defined
		local
			file_1, file_2: F
		do
			file_1 := empty_file
			file_2 := empty_file
			check
				file_1 /= file_2
			end
			check
				file_1 ~ file_2
			end
		end

	frozen write_well_defined (file_1, file_2: F; record: R)
		require
			file_1 ~ file_2
		do
			write (file_1, record)
			write (file_2, record)
		ensure
			file_1 ~ file_2
		end

	frozen skip_well_defined (file_1, file_2: F; gap: INTEGER)
		require
			file_1 ~ file_2
		do
			skip (file_1, gap)
			skip (file_2, gap)
		ensure
			file_1 ~ file_2
		end

	frozen reset_well_defined (file_1, file_2: F)
		require
			file_1 ~ file_2
		do
			reset (file_1)
			reset (file_2)
		ensure
			file_1 ~ file_2
		end

	frozen is_eof_well_defined (file_1, file_2: F): BOOLEAN
		require
			file_1 ~ file_2
		do
		ensure
			is_eof (file_1) ~ is_eof (file_2)
		end

	frozen read_well_defined (file_1, file_2: F)
		require
			file_1 ~ file_2
		do
		ensure
			read (file_1) ~ read (file_2)
		end

end
