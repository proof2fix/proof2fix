class
	MAPLE_RECURSIVE_CONSEQ_4

feature
	sum (n: INTEGER): INTEGER
		require
			n >= 0
		local
			k, h: INTEGER
		do
			if n = 0 then
				Result := 0
			else
				k := n * (n + 1)
				h := sum (n - 1)
				Result := -h - k
				-- proof2fix: Result := - Result
			end
		ensure
			result_correct: 3 * Result = n * (n + 1) * (n + 2)
		end
end
