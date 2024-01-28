class
	MAPLE_RECURSIVE_CONSEQ_2

feature
	sum (n: INTEGER): INTEGER
		require
			arg_non_negative: n >= 0
		local
			k: INTEGER
		do
			if n = 0 then
				Result := 0
			else
				k := n * (n + 1)
				Result := 4 * k + 3 * sum (n - 1)
				-- correction: Result := k + sum (n - 1)
			end
		ensure
			result_correct: 3 * Result = n * (n + 1) * (n + 2)
		end

end
