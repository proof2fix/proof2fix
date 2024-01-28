note
	description: "Summary description for {MAPLE_RECURSIVE_MIN_3_2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAPLE_RECURSIVE_MIN_3_2

feature
	sum (a_x, a_y, a_z: INTEGER): INTEGER
		require
			True
		do
			if ((2 * a_x) < a_y) and (a_x < a_z) then
				-- if ((a_x) < a_y) and (a_x < a_z) then
				Result := a_x
			elseif a_y < a_z then
				Result := a_y
			else
				Result := a_z
			end
		ensure
			result_for_a_x_smaller_or_equal_a_y_and_a_x_smaller_or_equal_a_z: ((a_x <= a_y) and (a_x <= a_z)) implies (Result = a_x)
			-- result_for_a_y_smaller_or_equal_a_x_and_a_y_smaller_or_equal_a_z: ((a_y <= a_x) and (a_y <= a_z)) implies (Result = a_y)
			result_for_a_z_smaller_or_equal_a_x_and_a_z_smaller_or_equal_a_y: ((a_z <= a_x) and (a_z <= a_y)) implies (Result = a_z)
		end
end
