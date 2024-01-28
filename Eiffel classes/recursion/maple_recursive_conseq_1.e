class
	MAPLE_RECURSIVE_CONSEQ_1

feature
	sum (n: INTEGER): INTEGER
		require
			arg_non_negative: n >= 0
		do
			if n = 0 then
				Result := 3 -- proof2fix: Result := 0
			else
				Result := n * (n + 1) + sum (n - 1)
			end
		ensure
			result_correct: Result = n * (n + 1) * (n + 2) // 3
		end
end
