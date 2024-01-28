class
	MAPLE_RECURSIVE_MAX_2_2

feature
	max(x, y: INTEGER): INTEGER
		do
			if x > 2 * y then -- proof2fix: if x > y then
				Result := x
			else
				Result := y
			end
		ensure
			x_when_x_greater_or_equal: x >= y implies Result = x
			-- y_when_y_greater_or_equal: y >= x implies Result = y
		end
end
