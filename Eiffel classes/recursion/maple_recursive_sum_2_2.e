note
	description: "Summary description for {MAPLE_RECURSIVE_SUM_2_2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAPLE_RECURSIVE_SUM_2_2

feature
	sum (a_x, a_y: INTEGER): INTEGER
		require
			True
		do
				Result := a_x + 2 * a_y
				-- correction: Result := a_x + a_y
		ensure
			correct_result: Result = a_x + a_y
		end

end
