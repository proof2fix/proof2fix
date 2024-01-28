note
	description: "Summary description for {MAPLE_RECURSIVE_MIN_2_1}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAPLE_RECURSIVE_MIN_2_1

feature
	sum (a_x, a_y: INTEGER): INTEGER
		require
			True
		do
			if a_x < a_y then
				Result := 2 * a_x
				-- correction: Result := a_x
			else
				Result := a_y
			end
		ensure
			result_for_a_x_smaller_or_equal_a_y: a_x <= a_y implies Result = a_x
			result_for_a_y_smaller_or_equal_a_x: a_y <= a_x implies Result = a_y
		end

end
