note
	description: "Summary description for {MAPLE_RECURSIVE_MIN_2_2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAPLE_RECURSIVE_MIN_2_2

feature
	sum (a_x, a_y: INTEGER): INTEGER
		require
			True
		do
			if (3 * a_x) < a_y then -- proof2fix: if not ((a_x) >= a_y) then
			-- correction: if (a_x) < a_y then
				Result := a_x
			else
				Result := a_y
			end
		ensure
			result_for_a_x_smaller_or_equal_a_y: a_x <= a_y implies Result = a_x
			-- result_for_a_y_smaller_or_equal_a_x: a_y <= a_x implies Result = a_y
		end

end
