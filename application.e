note
	description: "requirements_templates application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			ilss: IS_LINKED_STACK_STACK [INTEGER]
			s_1, s_2: LINKED_STACK [INTEGER]
		do
			--| Add your code here
			create ilss
			create s_1.make
--			s_1.extend (0)
			create s_2.make
			ilss.a_5 (s_1, s_2, 10)
			print ("gagsdfasfasf")
		end

end
