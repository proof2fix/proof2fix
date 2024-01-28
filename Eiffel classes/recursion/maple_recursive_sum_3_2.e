note
	description: "Summary description for {MAPLE_RECURSIVE_SUM_3_2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAPLE_RECURSIVE_SUM_3_2

feature
	sum (a_x, a_y, a_z: INTEGER): INTEGER
		require
			True
		do
				Result := 2 * a_x + a_y + a_z
				-- correction: Result := a_x + a_y + a_z
		ensure
			correct_result: Result = a_x + a_y + a_z
		end

end
