note
	description: "Summary description for {MAPLE_RECURSIVE_SUM_N_1}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAPLE_RECURSIVE_SUM_N_1

feature
	sum (a_n: INTEGER): INTEGER
		require
			argument_non_negative: a_n >= 0
		do
			if a_n = 0 then
				Result := 2 -- proof2fix: Result := 0
			else
				Result := a_n + sum (a_n - 1)
			end
		ensure
			correct_result: 2 * Result = a_n * (a_n + 1)
		end

end
