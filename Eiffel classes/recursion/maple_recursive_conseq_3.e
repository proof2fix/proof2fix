class
	MAPLE_RECURSIVE_CONSEQ_3

feature
	sum (n: INTEGER): INTEGER
		require
			arg_non_negative: n >= 0
		local
			k, h: INTEGER
		do
			if n = 0 then
				Result := 0
			else
				k := n * (n + 1)
				h := sum (n - 1)
				Result := -h + k
				-- correction: Result := h + k
			end
		ensure
			result_correct: 3 * Result = n * (n + 1) * (n + 2)
		end
end

