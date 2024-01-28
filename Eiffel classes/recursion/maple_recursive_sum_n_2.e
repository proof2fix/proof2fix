note
	description: "Summary description for {MAPLE_RECURSIVE_SUM_N_2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAPLE_RECURSIVE_SUM_N_2

feature
	sum (a_n: INTEGER): INTEGER
		require
			argument_non_negative: a_n >= 0
		do
			if a_n = 0 then
				Result := 0
			else
				Result := 2 * a_n + 3 * sum (a_n - 1)
				-- correction: Result := a_n + sum (a_n - 1)
			end
		ensure
			correct_result: Result = a_n * (a_n + 1) / 2
		end
end
